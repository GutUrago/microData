



#' Available surveys
#' @description
#' Extracts the available surveys from the organization. Returns name of the country,
#'  year, catalog and title of each survey.
#'
#'
#' @param org ame of an organization. `default = 'wb'`, also supports 'fao', 'unchr' and 'ihsn'.
#'
#' @return a data table
#' @export
#' @author Gutama Girja Urago
#' @examples
#' surveys("unhcr")


surveys <- function(org = "wb"){
        if(org == "wb") {
                link <- "https://microdata.worldbank.org/index.php/catalog/?page=1&ps=100"
        } else if(org == "fao"){
                link <- "https://microdata.fao.org/index.php/catalog/?page=1&ps=100"
        } else if(org == "unhcr"){
                link <- "https://microdata.unhcr.org/index.php/catalog/?page=1&ps=100"
        } else if(org == "ihsn"){
                link <- "https://datacatalog.ihsn.org/catalog/?page=1&ps=100"
        } else {stop("org argument takes only 'wb', 'fao', 'unhcr' or 'ihsn'")}

        pages <- rvest::read_html(link)
        pages <- rvest::html_nodes(pages, ".search-count")
        pages <- rvest::html_text2(pages)
        pages <- stringr::str_extract(pages, "(?<=100 of )\\d{1,3}(?:,\\d{3})*")
        pages <- stringr::str_remove_all(pages, ",")
        pages <- 1:ceiling(as.numeric(pages)/100)

        if(org == "wb") {
                root <- "https://microdata.worldbank.org/index.php/catalog/?page="
        } else if(org == "fao"){
                root <- "https://microdata.fao.org/index.php/catalog/?page="
        } else if(org == "unhcr"){
                root <- "https://microdata.unhcr.org/index.php/catalog/?page="
        } else if(org == "ihsn"){
                root <- "https://datacatalog.ihsn.org/catalog/?page="
        } else {stop("org argument takes only 'wb', 'fao', 'unhcr' or 'ihsn'")}

        links <- purrr::map_vec(pages, ~paste0(root, .x, "&ps=100"))
        raw_html <- purrr::map(links, rvest::read_html)
        surveys <- purrr::map(raw_html, ~rvest::html_nodes(.x, ".wb-card-title"))
        raw_text <- purrr::map(surveys, ~rvest::html_element(.x, "a"))
        text_attr <- purrr::map(raw_text, rvest::html_attrs)
        plain_text <- purrr::map(text_attr, as.character)
        plain_text <- unlist(plain_text)
        catalogs <- purrr::map_vec(plain_text, ~stringr::str_extract(.x, "(?<=catalog/)\\d+"))
        title <- purrr::map_vec(plain_text, ~stringr::str_extract(.x, "(?<=title = \")[^\"]+"))
        countries <- purrr::map(raw_html, ~rvest::html_nodes(.x, ".study-country"))
        countries <- purrr::map(countries, rvest::html_text2)
        countries <- purrr::map(countries, stringr::str_trim)
        country <- purrr::map(countries, ~stringr::str_extract(.x, ".*(?=,\\s*[^,]*$)"))
        year <- purrr::map(countries, ~stringr::str_extract(.x, "(?<=, )[^,]*$"))
        country <- unlist(country)
        year <- unlist(year)
        dt <- data.table::data.table(
                'Country' = country,
                'Year' = year,
                'Catalog' = catalogs,
                'Survey' = title)
        return(dt)
        }



