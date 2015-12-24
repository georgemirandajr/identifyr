library(testthat)
library(identifyr)
context("Match Output")

# test_check("identifyr")

test_that("string is padding correctly when PB is present", {
  expect_output(clean_pb("PB6789"), "PB006789")
  expect_output(clean_pb("PB"), NA)
  expect_output(clean_pb("0"), NA)
  expect_output(clean_pb("789"), "PB000789")
  expect_output(clean_pb("NOT IN APS"), NA)
  expect_output(clean_pb("NO X#"), NA)
  expect_output(clean_pb("PB 123456"), "PB123456")
  expect_output(clean_pb(" PB01234"), "PB001234")
  expect_output(clean_pb("PB01234 "), "PB001234")
  expect_output(clean_pb(" PB 01234 "), "PB001234")
  expect_output(clean_pb(" B 012 34"), "PB001234")
})
