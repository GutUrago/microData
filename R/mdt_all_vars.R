

mdt_all_vars <- function(){
        # base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}/variables"
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M/variables"
        response <- request_api(server_url)
        variables <- response$variables
        return(variables)
}
