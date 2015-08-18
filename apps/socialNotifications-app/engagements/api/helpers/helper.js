'use strict';

var usergrid = require('usergrid');

//var uri
//var appName = 'socialNotifications';
//var clientId = 'b3U62sgIGhrFEeWkaxeokc2GiA';
//var clientSecret = 'b3U6CLuY53hbQVsmSLwG4j01Mm42iaA';

var uri = 'amer-apibaas-prod.apigee.net';
var uriSuffix = "/appservices";
var clientId = '<INSERT CLIENT ID HERE>';
var clientSecret = '<INSERT CLIENT SECRET HERE>';

var notifiers = [
	'androidDev'
];



module.exports = {
	getClient: getClient,
	getURI: getURI,
	getURISuffix: getURISuffix, 
	getClientId: getClientId,
	getClientSecret: getClientSecret,
	getNotifiers: getNotifiers
};

function getClient( org, app ) {
	
	var clientURI = 'http://' + uri + uriSuffix;
	
	return new usergrid.client({
		URI: clientURI,
	    orgName: org,
	    appName: app,
	    authType:usergrid.AUTH_CLIENT_ID,
	    clientId:clientId,
	    clientSecret:clientSecret,
	    logging: false, //optional - turn on logging, off by default
	    buildCurl: false //optional - turn on curl commands, off by default
	});
}

function getURI() {
	return uri;
}

function getURISuffix() {
	return uriSuffix;
}

function getClientId() {
	return clientId;
}

function getClientSecret() {
	return clientSecret;
}

function getNotifiers() {
	return notifiers;
}