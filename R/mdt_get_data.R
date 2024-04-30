

function(idno){
        base_url <- "https://microdata.worldbank.org/index.php/api/tables/data/fcv"
        req <- httr2::request(base_url)
        req <- httr2::req_url_path_append(req, "wld_2021_rtfp_v02_m")
        req <- httr2::req_url_query(req, limit = 1000)
        resp <- httr2::req_perform(req)
        api_char <- rawToChar(resp$body)
        response <- jsonlite::fromJSON(api_char, flatten = TRUE)
        data <- response$data

}
