args <- commandArgs(trailingOnly = TRUE)
#change this if you want a different directory as your download path.
downloadDirectory <- getwd()
if(length(args) > 0)
  downloadDirectory <- args[[1]]
apigee_is_unc <- function(path)
{
  uncPattern <- "//"
  return(substring(path, 1 ,nchar(uncPattern))== uncPattern)
}
apigee_check_update_unc <- function()
{
  #check for windows
  if(tolower(Sys.info()[['sysname']]) == "windows")
  {
    r_libs_user <- Sys.getenv("R_LIBS_USER")
    if(apigee_is_unc(r_libs_user))
    {  
      user_profile <- Sys.getenv("userprofile")
      user_name <- Sys.getenv("username")
      libp <- NULL
      rPath <- "\\AppData\\R\\Library"
      if(apigee_is_unc(user_profile))
      {
        libp  <- paste('c:\\Users\\',user_name,rPath,sep="")
      }
      else
      {
        libp  <- paste(user_profile,rPath,sep="")
      }
      proceed <- readline(prompt=paste("R_LIBS_USER is a UNC path - ",r_libs_user,"\nand cannot be used to install packages.\nDo you want to update R_LIBS_USER (y or n) [y]: ",sep=""))

      if(proceed == "" || tolower(proceed) == "y")
      {
        user_lib_path <- readline(prompt=paste("\nEnter a writable lib location.\nIf not provided, i will default to ",libp," : ",sep=""))
        if(user_lib_path != "")
        {
          if(apigee_is_unc(user_lib_path))
          {
            stop("The lib path cannot be a UNC path.")
          }
          libp <- user_lib_path
        }
        cmd  <- paste('setx R_LIBS_USER "',libp,'"',sep="")
        dir.create(libp, showWarnings = FALSE, recursive = TRUE)
        system(cmd)
        .libPaths(libp)
      }
    }
  }
}
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
apigee_check_update_unc()
baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"
libUrl <- paste(baseUrl,"lib/",sep="")
rPackage <- "ApigeeInsights_patch.tar.gz"
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
