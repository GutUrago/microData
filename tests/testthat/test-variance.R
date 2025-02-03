

test_that("Equal with base when not weighted", {
        base_var <- var(micro_data$height)
        mdt_var <- variance(micro_data$height)
        expect_equal(base_var, mdt_var)
})


test_that("Can use matrix too, but with as.numeric", {
        expect_no_error(variance(as.numeric(height), data = as.matrix(micro_data)))
})

test_that("Can use matrix too, but with as.numeric", {
        expect_error(variance(height, data = as.matrix(micro_data)))
})


test_that("W must be numeric", {
        expect_error(variance(height, w = gender, data = micro_data))
})

test_that("x and w must have the same length", {
        expect_error(variance(height, w = iris$Sepal.Length,
                              data = micro_data, na.rm = FALSE))
})


test_that("w cannot contain negative values", {
        expect_error(variance(micro_data$height, w = micro_data$w - 10, na.rm = FALSE))
})

test_that("Correct specification", {
        expect_no_error(variance(height, w = w, data = micro_data))
})




