


#' Get Collections
#' @description
#' Get a list of all available collections
#'
#'
#' @param org a character string specifying the name of an organization
#' that will return the listed collections.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return A data frame that includes all available collections
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' mdt_collections("fao")


mdt_collections <- function(org = "wb"){

        api_req <- create_request(org)

        api_req <- httr2::req_url_path_append(api_req, "collections")

        api_resp <- get_response(api_req)

        collections <- api_resp$collections

        if(!is.data.frame(collections)){
                stop("\nAt the moment, ", toupper(org), " doesn't have any collections.")
                }

        collections <- collapse::fselect(.x = collections,
                          "id", "repo_id" = "repositoryid",
                          "title")

        return(collections)
        }












