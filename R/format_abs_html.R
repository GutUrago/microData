




#' Format abstract
#'
#' @param api_resp api response
#' @param raw_html raw or edite? logical
#'
#' @return html
#' @noRd
#'



format_abs_html <- function(api_resp, raw_html){


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
  ul {
  margin-left: 50px;
  list-style-type: circle;
  }
"))
        study_info <- api_resp$dataset


        study_id <- htmltools::tags$ul("Study id: ", study_info$id)
        study_idno <- htmltools::tags$ul("Study idno: ", study_info$idno)
        study_title <- htmltools::tags$ul("Study title: ", study_info$title)
        study_year <- htmltools::tags$ul("Study year: ", study_info$year_end)
        study_country <- htmltools::tags$ul("Study country: ", study_info$nation)
        study_auth <- htmltools::tags$ul("Authoring entity: ", study_info$authoring_entity)
        # study_link <- htmltools::tags$ul("Study link: ", htmltools::tags$a(href = study_info$link_study,
        #                                                                    study_info$link_study))
        abs_title <- htmltools::h2("Abstract")
        abstract <- study_info$metadata$study_desc$study_info$abstract
        abstract <- htmltools::p(abstract)

        if(raw_html){

        final_html_content <- htmltools::tagList(
                study_id,
                study_idno,
                study_title,
                study_year,
                study_country,
                study_auth,
                #study_link,
                abs_title,
                abstract
        )
        } else {
          final_html_content <- htmltools::tagList(
            css_styles,
            study_id,
            study_idno,
            study_title,
            study_year,
            study_country,
            study_auth,
            #study_link,
            abs_title,
            abstract
          )
        }


        return(final_html_content)

}



