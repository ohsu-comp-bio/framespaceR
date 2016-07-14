#' Sets up a keyspaces search request
#' @description Formats a keyspaces/search request to send through the refreq function to the framespace server.
#' @param axisNames = an atomic vector of strings e.g. c("a", "b", "c")
#' @param keyspaceIds = an atomic vector of strings e.g. c("a", "b", "c")
#' @param names = an atomic vector of strings e.g. c("a", "b", "c")
#' @param keys = an atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize = integer
#' @param pageToken = string
#' @return A properly formatted request
#' @export
keysearch <- function(axisNames, keyspaceIds = NULL, names = NULL, keys = NULL, pageSize = NULL, pageToken = NULL){
  req <- list(axisNames = axisNames, keyspaceIds = "", names = "", keys = "", pageSize = pageSize, pageToken = pageToken)
  req$keyspaceIds <- keyspaceIds
  req$names <- names
  req$keys <- keys
  req$pageSize <- unbox(req$pageSize)
  req$pageToken <- unbox(req$pageToken)
  return(req)
}
