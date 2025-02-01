



#' Search Microdata Catalog
#'
#' @description
#' Use all the search parameters available on the website.
#'
#' @param keyword a string keyword used to search
#' @param org a string that represents the name of an organization.
#' @param from an integer indicating start year for the data collection.
#' @param to an integer indicating end year for the data collection.
#' @param country a string. Provide country name or ISO 3 code.
#' For country names and codes, see `country_codes()`.
#' For searching multiple countries, you can even mix country name and ISO 3 code.
#' Example `c("Afghanistan", "Indonesia")` or `c("afg", "ind")` or `c("afghanistan", "ind")`
#' @param inc_iso a logical. Set the parameter value to `TRUE` to
#' include the ISO3 country codes in the results. `Default = FALSE`
#' @param collection a string. It is value returned as `repo_id` column
#' after calling `collections()`.
#' @param created a string. Filter results by date of creation.
#' Use the date format YYYY-MM-DD. Examples, 2020/04/01 returns records created on and after
#' that date. To specify a date range, use the format 2020/04/01-2020/04/20
#' @param dtype a string. Filter results by one or more data access types and takes values of
#' "open", "direct", "public", "licensed", "enclave", "remote" and "other".
#' For example, `c("open", "direct")`. See `access_types()`
#' @param sort_by a string value used to sort the result and takes values of
#' "rank", "title", "country" and "year" to sort search results.
#' @param sort_order a string indicating how to sort the result and takes values of
#' "asc" or "desc". Ascending = asc, Descending = desc
#' @param ps an integer indicating number of records per page.
#' Default is 15 records per page.
#' @param page an integer. Page number to return for the search result
#' @param info a logical. Do you want to see search results information?
#'
#' @return Returns a data frame
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' search_catalog("lsms")
#' }

search_catalog <- function(keyword = NULL,
                           org = c("wb", "fao", "unhcr", "ihsn", "ilo"),
                           from = NULL,
                           to = NULL,
                           country = NULL,
                           inc_iso = FALSE,
                           collection = NULL,
                           created = NULL,
                           dtype = NULL,
                           sort_by = NULL,
                           sort_order = NULL,
                           ps = NULL,
                           page = NULL,
                           info = FALSE){
        org <- match.arg(org)
        base_url <- base_url(org)
        req <- request(base_url) |>
                httr2::req_url_path_append("search")
        if(!is.null(keyword)) req <- req_url_query(req, sk = keyword)
        if(!is.null(from)) req <- req_url_query(req, from = from)
        if(!is.null(to)) req <- req_url_query(req, to = to)
        if(!is.null(country)) req <- req_url_query(req, country = country, .multi = "pipe")
        if(is.logical(inc_iso)) req <- req_url_query(req, inc_iso = inc_iso)
        if(!is.null(collection)) req <- req_url_query(req, collection = collection, .multi = "comma")
        if(!is.null(dtype)) req <- req_url_query(req, dtype = dtype, .multi = "comma")
        if(!is.null(sort_by)) {
                if (tolower(sort_by) == "country") sort_by <- "nation"
                req <- req_url_query(req, sort_by = sort_by)
        }
        if(!is.null(sort_order)) req <- req_url_query(req, sort_order = sort_order)
        if(!is.null(ps) && grepl("^\\d+$", ps)) req <- req_url_query(req, ps = ps)
        if(!is.null(page) && grepl("^\\d+$", page)) req <- req_url_query(req, page = page)
        req <- req_url_query(req, format = "json")
        response <- req |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        if (response$result$found == 0L) {
                cli::cli_abort("No results found at {.url {req_url}}")
        }

        if (info) return(response$result)

        return(response$result$rows)

}

