#' Sets up an axes search request
#' @description Formats a axes/search request to send through the refreq function to the framespace server.
#' @param names = an atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize = integer
#' @param pageToken = string
#' @return A properly formatted request
#' @export
axessearch <- function(names = NULL, pageSize = NULL, pageToken = NULL){
  req <- list(names = "", pageSize = pageSize, pageToken = pageToken)
  req$names <- names
  req$pageSize <- unbox(req$pageSize)
  req$pageToken <- unbox(req$pageToken)
  return(req)
}
