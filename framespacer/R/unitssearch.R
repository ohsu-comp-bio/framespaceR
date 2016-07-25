#' Sets up a units search request
#' @description Formats a /units/search request to send through the framereq function to the framespace server.
#' @param ids = an atomic vector of strings e.g. c("a", "b", "c")
#' @param names = an atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize = integer
#' @param pageToken = string
#' @return A properly formatted request
#' @export
unitssearch <- function(ids = NULL, names = NULL, pageSize = NULL, pageToken = NULL){
  req <- list(ids = "", names = "", pageSize = pageSize, pageToken = pageToken)
  req$ids <- ids
  req$names <- names
  req$pageSize <- unbox(req$pageSize)
  req$pageToken <- unbox(req$pageToken)
  return(req)
}
