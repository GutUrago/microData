

#' List data access types
#'
#' @description
#' Gets all data access types
#'
#'
#' @param org is a string of "wb", "fao" or "unhcr" organization.
#'
#' @return A dara frame
#' @export
#'
#' @examples
#' mdt_access_types()
#'


mdt_access_types <- function(org = "wb"){
        if(org == "wb"){
                server_url <- "https://microdata.worldbank.org/index.php/api/catalog/data_access_codes"
        } else if(org == "fao"){
                server_url <- "https://microdata.fao.org/index.php/api/catalog/data_access_codes"
        } else if(org == "unhcr"){
                server_url <- "https://microdata.unhcr.org/index.php/api/catalog/data_access_codes"
        } else if(org == "ihsn") {
                server_url <- "https://datacatalog.ihsn.org/index.php/api/catalog/data_access_codes"
        } else {stop("org should be 'wb', 'fao' or 'unhcr'")}
        response <- request_api(server_url)
        codes <- response$codes
        return(codes)
}








