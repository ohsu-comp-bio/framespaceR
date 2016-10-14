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
post <- function(url, data){

  if(!is.null(data$pageSize)){
    data$pageSize <- unbox(data$pageSize)
  }
  if(!is.null(data$pageStart)){
    data$pageStart <- unbox(data$pageStart)
  }
  if(!is.null(data$pageEnd)){
    data$pageEnd <- unbox(data$pageEnd)
  }
  if(!is.null(data$pageToken)){
    data$pageToken <- NULL
  }

  response <- POST(url,
                  encode = "json",
                  accept_json(),
                  add_headers(`Accept` = 'application/json',
                              `Content-Type` = 'application/json'),
                  body = toJSON(data))

  return(response)
}
