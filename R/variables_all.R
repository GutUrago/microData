



#' Variables in the Study
#'
#' @description
#' Get all lists of variables in a study
#'
#'
#' @param id a study id number. Accepts any of `id` (integer) and
#' `idno` (string) values to fetch study information.
#' @param org a string specifying organization
#'
#' @return A data frame
#' @export
#'
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' variables_all(6161)
#' }


variables_all <- function(id, org = "wb"){

        api_req <- create_request(org)

        if (!grepl("[A-Za-z]", id)){
                api_req <- req_url_path_append(api_req, id)
                api_req <- req_url_query(api_req, id_format = "id")
        } else {api_req <- req_url_path_append(api_req, id)}

        api_req <- req_url_path_append(api_req,  "variables")

        api_resp <- get_response(api_req)

        variables <- api_resp$variables

        return(variables)
}


