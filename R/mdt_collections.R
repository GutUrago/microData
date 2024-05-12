


#' List all collections
#' @description
#' Returns a list of all available collections
#'
#'
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return A data frame that includes all available collections
#' @export
#' @importFrom httr2 req_url_path_append
#'
#' @examples
#' mdt_collections("fao")


mdt_collections <- function(org = "wb"){
        if(org == "ihsn") {
                stop("\nAt the moment, IHSN doesn't have any collection")
                }
        req <- create_request(org)
        req <- req_url_path_append(req, "collections")
        collection <- get_response(req)
        collection <- collection$collections
        collection <- collection[,1:3]
        colnames(collection) <- c("id", "repo_id", "title")
        return(collection)
        }



