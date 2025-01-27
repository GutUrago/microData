test_that("Spreads", {
        expect_gt(ncol(dummify(data = iris, Species)), 7)
})

