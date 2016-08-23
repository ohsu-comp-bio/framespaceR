#' Sets up a dataframe slice request
#' @description Formats a /dataframe/slice request to send through the framereq or bufferreq functions.
#' @param dataframeId \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param newMajor \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param newMinor \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageStart \strong{integer}
#' @param pageEnd \strong{integer}
#' @return A properly formatted request
#' @import jsonlite
#' @export
dfslice <- function(dataframeId, newMajor = NULL, newMinor = NULL, pageStart = NULL, pageEnd = NULL){
  req <- list(dataframeId = dataframeId, newMajor = "", newMinor = "", pageStart = pageStart, pageEnd = "")
  req$dataframeId <- unbox(dataframeId)
  if(!is.null(newMajor)){
    req$newMajor <- list(keys = newMajor)
  }
  else{
    req$newMajor <- unbox(newMajor)
  }
  if(!is.null(newMinor)){
    req$newMinor <- list(keys = newMinor)
  }
  else{
    req$newMinor <- unbox(newMinor)
  }
  req$pageStart <- unbox(pageStart)
  req$pageEnd <- unbox(pageEnd)
  return(req)
}
