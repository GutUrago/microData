test_that("Returns named vector", {



        Fstat <- test_anova(data = iris,
                            vars = c("Sepal length" = "Sepal.Length"),
                            by = "Species",
                           .round = 3)

        expect_equal(Fstat, c("Sepal length" = "119.265***"))
})


test_that("Stars are based on p value", {

        my_data <- data.frame(
                x = c(1, 2, 1, 2),
                cat = c(1, 1, 2, 2)
        )

        Fstat <- test_anova(data = my_data,
                            vars = "x",
                            by = "cat")

        expect_equal(Fstat, c("x" = "0"))
})

