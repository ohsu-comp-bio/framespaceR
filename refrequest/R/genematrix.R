#' Converts a dataframe/slice response into a matrix
#' @description Converts a response from a dataframe/slice request into a matrix stuctured with genes as rows and samples as collumns. This allows you to call on data like so: your_data["genename", c("samplename1", "samplename2", "samplename3")].
#' @param resp = a responce from a dataframe/slice request
#' @return A matrix structured with genes as rows and samples as collumns.
#' @export
genematrix <- function(resp){
  genes <- names(resp$contents)
  samples <- names(resp$contents[[genes[[1]]]])
  mat <- matrix(unlist(resp$contents), ncol = 1218, dimnames = list(genes, samples))
  return(mat)
}
