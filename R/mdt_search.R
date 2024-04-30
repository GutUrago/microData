



#' Search micro data catalog
#'
#' @description
#' A short description...
#'
#' @param keyword A keyword used to search
#' @param org is a string of "wb", "fao" or "unhcr" organization.
#' @param from is an integer start year for the data collection.
#' @param to is an integer end year for the data collection.
#' @param country is a string. Provide country name or ISO 3 code.
#' For country names and codes, see `mdt_country_codes()`.
#' For searching multiple countries, provide names separated by pipe(|).
#' Example Afghanistan|Indonesia or afg|ind or afghanistan|ind
#' @param inc_iso boolean. Set the parameter value to true to
#' include the ISO3 country codes for the results
#' @param collection Filter results by one or more collections.
#' For filtering multiples, use format collection1, collection2
#' @param created string Filter results by date of creation.
#' Use the date format YYYY-MM-DD.
#' Examples, 2020/04/01 returns records created on and after
#' that date. To specify a date range, use the format 2020/04/01-2020/04/20
#' @param dtype a string. Data access types and takes values of
#' "open""direct""public""licensed""enclave""remote""other"
#' Filter by data access types. For multiple values,
#' use comma e.g. open, direct, remote
#' @param sort_by a string value used to sort the result and takes values of
#' "rank""title""nation""year" Sort search results.
#' Valid options are rank,title,year,nation
#' @param sort_order a string indicated how to sort the result and takes values of
#' "asc" "desc" Set results sort order. Ascending = asc, Descending= desc
#' @param results an integer or a string "all", Number of results per page.
#' Default is 15 records per page.
#' @param page an integer. Page to return for the search result
#' @param detailed a logical. if `TRUE` returns a list with all
#' search results, otherwise returns a data frame. Default `detailed = FALSE`
#'
#' @return A list or data frame based on the `detailed` argument.
#' @export
#' @importFrom httr2 req_url_path_append
#'
#' @examples
#' mdt_search()


mdt_search <- function(keyword = NULL,
                       org = "wb",
                       from = NULL,
                       to = NULL,
                       country = NULL,
                       inc_iso = FALSE,
                       collection = NULL,
                       created = NULL,
                       dtype = NULL,
                       sort_by = NULL,
                       sort_order = NULL,
                       results = NULL,
                       page = NULL,
                       detailed = FALSE){
        request <- create_request(org)
        request <- req_url_path_append(request, "search")
        server_req <- build_query(req = request, keyword = keyword,from = from,to = to,
                      country = country,inc_iso = inc_iso,collection = collection,
                      created = created, dtype = dtype, sort_by = sort_by,
                      sort_order = sort_order, results = results,page = page)
        response <- get_response(server_req)
        if(detailed){
                result <- as.list(response$result)
                names(result$rows)[names(result$rows) == "nation"] <- "country"
                result$rows <- result$rows[,!names(result$rows) %in% c("data_class_id", "thumbnail")]
        } else {
                result <- response$result$rows
                result <- result[,c("id", "idno", "title",
                                    "nation", "year_end", "form_model")]
                names(result) <- c("id", "idno", "title", "country", "year", "form_model")
        }
        return(result)
        }


