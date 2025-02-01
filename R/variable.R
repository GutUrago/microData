


#' Variable Metadata
#' @description
#' Get a single variable metadata
#'
#'
#' @param id a study id number. Accepts any of `id` (integer) and
#' `idno` (string) values to fetch study information.
#' @param var_id a string specifying variable
#' @param org a string specifying organization
#'
#' @return A list
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' variable(6161, "v10")
#' }

variable <- function(id, var_id, org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)
        base_url <- base_url(org)

        req_url <- glue("{base_url}/{id}/variables/{var_id}")

        if (grepl("^\\d+$", id)) {
                req_url <- glue("{req_url}?id_format=id")
        }

        response <- request(req_url) |>
                req_headers("Accept" = "application/json") |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        variable <- response$variable

        return(variable)
        }
