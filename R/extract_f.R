




#' Title
#'
#' @param models a named list of anova models
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
#' Age = aov(age ~ sex, data = my_data)))
#' }

extract_f <- function(models,
                      .round = 2,
                      .stars = c(0.01, 0.05, 0.1)) {

        extract_single <- function(model) {
                model_summary <- summary(model)
                # test_term <- as.character(model[["terms"]][[2]])
                f_stat <- round(model_summary[[1]][["F value"]][1], .round)
                p_value <- model_summary[[1]][["Pr(>F)"]][1]
                signif_stars <- if (p_value < .stars[1]) {
                        "***"
                } else if (p_value < .stars[2]) {
                        "**"
                } else if (p_value < .stars[3]) {
                        "*"
                } else {
                        ""
                }
                f_result <- paste0(f_stat, signif_stars)
                # names(f_result) <- test_term
                return(f_result)
        }

        results <- lapply(models, extract_single)
        results <- unlist(results)
        return(results)
}
