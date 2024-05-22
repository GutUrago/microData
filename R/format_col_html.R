
#' Formats HTML
#'
#' @param api_resp A api_resp raw data frame
#' @param org Organization
#'
#' @param raw_html raw or edited? logical
#'
#'
#' @return Formatted html
#' @noRd
#'


format_col_html <- function(api_resp, org, raw_html){

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
    base_url <- "https://webapps.ilo.org/surveyLib/"
  } else {stop("\nOrganization should be one of WB, FAO, UNHCR, IHSN or ILO")}


        css_styles <- htmltools::tags$style(htmltools::HTML("
  h2 {
    font-family: 'Inter', 'Roboto', 'Open Sans', sans-serif;
    font-size: 24px;
    color: #000000;
    background-color: #FFFFFF;/
    padding: 2px;
    text-align: center;
    border-radius: 3px;
  }
  p {
    font-family: 'Inter', 'Roboto', 'Open Sans', sans-serif;;
    font-size: 16px;
    color: #333333;
    background-color: #FFFFFF;
    padding: 10px;
    line-height: 1.6;
    text-align: justify;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-width: 100%;
    height: auto;
  }
"))

        id_html <- htmltools::HTML(paste('<h2>', 'ID:', api_resp$id, '</h2>'))
        repo_id_html <- htmltools::HTML(paste('<h2>', 'Repository ID:', api_resp$repositoryid, '</h2>'))
        title_html <- htmltools::HTML(paste('<h2>', 'Title:', api_resp$title, '</h2>'))

        short_desc_title_html <- htmltools::h2("Short Description")

        short_text <- api_resp$short_text

        if(grepl("^<.*>$", short_text)) {
          short_html <- htmltools::HTML(short_text)
        } else {short_html <- htmltools::p(short_text)}


        thumbnial <- api_resp$thumbnail
        if(grepl("^files/.*?\\.\\w{3}$", thumbnial)){
          thumbnial_link <- paste0(base_url, thumbnial)
          thumbnial_img <- htmltools::img(src = thumbnial_link)}


        long_desc_title_html <- htmltools::h2("Brief Description")

        long_text <- api_resp$long_text
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


        # if (!grepl("^<.*>$", long_text)) {
        #   long_text <- htmltools::p(long_text)
        # }

        if(is.character(long_text)){
          long_html <- htmltools::HTML(long_text)
        } else long_html <- long_text



        if(raw_html){
        final_html_content <- htmltools::tagList(
            id_html,
            repo_id_html,
            title_html,
            thumbnial_img,
            short_desc_title_html,
            short_html,
            long_desc_title_html,
            long_html
        )
        } else {
          final_html_content <- htmltools::tagList(
            css_styles,
            id_html,
            repo_id_html,
            title_html,
            thumbnial_img,
            short_desc_title_html,
            short_html,
            long_desc_title_html,
            long_html
          )
        }


        return(final_html_content)

}




















