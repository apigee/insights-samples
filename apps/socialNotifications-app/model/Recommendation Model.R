library(ApigeeInsights)
account <- connect(configFile = "~/mwb.conf")
myID <- "v6"
projectName <- paste("BigZExpanded", myID, sep="-")

setCatalog("Big_Z_ver2")

modelName <- paste(projectName, "NotificationPropensity", myID, sep="-")
model <- Model$new(project=projectName, name=modelName, 
                   description="A model to calculate propensity for different notification types.")
model$setDateFilter(startTime="2014-01-01 00:00:00", endTime="2014-02-15 23:59:59")

model$setProfile(dataset="Cutomer_profile", 
                 dimensions=list(c("AgeGroup", "Gender",
                                   "DownloadedMobileApp",
                                   "EmailSubscriber")))

model$addActivityEvent(dataset="MobileInterations", dimensions=list("Action","productID", c("Action","productID"))) 
model$addActivityEvent(dataset="Notifications", dimensions=list("notificationType", "productID"))
model$setResponseEvent(dataset="MobileResponse", predictionDimensions="notificationType")

model$setConfiguration("distanceIntervalStart","DAY")
model$execute()
model$getStatus()

scoreName <- paste(projectName, "NotificationModelScore", myID, sep="-")
score <- Score$new(model, name=scoreName, 
                   description="Output score from applying the model to the scoring dataset", 
                   targetScoreTime="2014-02-16 00:00:00")

# Execute the scoring process on the server.
score$execute()
score$getStatus()

# Create a report object with a name to identify it on the server. 
reportName <- paste("NotoficationModelAccuracyReport", myID, sep="-")
report <- Report$new(score=score, name=reportName)

# Execute the reporting process on the server.
report$execute()
report$getStatus()


##### Step 7: Get the accuracy report and plot it into a chart.

# Plot the gain, lift, and AUC charts.
report$plot("RelevantReviews", type="GAIN")
report$plot("RelevantReviews", type="LIFT")


report$plot("RelevantAccessoriesForNearbyStore", type="AUC")
