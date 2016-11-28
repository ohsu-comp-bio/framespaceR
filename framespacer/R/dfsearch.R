#' Sets up a search dataframe request
#' @description Perform /dataframes/search request
#' @param keyspaceIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param dataframeIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param unitIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize \strong{integer}
#' @param pageToken \strong{string}
#' @return FrameSpace SearchDataFrameResponse
#' @export
dfsearch <- function(url, keyspaceIds, dataframeIds = NULL, unitIds = NULL, pageSize = NULL, pageToken = NULL, auth_token = NULL, raw = FALSE){
  p <- new(framespace.SearchDataFramesRequest)
  p$add("keyspaceIds", keyspaceIds)
  p$add("dataframeIds", dataframeIds)
  p$add("unitIds", unitIds)

  resp <- post(paste(url, '/dataframes/search', sep=""), as.list(p), auth_token=auth_token)
  if(raw){
    return(resp)
  }else{
    return(content(resp, as = "parsed"))
  }
}
