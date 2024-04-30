

#' List data access types
#'
#' @description
#' Gets all data access types
#'
#'
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return A data frame
#' @export
#'
#' @examples
#' mdt_access_types()
#'


mdt_access_types <- function(org = "wb"){
        request <- create_request(org)
        request <- req_url_path_append(request, "data_access_codes")
        response <- get_response(request)
        codes <- response$codes
        return(codes)
}








