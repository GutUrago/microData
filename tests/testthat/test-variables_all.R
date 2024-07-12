test_that("A data containing all variables in the study", {
  expect_equal(nrow(variables_all(6211)), 58)
})
