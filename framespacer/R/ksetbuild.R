#' Construct a repeated set from provided query parameters
#' @description Construct a repeated set from query parameters
#' @return repeated set for BuildDataFrameRequest
#' @import RProtoBuf
#' @export
buildKeySet <- function(url, keyspaceIds = NULL, keyspaceNames = NULL, keys = NULL){
  ks_info <- kssearch(url, ids = keyspaceIds, names = keyspaceNames, keys = c('mask'))$keyspaces
  keysets <- lapply(ks_info, function(k){k[c('id','keys')]; })
  keysets <- lapply(keysets, function(y){names(y) <- c('keyspaceId', 'keys'); y$keyspaceId <- unbox(y$keyspaceId); return(y)})
  return(keysets)
}
