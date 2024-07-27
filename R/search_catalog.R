



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
#' @param results an integer indicating number of records per page.
#' set `results = "all"` to get all found results. Default is 15 records per page.
#' @param page an integer. Page number to return for the search result
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
                           page = NULL){

        request <- create_request(org)

        request <- httr2::req_url_path_append(request, "search")

        api_req <- build_query(req = request, keyword = keyword, from = from, to = to,
                      country = country, inc_iso = inc_iso, collection = collection,
                      created = created, dtype = dtype, sort_by = sort_by,
                      sort_order = sort_order, results = results, page = page)

        api_resp <- get_response(api_req)

        results <- api_resp$result$rows

        if (!is.data.frame(results)){
                stop("\nYour search did not match any studies provided in the catalog.")
        }

        results$data_class_id <- NULL
        results$thumbnail <- NULL

        results <- collapse::frename(.x = results, "country" = "nation")

        return(results)
        }



