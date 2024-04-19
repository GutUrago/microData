

#' Latest catalog entries
#'
#' @description
#' Gets all country codes
#'
#'
#' @param org is a string of "wb", "fao" or "unhcr" organization.
#'
#' @return A data frame
#' @export
#'
#' @examples
#' mdt_latest()

mdt_latest <- function(org = "wb"){
        if(org == "wb"){
                server_url <- "https://microdata.worldbank.org/index.php/api/catalog/latest"
        } else if(org == "fao"){
                server_url <- "https://microdata.fao.org/index.php/api/catalog/latest"
        } else if(org == "unhcr"){
                server_url <- "https://microdata.unhcr.org/index.php/api/catalog/latest"
        } else if(org == "ihsn") {
                server_url <- "https://datacatalog.ihsn.org/index.php/api/catalog/latest"
        } else {stop("org should be 'wb', 'fao' or 'unhcr'")}
        response <- request_api(server_url)
        latest <- response$result
        return(latest)
        }




