#' Sets up a dataframe slice request
#' @description formats the request to send through the refreq function
#' @param dataframeId = an atomic vector of strings e.g. c("a", "b", "c")
#' @param newMajor = dimention
#' @param newMinor = dimention
#' @param pageStart = integer
#' @param pageEnd = integer
#' @return A properly formatted request
#' @export
dfslice <- function(dataframeId, newMajor = NULL, newMinor = NULL, pageStart = NULL, pageEnd = NULL){
  req <- list(dataframeId = dataframeId, newMajor = "", newMinor = "", pageStart = pageStart, pageEnd = "")
  req$dataframeId <- unbox(dataframeId)
  req$newMajor <- newMajor
  req$newMinor <- newMinor
  req$pageStart <- unbox(pageStart)
  req$pageEnd <- unbox(pageEnd)
  return(req)
}
