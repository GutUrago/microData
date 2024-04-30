


#' Gets response from API
#'
#' @param req an object from `create_request()` or `build_quiry`
#'
#' @return API response as a single data frame or nested in a list
#'
#' @noRd
#' @importFrom httr2 req_perform
#' @importFrom httr2 resp_body_json
#'




get_response <- function(req){
        api_resp <- req_perform(req)
        response <- resp_body_json(api_resp,
                                   simplifyVector = TRUE,
                                   flatten = TRUE)
        return(response)
        }

