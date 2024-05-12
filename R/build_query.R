

#' Build search query
#'
#' @param req `httr2` request object returned by `create_request()` function.
#' @param keyword keyword to used for search
#' @param from beginning year
#' @param to end year
#' @param country country
#' @param inc_iso boolean if iso3 country code is included
#' @param collection in which collection
#' @param created date of data creation
#' @param dtype data access type
#' @param sort_by used for sorting
#' @param sort_order ascending or descending
#' @param results how many results per page
#' @param page page number
#'
#' @return a query ready to be sent to API
#'
#' @importFrom httr2 req_url_query
#' @noRd



build_query <- function(req,
                        keyword = NULL,
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
        if(!is.null(keyword)) req <- req_url_query(req, sk = keyword)
        if(!is.null(from)) req <- req_url_query(req, from = from)
        if(!is.null(to)) req <- req_url_query(req, to = to)
        if(!is.null(country)) req <- req_url_query(req, country = country, .multi = "pipe")
        if(!is.null(inc_iso)) req <- req_url_query(req, inc_iso = inc_iso)
        if(!is.null(collection)) req <- req_url_query(req, collection = collection, .multi = "comma")
        if(!is.null(dtype)) req <- req_url_query(req, dtype = dtype, .multi = "comma")
        if(!is.null(sort_by)) {
                sort_by <- gsub(pattern = "country", replacement = "nation", x = sort_by)
                req <- req_url_query(req, sort_by = sort_by)}
        if(!is.null(sort_order)) req <- req_url_query(req, sort_order = sort_order)
        if(!is.null(results) && tolower(results) == "all") {
                tmp_result <- get_response(req)
                found <- tmp_result$result$found
                req <- req_url_query(req, ps = found)
                query <- req_url_query(req, format = "json")
        } else if(!is.null(results) && is.numeric(results) && !is.null(page)) {
                req <- req_url_query(req, ps = results)
                req <- req_url_query(req, page = page)
                query <- req_url_query(req, format = "json")
        } else if(!is.null(results) && is.numeric(results) && is.null(page)) {
                req <- req_url_query(req, ps = results)
                query <- req_url_query(req, format = "json")
        } else if(is.null(results) && !is.null(page)) {
                req <- req_url_query(req, page = page)
                query <- req_url_query(req, format = "json")
        } else if(is.null(results) && is.null(page)) {
                query <- req_url_query(req, format = "json")}
        return(query)
        }


