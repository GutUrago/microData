



#' Cleans Microdata
#'
#' @description
#' Set names and label attributes to the data frame
#'
#'
#' @param data a data frame
#' @param metadata a data frame that contains old names, new names and
#' labels of each variables
#' @param old_name a column name in the `metadata` that contains
#' old names that exist in the `data`.
#' @param new_name a column name in the `metadata` that contains
#' new names to be set to the variables in the `data`.
#' @param label a column name in the `metadata` that contains
#' labels to be set to the variables in the `data`
#' @param slt_cols a logical. If `TRUE (default)` only variables that have new names
#' will be returned, and if `FALSE` all variables will be returned.
#'
#' @return A data frame with new attributes
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if(FALSE){
#' set_attributes(data = read.csv("microdata.csv"),
#'               metadata = 'readxl::read_excel("metadata.xlsx")',
#'               old_name = "Names",
#'               new_name = "New Names",
#'               label = "Labels")
#' }



set_attributes <- function(data,
                           metadata,
                           old_name,
                           new_name,
                           label = NULL,
                           slt_cols = TRUE){

        old_name <- substitute(old_name)
        old_name <- as.character(old_name)

        new_name <- substitute(new_name)
        new_name <- as.character(new_name)

        label <- substitute(label)
        label <- as.character(label)

        metadata <- na_omit(X = metadata,
                                      cols = old_name)

        if (slt_cols) {
                metadata <- na_omit(X = metadata,
                                              cols = new_name)

                data <- get_vars(x = data,
                                          vars = metadata[[old_name]])
        }

        metadata[[new_name]] <- replace_na(metadata[[new_name]],
                                                     metadata[[old_name]])

        new_names <- metadata[[new_name]]
        names(new_names) <- metadata[[old_name]]

        data <- frename(data, new_names, .nse = FALSE)

        if (!is.null(label)) {
                new_labels <- metadata[[label]]
                names(new_labels) <- metadata[[new_name]]

                data <- relabel(data, new_labels, .nse = FALSE)
        }

        return(data)
}

