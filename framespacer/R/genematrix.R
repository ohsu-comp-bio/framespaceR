#' Converts a dataframe/slice response into a dataframe
#' @description Converts a response from a dataframe/slice request into a dataframe or matrix stuctured with genes as collumns and samples as rows. This allows you to call on data like so: your_data[c("samplename1", "samplename2", "samplename3"), "genename"].
#' @param resp \strong{list} A responce from a dataframe/slice request
#' @param df \strong{bool} Leave TRUE if you want a dataframe or set to FALSE if you want a matrix
#' @return A matrix structured with genes as rows and samples as collumns.
#' @export
genematrix <- function(resp, df = TRUE){
  genes <- names(resp$contents)
  samples <- names(resp$contents[[genes[[1]]]])
  if (df){
    stuff <- list()
    for(i in 1:length(genes)){
      stuff[[genes[i]]] <- unname(unlist(resp$contents[genes[i]]))
    }
    mat <- structure(stuff, row.names = samples, class = "data.frame")
  }
  else{
    mat <- t(matrix(unlist(resp$contents), ncol = length(samples), dimnames = list(genes, samples)))
  }
  return(mat)
}
