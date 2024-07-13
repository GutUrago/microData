test_that("Returns named vector", {

        Fstat <- extract_f(models = list(
                "Sepal length" = lm(Sepal.Length ~ Species, data = iris)))

        expect_equal(Fstat, c("Sepal length" = "119.26***"))
})


test_that("Stars are based on p value", {

        my_data <- data.frame(
                x = c(1, 2, 1, 2),
                cat = c(1, 1, 2, 2)
        )

        Fstat <- extract_f(models = list(
                "x" = lm(x ~ cat, data = my_data)))

        expect_equal(Fstat, c("x" = "0"))
})

