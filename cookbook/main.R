tryCatch({
  args <- commandArgs(trailingOnly = TRUE)
  #change this if you want a different directory as your download path.
  if(length(args) == 0) downloadDirectory <- getwd() else downloadDirectory <- args[[1]]
  baseUrl <- "https://raw.githubusercontent.com/apigee/insights-samples/master/"
  installBaseUrl <- paste(baseUrl,"cookbook/",sep="")
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
  commandArgs <- function(trailingOnly)
  {
    return(c(downloadDirectory))
  }
  downloadAndSource <- function(file)
  {
    installFile <- file
    installUrl <- paste(installBaseUrl,installFile,sep="")
    installDestination <- file.path(downloadDirectory,installFile)
    apigee_download(installUrl, installDestination)
    source(installDestination)
  }
  invisible(sapply(c("downloadSamples.R","install.R"), downloadAndSource))
}, error = function(x) {
  commandArgs <- base::commandArgs
})