
#' Small Helper Functions
#' @name access_types
#'
#' @description
#' Small helper functions to get available data access codes, collections, and
#' country codes from different organization repositories.
#'
#' @aliases collections
#' @aliases country_codes
#'
#'
#'
#' @param org a character string (default = "wb") specifying the name of an organization.
#'
#' @return A data frame
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#'
#' if (FALSE) access_types("fao")
#' if (FALSE)collections("ilo")
#' if (FALSE)country_codes("wb")
#'
access_types <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)
        base_url <- base_url(org)

        response <- request(glue("{base_url}/data_access_codes")) |>
                req_headers("Accept" = "application/json") |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        codes <- response$codes
        if (length(codes) == 0) {
                        cli::cli_abort("{.strong {org}} has no collection.")
                }
                return(codes)

}

#' @rdname access_types
#' @export

collections <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)
        base_url <- base_url(org)

        response <- request(glue("{base_url}/collections")) |>
                req_headers("Accept" = "application/json") |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        if (response$status == "success") {
                collections <- response$collections
                if (length(collections) == 0) {
                        cli::cli_abort("{.strong {org}} has no collection.")
                        }
                return(collections)
        }
}

#' @rdname access_types
#' @export

country_codes <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)
        base_url <- base_url(org)

        response <- request(glue("{base_url}/country_codes")) |>
                req_headers("Accept" = "application/json") |>
                req_perform() |>
                resp_body_json(simplifyVector = TRUE, flatten = TRUE)

        if (response$status == "success") {
                country_codes <- response$country_codes
                if (length(country_codes) == 0) {
                        cli::cli_abort("{.strong {org}} has no country codes.")
                }
                return(country_codes)
        }
}


# Base Link ----
#' @noRd

base_url <- function(org){
        urls <- list(
                wb = "https://microdata.worldbank.org/index.php/api/catalog",
                fao = "https://microdata.fao.org/index.php/api/catalog",
                unhcr = "https://microdata.unhcr.org/index.php/api/catalog",
                ihsn = "https://datacatalog.ihsn.org/index.php/api/catalog",
                ilo = "https://www.ilo.org/surveyLib/index.php/api/catalog"
        )
        org <- tolower(org)
        return(urls[[org]])
}
