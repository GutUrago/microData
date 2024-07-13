


#' Variable Metadata
#' @description
#' Get a single variable metadata
#'
#'
#' @param id a study id number. Accepts any of `id` (integer) and
#' `idno` (string) values to fetch study information.
#' @param var_id a string specifying variable
#' @param org a string specifying organization
#'
#' @return A list
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' variable(6161, "v10")
#' }


variable <- function(id, var_id, org = "wb"){

        api_req <- create_request(org)

        if (!grepl("[A-Za-z]", id)){
                api_req <- httr2::req_url_path_append(api_req, id)
                api_req <- httr2::req_url_query(api_req, id_format = "id")
        } else {api_req <- httr2::req_url_path_append(api_req, id)}

        api_req <- httr2::req_url_path_append(api_req,  "variables", var_id)

        api_resp <- get_response(api_req)

        variable <- api_resp$variable

        return(variable)
        }
