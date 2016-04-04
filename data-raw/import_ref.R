# Import and Prepare Reference Data
# Data is taken from Daily APS list.
# Save the S7366 APS list as a new file in the R folder within identifyr folder
# Use the function use_data(ref, internal = T, overwrite = T) to resave this data as sysdata.rda
# Make sure the columns are in the same order as below

ref <- read.csv("./R/ids.csv")  # import csv file containing the identifiers only

colnames(ref) <- c("X", "CII", "CASE")  # rename the columns

# Convert the data from factor to character
ref$X <- as.character(ref$X)
ref$CASE <- as.character(ref$CASE)
ref$CII <- as.character(ref$CII)
