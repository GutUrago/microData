




#' Extract f stat from anova tests
#'
#' @param models a named list of linear models (lm)
#' @param .round an integer to F stat
#' @param .stars a vector of p value cutoffs for significance stars
#'
#' @return A named vector to be inserted in summary tables
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' if (FALSE){
#' extract_f(models = list(
#' Age = stats::lm(age ~ sex, weights = pw, data = my_data)))
#' }

extract_f <- function (models,
                       .round = 2,
                       .stars = c(0.01, 0.05, 0.1)) {

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
