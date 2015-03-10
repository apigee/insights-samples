# This script creates and scores a model designed to predict the propensity 
# for a user to buy a particular product. The script connects to the Insights 
# server and its functions set model, score, and report configuration. Where 
# execute methods are called, the script tells the server to use the 
# configuration to create a model, score, or report.

##### Step 1: Connect to Insights environment and library.

# Use the ApigeeInsights R package to provide modeling functions.
library(ApigeeInsights)
ls <- rm();

# Create a connection for creating the model on the Insights server.
# Before you can create a connection, you'll need to edit values in the .cnf
# file, adding values you can use to connect to Insights.
account <- connect(configFile="insights-connection.cnf")

# Change this value to append new models, scores, and reports with
# your name as an identifier. For each new model, score, and report
# you create, you'll need a name that's unique in your Insights instance. 
myID <- "your-name-or-other-identifier"

# Create a connection for creating the model on the Insights server.
account <- connect(account = accountName, user = userName, 
                   password = password,
                   host = hostName)


##### Step 2: Get things started by identifying a server-side
##### project and the catalog holding the data.

# Name the server-side project that will hold the modeling
# configuration created by this code. Insights creates the project.
projectName <- paste("RecommendationsTutorial", myID, sep="-")

# Specify the catalog that contains the datasets to be 
# used by this model.
setCatalog("RetailDatasets")


##### Step 3: Create the model. This code specifies the pieces of data 
##### to use in "training" the model. In training, Insights uses a subset
##### of the data to identify patterns based on the events you specify.
##### Further in the code, you have Insights apply the model to a fresh 
##### set of data.

# Create a model object so you can start setting model details. The name 
# value is used to identify the model on the server.

# This code creates a NEW model, rather than using the pre-installed model.
modelName <- paste("RecommendationsModel", myID, sep="-")
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

# Identify the target dataset for modeling. In a model, the target is the
# event representing the outcome you're trying to predict. 
model$setResponseEvent(dataset="Purchase", predictionDimensions="ProductName")


##### Step 4: Execute model training.

# Tell Insights to begin looking for patterns based on the information
# you've supplied. Depending on the amount of data, it can take some 
# time to execute the model. Use the getStatus function to report progress
# to the console.

# Uncomment these lines to create your own model on the server, 
# executing the model as configured using the preceding code.
#model$execute()
#model$getStatus()


##### Step 5: Score the model. When scoring, you apply the newly created model
##### against fresh data to see how reliable the model is. 

# Get the EXISTING model from the Insights server to build a NEW score 
# and report with. Comment the following two lines to 
# have the remainder of the code use the model configured above.
modelName <- paste("RecommendationsModel")
projectName <- paste("RecommendationsTutorial")

# Get the model from the server.
model <- account$getProject(projectName)$getModel(modelName)

# Create a score object. The target score time specifies the start of 
# the timestamp range for data to use when scoring. By default, the end time
# omitted here is the latest timestamp found in the data.
scoreName <- paste("RecommendationsModelScore", myID, sep="-")
score <- Score$new(model, name=scoreName, 
                   description="Output score from applying the model to the scoring dataset", 
                   targetScoreTime="2013-08-20")

# Execute the scoring process on the server.
score$execute()
score$getStatus()


##### Step 6: Generate a model accuracy report.

# Create a report object with a name to identify it on the server. 
reportName <- paste("RecommendationsModelAccuracyReport", myID, sep="-")
report <- Report$new(score=score, name=reportName)

# Execute the reporting process on the server.
report$execute()
report$getStatus()


##### Step 7: Get the accuracy report and plot it into a chart.

# Load EXISTING report data from the server into an object. Comment the first lines
# and uncomment the second to have this code plot reports for the model
# configured above.
chartReport <- account$getProject("RecommendationsTutorial")$getModel("RecommendationsModel")$getScore("RecommendationsModelScore")$getReport("RecommendationsModelAccuracyReport")
#cReport <- account$getProject(projectName)$getModel(modelName)$getScore(scoreName)$getReport(reportName)

chartReport$getStatus()

# Plot the gain chart.
chartReport$plot("SkipHopZooBackpack", type="GAIN")

# Plot the lift chart.
chartReport$plot("SkipHopZooBackpack", type="LIFT")

# Plot the "area under the curve" chart. 
chartReport$plot("SkipHopZooBackpack", type="AUC")

