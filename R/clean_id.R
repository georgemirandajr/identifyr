
#' @title Clean ID
#' @description Provides a method for applying both cleaning functions (clean_x and clean_pb) to a dataframe by index.
#' @param data is a data.frame containing any number of columns.
#' @param cols is a list of integers indicating the column numbers that are to be cleaned up.
#' @param FUN is a list of functions to pass to the specified columns (must be in same order as the column index)
#' @details This function is meant to be used on multiple columns at once. It makes use of the magrittr pipe operator to provide neat code.
#' @return Returns a dataframe with replacements in the specified columns
#' @seealso clean_x, clean_pb
#' @examples
#' df <- data.frame(pbnum = c("PB123", "PB 0034", "  5678 ", "None"),
#' status = c("Active", "Closed", "Closed", "Active"),
#' xnum = c("X00123", "9512", "X789", "NOT IN APS"))
#'
#' #' df %>% clean_id(cols = c(1,3), FUN = c("clean_pb", "clean_x"))
#'
#' #' clean_id(data = df, cols = c(1,3), FUN = c("clean_pb", "clean_x"))

# Take a dataframe (df) and apply both cleaning functions and return the clean dataframe
#' @import magrittr
#' @export
clean_id <- function(data, cols = list(), FUN = list()) {

  if (length(cols) != length(FUN)) {
    warning("The number of columns specified must equal the number of functions supplied.")
  } else { # make sure the specified columns equals the number of functions to apply

  possible_functions <- FUN  # rename the list of functions

  separated <- lapply(data, `[`)  # separate the original dataframe into a list containing each column as an element
  separated <- separated[cols]  # select only the elements that relate to the columns being cleaned

  temp <- list()  # initialize temporary container

  for (i in 1:length(cols)) {
    temp[i] <- lapply(separated[i], FUN = possible_functions[i])  # apply the specified function to each element of the list
  }

  data[,cols] <- temp  # overwrite the original dataframe columns specified by the user with the cleaned version

  return(data)  # return the final dataframe

  }

}
