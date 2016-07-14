#' Finds dataframe ids
#' @description This takes a response from a dataframes/search request then loads the ids into an atomic vector.
#' @param resp = a list from the output of a dataframes search using refreq
#' @return An atomic vector containing dataframe ids.
#' @export
dfidfind <- function(resp){
  n <- length(resp$dataframes)
  if(is.null(resp$dataframes) == TRUE){
    return(print("input error"))
  }
  else{
    ans <- rep("NA", n)
    for (i in 1:n){
      ans[i] <- resp$dataframes[[i]]$id
    }
  }
  return(ans)
}
