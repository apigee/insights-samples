# Overview of this script.


##### Step 1: Connect to Insights environment and library #####
library(ApigeeInsights)
ls <- rm();

# Connection params.
accountName <- "your-insights-account-name"
userName <- "your-insights-username"
password <- "your-insights-password"
hostName <- "url-to-your-insights-host"

account <- connect(account = accountName, user = userName, password = password,
                   host = hostName)

##### Step 2: Create project name, identify the catalog where the data is located, and name the model #####
project_name <- paste("RecommendationTutorial-",Sys.info()[[7]],sep="")
setCatalog("BigZDemo")
model <- Model$new(project=project_name,name="RecommendationTutorialModel",description="Recommendation Model")


##### Step 3: Set time frame for training data and identify event and profile datasets and specify attributes to be used in training the model #####
model$setDateFilter(startTime="2013-01-01 00:00:00" , endTime="2013-08-19 23:59:59")
model$addActivityEvent(dataset="VisitWeb", dimensions="Page")
model$addActivityEvent(dataset="Return", dimensions=list(c("Product","Reason")))
model$addActivityEvent(dataset="VisitStore2", dimensions="City")
model$addActivityEvent(dataset="CustService3", dimensions="Reason")
model$addActivityEvent(dataset="Offer", dimensions=list(c("Response","OfferType")))

model$setProfile(dataset="Profile", dimensions=list(c("AgeGrp","Gender","MobileApp","EmailSubscriber")))


##### Step 4: Identify the Target dataset (required) for modeling #####
model$setResponseEvent(dataset="Purchase", predictionDimensions="Product")


##### Step 5: Execute model training ####
model$execute()
model$getStatus()


##### Step 6: Specify timeframe for dataset to be scored and execute model scoring process #####
score <- Score$new(model,name="RecommendationTutorialScore",description="Recommendation Score",targetScoreTime="2013-08-20")
score$execute()
score$getStatus()


##### Step 7: Generate model accuracy report and AUC chart #####
report <- Report$new(score=score,name="RecommendationTutorialReport")
report$execute()
report
report$getStatus()

cReport <- account$getProject("RecommendationTutorial-ApigeeCorporation")$getModel("RecommendationTutorialModel")$getScore("RecommendationTutorialScore")$getReport("RecommendationTutorialReport")
cScore <- account$getProject("RecommendationTutorial-ApigeeCorporation")$getModel("RecommendationTutorialModel")$getScore("RecommendationTutorialScore")
cReport$getStatus()
cReport$plot(type="AUC")
cReport$plot("SkipHopZooBackpack",type="AUC")

# Plots you might find useful.
cReport$plot(type="GAIN")
cReport$plot(type="LIFT")
