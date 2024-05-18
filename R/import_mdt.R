



#' Import Microdata
#'
#' @description
#' Import microdata file, set names and labels.
#'
#'
#' @param mdt a data frame which is microdata
#' @param metadata a data frame that contains old names, new names and
#' labels of each variables
#' @param old_name a column name in the `metadata` data frame that contains
#' old names in the microdata. If there is any `NA` values these variables are omitted.
#' @param new_name a column name in the `metadata` data frame that contains
#' new names to set to the variables in the `mdt`
#' @param label a column name in the `metadata` data frame that contains
#' labes to be set to the variables in the `mdr`
#' @param all_vars a logical. If `FALSE (default)` variables with `NA` values
#' in the `new_name` column will be omitted, and if `TRUE` all variables will be returned.
#'
#' @return A data frame with attributes
#' @export
#'
#' @author Gutama Girja Urago
#'
#' @examples
#' if(FALSE){
#' import_mdt(mdt = microdata,
#'            metadata = metadata.xlsx,
#'            old_name = "Names",
#'            new_name = "New Names",
#'            label = "Labels")
#' }



import_mdt <- function(mdt,
                       metadata,
                       old_name = "old_name",
                       new_name = "new_name",
                       label = "label",
                       all_vars = FALSE){

        pre_names <- c("old_name", "new_name", "label")

        names(pre_names) <- c(old_name, new_name, label)

        metadata <- collapse::frename(.x = metadata, pre_names, .nse = FALSE)

        metadata <- collapse::na_omit(X = metadata, cols = "old_name")


        if(all_vars){
                metadata <- collapse::ftransform(.data = metadata,
                                                 new_name = ifelse(is.na(new_name),
                                                             old_name, new_name))

        } else {
                metadata <- collapse::na_omit(X = metadata, cols = "new_name")
                }

        my_data <- collapse::get_vars(x = mdt, vars = metadata$old_name)


        var_names <- metadata$new_name

        names(var_names) <- metadata$old_name

        my_data <- collapse::frename(.x = my_data, var_names, .nse = FALSE)

        var_labels <- metadata$label

        names(var_names) <- metadata$new_name

        my_data <- collapse::relabel(.x = my_data, metadata$label)

        return(my_data)
        }





