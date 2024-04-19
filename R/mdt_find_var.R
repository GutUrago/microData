



# base_url <- "https://microdata.worldbank.org/index.php/api/catalog/{IDNo}/variables/{varId}"

# sample <- mdt_vars()


mdt_find_var <- function(detailed = FALSE){
        server_url <- "https://microdata.worldbank.org/index.php/api/catalog/TUR_2023_WBCS_v01_M/variables/v26"
        response <- request_api(server_url)
        if(detailed){
                result <- response$variable
                return(result)
        } else {
                result <- response$variable
                cat(paste(paste0("VID: ", result$vid),
                          paste0("Name: ", result$name),
                          paste0("File Name: ", result$fid),
                          paste0("Type: ", result$metadata$var_format$type),
                          paste0("Label: ", result$labl),
                          paste0("Question: ", result$qstn),
                          sep = "\n"))
        }
}




