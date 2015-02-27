# Overview of this script.


##### Step 1: Connect to Insights environment and library #####
library(ApigeeInsights)
ls <- rm();

# Variables for parameters to use when connecting to Insights from R. Replace
# the values here with values for your Insights account.
accountName <- "your-insights-account-name"
userName <- "your-insights-username"
password <- "your-insights-password"
hostName <- "url-to-your-insights-host"

account <- connect(account = accountName, user = userName, password = password,
                   host = hostName)

##### Step 2: Create project name, identify the catalog where the data is located, and name the model #####
project_name <- paste("RecommendationsTutorial")

setCatalog("SampleDataset")

model <- Model$new(project=project_name,name="RecommendationsModel", 
                  description="A model to show propensity for buying a particular product.")


##### Step 3: Set time frame for training data and identify event and profile datasets and specify attributes to be used in training the model #####
model$setDateFilter(startTime="2013-01-01 00:00:00" , endTime="2013-08-19 23:59:59")
model$addActivityEvent(dataset="WebsiteVisit", dimensions="Page")
model$addActivityEvent(dataset="Return", dimensions=list(c("ProductName","Reason")))
model$addActivityEvent(dataset="StoreVisit", dimensions="City")
model$addActivityEvent(dataset="CustomerServiceCall", dimensions="Reason")
model$addActivityEvent(dataset="Offer", dimensions=list(c("Response","OfferType")))

model$setProfile(dataset="Profile", 
                 dimensions=list(c("AgeGroup", "Gender",
                                   "DownloadedMobileApp",
                                   "EmailSubscriber")))


##### Step 4: Identify the Target dataset (required) for modeling #####
model$setResponseEvent(dataset="Purchase", predictionDimensions="ProductName")


##### Step 5: Execute model training ####
model$execute()
model$getStatus()


##### Step 6: Specify timeframe for dataset to be scored and execute model scoring process #####
score <- Score$new(model,name="RecommendationsModelScore", 
                   description="Output score from applying the model to the scoring dataset", 
                   targetScoreTime="2013-08-20")
score$execute()
score$getStatus()


##### Step 7: Generate model accuracy report and AUC chart #####
report <- Report$new(score=score, name="RecommendationsModelAccuracyReport")
report$execute()
report$getStatus()

cScore <- account$getProject("RecommendationsTutorial")$getModel("RecommendationsModel")$getScore("RecommendationsModelScore")

cReport <- account$getProject("RecommendationsTutorial")$getModel("RecommendationsModel")$getScore("RecommendationsModelScore")$getReport("RecommendationsModelAccuracyReport")

cReport$getStatus()

cReport$plot("SkipHopZooBackpack",type="AUC")
cReport$plot("SkipHopZooBackpack", type="GAIN")
cReport$plot("SkipHopZooBackpack", type="LIFT")
