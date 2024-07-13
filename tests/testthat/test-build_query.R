test_that("Returns the intended url", {

        my_query <- build_query(req = create_request("wb"),
                    keyword = "keyword",
                    from = 2000,
                    to = 2024,
                    country = "ETH",
                    inc_iso = TRUE,
                    collection = "fao",
                    created = "2015/04/01-2024/04/20",
                    dtype = "open",
                    sort_by = "year",
                    sort_order = "asc",
                    results = 4,
                    page = 2)


        ret_url <- my_query$url

        ret_url <- "https://microdata.worldbank.org/index.php/api/catalog?sk=keyword&from=2000&to=2024&country=ETH&inc_iso=TRUE&collection=fao&dtype=open&sort_by=year&sort_order=asc&ps=4&page=2&format=json"

        expect_equal(ret_url, ret_url)

})






test_that("Ignores page number if all results have to be returned", {

        my_query <- build_query(req = create_request("wb"),
                                keyword = "keyword",
                                from = 2000,
                                to = 2024,
                                country = "ETH",
                                inc_iso = TRUE,
                                collection = "fao",
                                created = "2015/04/01-2024/04/20",
                                dtype = "open",
                                sort_by = "year",
                                sort_order = "asc",
                                results = "all",
                                page = 2)


        ret_url <- my_query$url

        ret_url <- "https://microdata.worldbank.org/index.php/api/catalog?sk=keyword&from=2000&to=2024&country=ETH&inc_iso=TRUE&collection=fao&dtype=open&sort_by=year&sort_order=asc&ps=0&format=json"

        expect_equal(ret_url, ret_url)

})








test_that("Ignores page number if all results have to be returned", {

        my_query <- build_query(req = create_request("wb"),
                                keyword = "keyword",
                                from = 2000,
                                to = 2024,
                                country = "ETH",
                                inc_iso = TRUE,
                                collection = "fao",
                                created = "2015/04/01-2024/04/20",
                                dtype = "open",
                                sort_by = "year",
                                sort_order = "asc",
                                results = 20,
                                page = NULL)


        ret_url <- my_query$url

        ret_url <- "https://microdata.worldbank.org/index.php/api/catalog?sk=keyword&from=2000&to=2024&country=ETH&inc_iso=TRUE&collection=fao&dtype=open&sort_by=year&sort_order=asc&ps=20&format=json"

        expect_equal(ret_url, ret_url)

})





test_that("It tries to convert character number if its valid", {

        my_query <- build_query(req = create_request("wb"),
                                keyword = "keyword",
                                from = 2000,
                                to = 2024,
                                country = "ETH",
                                inc_iso = TRUE,
                                collection = "fao",
                                created = "2015/04/01-2024/04/20",
                                dtype = "open",
                                sort_by = "year",
                                sort_order = "asc",
                                results = "5",
                                page = 2)


        ret_url <- tolower(my_query$url)

        ret_url <- "https://microdata.worldbank.org/index.php/api/catalog?sk=keyword&from=2000&to=2024&country=eth&inc_iso=true&collection=fao&dtype=open&sort_by=year&sort_order=asc&page=2&format=json"

        expect_equal(ret_url, ret_url)

})



test_that("Except `all` results doesn't accept non-number characters", {

        expect_error(build_query(req = create_request("wb"),
                                keyword = "keyword",
                                from = 2000,
                                to = 2024,
                                country = "ETH",
                                inc_iso = TRUE,
                                collection = "fao",
                                created = "2015/04/01-2024/04/20",
                                dtype = "open",
                                sort_by = "year",
                                sort_order = "asc",
                                results = "five",
                                page = 2)
                     )

})





test_that("When results is NULL server assigns it by default", {

        my_query <- build_query(req = create_request("wb"),
                                keyword = "keyword",
                                from = 2000,
                                to = 2024,
                                country = "ETH",
                                inc_iso = TRUE,
                                collection = "fao",
                                created = "2015/04/01-2024/04/20",
                                dtype = "open",
                                sort_by = "year",
                                sort_order = "asc",
                                results = NULL,
                                page = 2)


        ret_url <- my_query$url

        ret_url <- "https://microdata.worldbank.org/index.php/api/catalog?sk=keyword&from=2000&to=2024&country=ETH&inc_iso=TRUE&collection=fao&dtype=open&sort_by=year&sort_order=asc&page=2&format=json"

        expect_equal(ret_url, ret_url)

})


















