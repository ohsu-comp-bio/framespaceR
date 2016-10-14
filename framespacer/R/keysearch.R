#' Sets up a keyspaces search request
#' @description Formats a /keyspaces/search request to send through the framereq function to the framespace server.
#' @param axisNames \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param keyspaceIds \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param names \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param keys \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize \strong{integer}
#' @param pageToken \strong{string}
#' @return A properly formatted request
#' @import jsonlite
#' @export
kssearch <- function(url, axisNames, keyspaceIds = NULL, names = NULL, keys = NULL, pageSize = NULL, pageToken = NULL, raw=FALSE){
  p <- new(framespace.SearchKeySpacesRequest)
  p$add("axisNames", axisNames)
  p$add("keyspaceIds", keyspaceIds)
  p$add("names", names)
  p$add("keys", keys)
  
  resp <- post(paste(url, '/keyspaces/search', sep=""), as.list(p))
  if(raw){
    return(resp)
  }else{
    return(content(resp, as = "parsed"))
  }
}
