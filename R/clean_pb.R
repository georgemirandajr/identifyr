
#' @title Clean PB Numbers
#' @description Useful for correcting manually entered PB numbers that may be abbreviated or contain non-standard methods for handling null values such as "No #"
#' @param x is a character vector containing PB numbers
#' @return Character vector of standardized PB numbers. NA values are introduced where there appears to be non-X characters present.
#' @seealso clean_x, clean_id
#' @examples
#' clean_pb("PB123") # PB000123
#' clean_x("None") # NA
#' clean_x("5678") # PB005678

# Clean PB Numbers
# These should be 8 characters and contain PB as the first two characters
#' @export
clean_pb <- function(x) {

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
