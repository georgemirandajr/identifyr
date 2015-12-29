# Import and Prepare Reference Data

ref <- read.csv("./R/ids.csv")  # import csv file containing the identifiers only

colnames(ref) <- c("X", "CASE", "CII")  # rename the columns

# Convert the data from factor to character
ref$X <- as.character(ref$X)
ref$CASE <- as.character(ref$CASE)
ref$CII <- as.character(ref$CII)
