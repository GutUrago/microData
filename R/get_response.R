


#' Gets response from API
#'
#' @param req an object from `create_request()` or `build_quiry`
#'
#' @return API response as a single data frame or nested in a list
#'
#' @noRd
#'



get_response <- function(req){

        tryCatch(
        api_resp <- httr2::req_perform(req),
        error = function(e){
                stop("\nThe API didn't respond to your request; please check it!")
        }
        )


        if(api_resp$status_code != 200){
                stop("\nAPI request failed!")
        }

        response <- httr2::resp_body_json(api_resp,
                                   simplifyVector = TRUE,
                                   flatten = TRUE)

        return(response)
        }




