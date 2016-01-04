library(testthat)
library(identifyr)
context("Match Output")

# test_check("identifyr")

test_that("string is padding correctly when PB is present", {
  expect_output(clean_case("PB6789"), "PB006789")
  expect_output(clean_case("PB"), NA)
  expect_output(clean_case("0"), NA)
  expect_output(clean_case("789"), "PB000789")
  expect_output(clean_case("NOT IN APS"), NA)
  expect_output(clean_case("NO X#"), NA)
  expect_output(clean_case("PB 123456"), "PB123456")
  expect_output(clean_case(" PB01234"), "PB001234")
  expect_output(clean_case("PB01234 "), "PB001234")
  expect_output(clean_case(" PB 01234 "), "PB001234")
  expect_output(clean_case(" B 012 34"), "PB001234")
})
