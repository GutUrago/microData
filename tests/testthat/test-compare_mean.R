test_that("Uses star by default", {
        mean_df <- compare_mean(iris, c(Sepal.Length, Sepal.Width), by = Species)
  expect_equal(dim(mean_df), c(2, 5))
})


test_that("Calculates diffs for two groups", {

        mean_df <- compare_mean(iris[iris$Species != "setosa",],
                                vars = c(Sepal.Length, Sepal.Width),
                                by = Species, w = Petal.Width,
                                stars_on = "diffs")
        expect_equal(dim(mean_df), c(2, 4))
})

test_that("Converts character to factor internally", {

        iris_df <- iris[iris$Species != "setosa",]

        iris_df$Species <- as.character(iris_df$Species)

        mean_df <- compare_mean(iris_df,
                                vars = Sepal.Length,
                                by = Species, w = Petal.Width,
                                stars_on = "diffs")
        expect_equal(dim(mean_df), c(1, 4))
})




test_that("Throws warning and returns p stars", {

        expect_warning(compare_mean(iris,
                                  vars = c(Sepal.Length, Sepal.Width),
                                  by = Species, w = Petal.Width,
                                  stars_on = "diffs")
                     )
})






