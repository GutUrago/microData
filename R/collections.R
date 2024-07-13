


#' Get Collections
#' @description
#' Get a list of all the collections the organization offers.
#'
#'
#' @param org a character string (default = "wb") specifying the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return A data frame that contains all available collections
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' collections("fao")
#' }


collections <- function(org = "wb"){

        api_req <- create_request(org)

        api_req <- httr2::req_url_path_append(api_req, "collections")

        api_resp <- get_response(api_req)

        collections <- api_resp[["collections"]]

        if (!is.data.frame(collections)){
                stop("At the moment, ", toupper(org), " doesn't provide any collection lists.")
                }

        collections <- collapse::fselect(.x = collections,
                          "id", "repo_id" = "repositoryid",
                          "title")

        return(collections)
        }












