
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
#' access_types("fao")
#' collections("ilo")
#' country_codes("wb")
#'
access_types <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)

        api_req <- create_request(org)

        api_req <- req_url_path_append(api_req, "data_access_codes")

        api_resp <- get_response(api_req)

        codes <- api_resp$codes

        return(data.table::as.data.table(codes))
}

#' @rdname access_types
#' @export

collections <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)

        api_req <- create_request(org)

        api_req <- req_url_path_append(api_req, "collections")

        api_resp <- get_response(api_req)

        collections <- api_resp[["collections"]]

        if (!is.data.frame(collections)){
                stop("At the moment, ", toupper(org), " doesn't provide any collection lists.")
        }

        collections <- fselect(.x = collections,
                                         "id", "repo_id" = "repositoryid",
                                         "title")

        return(data.table::as.data.table(collections))
}

#' @rdname access_types
#' @export

country_codes <- function(org = c("wb", "fao", "unhcr", "ihsn", "ilo")){

        org <- match.arg(org)

        request <- create_request(org)

        request <- req_url_path_append(request, "country_codes")

        response <- get_response(request)

        country_codes <- response$country_codes

        return(data.table::as.data.table(country_codes))
}
