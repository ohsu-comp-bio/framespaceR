#' Sets up a units search request
#' @description Performs /units/search request
#' @param url \strong{string} FrameSpace hostname or host:port to send request
#' @param ids \strong{vector} an atomic vector of strings e.g. c("a", "b", "c")
#' @param names \strong{vector} an atomic vector of strings e.g. c("a", "b", "c")
#' @param pageSize \strong{integer}
#' @param pageToken \strong{string}
#' @param raw \strong{boolean} Flag to print raw or parsed content (default).
#' @return FrameSpace SearchUnitsResponse
#' @export
unitssearch <- function(url, ids = NULL, names = NULL, pageSize = NULL, pageToken = NULL, raw = FALSE){
  p <- new(framespace.SearchUnitsRequest)
  p$add("ids", ids)
  p$add("names", names)

  resp <- post(paste(url, '/units/search', sep=""), as.list(p))
  if(raw){
    return(resp)
  }else{
    return(content(resp, as = "parsed"))
  }
}
