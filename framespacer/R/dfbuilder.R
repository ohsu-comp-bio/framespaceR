#' Takes a
#' @description Beffers and sends a request in the form of a json file to the framespace server and retreaves the content of the response in packets.
#' @param host \strong{string} The host you want the data to come from e.g. "192.168.99.100"
#' @param port \strong{string} The port you wish to access e.g. "5000"
#' @param projectName \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param axisNames \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param newMajor \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param newMinor \strong{vector} An atomic vector of strings e.g. c("a", "b", "c")
#' @param id_num \strong{int} Sometimes there will be multiple dataframes attached to one keyspace this identifies which one you want.
#' @param buffer \strong{integer} The number of pages you would like to buffer for.
#' @param looplimit \strong{integer} The number of times you want it to loop before it thinks it is in an infinite loop.
#' @param df \strong{bool} TRUE if you want the output in a dataframe format and FALSE if you want it in a matrix format.
#' @return a dataframe/matrix with framespace data
#' @import jsonlite
#' @import httr
#' @export

dfbuilder <- function(host = '192.168.99.100', port = '5000', projectName = 'tcga.BRCA', axisNames = 'sample', newMajor = NULL, newMinor = NULL, id_num = 1, buffer = 1000, looplimit = 100000, df = TRUE){
  keysreq = keysearch(axisNames = axisNames, names = projectName)
  resp = framereq(host = host, port = port, end = '/keyspaces/search', req = keysreq)
  keyids = keyidfind(resp = resp)
  dfsearchreq = dfsearch(keyspaceIds = keyids)
  resp = framereq(host = host, port = port, end = '/dataframes/search', req = dfsearchreq)
  dfids = dfidfind(resp = resp)
  dfslicereq = dfslice(dataframeId = dfids[id_num], newMajor = newMajor, newMinor = newMinor, pageStart = 0)
  print('requesting data...')
  dfresp = bufferreq(host = host, port = port, end = '/dataframe/slice', req = dfslicereq, buffer = buffer, looplimit = looplimit)
  print('recieved')
  data = 'matrix...'
  if(df){
    data = 'dataframe...'
  }
  print(paste('building', data))
  mat = genematrix(resp = dfresp, df = df)
  return(mat)
}
