

test_that("The same as base if not weighted", {
        base_test <- chisq.test(micro_data$gender, micro_data$education)
        mdt_test <- chisq_test(gender, education, data = micro_data)
  expect_equal(base_test$statistic, mdt_test$statistic)
})


test_that("Different when weighted", {
        base_test <- chisq.test(micro_data$gender, micro_data$education)
        mdt_test <- chisq_test(gender, education, w = w, data = micro_data)
        expect_lt(base_test$statistic, mdt_test$statistic)
})

test_that("Can convert matrix too", {
  expect_no_error(chisq_test(gender, education, data = as.matrix(micro_data)))
})

test_that("X and Y must be provided", {
  expect_error(chisq_test(gender, data = as.matrix(micro_data)))
})


test_that("W must be numeric", {
  expect_error(chisq_test(gender, education, w = gender, data = micro_data))
})


test_that("W must be non-negative", {
  ws <- micro_data$w - 100
  expect_error(chisq_test(gender, education, w = ws, data = micro_data))
})

test_that("Correct specification", {
  expect_no_error(chisq_test(gender, education, w = w, data = micro_data))
})

test_that("Correct specification", {
  expect_no_error(chisq_test(micro_data$gender, micro_data$education,
                             w = micro_data$w))
})



