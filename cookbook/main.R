filesToDownloadAndSource <- c("downloadSamples.R","install.R")
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"
downloadBaseUrl <- paste(baseUrl,"cookbook/",sep="")
args <- commandArgs(trailingOnly = TRUE)
#change this if you want a different directory as your download path.
downloadDirectory <- getwd()
if(length(args) > 0)
  downloadDirectory <- args[[1]]

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
                                   stop("Cannot download.")
                                 })
                      })
           })
  cat("Copied to ",destinationFile,"\n",sep="")
}
tryCatch({
  .GlobalEnv$commandArgs <- function(trailingOnly)
  {
    return(c(downloadDirectory))
  }
  downloadAndSource <- function(file)
  {
    downloadUrl <- paste(downloadBaseUrl,file,sep="")
    downloadDestination <- file.path(downloadDirectory,file)
    apigee_download(downloadUrl, downloadDestination)
    source(downloadDestination)
  }
  invisible(sapply(filesToDownloadAndSource, downloadAndSource))
  .GlobalEnv$commandArgs <- base::commandArgs
}, error = function(err) {
  .GlobalEnv$commandArgs <- base::commandArgs
  stop(err)
})