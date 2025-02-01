

test_that("Weighted variance", {
        expect_no_warning(wtd_var(as.matrix(micro_data),
                                  x = as.numeric(height),
                                  w = as.numeric(w)))
})

test_that("Weight must be numeric", {
        expect_error(wtd_var(as.matrix(micro_data),
                                  x = as.numeric(height),
                                  w = w))
})

test_that("Error for factors", {
        expect_error(wtd_var(micro_data, x = gender, w = w))
})

test_that("Length must be the same", {
        x <- rep(c(1, 2, 3), 16)
        w <- rep(c(0.5, NA, NA))
        expect_error(wwtd_var(x = x, w = w))
})

test_that("Weight must be positive", {
        x <- rep(c(1, 2, 3), 16)
        w <- rep(c(-2, 0.5, 1), 16)
        expect_error(wwtd_var(x = x, w = w))
})

test_that("Equal with stats", {
        x <- rep(c(1, 2, 3), 16)
        expect_equal(wtd_var(x = x), var(x, na.rm = TRUE))
})



