

#' Weighted Chi-Square Test
#'
#' Performs a weighted chi-square test on two categorical variables, with an optional weighting variable.
#'
#' @param x A categorical variable to be used as rows in the contingency table.
#' @param y A categorical variable to be used as columns in the contingency table.
#' @param w An optional weighting variable.
#' @param data A data frame or matrix containing the variables.
#'
#' @return A list with the results of the chi-square test, including:
#' \describe{
#'   \item{\code{statistic}}{The value of the chi-square statistic.}
#'   \item{\code{parameter}}{The degrees of freedom for the test.}
#'   \item{\code{p.value}}{The p-value of the test.}
#'   \item{\code{n.cases}}{The number of cases used in the test.}
#' }
#'
#' @details
#' This function calculates the chi-square statistic for two categorical variables, taking into account optional weights.
#'
#' @examples
#' chisq_test(x = gender, y = education, w = w, data = micro_data)
#' @export
chisq_test <- function(x, y, w = NULL, data = NULL) {

        data.name <- deparse(substitute(data))

        if (data.name == "NULL") {
                data.name <- paste(deparse(substitute(x)), "and",
                                   deparse(substitute(y)))
        }

        if (!is.null(data) && is.matrix(data)) {
                data <- as.data.frame(data)
        }

        if (missing(x) || missing(y))
                stop("'x' and 'y' arguments must be provided.")

        x <- if (is.character(substitute(x))) rlang::sym(x) else rlang::enquo(x)
        y <- if (is.character(substitute(y))) rlang::sym(y) else rlang::enquo(y)
        w <- if (is.character(substitute(w))) rlang::sym(w) else rlang::enquo(w)
        x <- rlang::eval_tidy(x, data)
        y <- rlang::eval_tidy(y, data)
        w <- rlang::eval_tidy(w, data)
        if (!is.null(w)) {
                weighted <- TRUE
                } else weighted <- FALSE
        if (is.null(w))
                w <- rep(1, length(x))
        if (!is.numeric(w)) {
                stop("Weights 'w' must be numeric.")
        }
        if (any(w < 0)) {
                stop("Weights 'w' must be non-negative.")
        }

        ok <- stats::complete.cases(x, y, w)
        x <- x[ok]
        y <- y[ok]
        w <- w[ok]

        x_table <- stats::xtabs(w ~ x + y)
        out <- stats::chisq.test(x_table)

        out[["data.name"]] <- data.name
        if (weighted) out[["method"]] <- "Weighted Pearson's Chi-squared test"
        return(out)
        }
