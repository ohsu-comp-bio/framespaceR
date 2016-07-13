#' Sets up a dataframe search request
#' @description formats the request to send through the refreq function
#' @param keyspaceIds = vector of strings
#' @param dataframeIds = vector of strings
#' @param unitIds = vector of strings
#' @param pageSize = integer
#' @param pageToken = string
#' @return A properly formatted request
#' @export
dfsearch <- function(keyspaceIds, dataframeIds = NULL, unitIds = NULL, pageSize = NULL, pageToken = NULL){
  req <- list(keyspaceIds = keyspaceIds, dataframeIds = "", unitIds = "", pageSize = pageSize, pageToken = pageToken)
  req$dataframeIds <- dataframeIds
  req$unitIds <- unitIds
  req$pageSize <- unbox(req$pageSize)
  req$pageToken <- unbox(req$pageToken)
  return(req)
}
