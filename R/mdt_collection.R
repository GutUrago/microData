


#' Get A Collection
#'
#' @description
#' Get description about a specific collection.
#'
#'
#' @param repo_id a repository id.
#' See object returned by `mdt_collections()`.
#'
#' @param org a character string specifying the name of an organization
#' that will return the request.
#'
#' @return Prints to html viewer
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' mdt_collection("fao")

mdt_collection <- function(repo_id,
                           org = "wb"){

        api_req <- create_request(org)

        api_req <- httr2::req_url_path_append(api_req, "collections", repo_id)

        api_resp <- get_response(api_req)

        final_html <- format_col_html(api_resp, org)

        htmltools::html_print(final_html)

        }


