'use strict';

var util = require('util');
var usergrid = require('usergrid');
var http = require('http');
var async = require('async');
var access = require('apigee-access');

var helper = require('./../helpers/helper');  

module.exports = {
	postActivity: postActivity,
	test: test
};

/**
 * 
 * @constructor
 * @param {object} request - node.js request object with parameters
 * @param {object} response - node.js response object
 */
function postActivity( request, response ) {
	
	// Parameters
	var swaggerParams = request.swagger.params;
	
	// url parameters
	var org = swaggerParams.org.value;
	var app = swaggerParams.app.value;
    var username = swaggerParams.username.value;
    var activityType = swaggerParams.activityType.value;
    var target = swaggerParams.target.value;

    // body parameters
    var baasEntity = swaggerParams.baasEntity.value; //optional
    var pushToUser = swaggerParams.pushToUser.value; //optional
    var pushToFollowers = swaggerParams.pushToFollowers.value; //optional
    var followerMessage = swaggerParams.followerMessage.value; //optional
    var moreInfo = swaggerParams.moreInfo.value; //optional
    var tag = swaggerParams.tag.value; //optional
    
    // parameters from the helper class with information about the baas settings
    var uri = helper.getURI();
    var uriSuffix = helper.getURISuffix();
    var clientId = helper.getClientId();
    var clientSecret = helper.getClientSecret();
    
    // list of notifiers in baas
    var notifiers = helper.getNotifiers();
    
    // get the nodejs baas client
    var client = helper.getClient( org, app );
    
    // convert any empty boolean or string false to false type
    if( pushToUser == undefined || pushToUser == "false" ) {
	    pushToUser = false;
    } 
    if( pushToFollowers == undefined || pushToFollowers == "false") {
	    pushToFollowers = false;
    }
    
    var followerList = [];
    
    
    
    // Extra, just prints parameters
    var parameters = {};
    for( var key in request.swagger.params ) {
	    parameters[ key ] = request.swagger.params[key].value;
    }
    console.log(parameters);
    
    
    // Async will run a series of callbacks
    // if there is an error, all the callbacks will escape out and return to the final end function
    //
    // 1. the first callback will build a relations in baas with the user and the target if baasEntity is defined
    // 2. the second callback will add an activity of the user and target to the activity stream
    // 3. the third callback is the one that sends push notifications to the user and their followers
    //	3.1 if the pushToUser flag is set to true, a notification will be sent to the user
    //	3.1.1	this callback will get the id of the user from the baas entity
	// 	3.1.2	this callback will use the id of the users to best notification type from the userabritation table
	//	3.1.3	after 
    //	3.2 if the pushToFollowers flag is set to true, a push notification will be sent to the user's followers
    // 	3.2.1	this callback gets a list of all followers of the user
    //	3.2.2	this callback sends out a push notification to all the devices of the followers users
    async.series([
	    function( callback ) {	///////////// 1. build relationship from user to target if baasCollection is defined /////////////
		    
		    // if baasEntity collection is defined, build a relationship in baas from the user to the target
		    
		    if( baasEntity != undefined ) {
			    
			    var options = {
			        method:'POST',
			        endpoint:'/users/' + username + '/' + activityType + '/' + baasEntity
			    }
			    
			    client.request(options, function(err, responseJSON ){
			        if( err ){
				        callback( err, "Error, connection not build: " + username + " " + activityType + " " + target );
			        } else {
			            callback();
			        }
			    });
		    }
		    else {
			    callback();
		    }
	    },
	    function( callback ) {	//////////// 2. add to activity stream /////////////////
		    
		    // add the activity to the activity stream
		    // moreInfo is just a optioal blob of information that may be used later
		    // right now nothing
		    
		    var options = {
		        method:'POST',
		        endpoint:'users/' + username + '/activities',
		        body: {
		            target: target,
		            activity: activityType,
		            moreInfo: moreInfo, 
		            verb:"post",
		        }
		    }
		    
		    client.request( options, function( err, responseJSON ){
		        if( err ){
			        callback( err, "Error, activity not logged: " + username + " " + activityType + " " + target );
		        } else {
		            callback();
		        }
		    });
	    },
	    function( callback ) {	/////// 3. nested notification to self and/or followers ////////
		    
		    // this callback splits into 2 paths that will will run in parallel
		    // so it will not continue until both paths are complete
		    // the first one is the push notification to the user
		    // and the second one is the push notifications to the users's followers
		    // both are set by boolean flags
		    
		    async.parallel([
			    function( callback ) {	//////////// 3.1 notifications to self with scores ////////////
				    if( pushToUser == false ) {
					    
					    callback();
				    }
				    else {
					    async.waterfall([
						    function( callback ) {	//have to get the user id first from the user entity
							    
							    // this function is to get the user entity object so it can get the userId
							    
							    var options = {
								    method:'POST',
									endpoint:'users/' + username,
							    }
							    
							    client.request( options, function( err, responseJSON ){
								    
							        if( err ){
								        callback( err, "Error, couldn't get user uuid: " + username );
							        } else {
								        
								        var userId = responseJSON.entities[0].id;
								        
								        callback( null, userId );
							        }
							    });
						    },
						    function( userId, callback ) {	//////////// 3.1.2 determine the type of notification to send ////////////
							    
							    //	this gets a list of notification types from pusharbitrations that belong to the user
							    //	based on the highest propensity score, that is the notification type
							    
							    var options = {
							        method:'GET',
							        endpoint:'pusharbitrations?limit=100',
							        qs: { ql: "userId = '" + userId + "'" }
							    }
							    						    
							    client.request( options, function( err, responseJSON ){
										    
							        if( err ){
								        callback( err, "Error, getting Push Arbitrations: " + username );
							        } 
							        else {
								        
								        if( responseJSON.entities.length == 0 ) {
									        callback( null, "NONE" );
									        //TODO: possibly return an error for this case?
								        }
								        else {
									        var topScoreObject = responseJSON.entities[0];
									        
									        for( var i=1; i < responseJSON.entities.length; i++ ) {
										        if( responseJSON.entities[i].scoreValue > topScoreObject.scoreValue ) {
											        topScoreObject = responseJSON.entities[i];
										        }
									        }
									        
									        callback(null, topScoreObject.notificationType );
								        }
							        }
							    });
						    },
						    function( notificationType, callback ) {	//////////// 3.1.3 get the corrsponding collection and rule for the notification ////////////
							    
							    if( notificationType == "NONE" ) {
								    callback( null, "NONE", "", "" );
							    }
							    else {
								    var options = {
								        method:'GET',
								        endpoint:'rules?limit=100',
								        qs: { ql: "notificationType='" + notificationType + "' AND productId='" + target + "'" }
								    }
								    
								    client.request( options, function( err, responseJSON ){
								    
										if( err ){
									        callback( err, "Error, getting notification: " + username );
								        } else {
									        
									        if( responseJSON.entities.length == 0 ) {
										        callback( null, "NONE", "", "" );
									        }
									        else {
										        var topScoreObject = responseJSON.entities[0];
										        
										        for( var i=1; i < responseJSON.entities.length; i++ ) {
											        if( responseJSON.entities[i].scoreValue > topScoreObject.scoreValue ) {
												        topScoreObject = responseJSON.entities[i];
											        }
										        }
										        
										        var targetCollection = topScoreObject.targetCollection;
										        var newTargetId = topScoreObject.targetId;
										        
										        callback( null, notificationType, newTargetId, targetCollection );
									        }   
									    }
									});
							    }
						    },
						    function( notificationType, newTargetId, targetCollection, callback ) {	//////////// 3.1.4 determine what content to send in the notification ////////////
							    
							    if( notificationType == "NONE" ) {
								    callback( null, "NONE" );
							    }
							    else {
								    var options = {
								        method:'GET',
								        endpoint:targetCollection,
								        qs: { ql: "id='" + newTargetId + "'" }
								    }
								    
								    client.request( options, function( err, responseJSON ){
									    
									 	if( err ){
									        callback( err, "Error, getting new product: " + newTargetId );
								        } else {
									        
									        if( responseJSON.entities.length == 0 ) {
										        callback( null, "Error, getting new product: " + topScoreObject.targetId );
									        }
									        else {
										        
										        if( notificationType == 'RelevantNewProducts' ) {
											        var productName = responseJSON.entities[0].productName;
													var description = responseJSON.entities[0].description;
													callback( null, productName + ",\n " + description );
											    }
											    else if( notificationType == 'RelevantOffers' ) {
												    var title = responseJSON.entities[0].title;
													var description = responseJSON.entities[0].description;													        													callback( null, title + ", " + description );
												}
										        else if( notificationType == 'RelevantReviews' ) {
													var title = responseJSON.entities[0].title;
													var description = responseJSON.entities[0].description;													        													callback( null, title + ", " + description );
									    		}
												else if( notificationType == 'RelevantAccessoriesForNearbyStore' ) {
													var productName = responseJSON.entities[0].productName;
													var description = responseJSON.entities[0].description;
													callback( null, productName + ",\n " + description );
												}
												else {
													
												}
									        }
								        }
								    });
							    }
						    },
						    function( notificationMessage, callback ) {	//////////// 3.1.5 send the self notification ////////////
							    
							    if( notificationMessage != "NONE" ) {
								    
								    var postData = {
									    payloads: {}
								    }
								    
								    for( var i=0; i < notifiers.length; i++ ) {
									    postData.payloads[ notifiers[i] ] = notificationMessage;
								    }
									
									var path = uriSuffix + '/' + org + '/' + app + '/users/' + username + 
												'/notifications?client_id=' + clientId + "&client_secret=" + clientSecret;   
									
									var options = {
										method: "POST",
										host: uri,
										path: path,
									}
									
									var request = http.request( options, function( res ) {
										
										res.setEncoding('utf8');
										res.on('data', function (chunk) {
								         	//console.log('Response: ' + chunk);
								      	});
									});
									
									request.write( JSON.stringify( postData ) );
									request.end();
								}
								
								callback();
						    },
					    ], function( err ) {	//////////// end function for self notifcations ////////////
						    if( err ) {
							    callback( err );
						    }
						    else {
							    callback();
						    }
					    });
				    }
			    },
			    function( callback ) {  //////////// 3.2 social notifications to followers ////////////
				    
				    if( pushToFollowers == false ) {
					 	callback();
				    }
				    else {
					    async.series([
						    function( callback ) {	//////////// 3.2.1 get a list of followers ////////////
							    
							    var options = {
									method:'GET',
									endpoint:'users/' + username + '/followers'
								}
								
								client.request( options, function ( err, responseJSON ) {
							
								    if( err ) {
									    callback( err, "Error, activity not logged: " + username + " " + activityType + " " + target );
								    } else {
								        //data will contain raw results from API call
								        //success - GET worked
								            
							            for( var i=0; i < responseJSON.entities.length; i++ ) {
								            followerList.push( responseJSON.entities[i].username );
							            }
							            callback();
								    }
								});
						    },
						    function( callback ) {	//////////// 3.2.2 send notification to users devices ////////////
							    
							    if( followerList.length == 0 ) {
								    callback();
							    }
							    else {
								    if( followerMessage == undefined ) {
									    followerMessage = "Your friend, " + username + ", ";
								    
									    if( activityType == "like" ) {
										    followerMessage += "liked ";
									    }
									    else if( activityType == "comment" ) {
										    followerMessage += "commented on ";
									    }
									    else if( activityType == "favorite" ) {
										    followerMessage += "favorited ";
									    }
									    else {
										    followerMessage += "looked at ";
									    }
									    
									    followerMessage += target;
									}
									
									async.forEach( followerList, function( follower, callback ) {
									    
									    var postData = {
										    payloads: {}
									    }
									    
									    for( var i=0; i < notifiers.length; i++ ) {
										    postData.payloads[ notifiers[i] ] = followerMessage;
									    }
										
										var path = uriSuffix + '/' + org + '/' + app + '/users/' + follower + 
													'/notifications?client_id=' + clientId + "&client_secret=" + clientSecret;   
										
										var options = {
											method: "POST",
											host: uri,
											path: path,
										}
										
										var request = http.request( options, function( res ) {
											
											res.setEncoding('utf8');
											res.on('data', function (chunk) {
									         	//console.log('Response: ' + chunk);
									      	});
											
										});
										
										request.write( JSON.stringify( postData ) );
										request.end();
										
										callback();
										
								    }, function( err ) {
									    if( err ) {
										    callback(err);
									    }
									    else {
										    callback();
									    } 
								    });
							    }
						    }
					    ], function( err ) {	//////////// end function for social notifcations ////////////
						    if( err ) {
							    callback( err );
						    }
						    else {
							    callback();
						    }
					    });
				    }
				}
		    ], function( err ) {	//////////// end function for notification ////////////
			    
			    if( err ) {
				    callback( err );
			    }
			    else {
				    callback();
			    }
		    });
		},
    ], function( err, errorMessage ) {	////// Final Function ////////
	    
	    if(err) {
		    response.json( errorMessage );
	    }
	    else {
		    response.json("Successfully pushed to " + followerList.length + " followers");
	    }
	});	
}

function test( request, response ) {
	response.json("test successful")
}

