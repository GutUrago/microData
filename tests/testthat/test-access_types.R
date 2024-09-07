



# WB ----

test_that("Returns data frame", {
  expect_true(is.data.frame(access_types(org = "wb")))
})


# FAO ----

test_that("It returns a dataframe containing access types", {
        expect_true(is.data.frame(access_types(org = "fao")))
})

# UNHCR ----

# test_that("It returns a dataframe containing access types", {
#         expect_true(is.data.frame(access_types(org = "unhcr")))
# })

# IHSN ----

test_that("It returns a dataframe containing access types", {
        expect_true(is.data.frame(access_types(org = "ihsn")))
})

# ILO ----

test_that("It returns a dataframe containing access types", {
        expect_true(is.data.frame(access_types(org = "ilo")))
})



