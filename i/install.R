########GLOBALS##########
orgName <- "<OrgName>"
userName <- "<UserName>"
#########################
ask_for_password <- function()
{
  pass <- NULL
  if(Sys.getenv("RSTUDIO") == "1")
  {
    pass <- .rs.askForPassword("Enter your Apigee password:")
  }
  else if(.Platform$OS.type == "unix" && .Platform$GUI == "X11")
  {
    cat("Enter your Apigee password:\n") 
    pass <- system("stty -echo; read PASSWORD; stty echo; echo $PASSWORD",intern=T)
  }
  else
  {
    cat("Enter your Apigee password:\n") 
    pass <- readline()
    cat(rep("\n",150))
  }
  return(pass)
}
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
confTemplate <- '{"account":"%s","user":"%s","password":"%s"}'
confStr <- ask_for_password()
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"
libUrl <- paste(baseUrl,"lib/",sep="")
rPackage <- "ApigeeInsights_0.5.3.tar.gz"
rPackageUrl <- paste(libUrl,rPackage,sep="")
rPackageDestination <- file.path(getwd(),rPackage)

modelUrl <- paste(baseUrl,"recommendations-app/model/",sep="")
#confFile <- "insights-connection-config"
#confFileUrl <- paste(modelUrl,confFile,sep="")
#confFileDestination <- file.path(getwd(),confFile)

plotScript <- "purchase-predict-plots.R"
plotScriptUrl <- paste(modelUrl,plotScript,sep="")
plotScriptDestination <- file.path(getwd(),plotScript)

createScript <- "purchase-predict-model.R"
createScriptUrl <- paste(modelUrl,createScript,sep="")
createScriptDestination <- file.path(getwd(),createScript)

apigee_install(rPackageUrl, rPackageDestination)
#apigee_install(confFileUrl, confFileDestination)
apigee_install(plotScriptUrl, plotScriptDestination)
apigee_install(createScriptUrl, createScriptDestination)


file.edit(plotScriptDestination,createScriptDestination)
Sys.sleep(1)
#file.edit(confFileDestination)



#remove.packages(c("ApigeeInsights"))
#install_packages(c("RCurl", "pander", "RJSONIO"))
#install.packages(rPackageDestination,repo=NULL,type="source")
