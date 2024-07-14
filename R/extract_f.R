

#' Extract F stat from lm
#' @description
#' For each continuous variable supplied, it extracts F stat (ANOVA) and
#' returns named vector.
#'
#'
#' @param x a vector of continuous variable
#' @param by a character name of categorical variable
#' @param data a data frame
#' @param .round an integer value and digits after decimal
#' @param .stars a vector of significance p values
#' @param ... other arguments to pass to `stats::lm` model
#'
#' @return A named vector of F values with significance stars
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' if(FALSE) {
#' extract_f(x = c("Sepal length" = "Sepal.Length"),
#' by = "Species", data = iris, .round = 3)
#' }
extract_f <- function(x, by, data, .round = 2,
                      .stars = c(0.01, 0.05, 0.1), ...) {


        if (!is.null(names(x))) {
                x_names <- names(x)
        } else {
                        x_names <- x
        }

        models <- list()

        for(i in 1:length(x)) {
                models[[x_names[i]]] <- stats::lm(
                        formula = stats::as.formula(paste(x[i], "~", by)),
                        data = data, ...
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
