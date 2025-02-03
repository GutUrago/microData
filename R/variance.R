
#' Weighted Variance
#'
#' @name wtd_var
#'
#' @description
#' Calculates weighted variance and standard deviation in a pipe-friendly way.
#'
#'
#' @param data an optional matrix or data frame placed as first argument for the
#' function to be pipe-friendly.
#' @param x a name of numeric variable in the data frame or numeric vector in the environment.
#' @param w aan optional (weights) name of numeric variable in the data frame or in the environment.
#' @param na.rm a logical. Should missing values be removed?
#'
#' @return A numeric vector of length 1.
#' @export
#'
#' @examples
#' variance(height, w = w, data = micro_data)
variance <- function(x, w = NULL, data = NULL, na.rm = TRUE) {

        if (!is.null(data) && is.matrix(data)) {
                data <- as.data.frame(data)
        }

        x <- if (is.character(substitute(x))) rlang::sym(x) else rlang::enquo(x)
        w <- if (is.character(substitute(w))) rlang::sym(w) else rlang::enquo(w)
        x <- rlang::eval_tidy(x, data)
        w <- rlang::eval_tidy(w, data)

        if (!is.numeric(x)) {
                stop("'x' must be a numeric vector.")
        }

        if (is.null(w)) {
                return(stats::var(x, na.rm = na.rm))
        }

        if (na.rm) {
                complete <- stats::complete.cases(x, w)
                x <- x[complete]
                w <- w[complete]
        }

        if (!is.null(w)) {
                if (!is.numeric(w)) {
                        stop("'w' must be a numeric vector.")
                }
                if (length(x) != length(w)) {
                        stop("'x' and 'w' must have the same length.")
                }
                if (any(w < 0)) {
                        stop("'w' cannot contain negative values.")
                }
        }
        sum_w <- sum(w)
        mean_w <- sum(x * w) / sum_w
        variance <- sum(((x - mean_w)^2) * w) / (sum_w - (sum(w^2) / sum_w))
        return(variance)
}









