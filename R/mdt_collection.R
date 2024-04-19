


#' Get a collection
#'
#' @description
#' Gets and prints an information about single collection.
#'
#'
#' @param repo_id is an integer repository id.
#' See object returned by `mdt_collections()`.
#' @param org is a string of "wb", "fao" or "unhcr" organization.
#'
#' @return Prints to console
#' @export
#'
#' @examples
#' mdt_collection(26)


mdt_collection <- function(repo_id,
                           org = "wb"){
        if(org == "wb"){
                server_url <- "https://microdata.worldbank.org/index.php/api/catalog/collections"
        } else if(org == "fao"){
                server_url <- "https://microdata.fao.org/index.php/api/catalog/collections"
        } else if(org == "unhcr"){
                server_url <- "https://microdata.unhcr.org/index.php/api/catalog/collections"
        } else if(org == "ihsn") {
                stop("At the moment, IHSN has no specific collections. Use `search_catalog()`")
        } else {stop("org should be 'wb', 'fao' or 'unhcr'")}
        collection <- request_api(server_url)
        collection <- collection$collections
        collection <- collection[collection$id == repo_id,]
        cat(paste(paste0("ID: ", collection$id),
                  paste0("Name: ", collection$repositoryid),
                  paste0("Full Name: ", collection$title),
                  paste0("Description: ", collection$short_text), sep = "\n"))
}





