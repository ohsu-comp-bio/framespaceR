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
dfslice <- function(url, dataframeId, newMajorId = NULL, newMajorKeys = NULL, newMinorId = NULL, newMinorKeys = NULL, pageStart = NULL, pageEnd = NULL, raw = FALSE){
  p <- new(framespace.SliceDataFrameRequest, dataframeId=dataframeId, pageStart=pageStart, pageEnd=pageEnd)
  p$newMajor$keyspaceId = newMajorId
  p$newMajor$add("keys", newMajorKeys)
  p$newMinor$keyspaceId = newMinorId
  p$newMinor$add("keys", newMinorKeys)

  l <- as.list(p)
  l$dataframeId <- unbox(l$dataframeId)
  l$newMajor <- as.list(l$newMajor)
  l$newMajor$keyspaceId <- unbox(l$newMajor$keyspaceId)
  l$newMinor <- as.list(l$newMinor)
  l$newMinor$keyspaceId <- unbox(l$newMinor$keyspaceId)
  resp <- post(paste(url, '/dataframe/slice', sep=""), l)
  if(raw){
    return(resp)
  }else{
    return(content(resp, as = "parsed"))
  }
}
