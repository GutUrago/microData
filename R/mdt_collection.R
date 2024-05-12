


#' Get a collection
#'
#' @description
#' Gets and prints a description about a specific collection.
#'
#'
#' @param repo_id A repository id.
#' See object returned by `mdt_collections()`.
#'
#' @param org is a string of "wb", "fao", "unhcr" or "ilo" organization.
#'
#' @param display A logical. If `TRUE` prints html. `Default = TRUE`
#'
#' @param html A logical, If `TRUE` returns html file. `Default = FALSE`
#'
#' @return Prints to console
#' @export
#'
#' @examples
#' mdt_collection("fao")


mdt_collection <- function(repo_id,
                           org = "wb",
                           display = TRUE,
                           html = FALSE){
        req <- create_request(org)
        req <- req_url_path_append(req, "collections", repo_id)
        collection <- get_response(req)
        final_html <- format_col_html(collection, org)
        if(display) htmltools::html_print(final_html)
        if(html) return(final_html)
        }



