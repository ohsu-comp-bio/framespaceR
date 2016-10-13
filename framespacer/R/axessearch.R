
#' Sets up an axes search request
#' @description Formats an /axes/search request to send through the framefreq function to the framespace server.
#' @param names \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize \strong{integer}
#' @param pageToken \strong{string}
#' @return A properly formatted request
#' @import jsonlite
#' @export
#' 
axessearch <- function(url, names = NULL, pageSize = NULL, pageToken = NULL){
  # build request
  p <- new(framespace.SearchAxesRequest)
  p$add("names", names)
  # make request
  post(paste(url, '/axes/search', sep=""), as.list(p))
}