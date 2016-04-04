library(testthat)
library(identifyr)
context("Match Output")

# test_check("identifyr")

test_that("string is padding correctly when X is present", {
  expect_output(clean_case("PB6789"), print("PB006789"))
  expect_output(clean_x("X"), print(NA))
  expect_output(clean_x("0"), print(NA))
  expect_output(clean_x("789"), print("X00000789"))
  expect_output(clean_x("NOT IN APS"), print(NA))
  expect_output(clean_x("NO X#"), print(NA))
  expect_output(clean_x("X 0123456"), print("X00123456"))
  expect_output(clean_x(" X01234"), print("X00001234"))
  expect_output(clean_x("X01234 "), print("X00001234"))
  expect_output(clean_x(" X 01234 "), print("X00001234"))
  expect_output(clean_x(" X 012 34"), print("X00001234"))
})

test_that("cross-reference works properly", {
  expect_output(clean_x("A000A20", using = "CII", value = "A07515123"), print("X00000020"))
})
