

#' Create API request
#'
#' @param org Name of an organization
#'
#' @return `httr2` request object
#'
#' @importFrom httr2 request
#' @noRd


create_request <- function(org){
        if(org == "wb"){
                req <- request("https://microdata.worldbank.org/index.php/api/catalog")
        } else if(org == "fao"){
                req <- request("https://microdata.fao.org/index.php/api/catalog")
        } else if(org == "unhcr"){
                req <- request("https://microdata.unhcr.org/index.php/api/catalog")
        } else if(org == "ihsn") {
                req <- request("https://datacatalog.ihsn.org/index.php/api/catalog")
        } else if(org == "ilo") {
                req <- request("https://www.ilo.org/surveyLib/index.php/api/catalog")
        } else {stop("org should be one of 'wb', 'fao', 'unhcr', 'ihsn' or 'ilo'")}
        return(req)
}


