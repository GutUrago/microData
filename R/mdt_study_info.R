


#' Get study info
#'
#' @param idnoA A string that identifies the study. See object returned by `mdt_seach()` or `mdt_latest()`
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return a list
#' @export
#'
#' @examples
#' mdt_study_info("AFG_2022_BM-UBC_v01_M", "wb")


mdt_study_info <- function(idno, org = "wb"){
        request <- create_request(org)
        if(!missing(idno)) {
                request <- req_url_path_append(request, idno)
                } else stop("\nStudy idno should be provided.")
        response <- get_response(request)
        info <- response$dataset
        return(info)
}

