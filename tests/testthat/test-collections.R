# WB ----

test_that("It has more than 200 collections", {
        expect_gt(nrow(collections(org = "wb")), 20)
})



# FAO ----

test_that("It has 9 collections", {
        expect_lt(nrow(collections(org = "fao")), 10)
})

# UNHCR ----

test_that("It has 19 collections", {
        expect_lt(nrow(collections(org = "unhcr")), 20)
})

# IHSN ----

test_that("It has no any collections", {
        expect_error(collections(org = "ihsn"))
})

# ILO ----

test_that("It has 8 collections", {
        expect_gt(nrow(collections(org = "ilo")), 7)
})
