


test_that("Returns tag list", {
  expect_equal(class(mdt_collection("fao", raw_html = TRUE)),
               c("shiny.tag.list", "list"))
})
