


#' Gets response from API
#'
#' @param server_url a link to be requested from API
#'
#' @return API response as a single data frame or nested in a list
#'
#' @noRd
#' @importFrom httr2 request
#' @importFrom httr2 req_perform
#' @importFrom jsonlite fromJSON
#'




request_api <- function(server_url){
        server_req <- request(server_url)
        api_resp <- req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        response <- fromJSON(api_char, flatten = TRUE)
        return(response)
        }

