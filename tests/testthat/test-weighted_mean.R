

test_that("Equal with base if not weighted", {
        base_mean <- mean(micro_data$height)
        mdt_mean <- weighted_mean(micro_data$height)
        expect_equal(base_mean, mdt_mean)
})

test_that("x must be numeric", {
        expect_error(weighted_mean(micro_data$gender))
})

test_that("w must be numeric", {
        expect_error(weighted_mean(micro_data$height, micro_data$gender))
})

test_that("x and w must have the same length", {
        expect_error(weighted_mean(micro_data$height, iris$Sepal.Length,
                                   na.rm = FALSE))
})

test_that("w cannot contain negative values", {
        expect_error(weighted_mean(micro_data$height, micro_data$w - 10,
                                   na.rm = FALSE))
})

test_that("Correct specification", {
        expect_no_error(weighted_mean(x = as.numeric(height), w = as.numeric(w),
                                      data = as.matrix(micro_data)))
})

test_that("Correct specification", {
        expect_no_error(weighted_mean(x = height, w = w, data = micro_data))
})


