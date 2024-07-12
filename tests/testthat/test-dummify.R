test_that("Create dummy variables", {

        df <- data.frame(age = rep(c(19, 27, 46), 1000),
                         sex = rep(c("m", "f", "f"), 1000),
                         race = rep(c("a", "b", "d"), 1000))


        dummy <- dummify(df, c("sex", "race"), c("s", "d"))

        males <- subset(dummy, sex == "m")
        expect_equal(sum(males$sex_m), nrow(males))
})
