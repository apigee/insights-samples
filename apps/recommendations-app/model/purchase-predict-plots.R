# This script simply retrieves information from an existing score and report
# on the Insights server, printing the information in table and chart formats.

# Load the Insights R package.
library(ApigeeInsights)

# Collect configuration parameters from the config insights-connection-config file. 
# The paste function forms a path by concatenating the working directory 
# (where this R file is) with the name of the config file. If your config file isn't
# in the same directory as this script file, be sure to make the appropriate changes.
config <- paste(getwd(),"/insights-connection-config",sep="")
# Connect to the Insights server, but do it invisibly (without printing to the console).
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
