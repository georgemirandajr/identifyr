
#' @title Clean X Numbers
#' @description Useful for correcting manually entered X-numbers that may be abbreviated or contain non-standard methods for handling null values such as "No #"
#' @param x is a character vector containing X numbers
#' @return Character vector of standardized X numbers. NA values are introduced where there appears to be non-X characters present.
#' @seealso clean_pb, clean_id
#' @examples
#' clean_x("X6789") # X00006789
#' clean_x("No #") # NA
#' clean_x("1234") # X00001234

# X-Number Cleaning
#' @export
clean_x <- function(x) {

  # Replace any instances where there is a space anywhere in the X number, such as "X 0000789"
  x <- stringr::str_replace_all(x, pattern = " ", replacement = "")

  padded <- vapply(x, stringr::str_pad, FUN.VALUE = "character", width = 9, side = "left", pad = "X")  # Pad the character vector and assign to a temporary list

  # Replace X's with 0's when there's more than one X in an entry. Should only be X0, X00, X000, etc. Assign to new vector
  clean.x <- stringr::str_replace_all(padded,
                             pattern = c(
                               "XXXXXXXXX{1}" = "X00000000",
                               "XXXXXXXX{1}" = "X0000000",
                               "XXXXXXX{1}" = "X000000",
                               "XXXXXX{1}" = "X00000",
                               "XXXXX{1}" = "X0000",
                               "XXXX{1}" = "X000",
                               "XXX{1}" = "X00",
                               "^XX" = "X0")
  )

  # Find entries that have non-X numbers such as "NO X #", "Not in APS", etc. Replace these with NA values
  clean.x[grep("[A-Wa-w]\\D|[Y-Zy-z]\\D", clean.x)] <- NA

  # Return the cleaned up version of the character vector
  return(clean.x)
}

