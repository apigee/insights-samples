# This script simply retrieves information from an existing score and report
# on the Insights server, printing the information in table and chart formats.

# Connect to Insights environment and load the library #####
library(ApigeeInsights)
ls <- rm();

# Variables for parameters to use when connecting to Insights from R. Replace
# the values here with values for your Insights account.
accountName <- "your-insights-account-name"
userName <- "your-insights-username"
password <- "your-insights-password"
hostName <- "http://insights.apigee.net/IOMarketingManagerAPISS"

# Connect to the server in order to retrieve data.
account <- connect(account = accountName, user = userName, 
                   password = password,
                   host = hostName)

# Declare which report and score to get information about.
cModel <- account$getProject("RecommendationsTutorial")$getModel("RecommendationsModel")
cScore <- cModel$getScore("RecommendationsModelScore")
cReport <- cScore$getReport("RecommendationsModelAccuracyReport")

# Print out the score and report objects in tabular form. These lines print 
# (to the console) what the top 10 items in the score and report actually 
# contain.
stream(cModel, 10)
stream(cScore, 10)
stream(cReport, 10)

## Plot the report data in charts.

# Plot the gain chart.
cReport$plot("SkipHopZooBackpack", type="GAIN")

# Plot the lift chart.
cReport$plot("SkipHopZooBackpack", type="LIFT")

# Plot the "area under the curve" chart. 
cReport$plot("SkipHopZooBackpack", type="AUC")
