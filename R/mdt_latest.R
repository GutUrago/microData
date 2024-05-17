

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
#' @examples
#' mdt_latest("fao", 25)

mdt_latest <- function(org = "wb", limit = NULL){

        request <- create_request(org)

        request <- httr2::req_url_path_append(request, "latest")

        if(!is.null(limit)) {
                request <- httr2::req_url_query(request, limit = limit)
                }

        response <- get_response(request)

        latest <- response$result

        latest <- collapse::frename(.x = latest, "country" = "nation")

        return(latest)
        }




