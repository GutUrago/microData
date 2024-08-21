



#' Import Multiple Data Files
#' @description
#' Imports multiple data files from single directory and returns a list.
#'
#'
#' @param path a character vector of full path names; the default corresponds
#' to the working directory, \code{\link[base:getwd]{getwd()}}.
#' Tilde expansion (see \code{\link[base:path.expand]{path.expand()}}) is
#' performed. Missing values will be ignored. Elements with a marked encoding
#' will be converted to the native encoding (and if that fails, considered
#' non-existent).
#' @param pattern an optional \code{\link[base:regex]{regular expression}}.
#' Only file names which match
#' the regular expression will be returned.
#' @param fun a function used to read data files such as \code{\link[data.table:fread]{data.table::fread}}
#' @param rm_ext a logical indicating if the extensions are excluded from the
#' name of list elements to be returned.
#' @param ... an optional arguments passed to a function used to read data files.
#'
#' @return A list of data frames
#' @export
#'
#' @examples
#' if (FALSE) {
#' import_data(path = "data", pattern = "\\.csv$", fun = data.table::fread)}
import_data <- function(path = ".", pattern = NULL, fun = data.table::fread,
                        rm_ext = TRUE, ...) {
        file_list <- list.files(path = path, pattern = pattern)
        if (length(file_list) == 0L) {
                stop(paste("\nNo such files found in the", path, "directory"))
        }
        if (rm_ext) {file_names <- gsub("(\\.[^.]*$)", "", file_list)
        } else file_names <- file_list
        extensions <- gsub("^.*\\.", "", file_list)
        extension <- unique(extensions)
        file_paths <- paste0(path, "/",file_list)
        data_list <- lapply(file_paths, fun, ...)
        names(data_list) <- file_names
        return(data_list)
}





