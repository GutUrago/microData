



#' Metadata of the datasets
#' @description
#' Extracts names of available data files along with their description and dimensions
#'
#'
#' @param catalog An integer number located in the link after `catalog/` that
#' identifies the catalog. You can also get it using `surveys()`.
#' @param org Name of an organization. `default = 'wb'`, also supports 'fao', 'unchr' and 'ihsn'.
#'
#' @return A data table
#' @export
#' @author Gutama Girja Urago
#' @examples
#' metadata(1970)


metadata <- function(catalog,
                     org = "wb"){
        if(org == "wb") {
                link = paste0("https://microdata.worldbank.org/index.php/catalog/",
                              catalog, "/data-dictionary/")
                elink = paste0("https://microdata.worldbank.org/index.php/catalog/",
                               catalog, "/get-microdata")

        } else if(org == "fao"){
                link = paste0("https://microdata.fao.org/index.php/catalog/",
                              catalog, "/data-dictionary/")
                elink = paste0("https://microdata.fao.org/index.php/catalog/",
                              catalog, "/get-microdata")
        } else if(org == "unhcr"){
                link = paste0("https://microdata.unhcr.org/index.php/catalog/",
                              catalog, "/data-dictionary/")
                elink = paste0("https://microdata.unhcr.org/index.php/catalog/",
                              catalog, "/get-microdata")
        } else if(org == "ihsn"){
                link = paste0("https://datacatalog.ihsn.org/catalog/",
                              catalog, "/data-dictionary/")
                elink = paste0("https://datacatalog.ihsn.org/catalog/",
                              catalog, "/get-microdata")
        } else {stop("org argument takes only 'wb', 'fao', 'unhcr' or 'ihsn'")}
        tryCatch({base_url <- rvest::read_html(link)},
                 error = function(e){
                         stop(paste0("Catalog number ", catalog,
                                     " doesn't exist within ", org,
                                     " organization or no metadata is provided. Check if the data is from external organization using: ",
                                     elink))
                 })
        url <- rvest::html_elements(base_url, css = ".variable-metadata")
        url <- rvest::html_text2(url)
        url <- stringr::str_extract(url, "(Data file[\\s\\S]*$)")
        #url <- stringr::str_match(url, "(?s)Data Description\n\r\n(.*)")[, 2]
        url <- stringr::str_replace_all(string = url, pattern = "\r", replacement = "")
        url <- stringr::str_split(string = url, pattern = "  ")[[1]]
        url <- url[-c(1:3)]
        dt <- data.table::data.table(x = url,
                                     "i" = rep(1:3, times = length(url)/3))
        dt <- data.table::data.table(
                "Data file" = dt$x[dt$i == 1],
                "Description" = dt$x[dt$i == 2],
                "Dim" = dt$x[dt$i == 3])
        files <- rvest::html_nodes(base_url, ".data-file-row")
        files <- rvest::html_element(files, "a")
        files <- rvest::html_attrs(files)
        files <- as.character(files)
        files <- stringr::str_extract(files, "(?<=data-dictionary/).*?(?=\\?file_name)")
        dt <- collapse::fmutate(
                .data = dt,
                'File name' = files,
                'Cases' = stringr::str_extract(dt$Dim, "^\\d+"),
                'Variables' = stringr::str_remove(dt$Dim, "^\\d+\\s+"),
                .keep = "unused")
        dt <- collapse::fmutate(
                .data = dt,
                'Cases' = as.integer(dt$Cases),
                'Variables' = as.integer(dt$Variables))
        return(dt)
}

# metadata(1000, "unhcr")
# metadata(1000)

