downloadDirectory <- "/Users/akhilesh/insights-samples/cookbook/test"
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
installBaseUrl <- paste(baseUrl,"cookbook/",sep="")
installFile <- "install.R"
installUrl <- paste(installBaseUrl,installFile,sep="")
installDestination <- file.path(downloadDirectory,installFile)
apigee_download(installUrl, installDestination)
source(installDestination)
downloadDirectory <- NULL