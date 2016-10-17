#' HTTP methods generalized for FrameSpace Requests
#' @description HTTP methods generalized for FrameSpace requests
#' @param url \strong{string} FrameSpace hostname or host:port to send request
#' @param data \strong{list} list version of framespace proto request
#' @return httr POST response
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
