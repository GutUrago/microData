

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

latest_entries <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo"),
                           limit = NULL){

        org <- match.arg(org)
        base_url <- base_url(org)
        req_url <- glue("{base_url}/latest")
        if (!is.null(limit)) req_url <- glue("{req_url}?limit={limit}")

        response <- request(req_url) |>
                req_headers("Accept" = "application/json") |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        return(response$result)
        }




