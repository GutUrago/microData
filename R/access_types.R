

#' Data Access Types
#'
#' @description
#' Get all access types for data
#'
#'
#' @param org a string that represents the name of an organization.
#'
#' @return A data frame
#' @export
#'
#' @examples
#' access_types()
#'


access_types <- function(org = "wb"){

        api_req <- create_request(org)

        api_req <- httr2::req_url_path_append(api_req, "data_access_codes")

        api_resp <- get_response(api_req)

        codes <- api_resp$codes

        return(codes)
}








