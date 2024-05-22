
test_that("Returns tag list", {
        expect_equal(class(mdt_abstract(6161, raw_html = TRUE)),
                     c("shiny.tag.list", "list"))
})



