



#' Extract Mean Difference
#' @description
#' It extracts multiple (weighted) mean difference along with t-test
#' significance stars using `weights` packages.
#'
#' @param data a data frame containing all variables provided in the arguments
#' @param vars a string and (named) vector of numerical variables
#' @param by a string name of categorical (factor) variable with two levels
#' @param w a string name of weight variable
#' @param .round an integer of digits after decimal point for mean differences
#' @param .stars a numerical vector corresponding to `***`, `**`, and `*`
#' significance stars, respectively
#' @param ... arguments passed to `weights::wtd.t.test()`
#'
#' @return Returns a named vector
#' @export
#' @author Gutama Girja Urago
#'
#' @examples
#' if (FALSE) {
#' test_mean(data = my_data,
#' vars = c(Age = "age", Income = "income"),
#' by = "gender",
#' w = "pw")
#' }


test_mean <- function(data,
                      vars,
                      by,
                      w = NULL,
                      .round = 2,
                      .stars = c(0.01, 0.05, 0.1),
                            ...) {

        if (!is.factor(data[[by]])) {
                data[[by]] <- as.factor(data[[by]])
        }

        data[[by]] <- droplevels(data[[by]])

        if (length(levels(data[[by]])) > 2) {
                stop(paste("\nThe variable", by, "has more than 2 levels"))
        }

        level_x <- levels(data[[by]])[2]
        level_y <- levels(data[[by]])[1]

        if (!is.null(w)) {
                weight <- data[data[[by]] == level_x,][[w]]
                weighty <- data[data[[by]] == level_y,][[w]]
        } else {
                weight <- NULL
                weighty <- NULL
        }


        diffs <- NULL

        for (i in seq_along(vars)) {

                x <- data[data[[by]] == level_x,][[vars[i]]]
                y <- data[data[[by]] == level_y,][[vars[i]]]

                mean_test <- weights::wtd.t.test(x = x,
                                                 y = y,
                                                 weight = weight,
                                                 weighty = weighty,
                                                 ...)

                difference <- mean_test[["additional"]][["Difference"]]

                difference <- round(difference, .round)

                p_value <- mean_test[["coefficients"]][["p.value"]]

                signif_stars <- if (p_value < .stars[1]) {
                        "***"
                }
                else if (p_value < .stars[2]) {
                        "**"
                }
                else if (p_value < .stars[3]) {
                        "*"
                }
                else {
                        ""
                }

                diffs[i] <- paste0(difference, signif_stars)
        }

        if (!is.null(names(vars))) {
                var_names <- names(vars)
                names(diffs) <- var_names
        } else {names(diffs) <- vars}

        return(diffs)

}
















