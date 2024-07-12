

#' Country Codes
#'
#' @description
#' Get a list of all country codes
#'
#'
#'
#' @param org a string that represents the name of an organization.
#'
#' @return A data frame with all country codes
#' @export
#' @author Gutama Girja Urago
#'
#' @examples
#' country_codes()


country_codes <- function(org = "wb"){

        request <- create_request(org)

        request <- httr2::req_url_path_append(request, "country_codes")

        response <- get_response(request)

        country_codes <- response$country_codes

        return(country_codes)
        }



