
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


test_that("Throws an error when search is not found",{
        expect_error(search_catalog(keyword = "ethi", org = "unhcr"))
})


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
















