# Overview of this script.


##### Step 1: Connect to Insights environment and library #####
library(ApigeeInsights)
ls <- rm();

# Connection params.
accountName <- "your-insights-account-name"
userName <- "your-insights-user-name"
password <- "your-insights-password"
hostName <- "http://insights.host.name:portnumber"
jobManagerUrl <- "http://http://insights.host.name/insightsOne.html"

# Create a connection object
insightsAccount <- connect(account=accountName, user=userName, password=password, 
                   host=hostName, jobManagerBase=jobManagerUrl)


##### Step 2: Create project name, identify the catalog
##### where the data is located, and name the model #####
project_name <- paste("RetailProject1-", Sys.info()[[7]],sep="")
setCatalog("RetailDemo3")
model <- Model$new(project=project_name,
    name="RetailModel12", description="Recommendation Model")


##### Step 3: Set time frame for training data and identify event and
##### profile datasets and specify attributes to be used in training the model #####
model$setDateFilter(endTime="2013-09-19 23:59:59")
model$addActivityEvent(dataset="VisitWeb", dimensions="Page")
model$addActivityEvent(dataset="Return", dimensions="Product")
model$addActivityEvent(dataset="VisitStore", dimensions="City")
model$addActivityEvent(dataset="CustServ", dimensions="Channel")
model$setProfile(dataset="Profile", dimensions=list(c("AgeGrp",
    "Gender","MobileApp","LoyaltyCard")))


##### Step 4: Identify relevant Impression dataset (optional) and the
##### Target dataset (required) for modeling #####
model$setImpressionEvent(dataset="Offer3",
    responseMerge=ApigeeInsights::merge(by.response=c("UserID","Product"),
    by.impression=c("UserID","Product")))
model$setResponseEvent(dataset="Purchase3", predictionDimensions="Product",
    metric="Response")


##### Step 5 (Optional): Set desired model configuration
##### (if left unspecified default parameters will be used) #####
model$setConfiguration("distanceIntervalStart","DAY")
model$setConfiguration("firstLevelThreshold","5")
model$setConfiguration("setTreshold","2")
model$setConfiguration("responseThreshold","2")


##### Step 6: Execute model training ####
model$execute()
model$getStatus()


##### Step 7: Specify timeframe for dataset to be
##### scored and execute model scoring process #####
score <- Score$new(model,name="RecommendationScore-13",
    description="Retail Score",targetScoreTime="2013-09-20")
score$execute()
score$getStatus()


##### Step 8: Generate model accuracy report and AUC chart #####
report <- Report$new(score=score,name="RecommendationReport12")
report$execute()
report
report$getStatus()

cReport <- insightsAccount$getProject("RetailProject1-demo")$getModel("RetailModel12")$getScore("RecommendationScore-12")$getReport("RecommendationReport12")
cReport$getStatus()
#cReport$plot(type="AUC")
cReport$plot("CanonEOS6D",type="AUC")
