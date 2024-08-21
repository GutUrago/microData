



#' Weighted Variance
#'
#' @name wtd_var
#'
#' @description
#' Calculates weighted variance and standard deviation.
#'
#'
#' @aliases wtd_sd
#'
#' @param x a numeric vector.
#' @param w an optional numeric vector of weights
#' @param na.rm logical. Should missing values be removed?
#'
#' @return A numeric vector of length 1.
#' @export
#'
#' @examples
#' x <- rnorm(100)
#' w <- rep(c(1,2), 50)
#' wtd_var(x, w)
wtd_var <- function(x, w, na.rm = TRUE) {

        x <- eval(substitute(x), parent.frame())
        if (!is.numeric(x))
                stop("\n'x' must be a numeric vector.")
        if (missing(w))
                return(stats::var(x = x, na.rm = na.rm))
        w <- eval(substitute(w), parent.frame())
        if (!is.numeric(w))
                stop("\n'w' must be a numeric vector.")
        if (length(x) != length(w))
                stop("\n'x' and 'w' must have exactly the same length.")
        if (na.rm) {
                i <- !is.na(x)
                w <- w[i]
                x <- x[i]
        }
        sum.w <- sum(w)
        w.var <- (sum(w*x^2) * sum.w - sum(w*x)^2) / (sum.w^2 - sum(w^2))
        return(w.var)
}

#' @rdname wtd_var
#' @export
wtd_sd <- function(x, w, na.rm = TRUE) {

        x <- eval(substitute(x), parent.frame())
        if (!is.numeric(x))
                stop("\n'x' must be a numeric vector.")
        if (missing(w))
                return(sqrt(stats::var(x = x, na.rm = na.rm)))
        w <- eval(substitute(w), parent.frame())
        if (!is.numeric(w))
                stop("\n'w' must be a numeric vector.")
        if (length(x) != length(w))
                stop("\n'x' and 'w' must have exactly the same length.")
        if (na.rm) {
                i <- !is.na(x)
                w <- w[i]
                x <- x[i]
        }
        sum.w <- sum(w)
        w.var <- (sum(w*x^2) * sum.w - sum(w*x)^2) / (sum.w^2 - sum(w^2))
        return(sqrt(w.var))
}






