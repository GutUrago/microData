

#' Dummify variables
#' @description
#' Dummifies variables in a data set and add new dummies to a data frame
#'
#'
#' @param .data a data frame
#' @param vars a vector of variables to be used to create dummmies
#' @param refs a reference level for variables
#'
#' @return A data frame with newly added dummy variables
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' if (FALSE){
#' dummify(df, c("sex", "race"), c("m", "b"))
#' }


dummify <- function(.data, vars, refs = NULL) {

        for (var in vars) {
                if (!var %in% names(.data)) {
                        stop(paste("The specified column", var, "does not exist in the data frame."))
                }

                dummies <- unique(.data[[var]])
                dummies <- setdiff(dummies, refs)

                if (length(dummies) == 0) {
                        warning(paste("No levels to dummify for column", var, "after excluding reference levels."))
                        next
                }

                dummy_df <- sapply(dummies, function(x) {
                        ifelse(.data[[var]] == x, 1, 0)
                })

                colnames(dummy_df) <- paste(var, dummies, sep = "_")
                .data <- cbind(.data, as.data.frame(dummy_df))
        }

        return(.data)
}


