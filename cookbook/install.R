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
install_packages <- function(packages)
{
  for(p in packages)
  {
    if(!is.element(p, installed.packages()[,1]))
    {
      install.packages(p)
    }
    else
    {
      cat("Skipping package ",p,".. Already Installed.\n",sep="")
    }
  }
}
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"
libUrl <- paste(baseUrl,"lib/",sep="")
rPackage <- "ApigeeInsights_2.2.0.tar.gz"
rPackageUrl <- paste(libUrl,rPackage,sep="")
rPackageDestination <- file.path(downloadDirectory,rPackage)

modelUrl <- paste(baseUrl,"apps/recommendations-app/model/",sep="")
confFile <- "insights-connection-config"
confFileUrl <- paste(modelUrl,confFile,sep="")
confFileDestination <- file.path(downloadDirectory,confFile)

invisible(apigee_download(rPackageUrl, rPackageDestination))
invisible(apigee_download(confFileUrl, confFileDestination))
file.edit(confFileDestination)

remove.packages(c("ApigeeInsights"))
install_packages(c("RCurl", "pander", "RJSONIO"))
install.packages(rPackageDestination,repo=NULL,type="source")
cat("Config file would be downloaded to ",confFileDestination,"\n",sep="")
