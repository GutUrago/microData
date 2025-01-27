

#' Import Multiple Data Files
#'
#' @description
#' Imports multiple data files from a specified directory and returns a
#' named list of data frames.
#'
#' @param path A character vector specifying the directory path.
#' Defaults to the working directory, \code{\link[base:getwd]{getwd()}}.
#' Missing or invalid paths will trigger an error.
#' @param pattern An optional \code{\link[base:regex]{regular expression}}
#' to filter file names. Only files matching the pattern will be processed.
#' @param fun A function used to read data files,
#' such as \code{\link[data.table:fread]{data.table::fread}} or \code{\link[utils:read.csv]{read.csv}}.
#' @param rm_ext A logical value indicating whether file extensions should
#' be removed from the names of the returned list elements. Defaults to \code{TRUE}.
#' @param ... Additional arguments passed to the data reading function specified in \code{fun}.
#'
#' @return A named list of data frames, where names correspond to file names (optionally without extensions).
#' @export
#'
#' @examples
#' if (FALSE) {
#' # Example with data.table::fread
#' import_data(path = "data", pattern = "\\.csv$", fun = data.table::fread)
#'
#' # Example with base R read.csv
#' import_data(path = "data", pattern = "\\.csv$", fun = read.csv, rm_ext = FALSE)
#' }
import_data <- function(path = ".", pattern = NULL, fun = data.table::fread,
                        rm_ext = TRUE, ...) {
        # Validate inputs
        if (!dir.exists(path)) {
                stop("The specified path does not exist: ", path)
        }
        if (!is.function(fun)) {
                stop("The 'fun' argument must be a valid function.")
        }

        # List files
        file_list <- list.files(path = path, pattern = pattern, full.names = FALSE)
        if (length(file_list) == 0L) {
                stop("No files matching the specified pattern were found in the directory: ", path)
        }

        # Construct file paths and optionally modify names
        file_paths <- file.path(path, file_list)
        file_names <- if (rm_ext) tools::file_path_sans_ext(file_list) else file_list

        # Read files
        data_list <- tryCatch(
                lapply(file_paths, function(file) fun(file, ...)),
                error = function(e) stop("Error reading files: ", e$message)
        )

        # Assign names to the list
        names(data_list) <- file_names
        return(data_list)
}
