
# General tests ----

test_that("Throws an error when wrong organization is supplied",{
        expect_error(search_catalog(org = "repos"))
})

# WB ----


test_that("By default, it returns the first 15 studies", {
  expect_equal(nrow(search_catalog(org = "fao")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(search_catalog(keyword = "ethi", org = "fao"))
})

test_that("accepts full query",{
  response <- search_catalog(keyword = "Food security?", org = "wb",
                         from = 2000, to = 2023,
                         country = c("Ethiopia", "Nigeria"),
                         inc_iso = TRUE,
                         collection = "fao", ps = 30, info = F,
                         dtype = "open",
                         sort_by = "country", sort_order = "desc", page = 1)
  expect_lt(nrow(response), 31)
})

test_that("Can return in a list form",{
  response <- search_catalog(keyword = "Food security?", org = "wb",
                             from = 2000, to = 2023,
                             country = c("Ethiopia", "Nigeria"),
                             inc_iso = TRUE,
                             collection = "fao", ps = 30, info = T,
                             dtype = "open",
                             sort_by = "country", sort_order = "desc", page = 1)
  expect_equal(class(response), "list")
})



# FAO ----

test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(search_catalog(org = "fao")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(search_catalog(keyword = "ethi", org = "fao"))
})




# UNHCR ----

# test_that("By default, it returns the first 15 studies", {
#         expect_equal(nrow(search_catalog(org = "unhcr")), 15)
# })
#
#
# test_that("Throws an error when search is not found",{
#         expect_error(search_catalog(keyword = "ethi", org = "unhcr"))
# })


# IHSN ----


test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(search_catalog(org = "ihsn")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(search_catalog(keyword = "ethi", org = "ihsn"))
})


# ILO ----


test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(search_catalog(org = "ilo")), 15)
})

test_that("Throws an error when search is not found",{
        expect_error(search_catalog(keyword = "ethi", org = "ilo"))
})
















