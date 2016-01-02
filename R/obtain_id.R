
#' @title Obtain ID Numbers
#' @description Obtains an unknown identifier given some known identifier.
#' @param obtain character. The desired identifier. Could be either "X" or "CII".
#' @param using character. Name of the known identifier. Could be "X", "CASE", or "CII".
#' @param value character vector. The actual value(s) of the known identifier.
#' @return List of length 1 containing the desired unique identifier
#' @seealso clean_pb, clean_x, clean_id
#' @examples
#' obtain_id(obtain = "X", using = "CASE", "PB021665")

# Obtain ID
#' @export
obtain_id <- function(obtain = list(), using = list(), value = "") {
  # Use the reference data in the global environment
  position <- match(value, ref[,using])  # find the row position of the value within the reference table
  data <- ref[position,obtain]  # subset the reference table by the row position and return the column indicated by obtain
  return(data)
}
