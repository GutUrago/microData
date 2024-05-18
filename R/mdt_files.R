


#' Study Data Files
#'
#' @description
#' Get list of all study data files
#'
#'
#' @param id a study id number. Accepts any of `id` (integer) and
#' `idno` (string) values to fetch study information.
#' See object returned by `mdt_seach()` or `mdt_latest()`
#' @param org a string that represents the name of an organization.
#'
#' @return A data frame
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' mdt_files("ALB_2012_LSMS_v01_M_v01_A_PUF", "wb")


mdt_files <- function(id, org = "wb"){


        api_req <- create_request(org)

        if(!grepl("[A-Za-z]", id)){
                api_req <- httr2::req_url_path_append(api_req, id, "data_files")
                api_req <- httr2::req_url_query(api_req, id_format = "id")
        } else {api_req <- httr2::req_url_path_append(api_req, id, "data_files")}


        api_resp <- get_response(api_req)


        data_files  <- api_resp$datafiles

        if(!is.data.frame(data_files)){
                data_files <- lapply(data_files, function(x) as.data.frame(t(x)))
                data_files <- do.call(rbind, data_files)
        }


        data_files <- data_files[,1:7]

        return(data_files)
        }







