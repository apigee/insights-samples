# This script simply retrieves information from an existing score and report
# on the Insights server, printing the information in table and chart formats.

# Connect to Insights environment and load the library #####
library(ApigeeInsights)
ls <- rm();

# Variables for parameters to use when connecting to Insights 
# from code. Replace the values here with values for your Insights account.
accountName <- "your-insights-account-name"
userName <- "your-insights-username"
password <- "your-insights-password"
hostName <- "url-to-your-insights-host"

# Create a connection for creating the model on the Insights server.
account <- connect(account = accountName, user = userName, 
                   password = password, host = hostName)

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

# Plot the gain, lift, and AUC charts.
cReport$plot("SkipHopZooBackpack", type="GAIN")
cReport$plot("SkipHopZooBackpack", type="LIFT")
cReport$plot("SkipHopZooBackpack", type="AUC")
