

weighted_mean <- function(x, w = NULL, data = NULL, na.rm = TRUE) {

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
                return(mean(x, na.rm = na.rm))
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

        return(sum(x * w) / sum(w))
}
