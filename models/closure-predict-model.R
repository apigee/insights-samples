# This script creates and scores a model designed to predict the propensity 
# for a user to close an account with their financial institution.

## This script assumes that you've imported the financial data available
## in the Insights sample github repository at 
## https://github.com/apigee/insights-samples/tree/master/data 
## Be sure that the names of the catalog you create when importing 
## matches the name given here in the setCatalog function. 

##### Step 1: Connect to Insights environment and library.

# Use the ApigeeInsights R package to provide modeling functions.
library(ApigeeInsights)

# Variables for parameters to use when connecting to Insights 
# from code. Replace the values here with values for your Insights account.
accountName <- "your-insights-account-name"
userName <- "your-insights-username"
password <- "your-insights-password"
hostName <- "https://insights.apigee.net/api"

# Create a connection for creating the model on the server.
account <- connect(account = accountName, user = userName, 
                   password = password, host = hostName)

# Change this value to append the names of new models, scores, and reports with
# an identifier. This helps avoid conflicts with artifacts already on the server.
myID <- "v1"

##### Step 2: Identify a server-side project and the catalog holding the data.

# Name the server-side project that will hold the modeling
# configuration created by this code.
projectName <- paste("financial", myID, sep="-")

# Specify the catalog that contains the datasets to be 
# used by this model.
setCatalog("Financial")

##### Step 3: Create the model to train it with a subset of the data to 
##### identify patterns based on the events you specify.

# Create a model object so you can start setting model details. The model name 
# identifies the model on the server.
modelName <- paste("FinancialModel", myID, sep="-")
model <- Model$new(project=projectName, name=modelName, 
                   description="A model to show propensity for closing an account.")

# Set time frame for training data.
model$setDateFilter(startTime="2013-01-01 00:00:00", endTime="2013-08-30 23:59:59")

# Set the user profile data to consider in looking for patterns.
model$setProfile(dataset="User", 
                 dimensions=list(c("Age", "Gender",
                                   "Length_of_Residence_Experian",
                                   "Risk_Profile",
                                    "Person_1_Marital_Status_Experian",
                                   "Zip_Code_Experian",
                                   "MHP_Mortgage_Amount_Experian",
                                   "Income_Model_est_HH_code_SCS_v4_Experian",
                                   "Household_Composition_Experian")))

# Add the events to look at for patterns.
model$addActivityEvent(dataset="News", dimensions="type")
model$addActivityEvent(dataset="Purchase", dimensions="type")
model$addActivityEvent(dataset="Transfer", dimensions="type")

# Identify the response event representing the outcome you're trying to predict. 
model$setResponseEvent(dataset="Account", predictionDimensions="type")


##### Step 4: Execute model training.

# Tell Insights to begin looking for patterns.
model$execute()
model$getStatus()


##### Step 5: Score the model. When scoring, you apply the newly created model
##### against fresh data to see how reliable the model is. 

# Create a score object.
scoreName <- paste("FinancialScore", myID, sep="-")
score <- Score$new(model, name=scoreName, 
                   description="Output score from applying the model to the scoring dataset", 
                   targetScoreTime="2013-08-12")

# Execute the scoring process on the server.
score$execute()
score$getStatus()

##### Step 6: Generate a model accuracy report.

# Create a report object with a name to identify it on the server. 
reportName <- paste("FinancialReport", myID, sep="-")
report <- Report$new(score=score, name=reportName)

# Execute the reporting process on the server.
report$execute()
report$getStatus()



##### Step 7: Get the accuracy report and plot it into a chart.

# Plot the gain, lift, and AUC charts.
report$plot("CloseAccount", type="GAIN")
report$plot("CloseAccount", type="LIFT")
report$plot("CloseAccount", type="AUC")

