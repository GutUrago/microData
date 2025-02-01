

#' Weighted Chi-Square Test
#'
#' Performs a weighted chi-square test on two categorical variables, with an optional weighting variable.
#'
#' @param data A data frame or matrix containing the variables.
#' @param x A categorical variable (or its name as a string) to be used as rows in the contingency table.
#' @param y A categorical variable (or its name as a string) to be used as columns in the contingency table.
#' @param w An optional weighting variable (or its name as a string). If not provided, equal weights are assumed.
#' @param na.rm A logical value indicating whether to remove missing values. Defaults to `TRUE`.
#'
#' @return A list with the results of the chi-square test, including:
#' \describe{
#'   \item{\code{statistic}}{The value of the chi-square statistic.}
#'   \item{\code{parameter}}{The degrees of freedom for the test.}
#'   \item{\code{p.value}}{The p-value of the test.}
#'   \item{\code{n.cases}}{The number of cases used in the test.}
#'   \item{\code{call}}{The matched call.}
#' }
#'
#' @details
#' This function calculates the chi-square statistic for two categorical variables, taking into account optional weights.
#' If weights are not provided, all cases are treated as having equal weight.
#'
#' @examples
#' data <- data.frame(
#'   group = sample(c("A", "B", "C"), 100, replace = TRUE),
#'   outcome = sample(c("Yes", "No"), 100, replace = TRUE),
#'   weight = runif(100, 1, 10)
#' )
#' wtd_chisq_test(data, group, outcome, weight)
#'
#' @export
wtd_chisq_test <- function(data, x, y, w = NULL, na.rm = TRUE) {
        if (!missing(data)) {
                if (is.matrix(eval(data, parent.frame())))
                        data <- as.data.frame(data)
        } else data <- NULL
        u.call <- match.call(expand.dots = FALSE)
        if (missing(x) || missing(y))
                stop("'x' and 'y' arguments must be provided.")
        x <- if (is.character(substitute(x))) rlang::sym(x) else rlang::enquo(x)
        y <- if (is.character(substitute(y))) rlang::sym(y) else rlang::enquo(y)
        w <- if (is.character(substitute(w))) rlang::sym(w) else rlang::enquo(w)
        x <- rlang::eval_tidy(x, data)
        y <- rlang::eval_tidy(y, data)
        w <- rlang::eval_tidy(w, data)
        if (is.null(w))
                w <- rep(1, length(x))
        if (!is.numeric(w)) {
                stop("Weights 'w' must be numeric.")
        }
        if (any(w < 0)) {
                stop("Weights 'w' must be non-negative.")
        }
        if (na.rm) {
                ok <- stats::complete.cases(x, y, w)
                x <- x[ok]
                y <- y[ok]
                w <- w[ok]
        }
        out <- stats::xtabs(w ~ x + y)
        out <- summary(out)
        out[["n.cases"]] <- length(x)
        out[["call"]] <- u.call
        return(out)

}



















