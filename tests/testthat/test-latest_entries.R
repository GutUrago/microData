# WB ----

test_that("Returns 15 results by default", {
        expect_equal(nrow(latest_entries(org = "wb")), 15)
})



# FAO ----

test_that("Limit works on the number of latest entries to be returned", {
        expect_equal(nrow(latest_entries(org = "fao", limit = 25)), 25)
})

# UNHCR ----

# test_that("Returns 15 results by default", {
#         expect_equal(nrow(latest_entries(org = "unhcr")), 15)
# })

# IHSN ----

test_that("Returns 15 results by default", {
        expect_equal(nrow(latest_entries(org = "ihsn")), 15)
})

# ILO ----

test_that("Returns 15 results by default", {
        expect_equal(nrow(latest_entries(org = "ilo")), 15)
})
