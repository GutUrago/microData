

test_that("Supports only two levels", {
        expect_error(test_mean(iris,
                  vars = "Sepal.Length",
                  by = "Species"))
})


test_that("Drops unused leves", {
        expect_no_error(
                test_mean(subset(iris, Species != "virginica"),
                  vars = c(Weighted_test = "Sepal.Length"),
                  by = "Species")
        )
})


test_that("Supports weighted test", {
        expect_no_error(
                test_mean(subset(iris, Species != "virginica"),
                          vars = "Sepal.Length",
                          by = "Species",
                          w = "Petal.Width")
        )
})




