set.seed(1)
x <- rnorm(100)
w <- rep(c(1,2), 50)

test_that("Weighted variance", {
        expect_no_warning(wtd_var(x = x, w = w))
})



test_that("Weighted standard deviation", {
        expect_no_warning(wtd_sd(x = x, w = w))
})
