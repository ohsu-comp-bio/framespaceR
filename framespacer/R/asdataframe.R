#' FrameSpace DataFrame to R DataFrame
#' @description Converts a FrameSpace DataFrame into an R DataFrame
#' @param dataframe \strong{list} FrameSpace DataFrame
#' @return R DataFrame
#' @export
as.dataframe <- function(dataframe){
  major_keys <- names(dataframe$contents)
  minor_keys <- names(dataframe$contents[[major_keys[[1]]]])
  contents <- list()
  for(i in 1:length(major_keys)){
    contents[[major_keys[i]]] <- unname(unlist(dataframe$contents[major_keys[i]]))
  }
  mat <- structure(contents, row.names = minor_keys, class = "data.frame")
  return(mat)
}
