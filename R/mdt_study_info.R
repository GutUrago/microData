

mdt_study_info <- function(){
        # base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}"
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M"
        response <- request_api(server_url)
        info <- response$dataset
        return(info)
}

