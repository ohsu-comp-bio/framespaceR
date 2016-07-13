#' Buffers a dataframe slice request from the framespace server
#' @description NOTE: THIS DOES REQUIRE PAGE END TO BE IN THE REQUEST RIGHT NOW. Sends a request in the form of a json file to the framespace reference server and retreaves the content of the response in packets of 1000 pages.
#' @param url = string This is the url you want the data to come from e.g. "http://example.com/api/"
#' @param end = string This is the prefex to the above url e.g. "example/search" (This is mostly for convenience sake and is not necisarry if the url section has everything in it)
#' @param req = list Input a list containing the search request structured as such e.g. list(dataframeId = unbox("57854014105a6c509d189029"), pageStart = unbox(37), pageEnd = unbox(500))
#' @param buffer = integer Imput the number of pages you would like to buffer for.
#' @return a list containig the full response
#' @export
bufferreq <- function(url = "http://192.168.99.100:5000/", end = "dataframe/slice", req = list(dataframeId = unbox("57854014105a6c509d189029")), buffer = 1000){

  #unboxes all non-array data
  req$dataframeId <- unbox(req$dataframeId)
  req$pageStart <- unbox(req$pageStart)
  req$pageEnd <- unbox(req$pageEnd)



  #combines the url
  url <- paste0(url, end)

  #makes variables used to buffer response
  n <- req$pageEnd
  f <- req$pageStart
  l <- req$pageStart + buffer

  if(n > l){
    req$pageEnd <- unbox(l)
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

  #c <- 1


  #Grabs the rest of the pages if needed
  while(n > l){
    #moves to next 1000 pages
    #c <- c + 1
    f = f + buffer
    l = l + buffer

    #submits a new request for the next set of pages
    nreq <- req
    nreq$pageStart <- unbox(f)
    nreq$pageEnd <- unbox(l)
    if(n < l){
      nreq$pageEnd <- unbox(n)
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


    #if(c >= 1000000000000){
    #  return(print("infinite loop!"))
    #}
  }

  return(response)
}
