library(testthat)
library(identifyr)
context("Match Output")

# test_check("identifyr")

test_that("string is padding correctly when PB is present", {
  expect_output(clean_case("PB6789"), print("PB006789"))
  expect_output(clean_case("PB"), print(NA))
  expect_output(clean_case("0"), print(NA))
  expect_output(clean_case("789"), print("PB000789"))
  expect_output(clean_case("NOT IN APS"), print(NA))
  expect_output(clean_case("NO X#"), print(NA))
  expect_output(clean_case("PB 123456"), print("PB123456"))
  expect_output(clean_case(" PB01234"), print("PB001234"))
  expect_output(clean_case("PB01234 "), print("PB001234"))
  expect_output(clean_case(" PB 01234 "), print("PB001234"))
  expect_output(clean_case(" B 012 34"), print("PB001234"))
})
