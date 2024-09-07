



#' Weighted Variance
#'
#' @name wtd_var
#'
#' @description
#' Calculates weighted variance and standard deviation in a pipe-friendly way.
#'
#'
#' @aliases wtd_sd
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
#' x <- rnorm(100)
#' w <- rep(c(1,2), 50)
#' wtd_var(x = x, w = w)
wtd_var <- function(data, x, w = NULL, na.rm = TRUE) {

        if (!missing(data)) {
                if (is.matrix(eval(data, parent.frame())))
                        data <- as.data.frame(data)
        } else data <- NULL

        x <- eval_tidy(enquo(x), data)
        if (!is.numeric(x))
                stop("\n'x' must be a numeric vector.")
        w <- eval_tidy(enquo(w), data)
        if (is.null(w))
                return(var(x = x, na.rm = na.rm))
        if (!is.numeric(w))
                stop("\n'w' must be a numeric vector.")
        if (length(x) != length(w))
                stop("\n'x' and 'w' must have exactly the same length.")
        if (na.rm) {
                ok <- complete.cases(x, w)
                x <- x[ok]
                w <- w[ok]
        }
        sum.w <- sum(w)
        w.var <- (sum(w*x^2) * sum.w - sum(w*x)^2) / (sum.w^2 - sum(w^2))
        return(w.var)
}



#' @rdname wtd_var
#' @export
wtd_sd <- function(data, x, w = NULL, na.rm = TRUE) {
        v <- wtd_var(data, x, w, na.rm = na.rm)
        return(sqrt(v))
        }





