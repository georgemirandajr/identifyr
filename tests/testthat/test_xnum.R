library(testthat)
library(identifyr)
context("Match Output")

# test_check("identifyr")

test_that("string is padding correctly when X is present", {
  expect_output(clean_x("X6789"), "X00006789")
  expect_output(clean_x("X"), "X00000000")
  expect_output(clean_x("0"), "X00000000")
  expect_output(clean_x("789"), "X00000789")
  expect_output(clean_x("NOT IN APS"), NA)
  expect_output(clean_x("NO X#"), NA)
  expect_output(clean_x("X 0123456"), "X00123456")
  expect_output(clean_x(" X01234"), "X00001234")
  expect_output(clean_x("X01234 "), "X00001234")
  expect_output(clean_x(" X 01234 "), "X00001234")
  expect_output(clean_x(" X 012 34"), "X00001234")
})
