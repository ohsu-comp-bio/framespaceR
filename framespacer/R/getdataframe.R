#' Get DataFrame from KeySpace name and Unit name
#' @description retrieves a dataframe from a given keyspace name and a unit name
#' @param keyspaceName \strong{string} Name of the keyspace
#' @param unitName \strong{string} Name of the unit
#' @param pageStart \strong{integer}
#' @param pageEnd \strong{integer}
#' @return R DataFrame
#' @export
get.dataframe <- function(url, keyspaceName, unitName, pageStart = NULL, pageEnd = NULL, auth_token = NULL, type = "data.frame"){
  ks <- kssearch(url, names=c(keyspaceName), auth_token = auth_token)
  print(ks$keyspaces[[1]]$id)
  u <- unitssearch(url, names=c(unitName))
  print(u$units[[1]]$id)
  df <- dfsearch(url, keyspaceIds=c(ks$keyspaces[[1]]$id), unitIds=u$units[[1]]$id, auth_token=auth_token)
  print(df)
  print(df$dataframes[[1]]$id)
  # if this is a clinical dataframe, set filter on unit
  # this avoids NaN issue - need to fix this server side
  if(!grepl(ks$keyspaces[[1]]$axisName,'clinical')){
    unitName <- NULL
  }
  data <- dfslice(url, df$dataframes[[1]]$id, newMinorKeys=c(unitName), newMajorId=ks$keyspaces[[1]]$id, pageStart=pageStart, pageEnd=pageEnd, auth_token=auth_token)
  print(data)
  if(type == "data.frame"){
    data <- as.data.frame(data)
  }
  return(data)
}
