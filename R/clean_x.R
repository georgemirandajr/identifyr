
#' @title Clean X Numbers
#' @description Useful for correcting manually entered or missing X-numbers that may be abbreviated or contain non-standard methods for handling null values such as "No #"
#' @param x character vector containing X numbers
#' @param using string indicating the name of a reference identifier to compare with. May be one of the following options: "CASE" or "CII".
#' @param value list or character vector that contains the actual values of the known identifier.
#' @details By default, clean_x() simply pads the string containing X numbers and ensures it meets the standard format. This is useful when correcting a small amount of X numbers, or when there is an untrustworthy reference identifier. If a clean case or CII number is available, the X numbers can be cross-referenced to a built-in table using the reference identifier. Only one reference identifier is allowed at the time of the current release.
#' @return Character vector of standardized X numbers. By default, NA values are introduced where there appears to be non-X characters present, unless a match was found in the reference table.
#' @seealso clean_pb, clean_id, obtain_id
#' @examples
#' clean_x("X6789") # X00006789
#' clean_x("No #") # NA
#' clean_x("1234") # X00001234
#' clean_x("X00020", using = "CASE", value = "PB021665")
#' clean_x("X00020", using = "CII", value = "A07515123")

# X-Number Cleaning
#' @export
clean_x <- function(x, using = NULL, value = "") {

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

  ## If verify is TRUE, use the reference table to verify the X numbers.
  if (is.null(using)) {
    # Return the cleaned up version of the character vector
    return(clean.x)

  } else {
    verified <- obtain_id(obtain = "X", using = using, value = value)
    return(verified)
  }
}

