



#' Compare Group (Weighted) Mean
#' @description
#' Create a summary table for the (weighted) mean by group and performs an ANOVA test.
#'  If the grouping variable is binary, t-statistics is reported instead of f-statistic.
#'
#'
#' @param data is a data frame that contains all variables, including weight, if supplied.
#' @param vars is a vector of variables for which means are supposed to be calculated.
#' @param by is a factor grouping variable. It internally converts to a factor
#' if another type of variable is supplied.
#' @param w is an optional weight variable.
#' @param digits is an integer indicating number of digits after decimal point.
#' @param use_labels is a logical indicating if the variable labels should be
#' returned instead of variable names.
#' @param stars_on is a character indicating where to paste significance stars
#' taking value of 'non', 'stat' or 'diffs'. If 'none' p values are returned as a
#' separate column.
#' @param sign_levels is a named vector of p_values with corresponding stars.
#'
#' @details
#' This function calculates the mean using `collapse::fmean()` by using a grouping
#' variable. After all mean values are calculated, it employs the `stats::lm()` model
#' to obtain test statistics. If the grouping variable is a factor with two levels,
#' the square root of the resulting F statistics is returned. Therefore, for binary
#' grouping variables, the test is a two-sample t-test with an assumption of equal variance.
#'
#'
#' @return Returns a data frame ready to be exported or manipulated with fancy
#' gt table. The 'diffs' column is returned only when a grouping variable has only
#' two levels.
#'
#' @author Gutama Girja Urago
#'
#' @seealso [dummify()] to create dummy variables
#'
#' @export
#'
#' @examples
#'
#' if (FALSE) {
#' compare_mean(iris, vars = c(Sepal.Length, Sepal.Width,
#' Petal.Length, Petal.Width),
#' by = Species)
#' }
#'
compare_mean <- function(data, vars, by, w = NULL,
                           digits = 2, use_labels = TRUE,
                           stars_on = "stat",
                           sign_levels = c("***" = 0.01, "**" = 0.05, "*" = 0.1)) {

        vars <- substitute(vars)

        if (is.call(vars) && vars[[1]] == "c") {
                var_names <- as.character(vars[-1])
        } else {
                var_names <- as.character(vars)
        }

        w <- substitute(w)
        if (!is.null(w)) {
                w <- as.character(w)
                w <- data[[w]]
        }

        by <- substitute(by)
        by <- as.character(by)

        if (!is.factor(data[[by]])) {
                data[[by]] <- as.factor(data[[by]])
        }

        data[[by]] <- droplevels(data[[by]])

        g <- GRP(data, by = by)

        n_groups <- g[["N.groups"]]

        mean_list <- list()

        for (i in seq_along(var_names)) {
                var_name <- var_names[i]
                mean_list[[var_name]] <- fmean(data[[var_name]],
                                                          g = g, w = w)
        }

        mean_list <- lapply(mean_list, round, digits = digits)
        mean_df <- do.call(rbind, mean_list)
        mean_df <- as.data.frame(mean_df)
        mean_df <- data.frame("Variable" = row.names(mean_df), mean_df)
        row.names(mean_df) <- NULL
        if (n_groups == 2) {
                mean_df[["diffs"]] <- mean_df[, 3] - mean_df[, 2]
        }

        test_df <- data.frame()

        for(i in seq_along(var_names)) {

                var_name <- var_names[i]

                model <- stats::lm(
                        formula = stats::as.formula(paste(var_name, "~", by)),
                        data = data, weights = w)

                test <- stats::anova(model)

                Variable <- var_name

                stat <- test[["F value"]][1]

                p_value <- test[["Pr(>F)"]][1]

                test_stat <- data.frame(Variable, stat, p_value)

                test_df <- rbind(test_df, test_stat)
        }

        if (n_groups == 2) {
                test_df$stat <- sqrt(test_df$stat)
        }

        test_df$stat <- round(test_df$stat, digits)

        sign_levels <- sort(sign_levels)
        .stars <- names(sign_levels)

        if (tolower(stars_on) == "stat" || tolower(stars_on) == "diffs") {

                for (i in 1:nrow(test_df)) {
                        p_value <- test_df[["p_value"]][i]
                        star <- ""
                        for (j in 1:length(sign_levels)) {
                                if (p_value < sign_levels[j]) {
                                        star <- .stars[j]
                                        break
                                        }
                                }
                        test_df[["p_value"]][i] <- star
                        }

        }

        if (tolower(stars_on) == "stat") {
                test_df[["stat"]] <- round(test_df[["stat"]], digits)
                test_df[["stat"]] <- paste0(test_df$stat, test_df$p_value)
                test_df$p_value <- NULL
        } else if (tolower(stars_on) == "diffs" && n_groups == 2) {
                mean_df[["diffs"]] <- round(mean_df[["diffs"]], digits)
                mean_df[["diffs"]] <- paste0(mean_df$diffs, test_df$p_value)
                test_df$stat <- NULL
                test_df$p_value <- NULL
        }

        if (tolower(stars_on) == "none") {
                test_df$p_value <- round(test_df$p_value, 4)
        }

        if (tolower(stars_on) == "diffs" && n_groups != 2) {
                warning("\nMean difference is only calculated for factor with two levels.")
        }


        out_df <- join(mean_df, test_df,
                                 on = "Variable", verbose = FALSE)

        if (use_labels) {
                var_labels <- vlabels(data, attrn = "label", use.names = TRUE)

                var_labels <- var_labels[var_names]

                var_names <- names(var_labels)

                for (i in seq_along(var_labels)){
                        if (is.na(var_labels[i])) var_labels[i] <- var_names[i]

                }

                out_df$Variable <- var_labels[out_df$Variable]
        }


        return(out_df)

}





