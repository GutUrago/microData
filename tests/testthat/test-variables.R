test_that("All variables in a single file", {
        expect_equal(nrow(variables(6211, file_id = "cross_data")), 58)
})
