


#' Get a collection
#'
#' @description
#' Gets and prints a description about single collection.
#'
#'
#' @param id is an integer repository id.
#' See object returned by `mdt_collections()`.
#' @param org is a string of "wb", "fao", "unhcr" or "ilo" organization.
#'
#' @return Prints to console
#' @export
#'
#' @examples
#' mdt_collection(26)


mdt_collection <- function(id,
                           org = "wb"){
        req <- create_request(org)
        req <- req_url_path_append(req, "collections")
        collection <- get_response(req)
        collection <- collection$collections
        collection <- collection[collection$id == id,]
        cat(paste(paste0("ID: ", collection$id),
                  paste0("Repository ID: ", collection$repositoryid),
                  paste0("Full Name: ", collection$title),
                  paste0("Description: ", collection$short_text), sep = "\n"))
}





