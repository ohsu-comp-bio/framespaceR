#' Request from refence server
#' @description Sends a request in the form of a json file to the framespace reference server and retreaves the content of the response in the form of a list.
#' @param url = string This is the url you want the data to come from e.g. "http://example.com/api/"
#' @param end = string This is the prefex to the above url e.g. "example/search" (This is mostly for convenience sake and is not necisarry if the url section has everything in it)
#' @param req = list Input a list containing the search request structured as such: list(axisNames = "sample", keys = c("TCGA-ZQ-A9CR-01A-11R-A39E-31", "TCGA-ZR-A9CJ-01B-11R-A38D-31"))
#' @return a list containig the response
#' @export
refreq <- function(url = "http://192.168.99.100:5000/", end = "units/search", req = {}){

  #unboxes all non-array data
  if(is.null(req$pageSize) == FALSE){
    req$pageSize <- unbox(req$pageSize)
  }
  if(is.null(req$dataframeId) == FALSE){
    req$dataframeId <- unbox(req$dataframeId)
  }
  if(is.null(req$pageStart) == FALSE){
    req$pageStart <- unbox(req$pageStart)
  }
  if(is.null(req$pageEnd) == FALSE){
    req$pageEnd <- unbox(req$pageEnd)
  }
  if(is.null(req$pageToken) == FALSE){
    req$pageToken <- unbox(req$pageToken)
  }

  #combines the url
  url <- paste0(url, end)

  #makes the request
  request <- POST(url,
             encode = "json",
             accept_json(),
             add_headers(`Accept` = 'application/json',
                        `Content-Type` = 'application/json'),
             body = toJSON(req))

  #converts and returns response
  response <- content(request, as = "parsed")

  #Grabs the rest of the pages if needed
  while(is.null(response$nextPageToken == FALSE)){
    #submits a new request for the next page
    nreq <- req
    nreq$pageToken <- unbox(response$nextPageToken)
    request <- POST(url,
                     encode = "json",
                     accept_json(),
                     add_headers(`Accept` = 'application/json',
                                 `Content-Type` = 'application/json'),
                     body = toJSON(nreq))
    nresp <- content(request, as = "parsed")
    response <- mapply(c, response, nresp)
    response$nextPageToken <- unbox(nresp$nextPageToken)
  }

  return(response)
}
