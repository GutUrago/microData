

#' Create API request
#'
#' @param org Name of an organization
#'
#' @return `httr2` request object
#' @noRd
#'


create_request <- function(org){
        if(tolower(org) == "wb"){
                req <- httr2::request("https://microdata.worldbank.org/index.php/api/catalog")
        } else if(tolower(org) == "fao"){
                req <- httr2::request("https://microdata.fao.org/index.php/api/catalog")
        } else if(tolower(org) == "unhcr"){
                req <- httr2::request("https://microdata.unhcr.org/index.php/api/catalog")
        } else if(tolower(org) == "ihsn") {
                req <- httr2::request("https://datacatalog.ihsn.org/index.php/api/catalog")
        } else if(tolower(org) == "ilo") {
                req <- httr2::request("https://www.ilo.org/surveyLib/index.php/api/catalog")
        } else {stop("\nOrganization should be one of WB, FAO, UNHCR, IHSN or ILO")}
        req <- httr2::req_retry(req, max_tries = 3)
        req <- httr2::req_headers(req, "Accept" = "application/json")
        return(req)
}


