


#' Get study data file lists
#'
#' @param idno A string that identifies the study. See object returned by `mdt_seach()` or `mdt_latest()`
#' @param org A string that represents the name of an organization.
#' At the moment, it supports "wb", "fao", "unhcr", "ihsn" and "ilo" organizations.
#'
#' @return a data frame
#' @export
#'
#' @examples
#' mdt_data_files("ALB_2012_LSMS_v01_M_v01_A_PUF", "wb")


mdt_data_files <- function(idno, org = "wb"){
        request <- create_request(org)
        if(!missing(idno)) {
                request <- req_url_path_append(request, idno)
                request <- req_url_path_append(request, "data_files")
        } else stop("\nStudy idno should be provided.")
        response <- get_response(request)
        response <- response$datafiles
        if(!is.data.frame(response)){
                response <- lapply(response, function(x) as.data.frame(t(x)))
                response <- do.call(rbind, response)}
        response <- response[,1:7]
        return(response)
        }
