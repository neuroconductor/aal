testthat::context("Does data install")

testthat::test_that("Checking all versions work for fname", {

  testthat::expect_silent(aal_fname(version = 4))
  testthat::expect_silent(aal_fname(version = 5))
  testthat::expect_silent(aal_fname(version = "4"))
  testthat::expect_silent(aal_fname(version = "5"))

  testthat::expect_silent({
    v4 = aal_image(version = 4)
    })
  testthat::expect_silent({
    v5 = aal_image()
    })
  testthat::expect_is(v4, "nifti")
  testthat::expect_is(v5, "nifti")

})

