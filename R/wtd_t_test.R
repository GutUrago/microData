
# Not support weights for Pair() formula, will be fixed


#' @title Weighted Students t-Test
#'
#' @name wtd_t_test
#' @aliases wtd_t_test.default
#' @aliases wtd_t_test.formula
#'
#' @description
#' Performs a one-sample, a two-sample and a paired weighted t-test. It is
#' a slightly modified version of [`t.test`][stats::t.test] with added functionality
#' of supporting weight.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param y an optional (non-empty) numeric vector of data values.
#' @param w an optional numeric vector of weights for `x`. If `NULL`, equal weights are assumed.
#' @param w.y an optional numeric vector of weights for `y`. If `NULL`, equal weights are assumed.
#' @param alternative a character string specifying the alternative hypothesis,
#' must be one of "`two.sided`" (default), "`greater`" or "`less`". You can specify just the initial letter.
#' @param mu a number indicating the true value of the mean (or difference in means if you are performing a two sample test).
#' @param paired a logical indicating whether you want a paired t-test. Default is `FALSE`.
#' @param var.equal a logical variable indicating whether to treat the two variances
#' as being equal. If `TRUE` (default) then the pooled variance is used to estimate
#' the variance otherwise the Welch (or Satterthwaite) approximation to the
#' degrees of freedom is used.
#' @param conf.level confidence level of the interval. Default is 0.95.
#' @param formula a formula of the form `lhs ~ rhs` where `lhs` is a numeric variable
#' giving the data values and `rhs` either `1` for a one-sample or paired test or a
#' factor with two levels giving the corresponding groups. If `lhs` is of class ["Pair"][stats::Pair]
#' and `rhs` is `1`, a paired test is done, see Examples.
#' @param data an optional matrix or data frame (or similar: see [model.frame][stats::model.frame])
#' containing the variables in the formula formula. By default the variables are
#' taken from `environment(formula)`.
#' @param subset an optional vector specifying a subset of observations to be used.
#' @param na.action a function which indicates what should happen when the data contain [NA][base::NA]s.
#' @param ... Additional arguments passed to or from other methods.
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
#'
#' @export
#' @examples
#' # Example 1: One-sample t-test
#' x <- rnorm(10)
#' w <- runif(10)
#' wtd_t_test(x, w = w)
#'
#' # Example 2: Two-sample t-test with equal variances
#' x <- rnorm(10)
#' y <- rnorm(10)
#' wtd_t_test(x, y)
#'
#' # Example 3: Paired t-test
#' x <- rnorm(10)
#' y <- x + rnorm(10)
#' wtd_t_test(x, y, paired = TRUE)
wtd_t_test <- function(x, ...) UseMethod("wtd_t_test")

#' @rdname wtd_t_test
#' @exportS3Method microData::wtd_t_test
# x <- rnorm(10)
# y <- x + rnorm(10)
# wtd_t_test(x, y, paired = TRUE)
wtd_t_test.default <- function(x, y = NULL, w = NULL, w.y = NULL,
                               alternative = c("two.sided", "less", "greater"),
                               mu = 0, paired = FALSE, var.equal = TRUE,
                               conf.level = 0.95, ...) {
    alternative <- match.arg(alternative)
    if (!missing(mu) && (length(mu) != 1 || is.na(mu)))
        stop("'mu' must be a single number")
    if (!missing(conf.level) && (length(conf.level) != 1 ||
                                 !is.finite(conf.level) ||
                                 conf.level < 0 ||
                                 conf.level >1))
        stop("'conf.level' must be a single number between 0 and 1")

    if (!is.null(w) && all(w == 1)) {
        weighted <- FALSE
    } else if (!is.null(w) || !is.null(w.y)) {
        weighted <- TRUE
    } else weighted <- FALSE

    if (paired) {
        if (!is.null(w) && !is.null(w.y)) {
            warning("'ignoring 'w.y' for paired test", call. = FALSE)
        }
        w.y <- NULL  # Ignore w.y in paired tests
    }

    if (is.null(w)) w <- rep(1, length(x))
    if (!paired && is.null(w.y)) w.y <- rep(1, length(y))  # Only needed for unpaired tests

    if (!is.null(y)) {
        dname <- paste(deparse1(substitute(x)), "and", deparse1(substitute(y)))
        if (paired) {
            xok <- yok <- wok <- stats::complete.cases(x, y, w)
        } else {
            yok <- !is.na(y)
            xok <- !is.na(x)
            wok <- !is.na(w)
            w.yok <- !is.na(w.y)
            y <- y[yok]
            w.y <- w.y[w.yok]
        }
        x <- x[xok]
        w <- w[wok]
    } else {
        dname <- deparse1(substitute(x))
        if (paired)
            stop("'y' is missing for paired test")
        xok <- !is.na(x)
        yok <- NULL
        x <- x[xok]
    }

    if (paired) {
        x <- x - y
        y <- NULL
    }

    nx <- length(x)
    mx <- stats::weighted.mean(x, w)
    vx <- wtd_var(x, w)

    if (is.null(y)) {
        if (nx < 2)
            stop("not enough 'x' observations")
        df <- nx - 1
        stderr <- sqrt(vx/nx)
        if (stderr < 10 * .Machine$double.eps * abs(mx))
            stop("data are essentially constant")
        tstat <- (mx - mu)/stderr
        method <- paste(if (weighted) "Weighted",
                        paste(if (paired) "Paired t-test"
                              else "One Sample t-test"))
        estimate <- stats::setNames(mx, if (paired)
            "mean difference"
            else "mean of x")
    }
    else {
        ny <- length(y)
        if (nx < 1 || (!var.equal && nx < 2))
            stop("not enough 'x' observations")
        if (ny < 1 || (!var.equal && ny < 2))
            stop("not enough 'y' observations")
        if (var.equal && nx + ny < 3)
            stop("not enough observations")
        if (length(w.y) != ny)
            stop("'y' and 'w.y' must have the same length")
        my <- stats::weighted.mean(y, w.y)
        vy <- wtd_var(y, w.y)
        method <- paste(if (weighted) "Weighted",
                        paste(if (!var.equal)
                            "Welch", "Two Sample t-test"))
        estimate <- c(mx, my)
        names(estimate) <- c("mean of x", "mean of y")
        if (var.equal) {
            df <- nx + ny - 2
            v <- 0
            if (nx > 1)
                v <- v + (nx - 1) * vx
            if (ny > 1)
                v <- v + (ny - 1) * vy
            v <- v/df
            stderr <- sqrt(v * (1/nx + 1/ny))
        }
        else {
            stderrx <- sqrt(vx/nx)
            stderry <- sqrt(vy/ny)
            stderr <- sqrt(stderrx^2 + stderry^2)
            df <- stderr^4/(stderrx^4/(nx - 1) + stderry^4/(ny - 1))
        }
        if (stderr < 10 * .Machine$double.eps * max(abs(mx),
                                                    abs(my)))
            stop("data are essentially constant")
        tstat <- (mx - my - mu)/stderr
    }

    if (alternative == "less") {
        pval <- stats::pt(tstat, df)
        cint <- c(-Inf, tstat + stats::qt(conf.level, df))
    }
    else if (alternative == "greater") {
        pval <- stats::pt(tstat, df, lower.tail = FALSE)
        cint <- c(tstat - stats::qt(conf.level, df), Inf)
    }
    else {
        pval <- 2 * stats::pt(-abs(tstat), df)
        alpha <- 1 - conf.level
        cint <- stats::qt(1 - alpha/2, df)
        cint <- tstat + c(-cint, cint)
    }
    cint <- mu + cint * stderr
    names(tstat) <- "t"
    names(df) <- "df"
    names(mu) <- if (paired)
        "mean difference"
    else if (!is.null(y))
        "difference in means"
    else "mean"
    attr(cint, "conf.level") <- conf.level
    rval <- list(statistic = tstat, parameter = df, p.value = pval,
                 conf.int = cint, estimate = estimate, null.value = mu,
                 stderr = stderr, alternative = alternative, method = method,
                 data.name = dname)
    class(rval) <- "htest"
    rval
}


#' @rdname wtd_t_test
#' @exportS3Method microData::wtd_t_test
#' @importFrom stats na.pass
wtd_t_test.formula <- function(formula, w = NULL, data, subset, na.action = na.pass, ...){
        if (missing(formula) || (length(formula) != 3L)) {
                stop("'formula' missing or incorrect")
        }
        if ("paired" %in% names(list(...))) {
                stop("cannot use 'paired' in formula method")
        }
        if (missing(formula) || (length(formula) != 3L))
                stop("'formula' missing or incorrect")
        if ("paired" %in% ...names())
                stop("cannot use 'paired' in formula method")
        oneSampleOrPaired <- FALSE
        if (length(attr(stats::terms(formula[-2L]), "term.labels")) !=
            1L)
                if (formula[[3L]] == 1L)
                        oneSampleOrPaired <- TRUE
        else stop("'formula' missing or incorrect")
        m <- match.call(expand.dots = FALSE)
        if (is.matrix(eval(m$data, parent.frame())))
                m$data <- as.data.frame(data)
        m[[1L]] <- quote(stats::model.frame)
        m$... <- NULL
        mf <- eval(m, parent.frame())
        x.name <- names(mf)[1L]
        g.name <- names(mf)[2L]
        w.name <- names(mf)[3L]
        DNAME <- paste(c(x.name, g.name), collapse = " by ")
        if (!oneSampleOrPaired) {
                x <- mf[[x.name]]
                g <- factor(mf[[g.name]])
                if (nlevels(g) != 2L)
                        stop("grouping factor must have exactly 2 levels")
                w <- mf[[w.name]]
                if (is.null(w))
                        w <- rep(1, length(x))
                xs <- split(x, g)
                ws <- split(w, g)
                out <- wtd_t_test(x = xs[[1]], y = xs[[2]], w = ws[[1]], w.y = ws[[1]], ...)
                if (length(out$estimate) == 2L) {
                        names(out$estimate) <- paste("mean in group", levels(g))
                        names(out$null.value) <- paste("difference in means between",
                                                     paste("group", levels(g), collapse = " and "))
                }
        }
        else {
                respVar <- mf[[x.name]]
                w <- mf[[w.name]]
                if (is.null(w)) w <- rep(1, length(x))
                if (inherits(respVar, "Pair")) {
                        out <- wtd_t_test(x = respVar[, 1L],
                                          y = respVar[, 2L],
                                          w = w,
                                          paired = TRUE, ...)
                }
                else {
                    w <- mf[[w.name]]
                    if (is.null(w)) w <- rep(1, length(x))
                    out <- wtd_t_test(x = respVar, w = w, ...)
                }
        }
        out$data.name <- DNAME
        class(out) <- "htest"
        return(out)
}














