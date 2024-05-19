





# WB ----

test_that("It returns codes for morethan 200 countries", {
        expect_gt(nrow(country_codes(org = "wb")), 200)
})



# FAO ----

test_that("It returns codes for morethan 200 countries", {
        expect_gt(nrow(country_codes(org = "fao")), 200)
})

# UNHCR ----

test_that("It returns codes for morethan 200 countries", {
        expect_gt(nrow(country_codes(org = "unhcr")), 200)
})

# IHSN ----

test_that("It returns codes for morethan 200 countries", {
        expect_gt(nrow(country_codes(org = "ihsn")), 200)
})

# ILO ----

test_that("It returns codes for morethan 200 countries", {
        expect_gt(nrow(country_codes(org = "ilo")), 200)
})








