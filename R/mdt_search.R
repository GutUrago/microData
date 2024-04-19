

mdt_search <- function(org = "wb",
                       from = NULL,
                       to = NULL,
                       country = NULL,
                       collection = NULL,
                       dtype = NULL,
                       sort_by = NULL,
                       sort_order = NULL,
                       ps = NULL,
                       page = NULL,
                       detailed = FALSE){
        if(org == "wb"){
                base_url <- "https://microdata.worldbank.org/index.php/api/catalog/search/?"
        } else if(org == "fao"){
                base_url <- "https://microdata.fao.org/index.php/api/catalog/search/?"
        } else if(org == "unhcr"){
                base_url <- "https://microdata.unhcr.org/index.php/api/catalog/search/?"
        } else if(org == "ihsn"){
                base_url <- "https://datacatalog.ihsn.org/index.php/api/catalog/search/?"
        } else {stop("org should be 'wb', 'fao', 'unhcr' or 'ihsn'")}
        if(!is.null(page)) page <- paste0("page=", page)
        if(!is.null(from)) from <- paste0("&from=", from)
        if(!is.null(to)) to <- paste0("&to=", to)
        if(!is.null(country)) country <- paste0("&country=", country)
        if(!is.null(collection)) collection <- paste0("&collection=", collection)
        if(!is.null(dtype)) dtype <- paste0("&dtype=", paste(dtype, collapse = ","))
        if(!is.null(sort_by)) sort_by <- paste0("&sort_by=", sort_by)
        if(!is.null(sort_order)) sort_order <- paste0("&sort_order=", sort_order)
        if(!is.null(ps) && ps == "all") {
                tmp_server_url <- paste0(base_url, page, from, to, country,
                                     collection, dtype, sort_by, sort_order)
                tmp_server_req <- httr2::request(server_url)
                tmp_api_resp <- httr2::req_perform(server_req)
                tmp_api_char <- rawToChar(api_resp$body)
                tmp_collection <- jsonlite::fromJSON(api_char, flatten = T)
                found <- tmp_collection$result$found
                ps <- paste0("&ps=", found)
        } else if(!is.null(ps)) {ps <- paste0("&ps=", ps)}
        server_url <- paste0(base_url, page, from, to, country,
                             collection, dtype, sort_by, sort_order, ps)
        server_req <- httr2::request(server_url)
        api_resp <- httr2::req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        collection <- jsonlite::fromJSON(api_char, flatten = T)
        if(detailed){
                result <- as.list(collection$result)
                names(result$rows)[names(result$rows) == "id"] <- "repo_id"
                names(result$rows)[names(result$rows) == "idno"] <- "name"
                names(result$rows)[names(result$rows) == "nation"] <- "country"
                result$rows <- result$rows[,!names(result$rows) %in% c("data_class_id", "thumbnail")]
        } else {
                result <- collection$result$rows
                result <- result[,c("id", "idno", "title", "nation", "year_end")]
                names(result) <- c("repo_id", "name", "title", "country", "year")
        }
        return(result)
        }




