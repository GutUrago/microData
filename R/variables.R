

#' Variables in the File
#'
#' @description
#' Get list of all variables included in a single file
#'
#'
#' @param id a study id number. Accepts any of `id` (integer) and
#' `idno` (string) values to fetch study information.
#' @param file_id a string specifying file id
#' @param org a string specifying organization
#'
#' @return A data frame
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE){
#' variables(6161, "F1")
#' }



variables <- function(id, file_id, org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)
        base_url <- base_url(org)

        req_url <- glue("{base_url}/{id}/data_files/{file_id}/variables")

        if (grepl("^\\d+$", id)) {
                req_url <- glue("{req_url}?id_format=id")
        }

        response <- request(req_url) |>
                req_headers("Accept" = "application/json") |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        variables <- response$variables

        return(variables)
        }



