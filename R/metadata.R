



#' Metadata of the datasets
#' @description
#' Extracts names of available datasets along with their description and dimensions
#'
#'
#' @param catalog An integer number located in the link after `catalog/` that
#' identifies the catalog
#' @param org Name of an organization. `default = 'wb'`, also supports 'fao', 'unchr' and 'ihsn'.
#'
#' @return A data table
#' @export
#'
#' @examples
#' metadata(1970)


metadata <- function(catalog,
                     org = "wb"){
        if(org == "wb") {
                link = paste0("https://microdata.worldbank.org/index.php/catalog/",
                              catalog, "/data-dictionary/")

        } else if(org == "fao"){
                link = paste0("https://microdata.fao.org/index.php/catalog/",
                              catalog, "/data-dictionary/")
        } else if(org == "unhcr"){
                link = paste0("https://microdata.unhcr.org/index.php/catalog/",
                              catalog, "/data-dictionary/")
        } else if(org == "ihsn"){
                link = paste0("https://datacatalog.ihsn.org/catalog/",
                              catalog, "/data-dictionary/")
        } else {stop("org argument takes only 'wb', 'fao', 'unhcr' or 'ihsn'")}
        tryCatch(
                {rvest::read_html(link)},
                 error = function(msg){
                         message(paste("Catalog number", catalog, "doesn't exist within", paste0(org, "."), "Did you forget to specify organization?"))
                         return(NA)
                 }, finally = url <- rvest::read_html(link)
                 )
        url <- rvest::html_elements(url, css = ".variable-metadata")
        url <- rvest::html_text2(url)
        url <- stringr::str_match(url, "(?s)Data Description\n\r\n(.*)")[, 2]
        url <- stringr::str_replace_all(string = url, pattern = "\r", replacement = "")
        url <- stringr::str_split(string = url, pattern = "  ")[[1]]
        url <- url[-c(1:3)]
        dt <- data.table::data.table(x = url,
                                     "i" = rep(1:3, times = length(url)/3))
        dt <- data.table::data.table(
                "Data file" = dt$x[dt$i == 1],
                "Description" = dt$x[dt$i == 2],
                "Dim" = dt$x[dt$i == 3])
        dt <- collapse::fmutate(
                .data = dt,
                'Cases' = stringr::str_extract(dt$Dim, "^\\d+"),
                'Variables' = stringr::str_remove(dt$Dim, "^\\d+\\s+"),
                .keep = "unused")
        dt <- collapse::fmutate(
                .data = dt,
                'Cases' = as.numeric(dt$Cases),
                'Variables' = as.numeric(dt$Variables))
        return(dt)
}

