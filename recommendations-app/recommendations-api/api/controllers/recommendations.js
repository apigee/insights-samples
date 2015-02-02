'use strict';

// TODO: This code contains multiple short variable names for things like
// recommendations/recommendation, entities/entity. We could clarify these
// with more intuitive names based on the role of the thing the variable
// represents.


var util = require('util');
//var data = require('./mocks/testscores')
var usergrid = require('usergrid');
var helpers = require('../helpers/helper');
var async = require('async');

// Create a client object to get client access to API BaaS.
// To give this code access to your BaaS app, you'll need 
// to enter your org and app name below. You'll also need 
// your client ID and client secret; you'll find those on the 
// Org Administration page of your BaaS admin console.
var client = new usergrid.client({
    URI : 'https://api-connectors-prod.apigee.net/appservices',
    orgName: 'your-org-name',
    appName: 'your-app-name',
    clientId:'your-client-ID',
    clientSecret:'your-client-secret',
    authType:usergrid.AUTH_CLIENT_ID,
    logging: false, //optional - turn on logging, off by default
    buildCurl: true //optional - turn on curl commands, off by default
});

module.exports = {
  getRecommendations: getRecommendations
};

// Retrieves the recommended products for the current customer (registered 
// user whose instance of the client app is calling the API.
function getRecommendations(req, res) {
  // Get the ID for the current customer from the URL.
  var customer_id = req.swagger.params.customer_id.value;
  // Create a query string from the string passed with the URL
  // and the user ID.
  // [TODO: Not sure why we're doing this if the user ID is in the
  // main part of the URL.]
  var ql = helpers.appendCustomerIdtoQl(req.swagger.params.ql.value, customer_id);

  if(ql.indexOf('where') == -1){
    res.send(400, {code : 400, message : "ql parameter must contain at least one condition in where statement. e.g. select * where scoreType = 'recommendationScore'"})
    return;
  }
  var options = {
    //type:'testscoresimport',
    type:'recommendationscores',
    qs: {ql : ql,
         limit : req.swagger.params.limit.value || 10
    }
  }
  // Create an array to hold the recommendations.
  var recommendations = [];

  // Call a function of the API BaaS client object to create a collection 
  // on the API BaaS server. The callback function receives a recs
  // collection of API BaaS entities representing members of the 
  // new collection. 
  client.createCollection(options, function (err, recs) {
    if (err) {
      // TODO: Code to handle the case of failure to create a collection.
    } else {
        // 
        var ents = {entities : []}
        var recommendation = {};
        while(recs.hasNextEntity()){
          // Add an entity to the recommendations array.
          recommendations.push(recs.getNextEntity());
        }
        // For each of the recommendations, 
        async.each(recommendations, 
          function(recommendation, callback){
            // Create a collection of API BaaS product entities from 
            // product names in the recommendations collection
            helpers.getProduct(recommendation, function (err, products) {
              if (err) {
                // Handle error.
              } else {
                  if(products.hasNextEntity()) {
                      var product = products.getNextEntity();
                      var ent = {};
                      helpers.dataMapperProductBaas(product, ent)
                      ents.entities.push(helpers.dataMapperInsights(recommendation, ent));
                  }
              }
              callback();
            }, client);
          },
          function(callback){
            ents.cursor = recs._next;
            res.json(ents);
          }
        );
    }
  });
}


