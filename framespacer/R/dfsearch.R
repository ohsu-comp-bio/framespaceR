#' Sets up a dataframe search request
#' @description Formats a /dataframes/search request to send through the framereq function to the framespace server.
#' @param keyspaceIds = an atomic vector of strings e.g. c("a", "b", "c")
#' @param dataframeIds = an atomic vector of strings e.g. c("a", "b", "c")
#' @param unitIds = an atomic vector of strings e.g. c("a", "b", "c")
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
