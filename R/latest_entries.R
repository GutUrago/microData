

#' Latest Catalog Entries
#'
#' @description
#' Get latest catalog entries
#'
#'
#' @param org a string that represents the name of an organization.
#'
#' @param limit an integer. Number of latest catalog entries to return.
#' `Default = 15`
#'
#' @return A data frame
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' latest_entries("fao", 25)
#' }

latest_entries <- function(org = "wb", limit = NULL){

        request <- create_request(org)

        request <- req_url_path_append(request, "latest")

        if (!is.null(limit) && !is.numeric(limit)) {
                stop("'limit' must an integer number")
        }

        if (!is.null(limit)) {
                request <- req_url_query(request, limit = limit)
                }

        response <- get_response(request)

        latest <- response$result

        latest <- frename(.x = latest, "country" = "nation")

        return(latest)
        }




