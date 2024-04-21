

create_request <- function(org = "wb"){
        if(org == "wb"){
                req <- httr2::request("https://microdata.worldbank.org/index.php/api/catalog")
        } else if(org == "fao"){
                req <- httr2::request("https://microdata.fao.org/index.php/api/catalog")
        } else if(org == "unhcr"){
                req <- httr2::request("https://microdata.unhcr.org/index.php/api/catalog")
        } else if(org == "ihsn") {
                req <- httr2::request("https://datacatalog.ihsn.org/index.php/api/catalog")
        } else if(org == "ilo") {
                req <- httr2::request("https://www.ilo.org/surveyLib/index.php/api/catalog")
        } else {stop("org should be one of 'wb', 'fao' or 'unhcr'")}
        return(req)
}


