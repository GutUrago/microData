

mdt_data_files <- function(){
        #base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}/data_files"
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M/data_files"
        response <- request_api(server_url)
        datafiles <- response$datafiles
        return(datafiles)
        }
