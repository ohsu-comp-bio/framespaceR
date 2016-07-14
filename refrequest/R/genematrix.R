#' Converts a dataframe/slice response into a matrix
#' @description Converts a response from a dataframe/slice request into a matrix stuctured with genes as rows and samples as collumns. This allows you to call on data like so: your_data["genename", c("samplename1", "samplename2", "samplename3")].
#' @param resp = a responce from a dataframe/slice request
#' @return A matrix structured with genes as rows and samples as collumns.
#' @export
genematrix <- function(resp){
  genes <- names(resp$contents)
  samples <- names(resp$contents[[genes[[1]]]])
  mat <- matrix(rep(0, length(genes)*length(samples)), ncol = length(samples), dimnames = list(genes, samples))
  for(j in 1:length(genes)){
    for(k in 1:length(samples)){
      mat[j,k] <- resp$contents[[genes[[j]]]][[samples[[k]]]]
    }
  }
  return(mat)
}
