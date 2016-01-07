
#' @title Clean X Numbers
#' @description Useful for correcting manually entered or missing X-numbers that may be abbreviated or contain non-standard methods for handling null values such as "No #"
#' @param x character vector containing X numbers
#' @param using string indicating the name of a reference identifier to compare with. May be one of the following options: "CASE" or "CII".
#' @param value list or character vector that contains the actual values of the known identifier.
#' @details By default, clean_x() simply pads the string containing X numbers and ensures it meets the standard format. This is useful when correcting a small amount of X numbers, or when there is an untrustworthy reference identifier. If a clean case or CII number is available, the X numbers can be cross-referenced to a built-in table using the reference identifier. Only one reference identifier is allowed at the time of the current release.
#' @return Character vector of standardized X numbers. By default, NA values are introduced where there appears to be non-X characters present, unless a match was found in the reference table.
#' @seealso clean_case, clean_id, obtain_id
#' @examples
#' clean_x("X6789") # X00006789
#' clean_x("No #") # NA
#' clean_x("1234") # X00001234
#' clean_x("X00020", using = "CASE", value = "PB021665")
#' clean_x("X00020", using = "CII", value = "A07515123")

# X-Number Cleaning
#' @export
clean_x <- function(x, using = NULL, value = NULL) {

  # Strip away all characters, even if it's something that indicates an empty value such as "No PB #"
  x <- stringr::str_replace_all(x, pattern = "[A-Za-z]", replacement = "")

  # Replace all whitespace
  x <- stringr::str_replace_all(x, pattern = " ", replacement = "")

  # Pad each element with zeros to become 6 digits long
  padded <- vapply(x, stringr::str_pad, FUN.VALUE = "character", width = 8, side = "left", pad = "0")

  # Add the PB prefix to all strings
  padded <- stringr::str_c("X", padded)

  # Convert the ones that originally used text to indicate null values to NA
  padded[grep("X0000000", padded)] <- NA

  ## If the using argument is not null, use the reference table to verify the X numbers.
  if (is.null(using)) {
    # Return the cleaned up version of the character vector
    return(padded)

  } else if (!is.null(using) & is.null(value)) {

    stop("The 'value' argument is null when 'using' argument is not null")

  } else {

    verified <- obtain_id(obtain = "X", using = using, value = value)

    return(verified)
  }

}

