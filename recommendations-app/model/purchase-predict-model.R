# This script creates and scores a model designed to predict the propensity 
# for a user to buy a particular product. The script connects to the Insights 
# server and its functions set model, score, and report configuration. Where 
# execute methods are called, the script tells the server to use the 
# configuration to create a model, score, or report.

##### Step 1: Connect to Insights environment and library.

# Use the ApigeeInsights R package to provide modeling functions.
library(ApigeeInsights)

# Variables for parameters to use when connecting to Insights 
# from code. Replace the values here with values for your Insights account.
accountName <- "your-insights-account-name"
userName <- "your-insights-username"
password <- "your-insights-password"
hostName <- "url-to-your-insights-host"

# Create a connection for creating the model on the Insights server.
account <- connect(account = accountName, user = userName, 
                  password = password, host = hostName)

# Change this value to append new models, scores, and reports with
# something as an identifier. This helps avoid conflicts with artifacts
# already on the server. Each time you run this script to create new 
# objects on the server, you’ll need to change this value to avoid
# name conflicts with objects already on the server.
myID <- "version1"

##### Step 2: Get things started by identifying a server-side
##### project and the catalog holding the data.

# Name the server-side project that will hold the modeling
# configuration created by this code. Insights creates the project.
projectName <- paste("RecTutorial", myID, sep="-")

# Specify the catalog that contains the datasets to be 
# used by this model. RetailDatasets is a pre-installed catalog.
setCatalog("RetailDatasets")

##### Step 3: Create the model. This code specifies the pieces of data 
##### to use in "training" the model. In training, Insights uses a subset
##### of the data to identify patterns based on the events you specify.
##### Further in the code, you have Insights apply the model to a fresh 
##### set of data.

# Create a model object so you can start setting model details. The name 
# value is used to identify the model on the server.
modelName <- paste("RecModel", myID, sep="-")
model <- Model$new(project=projectName, name=modelName, 
                   description="A model to show propensity for buying a particular product.")

# Set time frame for training data. The model will be created by analyzing 
# events whose timestamps fall within these boundaries.
model$setDateFilter(startTime="2013-01-01 00:00:00", endTime="2013-08-19 23:59:59")

# Set the user profile dataset to use, along with the parts of the data 
# that should be considered in looking for patterns.
model$setProfile(dataset="Profile", 
                 dimensions=list(c("AgeGroup", "Gender",
                                   "DownloadedMobileApp",
                                   "EmailSubscriber")))

# Add the events to look at for patterns. Each of these lines specifies 
# an event dataset, along with the event attributes to include as dimensions 
# in the model. Attributes correspond to columns in imported data.
model$addActivityEvent(dataset="WebsiteVisit", dimensions="ProductCategory")
model$addActivityEvent(dataset="Return", dimensions=list(c("ProductName","Reason")))
model$addActivityEvent(dataset="StoreVisit", dimensions="City")
model$addActivityEvent(dataset="CustomerServiceCall", dimensions="Reason")
model$addActivityEvent(dataset="Offer", dimensions=list(c("ProductName","OfferType")))

# Identify the response dataset for modeling. In a model, the response is the
# event representing the outcome you're trying to predict. 
model$setResponseEvent(dataset="Purchase", predictionDimensions="ProductName")


##### Step 4: Execute model training.

# Tell Insights to begin looking for patterns based on the information
# you've supplied. Depending on the amount of data, it can take some 
# time to execute the model. Use the getStatus function to report progress
# to the console.
model$execute()
model$getStatus()


##### Step 5: Score the model. When scoring, you apply the newly created model
##### against fresh data to see how reliable the model is. 

# Create a score object. The target score time specifies the start of 
# the timestamp range for data to use when scoring. By default, the end time
# omitted here is the latest timestamp found in the data.
scoreName <- paste("RecModelScore", myID, sep="-")
score <- Score$new(model, name=scoreName, 
                   description="Output score from applying the model to the scoring dataset", 
                   targetScoreTime="2013-08-20")

# Execute the scoring process on the server.
score$execute()
score$getStatus()

##### Step 6: Generate a model accuracy report.

# Create a report object with a name to identify it on the server. 
reportName <- paste("RecModelAccuracyReport", myID, sep="-")
report <- Report$new(score=score, name=reportName)

# Execute the reporting process on the server.
report$execute()
report$getStatus()


##### Step 7: Get the accuracy report and plot it into a chart.

# Plot the gain, lift, and AUC charts.
report$plot("SkipHopZooBackpack", type="GAIN")
report$plot("SkipHopZooBackpack", type="LIFT")
report$plot("SkipHopZooBackpack", type="AUC")
