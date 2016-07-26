#' Sets up a dataframe slice request
#' @description Formats a /dataframe/slice request to send through the framereq or bufferreq functions.
#' @param dataframeId \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param newMajor \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param newMinor \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageStart \strong{integer}
#' @param pageEnd \strong{integer}
#' @return A properly formatted request
#' @export
dfslice <- function(dataframeId, newMajor = NULL, newMinor = NULL, pageStart = NULL, pageEnd = NULL){
  req <- list(dataframeId = dataframeId, newMajor = "", newMinor = "", pageStart = pageStart, pageEnd = "")
  req$dataframeId <- unbox(dataframeId)
  req$newMajor <- list(keys = newMajor)
  req$newMinor <- list(keys = newMinor)
  req$pageStart <- unbox(pageStart)
  req$pageEnd <- unbox(pageEnd)
  return(req)
}
