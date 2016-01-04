
#' @title Clean Case Numbers
#' @description Useful for correcting manually entered case numbers that may be abbreviated or contain non-standard methods for handling null values such as "No #"
#' @param x is a character vector containing case numbers.
#' @return Character vector of standardized case numbers.
#' @seealso clean_x, clean_id
#' @examples
#' clean_case("PB123") # PB000123
#' clean_case("None") # NA
#' clean_case("5678") # PB005678

# Clean Case Numbers
# These should be 8 characters and usually contain PB or some other letter(s) as the first two characters
#' @export
clean_case <- function(x) {

  # Strip away all characters, even if it's something that indicates an empty value such as "No PB #"
  x <- stringr::str_replace_all(x, pattern = "[A-Za-z]", replacement = "")

  # Replace all whitespace
  x <- stringr::str_replace_all(x, pattern = " ", replacement = "")

  # Pad each element with zeros to become 6 digits long
  padded <- vapply(x, stringr::str_pad, FUN.VALUE = "character", width = 6, side = "left", pad = "0")

  # Add the PB prefix to all strings
  padded <- stringr::str_c("PB", padded)

  # Convert the ones that originally used text to indicate null values to NA
  padded[grep("PB000000", padded)] <- NA

  # Return the final string
  return(padded)
}
#' @importFrom magrittr "%>%"
