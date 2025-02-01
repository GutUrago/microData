

test_that("The same as base if not weighted", {
        base_test <- chisq.test(micro_data$gender, micro_data$education)
        mdt_test <- wtd_chisq_test(micro_data, gender, education)
  expect_equal(unname(base_test$statistic), mdt_test$statistic)
})


test_that("Different when weighted", {
        base_test <- chisq.test(micro_data$gender, micro_data$education)
        mdt_test <- wtd_chisq_test(micro_data, gender, education, w = w)
        expect_lt(unname(base_test$statistic), mdt_test$statistic)
})
