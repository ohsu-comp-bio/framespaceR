#' Buffers a dataframe slice request from the framespace server
#' @description Beffers and sends a request in the form of a json file to the framespace server and retreaves the content of the response in packets.
#' @param host = string This is the host you want the data to come from e.g. "192.168.99.100"
#' @param port = string containing the port you wish to access e.g. "5000"
#' @param end = string This is the prefex to the above url e.g. "example/search" (This is mostly for convenience sake and is not necisarry if the url section has everything in it)
#' @param req = list Input a list containing the search request structured as such e.g. list(dataframeId = unbox("57854014105a6c509d189029"), pageStart = unbox(37), pageEnd = unbox(500))
#' @param buffer = integer Imput the number of pages you would like to buffer for.
#' @param looplimit = integer The number of number of iterations you want the while loop to run for before you think it is stuck in an infinite loop. Defaults at 100,000.
#' @return a list containig the full response
#' @export
bufferreq <- function(host = "192.168.99.100", port = "5000", end = "/dataframe/slice", req = list(dataframeId = unbox("57912977105a6c0d293bbe8e")), buffer = 1000, looplimit = 1000000){

  #unboxes all non-array data
  req$dataframeId <- unbox(req$dataframeId)
  req$pageEnd <- unbox(req$pageEnd)
  if(is.null(req$pageStart)){
    req$pageStart <- unbox(0)
  }
  else{
    req$pageStart <- unbox(req$pageStart)
  }

  #combines the url
  url <- paste0("http://", host, ":", port, end)

  #makes variables used to buffer response
  n <- req$pageEnd
  f <- req$pageStart
  l <- req$pageStart + buffer


  if(is.null(n)){
    req$pageEnd <- unbox(l)
  }
  else{
    if(n > l){
      req$pageEnd <- unbox(l)
    }
  }

  #makes the request
  request <- POST(url,
                  encode = "json",
                  accept_json(),
                  add_headers(`Accept` = 'application/json',
                              `Content-Type` = 'application/json'),
                  body = toJSON(req))

  #converts and returns response
  response <- content(request, as = "parsed")

  c <- 1


  #Grabs the rest of the pages if needed
  while(!is.null(response$contents)){
    #moves to next 1000 pages
    c <- c + 1
    f = f + buffer
    l = l + buffer

    #submits a new request for the next set of pages
    nreq <- req
    nreq$pageStart <- unbox(f)
    nreq$pageEnd <- unbox(l)
    if(!is.null(n)){
      if(n < l){
        nreq$pageEnd <- unbox(n)
      }
    }

    request <- POST(url,
                  encode = "json",
                  accept_json(),
                  add_headers(`Accept` = 'application/json',
                              `Content-Type` = 'application/json'),
                  body = toJSON(nreq))
    nresp <- content(request, as = "parsed")


    if(length(nresp$contents) <= 0.5){
      return(response)
    }

    response <- mapply(c, response, nresp)

    if(!is.null(n)){
      if(n < l){
        return(response)
      }
    }


    if(c >= looplimit){
      response$loop <- "You were stuck in an infinite loop."
      return(response)
    }
  }

  return(response)
}
