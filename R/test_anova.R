

#' Extract F-stat from ANOVA Test
#' @description
#' For each continuous variable supplied, it extracts F stat (ANOVA) and
#' returns named vector.
#'
#'
#' @param data a data frame containing all variables passed to arguments
#' @param vars a string or (named) vector of continuous variables
#' @param by a string name of categorical variable
#' @param w a string of weights variable name

#' @param .round an integer value and digits after decimal
#' @param .stars a vector of significance p values
#' @param ... other arguments to pass to `stats::lm()` model
#'
#' @return A named vector of F values with significance stars
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' if(FALSE) {
#' test_anova(data = iris,
#' vars = c("Sepal length" = "Sepal.Length",
#' "Sepal Width" = "Sepal.Width"),
#' by = "Species", .round = 3)
#' }
test_anova <- function(data,
                       vars,
                       by,
                       w = NULL,
                       .round = 2,
                       .stars = c(0.01, 0.05, 0.1),
                       ...) {


        if (!is.null(names(vars))) {
                x_names <- names(vars)
        } else {
                        x_names <- vars
        }

        models <- list()

        for(i in 1:length(vars)) {
                models[[x_names[i]]] <- stats::lm(
                        formula = stats::as.formula(paste(vars[i], "~", by)),
                        data = data, weights = w, ...
                )
        }

        extract_single <- function(model) {
                model_summary <- stats::anova(model)
                f_stat <- round(model_summary[["F value"]][1],
                                .round)
                p_value <- model_summary[["Pr(>F)"]][1]
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
                f_result <- paste0(f_stat, signif_stars)
                return(f_result)
        }

        results <- lapply(models, extract_single)
        results <- unlist(results)

        return(results)
}
