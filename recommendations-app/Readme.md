# Recommendations Application

Authors: Diego Zuluaga, Joy Thomas, Yong Kim

## Description

This sample illustrates how to build a predictive model from data and use the results to support an app recommendations feature. Code from this sample is used in the [Recommendations Tutorial](http://apigee.com/docs/insights/content/recommendations-tutorial), which walks through using the code to build an API to offer product recommendations.

The sample includes the following pieces:
- An R script that builds an Insights predictive model using data included with new Insights instances. The model predicts each customer's propensity to buy particular products.
- Data (in JSON form) to import to an Apigee API BaaS application. The data describes products.
- An Apigee-127 project with an API that retrieves recommendation data for use in client apps.

## What You'll Need

This sample is intended to be used in conjunction with pre-installed data in the Insights system. For a complete view, see the [Recommendations Tutorial](http://apigee.com/docs/insights/content/recommendations-tutorial), which uses this code.

This sample assumes that you have the following:

- An [Apigee Insights](https://apigee.com/insights) account to access pre-installed data.
- An [Apigee API BaaS](https://apigee.com/appservices) account to store recommendation data.
- An environment to run R scripts (such as RStudio) for building the predictive model.
- An installation of [Apigee-127]() to serve recommendations via an API.

## Running the Sample

If you just want to run the API portion of the sample:

1. Clone this repository.
2. Import the included product data JSON to your API BaaS sandbox application.
3. In your Apigee Insights account, export the RecommendationsScore to your API BaaS sandbox application.
4. Install Apigee-127.
5. Start the recommendations-api project.
6. Use curl to call the API to get recommendations.

## Documentation

- [Recommendations Tutorial](http://apigee.com/docs/insights/content/recommendations-tutorial): Walk through or build this application.
- [Apigee Insights](http://apigee.com/docs/insights/content/insights-home): 
- [Apigee API BaaS](http://apigee.com/docs/api-baas): 
- [Apigee-127](http://apigee.com/docs/api-services/content/apigee-127):
