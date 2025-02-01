




#' Convert a Variables into Dummy
#' @description
#' It converts categorical or factor variable into binary variable coded as 0 and 1.
#'
#'
#' @param data is a matrix or data frame containing variables.
#' @param var_lev is a logical indicating if new variables are named as
#' 'variable_level' style or just only levels.
#' @param keep is a logical indicating if the original variable is also returned.
#' @param ... a names of variables to be coded into dummy.
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
#' dummify(data = iris, Species)
#' # Work on how to include vectors without quotation
dummify <- function(data, ..., var_lev = TRUE, keep = TRUE) {
        if (is.matrix(eval(data, parent.frame())))
                data <- as.data.frame(data)

        vars <- rlang::exprs(...)
        vars <- lapply(vars, \(x) if (is.character(x)) rlang::sym(x) else rlang::enquo(x))

        for (var in vars) {
                var_name <- rlang::as_name(var)
                x <- rlang::eval_tidy(var, data)

                if (!is.factor(x)) x <- as.factor(x)
                levels(x) <- c(levels(x), "NA")
                x[is.na(x)] <- "NA"

                dummies <- stats::model.matrix(~x - 1)
                colnames(dummies) <- levels(x)
                attributes(dummies)$assign <- NULL
                attributes(dummies)$contrasts <- NULL
                dummies <- as.data.frame(dummies)

                if (var_lev) {
                        colnames(dummies) <- paste(var_name, colnames(dummies), sep = "_")
                }

                data <- cbind(data, dummies)

                if (!keep) {
                        data[[var_name]] <- NULL
                }
        }

        return(data)
}



