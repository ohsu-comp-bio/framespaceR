
#' Sets up an axes search request
#' @description Perform /axes/search request
#' @param url \strong{string} FrameSpace hostname or host:port to send request
#' @param names \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize \strong{integer}
#' @param pageToken \strong{string}
#' @param raw \strong{boolean} Flag to print raw or parsed content (default).
#' @return FrameSpace SearchAxesResponse
#' @export
#'
axessearch <- function(url, names = NULL, pageSize = NULL, pageToken = NULL, raw=FALSE){
  p <- new(framespace.SearchAxesRequest)
  p$add("names", names)

  resp <- post(paste(url, '/axes/search', sep=""), as.list(p))
  if(raw){
    return(resp)
  }else{
    return(content(resp, as = "parsed"))
  }
}
