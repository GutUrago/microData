
# here <- data_files()

data_info <- function(){
        #base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}/data_files/{fileId}"
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M/data_files/F1"
        server_req <- httr2::request(server_url)
        api_resp <- httr2::req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        collection <- jsonlite::fromJSON(api_char, flatten = T)
        df <- collection$datafile
        return(df)
        }
