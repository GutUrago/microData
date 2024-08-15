test_that("Create dummy variables", {

        df <- data.frame(age = rep(c(19, 27, 46), 1000),
                         sex = rep(c("m", "f", "f"), 1000),
                         race = rep(c("a", "b", "d"), 1000))


        dummy <- dummify(df, vars = c(sex, race),
                         refs = c(sex = "s", race = "d"), keep = T)

        males <- subset(dummy, sex == "m")
        expect_equal(sum(males$sex_m), nrow(males))
})


test_that("Refuses when columns are unavailable", {

        df <- data.frame(age = rep(c(19, 27, 46), 1000),
                         sex = rep(c("m", "f", "f"), 1000),
                         race = rep(c("a", "b", "d"), 1000))

        expect_error(dummify(df, c("sex", "here"), c("s", "d")))
})


test_that("Warning for 0 levels", {

        df <- data.frame(age = rep(c(19, 27, 46), 1000),
                         sex = rep(c("m", "f", "f"), 1000),
                         race = rep(c("a", "b", "d"), 1000))

        expect_warning(dummify(df, sex, c("m", "f")))
})



test_that("If named vector, takes only first reference for each variable", {

        df <- data.frame(age = rep(c(19, 27, 46), 1000),
                         sex = rep(c("m", "f", "f"), 1000),
                         race = rep(c("a", "b", "d"), 1000))

        dummy_df <- dummify(df, sex, c(sex = "m", sex = "f"))

        expect_equal(ncol(dummy_df), 3)
})






