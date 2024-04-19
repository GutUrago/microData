

study_variables <- function(){
        # base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}/variables"
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M/variables"
        server_req <- httr2::request(server_url)
        api_resp <- httr2::req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        collection <- jsonlite::fromJSON(api_char, flatten = T)
        df <- collection$variables
        return(df)
}


study_variables()
