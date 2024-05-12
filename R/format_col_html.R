
#' Formats HTML
#'
#' @param collection A collection raw data frame
#' @param org Organization
#'
#'
#' @return Formatted html
#' @noRd
#'


format_col_html <- function(collection, org){

  # Retrieve missing parts of file url
  if(tolower(org) == "wb"){
    base_url <- "https://microdata.worldbank.org/"
  } else if(tolower(org) == "fao"){
    base_url <- "https://microdata.fao.org/"
  } else if(tolower(org) == "unhcr"){
    base_url <- "https://microdata.unhcr.org/"
  } else if(tolower(org) == "ihsn") {
    base_url <- "https://datacatalog.ihsn.org/"
  } else if(tolower(org) == "ilo") {
    base_url <- "https://www.ilo.org/"
  } else {stop("\nOrganization should be one of WB, FAO, UNHCR, IHSN or ILO")}

        # Define the CSS for all h2 headings and p paragraphs
        css_styles <- htmltools::tags$style(htmltools::HTML("
  h2 {
    font-family: 'Arial', sans-serif; /* Uniform font family for h2 */
    font-size: 24px; /* Font size for h2 */
    color: #000000; /* Color for h2 */
    background-color: #FFFFFF; /* Background color for h2 */
    padding: 2px; /* Padding around h2 */
    text-align: center; /* Center alignment for h2 */
    border-radius: 3px; /* Rounded corners for h2 */
  }
  p {
    font-family: 'Arial', sans-serif; /* Uniform font family for p */
    font-size: 16px; /* Font size for p */
    color: #333333; /* Text color for p */
    background-color: #FFFFFF; /* Background color for p */
    padding: 10px; /* Padding around p */
    line-height: 1.6; /* Line height for p */
    text-align: justify; /* Justified text for p */
  }
"))


        id_html <- htmltools::HTML(paste('<h2>', 'ID:', collection$id, '</h2>'))
        repo_id_html <- htmltools::HTML(paste('<h2>', 'Repository ID:', collection$repositoryid, '</h2>'))
        title_html <- htmltools::HTML(paste('<h2>', 'Title:', collection$title, '</h2>'))

        # short_text <- collection$short_text
        #
        # if(grepl("^<.*>$", short_text)) {
        #   short_html <- htmltools::HTML(short_text)
        # } else {short_html <- htmltools::HTML(paste("<p>", short_text, "</p>"))}


        thumbnial <- collection$thumbnail
        if(grepl("^files/.*?\\.\\w{3}$", thumbnial)){
          thumbnial_link <- paste0(base_url, thumbnial)
          thumbnial_img <- htmltools::img(src = thumbnial_link,
                                          style = "display: block; margin-left: auto; margin-right: auto;")}


        long_text <- collection$long_text
        if(grepl("\"/files.*?\\\"", long_text)){
          long_text <- gsub(pattern = "\"(/files.*?\")",
                            replacement = paste0("\\\"", base_url, "\\1"),
                            x = long_text)

        }


        if(grepl("<div.*?:fcv]</div>", long_text)){
          long_text <- gsub(pattern = "<div.*?:fcv]</div>",
                            replacement = "",
                            x = long_text)

        }

        if(grepl("^<.*>$", long_text)) {
          long_html <- htmltools::HTML(long_text)
          } else {long_html <- htmltools::HTML(paste("<p>", long_text, "</p>"))}

        # Not to duplicate thumbnail
        if(grepl("^<img.*", long_text)){
        final_html_content <- htmltools::tagList(
                css_styles,
                id_html,
                repo_id_html,
                title_html,
                long_html
        )}
        else {final_html_content <- htmltools::tagList(
          css_styles,
          id_html,
          repo_id_html,
          title_html,
          thumbnial_img,
          long_html
        )}

        return(final_html_content)

}




