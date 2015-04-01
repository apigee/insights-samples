#change this if you want a different directory as your download path.
if(!exists("downloadDirectory") || is.null(downloadDirectory))
  downloadDirectory <- getwd()

apigee_download <- function(downloadUrl, destinationFile)
{
  cat("Downloading from ",downloadUrl,"\n",sep="")
  tryCatch({download.file(url=downloadUrl,destinationFile)},
           error=function(x){
             tryCatch({download.file(url=downloadUrl,destinationFile,method="curl")},
                      warning=function(y)
                      {
                        tryCatch({download.file(url=downloadUrl,destinationFile,method="wget")},
                                 warning=function(z)
                                 {
                                   stop("Cannot start download.")
                                 })
                      })
           })
  cat("Copied to ",destinationFile,"\n",sep="")
}
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"

modelUrl <- paste(baseUrl,"recommendations-app/model/",sep="")

plotScript <- "purchase-predict-plots.R"
plotScriptUrl <- paste(modelUrl,plotScript,sep="")
plotScriptDestination <- file.path(downloadDirectory,plotScript)

createScript <- "purchase-predict-model.R"
createScriptUrl <- paste(modelUrl,createScript,sep="")
createScriptDestination <- file.path(downloadDirectory,createScript)

apigee_download(plotScriptUrl, plotScriptDestination)
apigee_download(createScriptUrl, createScriptDestination)

file.edit(plotScriptDestination)
file.edit(createScriptDestination)
