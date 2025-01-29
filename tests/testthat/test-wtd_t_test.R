library(datasets)

test_that("One sample t-test", {
        p1 <- wtd_t_test(mtcars, disp, mu = 200)[["p.value"]]
        p2 <- t.test(mtcars$disp, mu = 200)[["p.value"]]
        expect_equal(p1, p2)
})


test_that("Weighted one sample t-test", {
        p1 <- wtd_t_test(mtcars, disp, w = rep(c(1, 2), 16), mu = 200)[["p.value"]]
        p2 <- t.test(mtcars$disp, mu = 200)[["p.value"]]
        expect_gt(p1, p2)
})

test_that("Paired t-test", {
        p1 <- wtd_t_test(mtcars, gear, carb, paired = TRUE)[["p.value"]]
        p2 <- t.test(mtcars$gear, mtcars$carb, paired = TRUE)[["p.value"]]
        expect_equal(p1, p2)
})


test_that("Paired Paired doesn't accept factor", {
        expect_error(wtd_t_test(mtcars, gear, factor(rep(c(1,2), 16)), paired = TRUE))
})

test_that("Two sample t-test", {
        p1 <- wtd_t_test(mtcars, drat, wt, var.equal = FALSE)[["p.value"]]
        p2 <- t.test(mtcars$drat, mtcars$wt, var.equal = FALSE)[["p.value"]]
        expect_equal(p1, p2)
})

test_that("Two sample t-test", {
        p1 <- wtd_t_test(mtcars, drat, as.factor(vs), var.equal = FALSE)[["p.value"]]
        p2 <- t.test(mtcars$drat ~ as.factor(mtcars$vs), var.equal = FALSE)[["p.value"]]
        expect_equal(p1, p2)
})

test_that("Two sample t-test", {
        p1 <- wtd_t_test(mtcars, drat, as.factor(vs), w = qsec, var.equal = FALSE)[["p.value"]]
        p2 <- t.test(mtcars$drat ~ as.factor(mtcars$vs), var.equal = FALSE)[["p.value"]]
        expect_lt(p1, p2)
})

