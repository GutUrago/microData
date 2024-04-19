


mdt_collection <- function(repo_id,
                           org = "wb"){
        if(org == "wb"){
                server_url <- "https://microdata.worldbank.org/index.php/api/catalog/collections"
        } else if(org == "fao"){
                server_url <- "https://microdata.fao.org/index.php/api/catalog/collections"
        } else if(org == "unhcr"){
                server_url <- "https://microdata.unhcr.org/index.php/api/catalog/collections"
        } else if(org == "ihsn") {
                stop("At the moment, IHSN has no specific collections. Use `search_catalog()`")
        } else {stop("org should be 'wb', 'fao' or 'unhcr'")}
        server_req <- httr2::request(server_url)
        api_resp <- httr2::req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        collection <- jsonlite::fromJSON(api_char, flatten = TRUE)
        collection <- collection$collections
        collection <- collection[collection$id == repo_id,]
        cat(paste(paste0("ID: ", collection$id),
                  paste0("Name: ", collection$repositoryid),
                  paste0("Full Name: ", collection$title),
                  paste0("Description: ", collection$short_text), sep = "\n"))
}





