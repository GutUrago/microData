

test_that("Spreads Matrix too", {
        expect_equal(ncol(dummify(as.matrix(micro_data), gender, keep = TRUE)), 10)
})

test_that("Spreads and drops", {
        test_data <- micro_data
        test_data$gender <- as.character(test_data$gender)
        expect_equal(ncol(dummify(test_data, gender, keep = FALSE)), 9)
})
