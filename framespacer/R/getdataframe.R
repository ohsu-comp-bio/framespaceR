#' Get DataFrame from KeySpace name and Unit name
#' @description retrieves a dataframe from a given keyspace name and a unit name
#' @param keyspaceName \strong{string} Name of the keyspace
#' @param unitName \strong{string} Name of the unit
#' @param pageStart \strong{integer}
#' @param pageEnd \strong{integer}
#' @return R DataFrame
#' @export
get.dataframe <- function(url, keyspaceName, unitName, pageStart = NULL, pageEnd = NULL, type = "data.frame"){
  ks <- kssearch(url, names=c(keyspaceName))
  u <- unitssearch(url, names=c(unitName))
  df <- dfsearch(url, keyspaceIds=c(ks$keyspaces[[1]]$id), unitIds=u$units[[1]]$id)
  data <- dfslice(url, df$dataframes[[1]]$id, pageStart = pageStart, pageEnd=pageEnd)
  if(type == "data.frame"){
    data <- as.dataframe(data)
  }
  return(data)
}
