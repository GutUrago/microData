


#' Get study info
#'
#' @param id a study id number. Accepts any of `id` (integer) and
#' `idno` (string) values to fetch study information.
#' See object returned by `mdt_seach()` or `mdt_latest()`
#' @param org a string that represents the name of an organization.
#'
#' @return a list
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' mdt_abstract(6211, "wb")


mdt_abstract <- function(id, org = "wb"){

        api_req <- create_request(org)

        if(!grepl("[A-Za-z]", id)){
                api_req <- httr2::req_url_path_append(api_req, id)
                api_req <- httr2::req_url_query(api_req, id_format = "id")
        } else {api_req <- httr2::req_url_path_append(api_req, id)}

        api_resp <- get_response(api_req)

        abstract <- format_abs_html(api_resp)

        htmltools::html_print(abstract)
}


