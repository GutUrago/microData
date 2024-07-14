test_that("Returns named vector", {



        Fstat <- extract_f(x = c("Sepal length" = "Sepal.Length"),
                           by = "Species", data = iris, .round = 3)

        expect_equal(Fstat, c("Sepal length" = "119.265***"))
})


test_that("Stars are based on p value", {

        my_data <- data.frame(
                x = c(1, 2, 1, 2),
                cat = c(1, 1, 2, 2)
        )

        Fstat <- extract_f(x = "x", by = "cat", data = my_data)

        expect_equal(Fstat, c("x" = "0"))
})

