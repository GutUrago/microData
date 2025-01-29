

#' @title Weighted Students t-Test
#' @description
#' Performs a one-sample, a two-sample and a paired weighted t-test. It is
#' a slightly modified version of [`t.test`][stats::t.test] with added functionality
#' of supporting weight and pipe.
#'
#' @param data an optional matrix or data frame placed as first argument for the
#' function to be pipe-friendly.
#' @param x a name of numeric variable in the data frame or numeric vector in the environment.
#' @param y an optional name variable in the data frame or a vector in the environment.
#' It can be a numeric or factor with two levels. See details.
#' @param w an optional (weights) name of numeric variable in the data frame or in the environment.
#' See details.
#' @param w.y an optional weights argument for y.
#' @param alternative a character string specifying the alternative hypothesis,
#' must be one of "`two.sided`" (default), "`greater`" or "`less`". You can
#' specify just the initial letter.
#' @param paired a logical indicating whether you want a paired t-test.
#' @param mu a number indicating the true value of the mean (or difference in
#' means if you are performing a two sample test).
#' @param conf.level onfidence level of the interval.
#' @param var.equal a logical variable indicating whether to treat the two
#' variances as being equal. If TRUE then the pooled variance is used to
#' estimate the variance otherwise the Welch (or Satterthwaite) approximation
#' to the degrees of freedom is used.
#' @param na.rm a logical indicating wether you want to remove `NA` values.
#'
#'
#' @details
#' It shares the same default behavior with [`t.test`][stats::t.test], except
#' `var.equal = TRUE` for this function.
#'
#' `alternative = "greater"` is the alternative that `x` has a larger mean than `y`.
#' For the one-sample case: that the mean is positive.
#'
#' If `paired` is `TRUE` then both `x` and `y` must be specified and they must be the same length. Missing
#' values are silently removed (in pairs if `paired` is `TRUE`). By default,
#' if `var.equal` is `TRUE` then the variance is estimated separately for both
#' groups and the Welch modification to the degrees of freedom is used.
#'
#' If the input data are effectively constant (compared to the larger of the
#' two means) an error is generated.
#'
#'
#' @return A list with class "`htest`" containing the following components:
#' \itemize{
#'   \item \code{statistic}: the value of the t-statistic.
#'   \item \code{parameter}: the degrees of freedom for the t-statistic.
#'   \item \code{p.value}: the p-value for the test.
#'   \item \code{conf.int}: a confidence interval for the mean appropriate to the specified alternative hypothesis.
#'   \item \code{estimate}: the estimated mean or difference in means depending on whether it was a one-sample test or a two-sample test.
#'   \item \code{null.value}: the specified hypothesized value of the mean or mean difference depending on whether it was a one-sample test or a two-sample test.
#'   \item \code{stderr}: the standard error of the mean (difference), used as denominator in the t-statistic formula.
#'   \item \code{alternative}: a character string describing the alternative hypothesis.
#'   \item \code{method}: a character string indicating what type of t-test was performed.
#'   \item \code{data.name}: a character string giving the name(s) of the data.
#' }
#'
#' @author Gutama Girja Urago
#'
#' @references This function if a modified version of [t.test][stats::t.test].
#' @export
#'
#' @examples
#' library(datasets)
#' # One sample t-test
#' wtd_t_test(mtcars, disp, mu = 200)
#' # Variables can be a vector outside of data frame
#' wtd_t_test(mtcars, disp, w = rep(c(1, 2), 16), mu = 200)
#' # Paired t-test
#' wtd_t_test(mtcars, gear, carb, paired = TRUE)
#' # Two sample t-test
#' wtd_t_test(mtcars, drat, wt)
#' wtd_t_test(mtcars, mpg, as.factor(vs))
#' wtd_t_test(mtcars, mpg, as.factor(vs), w = qsec)


wtd_t_test <- function(data, x, y = NULL, w = NULL, w.y = NULL,
                       alternative = c("two.sided", "less", "greater"),
                       paired = FALSE, mu = 0, conf.level = 0.95,
                       var.equal = TRUE, na.rm = TRUE) {

    alternative <- arg_match0(alternative,
                                     values = c("two.sided", "less", "greater"))

    if (!missing(mu) && (length(mu) != 1 || is.na(mu)))
        stop("'mu' must be a single number")
    if (!missing(conf.level) && (length(conf.level) != 1 ||
                                 !is.finite(conf.level) ||
                                 conf.level < 0 ||
                                 conf.level >1))
        stop("'conf.level' must be a single number between 0 and 1")

    if (!missing(data)) {
        if (is.matrix(eval(data, parent.frame())))
        data <- as.data.frame(data)
    } else data <- NULL

    x.name <- deparse1(substitute(x))
    dname <- x.name
    y.name <- deparse1(substitute(y))
    x <- if (is.character(substitute(x))) sym(x) else enquo(x)
    y <- if (is.character(substitute(y))) sym(y) else enquo(y)
    w <- if (is.character(substitute(w))) sym(w) else enquo(w)
    w.y <- if (is.character(substitute(w.y))) sym(w.y) else enquo(w.y)
    x <- eval_tidy(x, data)
    y <- eval_tidy(y, data)
    w <- eval_tidy(w, data)
    w.y <- eval_tidy(w.y, data)

    if (is.factor(y) && paired) {
        stop("For paired test 'y' cannot be a factor.")
    }

    if (is.null(y)) {
        oneSample <- TRUE
    } else oneSample <- FALSE

    if (na.rm) {
        if (paired) {
            ok <- complete.cases(x, y, w, w.y)
            x <- x[ok]
            y <- y[ok]
            w <- w[ok]
            w.y <- w.y[ok]
        } else {
            xok <- complete.cases(x, w)
            x <- x[xok]
            w <- w[xok]

            if (!is.null(y)) {
                yok <- complete.cases(y, w.y)
                y <- y[yok]
                w.y <- w.y[yok]
            }
        }
    }

    if (is.null(w)) {
        w <- rep(1, length(x))
    }
    y.fct <- FALSE
    if (!is.null(y)) {
        dname <- paste(x.name, "and", y.name)
        if (is.null(w.y)) {
            w.y <- rep(1, length(y))
        }

        if (is.factor(y)) {
            if (nlevels(y) != 2) {
                stop("'y' must be a factor with exactly two levels")
            }
            y.fct <- TRUE
            dname <- paste(x.name, "by", y.name)
            if (length(x) != length(y)) {
                stop("'x' and 'y' must have the same length if y is a factor.")
            }
            group1 <- y == levels(y)[1]
            group2 <- y == levels(y)[2]

            x1 <- x[group1]
            x2 <- x[group2]

            w1 <- w[group1]
            w2 <- w[group2]

            y <- NULL
            x <- x1
            w <- w1
            y <- x2
            w.y <- w2
        }
    }
    if (!is.numeric(w) && !is.null(w))
        stop("'w' must be a numeric variable or vector.")
    if (!is.numeric(w.y) && !is.null(w.y))
        stop("'w.y' must be a numeric variable or vector.")

    if (paired) {
        if (is.null(y)) {
            stop("For a paired test, both 'x' and 'y' must be provided.")
        }
        dname <- paste(x.name, "and", y.name)
        d <- x - y
        w.d <- (w + w.y) / 2
        x <- d
        w <- w.d
        y <- NULL
    }

    wtd_mean <- function(x, w) sum(w * x) / sum(w)

    mean_x <- wtd_mean(x, w)
    n_x <- length(x)

    if (!is.null(y)) {
        mean_y <- wtd_mean(y, w.y)
        n_y <- length(y)
    }

    var_x <- wtd_var(data = NULL, x, w, na.rm = na.rm)

    if (!is.null(y)) {
        var_y <- wtd_var(data = NULL, y, w.y, na.rm = na.rm)
    }

    if (is.null(y)) {
        stderr <- sqrt(var_x / n_x)
        if (stderr < 10 * .Machine$double.eps * abs(mean_x))
            stop("data are essentially constant")
        t_stat <- (mean_x - mu) / stderr
        df <- n_x - 1
        method <- if (paired) {
            "Weighted Paired t-test"
            } else " Weighted One Sample t-test"
        estimate <- mean_x
        names(estimate) <- if (paired) {
            "mean difference"
            } else "mean of x"
    } else {
        if (n_x < 1 || (!var.equal && n_x < 2))
            stop("not enough 'x' observations")
        if (n_y < 1 || (!var.equal && n_y < 2))
            stop("not enough 'y' observations")
        if (var.equal && n_x + n_y < 3)
            stop("not enough observations")
        method <- if (var.equal) {
            "Weighted Two Sample t-test"
        } else "Weighted Welch Two Sample t-test"
        estimate <- c(mean_x, mean_y)
        names(estimate) <- c("mean of x", "mean of y")
        if (var.equal) {
            df <- n_x + n_y - 2
            v <- 0
            if (n_x > 1)
                v <- v + (n_x - 1) * var_x
            if (n_y > 1)
                v <- v + (n_y - 1) * var_y
            v <- v/df
            stderr <- sqrt(v * (1/n_x + 1/n_y))

        } else {
            stderrx <- sqrt(var_x/n_x)
            stderry <- sqrt(var_y/n_y)
            stderr <- sqrt(stderrx^2 + stderry^2)
            df <- stderr^4/(stderrx^4/(n_x - 1) + stderry^4/(n_y - 1))
        }
        if (stderr < 10 * .Machine$double.eps * max(abs(mean_x),
                                                    abs(mean_y)))
            stop("data are essentially constant")
        t_stat <- (mean_x - mean_y - mu) / stderr
    }

    p_value <- switch(alternative,
                      "two.sided" = 2 * pt(-abs(t_stat), df),
                      "less" = pt(t_stat, df),
                      "greater" = pt(t_stat, df, lower.tail = FALSE))

    alpha <- 1 - conf.level
    t_crit <- qt(1 - alpha / 2, df)
    if (is.null(y)) {
        margin_error <- t_crit * stderr
        conf_interval <- c(mean_x - margin_error, mean_x + margin_error)
    } else {
        margin_error <- t_crit * stderr
        conf_interval <- c((mean_x - mean_y) - margin_error,
                           (mean_x - mean_y) + margin_error)
    }

    names(t_stat) <- "t"
    names(df) <- "df"
    names(mu) <- if (paired)
        "mean difference"
    else if (!is.null(y))
        "difference in means"
    else "mean"
    attr(conf_interval, "conf.level") <- conf.level

    result <- list(
        statistic = t_stat,
        parameter = df,
        p.value = p_value,
        conf.int = conf_interval,
        estimate = estimate,
        null.value = mu,
        stderr = stderr,
        alternative = alternative,
        method = method,
        data.name = dname
    )

    class(result) <- "htest"
    return(result)
}








