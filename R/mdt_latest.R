

#' Latest catalog entries
#'
#' @description
#' Get latest catalog entries
#'
#'
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @param limit An integer. Number of latest catalog entries to return.
#' `Default = 15`
#'
#' @return A data frame
#' @export
#'
#' @examples
#' mdt_latest("fao", 25)

mdt_latest <- function(org = "wb", limit = NULL){
        request <- create_request(org)
        request <- req_url_path_append(request, "latest")
        if(!is.null(limit)) request <- req_url_query(request, limit = limit)
        response <- get_response(request)
        latest <- response$result
        latest <- latest[,c("id", "idno", "title", "nation", "created", "changed")]
        names(latest) <- c("id", "idno", "title", "country", "created", "changed")
        return(latest)
        }




