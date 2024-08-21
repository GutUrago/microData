

# build_query ----


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
        if(!is.null(keyword)) req <- httr2::req_url_query(req, sk = keyword)
        if(!is.null(from)) req <- httr2::req_url_query(req, from = from)
        if(!is.null(to)) req <- httr2::req_url_query(req, to = to)
        if(!is.null(country)) req <- httr2::req_url_query(req, country = country, .multi = "pipe")
        if(!is.null(inc_iso)) req <- httr2::req_url_query(req, inc_iso = inc_iso)
        if(!is.null(collection)) req <- httr2::req_url_query(req, collection = collection, .multi = "comma")
        if(!is.null(dtype)) req <- httr2::req_url_query(req, dtype = dtype, .multi = "comma")
        if(!is.null(sort_by)) {
                sort_by <- gsub(pattern = "country", replacement = "nation", x = sort_by)
                req <- httr2::req_url_query(req, sort_by = sort_by)}
        if(!is.null(sort_order)) req <- httr2::req_url_query(req, sort_order = sort_order)
        if(!is.null(results) && tolower(results) == "all") {
                tmp_result <- get_response(req)
                found <- tmp_result$result$found
                req <- httr2::req_url_query(req, ps = found)
                query <- httr2::req_url_query(req, format = "json")
        } else if(!is.null(results) && is.numeric(results) && !is.null(page)) {
                req <- httr2::req_url_query(req, ps = results)
                req <- httr2::req_url_query(req, page = page)
                query <- httr2::req_url_query(req, format = "json")
        } else if(!is.null(results) && !is.numeric(results) && !is.null(page)) {
                tryCatch({
                        results <- as.numeric(results)
                        req <- httr2::req_url_query(req, ps = results)
                        req <- httr2::req_url_query(req, page = page)
                        query <- httr2::req_url_query(req, format = "json")
                },
                warning = function(w){
                        stop(paste0("\nresults argument takes only interger not a ",
                                    class(results)))
                })
        } else if(!is.null(results) && is.numeric(results) && is.null(page)) {
                req <- httr2::req_url_query(req, ps = results)
                query <- httr2::req_url_query(req, format = "json")
        } else if(is.null(results) && !is.null(page)) {
                req <- httr2::req_url_query(req, page = page)
                query <- httr2::req_url_query(req, format = "json")
        } else if(is.null(results) && is.null(page)) {
                query <- httr2::req_url_query(req, format = "json")}
        return(query)
}




# create_request ----


#' Create API request
#'
#' @param org Name of an organization
#'
#' @return `httr2` request object
#' @noRd
#'


create_request <- function(org){
        if(tolower(org) == "wb"){
                req <- httr2::request("https://microdata.worldbank.org/index.php/api/catalog")
        } else if(tolower(org) == "fao"){
                req <- httr2::request("https://microdata.fao.org/index.php/api/catalog")
        } else if(tolower(org) == "unhcr"){
                req <- httr2::request("https://microdata.unhcr.org/index.php/api/catalog")
        } else if(tolower(org) == "ihsn") {
                req <- httr2::request("https://datacatalog.ihsn.org/index.php/api/catalog")
        } else if(tolower(org) == "ilo") {
                req <- httr2::request("https://www.ilo.org/surveyLib/index.php/api/catalog")
        } else {stop("\nOrganization should be one of WB, FAO, UNHCR, IHSN or ILO")}
        req <- httr2::req_retry(req, max_tries = 3)
        req <- httr2::req_headers(req, "Accept" = "application/json")
        return(req)
}



# get_response ----



#' Gets response from API
#'
#' @param req an object from `create_request()` or `build_quiry`
#'
#' @return API response as a single data frame or nested in a list
#'
#' @noRd
#'



get_response <- function(req){

        tryCatch(
                api_resp <- httr2::req_perform(req),
                error = function(e){
                        stop("\nThe API didn't respond to your request; please check it!")
                }
        )


        if(api_resp$status_code != 200){
                stop("\nAPI request failed!")
        }

        response <- httr2::resp_body_json(api_resp,
                                          simplifyVector = TRUE,
                                          flatten = TRUE)

        return(response)
}





