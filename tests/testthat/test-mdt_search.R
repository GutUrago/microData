
# General tests ----

test_that("Throws an error when wrong organization is supplied",{
        expect_error(mdt_search(org = "repos"))
})

# WB ----


test_that("By default, it returns the first 15 studies", {
  expect_equal(nrow(mdt_search(org = "wb")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(mdt_search(keyword = "ethi", org = "wb"))
})



# FAO ----

test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(mdt_search(org = "fao")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(mdt_search(keyword = "ethi", org = "fao"))
})




# UNHCR ----

test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(mdt_search(org = "unhcr")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(mdt_search(keyword = "ethi", org = "unhcr"))
})


# IHSN ----


test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(mdt_search(org = "ihsn")), 15)
})


test_that("Throws an error when search is not found",{
        expect_error(mdt_search(keyword = "ethi", org = "ihsn"))
})


# ILO ----


test_that("By default, it returns the first 15 studies", {
        expect_equal(nrow(mdt_search(org = "ilo")), 15)
})

test_that("Throws an error when search is not found",{
        expect_error(mdt_search(keyword = "ethi", org = "ilo"))
})
















