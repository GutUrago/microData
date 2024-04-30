



#' Search microdata catalog
#'
#' @description
#' Search microdata catalog
#'
#' @param keyword A string keyword used to search
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#' @param from An integer indicating start year for the data collection.
#' @param to An integer indicating end year for the data collection.
#' @param country A string. Provide country name or ISO 3 code.
#' For country names and codes, see `mdt_country_codes()`.
#' For searching multiple countries, you can mix country name and ISO 3 code.
#' Example `c("Afghanistan", "Indonesia")` or `c("afg", "ind")` or `c("afghanistan", "ind")`
#' @param inc_iso A logical. Set the parameter value to `TRUE` to
#' include the ISO3 country codes in the results. `Default = FALSE`
#' @param collection A string. Filter results by one or more collections.
#' @param created A string. Filter results by date of creation.
#' Use the date format YYYY-MM-DD. Examples, 2020/04/01 returns records created on and after
#' that date. To specify a date range, use the format 2020/04/01-2020/04/20
#' @param dtype A string. Filter results by one or more data access types and takes values of
#' "open", "direct", "public", "licensed", "enclave", "remote" and "other".
#' For example, `c("open", "direct")`. See `mdt_access_types()`
#' @param sort_by A string value used to sort the result and takes values of
#' "rank", "title", "country" and "year" Sort search results.
#' @param sort_order A string indicating how to sort the result and takes values of
#' "asc" or "desc". Ascending = asc, Descending = desc
#' @param results An integer indicating number of records per page.
#' set `results = "all"` to get all found results. Default is 15 records per page.
#' @param page An integer. Page to return for the search result
#' @param detailed A logical. if `TRUE` returns a list with all details of
#' search results, otherwise returns a data frame with only key information.
#' Default `detailed = FALSE`
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
        } else if (inc_iso){
                result <- response$result$rows
                result <- result[,c("id", "idno", "title", "iso3",
                                    "nation", "year_end", "form_model")]
                names(result) <- c("id", "idno", "title", "iso", "country", "year", "form_model")
        }
        return(result)
        }


