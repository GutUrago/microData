

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
        server_req <- httr2::request(server_url)
        api_resp <- httr2::req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        collection <- jsonlite::fromJSON(api_char, flatten = T)
        df <- collection$result
        return(df)
        }




