# This script simply retrieves information from an existing score and report
# on the Insights server, printing the information in table and chart formats.

# Connect to Insights environment and load the library #####
library(ApigeeInsights)

# Create a connection for creating the model on the Insights server.
# Make surethe path to the config file is proper
config <- paste(getwd(),"/insights-connection-config",sep="")
invisible(connect(configFile = config))

# Declare which report and score to get information about.
cModel <- getProject(name = "RecommendationsTutorial")$getModel(name = "RecommendationsModel")
cScore <- cModel$getScore(name = "RecommendationsModelScore")
cReport <- cScore$getReport(name = "RecommendationsModelAccuracyReport")

# Print out the score and report objects in tabular form. These lines print 
# (to the console) what the top 10 items in the score and report actually 
# contain.
cModel$stream(10)
cScore$stream(10)
cReport$stream(10)

## Plot the report data in charts.

# Plot the gain, lift, and AUC charts.
cReport$plot("SkipHopZooBackpack", type="GAIN")
cReport$plot("SkipHopZooBackpack", type="LIFT")
cReport$plot("SkipHopZooBackpack", type="AUC")
