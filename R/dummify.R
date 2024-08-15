




#' Convert a Variables into Dummy
#' @description
#' It converts categorical or factor variable into binary variable coded as 0 and 1.
#'
#'
#' @param data is a data frame containing variables.
#' @param vars is a vector of variables to be coded into dummy.
#' @param refs is a (named) vector used as reference for dummy coding.
#' @param keep is a logical indicating if the original variable is also returned.
#'
#' @details
#' It computes a dummy variable for each unique value of the supplied variable
#' except for reference, if provided.
#'
#'
#' @return A data frame with newly added dummy variables with labels attribute.
#' @author Gutama Girja Urago
#'
#' @export
#'
#' @examples
#'
#' dummify(data = iris, vars = Species, refs = c(Species = "setosa"))
#'
dummify <- function(data, vars, refs = NULL, keep = FALSE) {

        vars <- substitute(vars)

        if (is.call(vars) && vars[[1]] == "c") {
                vars <- as.character(vars[-1])
        } else {
                vars <- as.character(vars)
        }

        for (var in vars) {
                if (!var %in% names(data)) {
                        stop(paste("\nThe specified column", var, "does not exist in the data frame."))
                }

                dummies <- unique(data[[var]])

                if (!is.null(names(refs))) {
                        dummies <- setdiff(dummies, refs[var])
                } else dummies <- setdiff(dummies, refs)

                if (length(dummies) == 0) {
                        warning(paste("\nNo levels to dummify for column", var, "after excluding reference levels."))
                        next
                }

                dummy_df <- sapply(dummies, function(x) {
                        ifelse(data[[var]] == x, 1, 0)
                })

                if (length(dummies) > 1L) {
                        colnames(dummy_df) <- paste(var, dummies, sep = "_")
                        } else colnames(dummy_df) <- var


                dummy_df <- as.data.frame(dummy_df)

                col_names <- colnames(dummy_df)

                for (i in 1:length(dummies)) {
                        collapse::vlabels(dummy_df[[col_names[i]]], attrn = "label") <- paste0(var, ' [', dummies[i], ']')
                }

                data <- cbind(data, as.data.frame(dummy_df))

                if (!keep) {
                        data[[var]] <- NULL
                }
        }

        return(data)
}
