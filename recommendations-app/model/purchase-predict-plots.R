# This script simply retrieves information from an existing score and report,
# printing the information in tabular and chart formats.

# Connect to Insights environment and load the library #####
library(ApigeeInsights)
ls <- rm();

# Connection params.
accountName <- "iot"
userName <- "iot"
password <- "insightsone765"
hostName <- "http://ec2-54-187-95-59.us-west-2.compute.amazonaws.com:8080/api"

account <- connect(account = accountName, user = userName, password = password,
                   host = hostName)

# Declare which report and score to get information about.

cReport <- account$getProject("RecommendationTutorial-ApigeeCorporation")$getModel("RecommendationTutorialModel")$getScore("RecommendationTutorialScore")$getReport("RecommendationTutorialReport")
cScore <- account$getProject("RecommendationTutorial-ApigeeCorporation")$getModel("RecommendationTutorialModel")$getScore("RecommendationTutorialScore")

# Print out the score and report objects in tabular form.
# These lines print (to the console) what the top 10
# items in the score and report actually contain.

stream(cScore, 10)
stream(cReport, 10)

# Plot the report data in charts.

# Plot the "area under the curve" chart. 
cReport$plot(type="AUC")
cReport$plot("SkipHopZooBackpack",type="AUC")
# Plot the gain chart.
cReport$plot(type="GAIN")
# Plot the lift chart.
cReport$plot(type="LIFT")
