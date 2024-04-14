




#' Reduce to binary factor
#' @description
#' Used with grouped data frames to aggregate variables
#' by testing if the value `look` observed at least once
#'
#'
#' @param x a variable
#' @param look targeted values
#' @param yes values set to target values
#' @param no values set to if the test is false
#'
#' @return factor with two levels
#' @export
#'
#' @examples
#' # to_dummy(x)



to_dummy <- function(x, look = "yes",
                     yes = "yes", no = "no"){
        x <- any(x %in% look)
        x <- data.table::fifelse(x, yes = yes, no = no)
        x <- factor(x = x, levels = c(no, yes))
        return(x)
        }


