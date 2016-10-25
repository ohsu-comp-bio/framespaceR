#' FrameSpace DataFrame to R DataFrame
#' @description Converts a FrameSpace DataFrame into an R DataFrame
#' @param dataframe \strong{list} FrameSpace DataFrame
#' @return R DataFrame
#' @export
as.data.frame.framespace <- function(dataframe){
  # flatten the vectors in the FrameSpace DataFrame
  contents <- sapply(names(dataframe$contents), function(x) unname(unlist(dataframe$contents[x])), simplify=FALSE, USE.NAMES=TRUE)
  # format matrix with flatten contents
  mat <- structure(contents, row.names = names(dataframe$contents[[names(contents[1])]]), class = "data.frame")
  return(mat)
}
