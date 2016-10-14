#' Sets up a dataframe search request
#' @description Formats a /dataframes/search request to send through the framereq function to the framespace server.
#' @param keyspaceIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param dataframeIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param unitIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize \strong{integer}
#' @param pageToken \strong{string}
#' @return A properly formatted request
#' @import jsonlite
#' @export
dfsearch <- function(url, keyspaceIds, dataframeIds = NULL, unitIds = NULL, pageSize = NULL, pageToken = NULL, raw = FALSE){
  p <- new(framespace.SearchDataFramesRequest)
  p$add("keyspaceIds", keyspaceIds)
  p$add("dataframeIds", dataframeIds)
  p$add("unitIds", unitIds)
  
  resp <- post(paste(url, '/dataframes/search', sep=""), as.list(p))
  if(raw){
    return(resp)
  }else{
    return(content(resp, as = "parsed"))
  }
}
