
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
wtd_var <- function(data = NULL, x, w = NULL, na.rm = TRUE) {
        # Convert data to data frame if needed
        if (!is.null(data) && is.matrix(data)) {
                data <- as.data.frame(data)
        }

        # Evaluate x and w in the provided data context
        x <- rlang::eval_tidy(rlang::enquo(x), data)
        w <- rlang::eval_tidy(rlang::enquo(w), data)

        # Validate x
        if (!is.numeric(x)) {
                stop("'x' must be a numeric vector.")
        }

        # Validate w
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

        # Handle missing values
        if (na.rm) {
                complete <- stats::complete.cases(x, w)
                x <- x[complete]
                w <- w[complete]
        }

        # Check for valid lengths
        if (length(x) == 0) {
                stop("After removing missing values, 'x' contains no observations.")
        }

        # If no weights, compute unweighted variance
        if (is.null(w)) {
                return(stats::var(x, na.rm = na.rm))
        }

        # Compute weighted variance
        sum_w <- sum(w)
        mean_w <- sum(w * x) / sum_w
        w_var <- sum(w * (x - mean_w)^2) / (sum_w - sum(w^2) / sum_w)

        return(w_var)
}




#' @rdname wtd_var
#' @export
wtd_sd <- function(data = NULL, x, w = NULL, na.rm = TRUE) {
        v <- wtd_var(data, x, w, na.rm = na.rm)
        return(sqrt(v))
        }





