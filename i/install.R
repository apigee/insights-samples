########GLOBALS##########
orgName <- "<OrgName>"
userName <- "<UserName>"
#########################
apigee_download <- function(downloadUrl, destinationFile)
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
rPackageDestination <- file.path(getwd(),rPackage)

modelUrl <- paste(baseUrl,"recommendations-app/model/",sep="")
confFile <- "insights-connection-config"
confFileUrl <- paste(modelUrl,confFile,sep="")
confFileDestination <- file.path(getwd(),confFile)

plotScript <- "purchase-predict-plots.R"
plotScriptUrl <- paste(modelUrl,plotScript,sep="")
plotScriptDestination <- file.path(getwd(),plotScript)

createScript <- "purchase-predict-model.R"
createScriptUrl <- paste(modelUrl,createScript,sep="")
createScriptDestination <- file.path(getwd(),createScript)

apigee_download(rPackageUrl, rPackageDestination)
apigee_download(confFileUrl, confFileDestination)
apigee_download(plotScriptUrl, plotScriptDestination)
apigee_download(createScriptUrl, createScriptDestination)


file.edit(plotScriptDestination)
file.edit(createScriptDestination)
Sys.sleep(1)
file.edit(confFileDestination)


remove.packages(c("ApigeeInsights"))
install_packages(c("RCurl", "pander", "RJSONIO"))
install.packages(rPackageDestination,repo=NULL,type="source")
