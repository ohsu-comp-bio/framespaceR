#' Sends a reqest to the framespace server
#' @description Sends a request in the form of a json file to the framespace server and retreaves the content of the response in the form of a list.
#' @param host \strong{string} The host you want the data to come from e.g. "192.168.99.100"
#' @param port \strong{string} The port you wish to access e.g. "5000"
#' @param end \strong{string} The prefex to the above url e.g. "/example/search" (This is mostly for convenience sake and is not necisarry if the url section has everything in it)
#' @param req \strong{list} A list containing the search request structured as such: list(axisNames = "sample", keys = c("TCGA-ZQ-A9CR-01A-11R-A39E-31", "TCGA-ZR-A9CJ-01B-11R-A38D-31"))
#' @return A list containig the response
#' @import jsonlite
#' @import httr
#' @export
framereq <- function(host = "192.168.99.100", port = "5000", end = "/units/search", req = {}){

  #unboxes all non-array data
  if(!is.null(req$pageSize)){
    req$pageSize <- unbox(req$pageSize)
  }
  if(!is.null(req$dataframeId)){
    req$dataframeId <- unbox(req$dataframeId)
  }
  if(!is.null(req$pageStart)){
    req$pageStart <- unbox(req$pageStart)
  }
  if(!is.null(req$pageEnd)){
    req$pageEnd <- unbox(req$pageEnd)
  }
  if(!is.null(req$pageToken)){
    req$pageToken <- unbox(req$pageToken)
  }

  #combines the url
  url <- paste0("http://", host, ":", port, end)

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
  while(!is.null(response$nextPageToken)){
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
