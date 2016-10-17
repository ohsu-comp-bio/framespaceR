#' Sets up a dataframe slice request
#' @description Performs /dataframe/slice request
#' @param dataframeId \strong{string}
#' @param newMajorId \strong{string} keyspaceId for the major dimension
#' @param newMajorKeys \strong{vector} atomic vector of keys associated with the major dimension
#' @param newMinorId \strong{string} keyspaceId for the minor dimension
#' @param newMajorKeys \strong{vector} atomic vector of keys associated with the minor dimension
#' @param pageStart \strong{integer}
#' @param pageEnd \strong{integer}
#' @return FrameSpace DataFrame
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
