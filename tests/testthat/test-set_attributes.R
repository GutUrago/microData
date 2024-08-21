


test_that("Cleans data name and labels", {


  mdt <- data.frame(v1 = c(18:25),
                    v2 = rep(c("m", "f"), 4),
                    v3 = rep(c("BE", "DE"), 4))

  metadata <- data.frame(vars = c("v1", "v2", "v3"),
                         name = c("age", "gender", "country"),
                         labs = c("Age", "Gender", "Country"))

  cleaned <- set_attributes(mdt, metadata,
                       old_name = "vars",
                       new_name = "name",
                       label = "labs")

  expect_equal(attr(cleaned$gender, "label"), "Gender")



})




test_that("Drops NA automatically", {


        mdt <- data.frame(v1 = c(18:25),
                          v2 = rep(c("m", "f"), 4),
                          v3 = rep(c("BE", "DE"), 4))

        metadata <- data.frame(vars = c("v1", "v2", "v3"),
                               name = c(NA, "gender", "country"),
                               labs = c("Age", "Gender", "Country"))

        cleaned <- set_attributes(mdt, metadata,
                             old_name = "vars",
                             new_name = "name",
                             label = "labs")

        expect_equal(ncol(cleaned), 2)



})





test_that("NA can also be skipped", {


        mdt <- data.frame(v1 = c(18:25),
                          v2 = rep(c("m", "f"), 4),
                          v3 = rep(c("BE", "DE"), 4))

        metadata <- data.frame(vars = c("v1", "v2", "v3"),
                               name = c(NA, "gender", "country"),
                               labs = c("Age", NA, "Country"))

        cleaned <- set_attributes(mdt, metadata,
                             old_name = vars,
                             new_name = name,
                             label = labs,
                             slt_cols = FALSE)

        expect_equal(names(cleaned)[[1]], "v1")



})





