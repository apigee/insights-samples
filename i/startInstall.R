apigee_install <- function(downloadUrl, destinationFile)
{
  cat("Downloading from ",downloadUrl,"\n",sep="")
  tryCatch({download.file(url=downloadUrl,destinationFile)},
           error=function(x){
             tryCatch({download.file(url=downloadUrl,destinationFile,method="curl")},
                      error=function(y)
                      {
                        download.file(url=downloadUrl,destinationFile,method="wget")
                      })
           })
  cat("Copied to ",destinationFile,"\n",sep="")
}
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"
installBaseUrl <- paste(baseUrl,"i/",sep="")
installFile <- "install.R"
installUrl <- paste(installBaseUrl,installFile,sep="")
installDestination <- file.path(getwd(),installFile)
apigee_install(installUrl, installDestination)
source(installDestination)
