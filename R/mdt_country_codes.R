

#' List of all country codes
#'
#' @param org is a string of "wb", "fao" or "unhcr" organization.
#'
#' @return A data frame
#' @export
#'
#' @examples
#' mdt_country_codes()


mdt_country_codes <- function(org = "wb"){
        if(org == "wb"){
                server_url <- "https://microdata.worldbank.org/index.php/api/catalog/country_codes"
        } else if(org == "fao"){
                server_url <- "https://microdata.fao.org/index.php/api/catalog/country_codes"
        } else if(org == "unhcr"){
                server_url <- "https://microdata.unhcr.org/index.php/api/catalog/country_codes"
        } else if(org == "ihsn") {
                server_url <- "https://datacatalog.ihsn.org/index.php/api/catalog/country_codes"
        } else {stop("org should be 'wb', 'fao' or 'unhcr'")}
        response <- request_api(server_url)
        country_codes <- response$country_codes
        return(country_codes)
        }



