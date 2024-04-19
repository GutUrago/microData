


mdt_api <- function(server_url){
        server_req <- httr2::request(server_url)
        api_resp <- httr2::req_perform(server_req)
        api_char <- rawToChar(api_resp$body)
        response <- jsonlite::fromJSON(api_char, flatten = TRUE)
        return(response)
        }
