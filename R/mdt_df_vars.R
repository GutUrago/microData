

mdt_vars <- function(){
        # base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}/data_files/{fileId}/variables"
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M/data_files/F1/variables"
        response <- request_api(server_url)
        variables <- response$variables
        return(variables)
        }



