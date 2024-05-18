
# v Writing 'codecov.yml'
# v Adding '^codecov\\.yml$' to '.Rbuildignore'
# v Adding Codecov test coverage badge to 'README.Rmd'
# * Re-knit 'README.Rmd' with `devtools::build_readme()`
# * Call `use_github_action("test-coverage")` to continuously monitor test coverage.


test_that("By default, it returns the first 15 studies", {
  expect_equal(nrow(mdt_search()), 15)
})


test_that("Test for results argument", {
        expect_equal(nrow(mdt_search(results = 25)), 25)
})

