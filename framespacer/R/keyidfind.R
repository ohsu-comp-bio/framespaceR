#' Finds keyspace ids
#' @description This takes a response from a /keyspaces/search request then loads the ids into an atomic vector.
#' @param resp = a list from the output of a keyspace search using refreq
#' @return An atomic vector containing keyspace ids.
#' @export
keyidfind <- function(resp){
  n <- length(resp$keyspaces)
  if(is.null(resp$keyspaces) == TRUE){
    return(print("input error"))
  }
  else{
    ans <- rep("NA", n)
    for (i in 1:n){
      ans[i] <- resp$keyspaces[[i]]$id
    }
  }
  return(ans)
}
