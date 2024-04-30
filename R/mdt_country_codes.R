

#' Get a list of all country codes
#'
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return A data frame with all country codes
#' @export
#'
#' @examples
#' mdt_country_codes()


mdt_country_codes <- function(org = "wb"){
        request <- create_request(org)
        request <- req_url_path_append(request, "country_codes")
        response <- get_response(request)
        country_codes <- response$country_codes
        return(country_codes)
        }



