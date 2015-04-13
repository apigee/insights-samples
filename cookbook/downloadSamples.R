args <- commandArgs(trailingOnly = TRUE)
#change this if you want a different directory as your download path.
downloadDirectory <- getwd()
if(length(args) > 0)
  downloadDirectory <- args[[1]]

apigee_download <- function(downloadUrl, destinationFile)
{
  overwrite <- "y"
  if(file.exists(destinationFile))
  {
    overwrite <- readline(prompt=paste("File (",destinationFile,") already available. Overwrite? (y or n) [y]: ",sep=""))
  }
  if(overwrite == "n")
    return()
  cat("Downloading from ",downloadUrl,"\n",sep="")
  tryCatch({download.file(url=downloadUrl,destinationFile)},
           error=function(x){
             tryCatch({download.file(url=downloadUrl,destinationFile,method="curl")},
                      warning=function(y)
                      {
                        tryCatch({download.file(url=downloadUrl,destinationFile,method="wget")},
                                 warning=function(z)
                                 {
                                   stop("Cannot download.")
                                 })
                      })
           })
  cat("Copied to ",destinationFile,"\n",sep="")
}
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"

modelUrl <- paste(baseUrl,"apps/recommendations-app/model/",sep="")

plotScript <- "purchase-predict-plots.R"
plotScriptUrl <- paste(modelUrl,plotScript,sep="")
plotScriptDestination <- file.path(downloadDirectory,plotScript)

createScript <- "purchase-predict-model.R"
createScriptUrl <- paste(modelUrl,createScript,sep="")
createScriptDestination <- file.path(downloadDirectory,createScript)

invisible(apigee_download(plotScriptUrl, plotScriptDestination))
invisible(apigee_download(createScriptUrl, createScriptDestination))

file.edit(plotScriptDestination)
file.edit(createScriptDestination)
