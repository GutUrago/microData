

test_that("Weighted variance", {
        expect_no_warning(wtd_var(as.matrix(micro_data),
                                  x = as.numeric(height),
                                  w = as.numeric(w)))
})

test_that("Error for factors", {
        expect_error(wtd_var(micro_data, x = gender, w = w))
})

