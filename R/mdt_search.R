



#' Search micro data catalog
#'
#' @description
#' A short description...
#'
#'
#' @param org is a string of "wb", "fao" or "unhcr" organization.
#' @param from is an integer start year for the data collection.
#' @param to is an integer end year for the data collection.
#' @param country is a string. Provide country name or ISO 3 code.
#' For country names and codes, see `mdt_country_codes()`.
#' For searching multiple countries, provide names separated by pipe(|).
#' Example Afghanistan|Indonesia or afg|ind or afghanistan|ind
#' @param collection Filter results by one or more collections.
#' For filtering multiples, use format collection1, collection2
#' @param dtype a string. Data access types and takes values of
#' "open""direct""public""licensed""enclave""remote""other"
#' Filter by data access types. For multiple values,
#' use comma e.g. open, direct, remote
#' @param sort_by a string value used to sort the result and takes values of
#' "rank""title""nation""year" Sort search results.
#' Valid options are rank,title,year,nation
#' @param sort_order a string indicated how to sort the result and takes values of
#' "asc" "desc" Set results sort order. Ascending = asc, Descending= desc
#' @param ps an integer, Number of results per page.
#' Default is 15 records per page
#' @param page an integer. Page to return for the search result
#' @param detailed a logical. if `TRUE` returns a list with all
#' search results, otherwise returns a data frame. Default `detailed = FALSE`
#'
#' @return A list or data frame based on the `detailed` argument.
#' @export
#'
#' @examples
#' mdt_search()


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
                tmp_result <- request_api(tmp_server_url)
                found <- tmp_result$result$found
                ps <- paste0("&ps=", found)
        } else if(!is.null(ps)) {ps <- paste0("&ps=", ps)}
        server_url <- paste0(base_url, page, from, to, country,
                             collection, dtype, sort_by, sort_order, ps)
        response <- request_api(server_url)
        if(detailed){
                result <- as.list(response$result)
                names(result$rows)[names(result$rows) == "id"] <- "repo_id"
                names(result$rows)[names(result$rows) == "idno"] <- "name"
                names(result$rows)[names(result$rows) == "nation"] <- "country"
                result$rows <- result$rows[,!names(result$rows) %in% c("data_class_id", "thumbnail")]
        } else {
                result <- response$result$rows
                result <- result[,c("id", "idno", "title", "nation", "year_end")]
                names(result) <- c("repo_id", "name", "title", "country", "year")
        }
        return(result)
        }




