#' Sets up a build dataframe request
#' @description Performs /dataframe request
#' @param majorSets \strong{string} keyspaceId for the major dimension
#' @param pageSize \strong{integer}
#' @return FrameSpace DataFrame
#' @export
dfbuild <- function(url, majorSets, minorSets, units, pageSize = 0, raw = FALSE){
  # setting nested types is not working
  major <- buildKeySet(url, keyspaceIds = majorSets)
  minor <- buildKeySet(url, keyspaceIds = minorSets)
  units <- unitssearch(url, ids = units)$units
  units <- lapply(seq(units), function(u){lapply(units[[u]], unbox)})
  l <- list(major=major, minor=minor, units=units, pageSize=pageSize)
  resp <- post(paste(url, '/dataframe', sep=""), l)
  if(raw){
    return(resp)
  }else{
    return(structure(content(resp, as = "parsed"), class = "framespace"))
  }
}
