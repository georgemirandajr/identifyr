# Identifyr 0.1.3

# Purpose 
This package provides efficient tools for cleaning unique identifiers used by the Los Angeles County Probation Department. It contains functions that standardize identifiers in preparation for analysis by removing extraneous characters and padding where necessary. Users also have an option to utilize an internal dataset to validate or obtain identifiers based on another identifier. A wrapper function that applies multiple identifyr functions at once is also included (similar to `dplyr::mutate`, but is maybe more user friendly for this purpose). 
    
# How to Use It
Users can apply the individual functions to an identifier of interest, or use the wrapper `clean_id()` to indicate the column numbers or names and corresponding functions to apply. The user-supplied columns and the functions to apply must be in the same order (otherwise you can apply a function to the wrong column and get an error!). The result of the wrapper function is a dataframe of the original length with replaced values in the indicated columns. Identifyr utilizes the magrittr pipe operator because it is designed to be used in conjunction with other data cleaning packages that use this operator such as `dplyr` and `tidyr`. 
  
### Cleaning Functions
You can apply one function at a time.
```{r}
clean_x("X6789")
clean_case("PB123") 
```
  
You can pass additional arguments to clean_x that verifies the identifier against a reference table.
```{r}
# If the case number is known, you can use this to obtain/verify the X-Number. 
# The 'using' argument is how you would like to verify the ID and 'value' is the actual known ID.
clean_x("X00020", using = "CASE", value = "PB021665")
```
  
### Obtain_id
You can obtain an identifier if you have another identifier that could be cross-referenced in the built-in table. Currently, you can obtain either X or CII numbers.
```{r}
obtain_id(obtain = "X",  # what you want to obtain
  using = "CASE",        # the type of ID that you already know
  value = "PB021665")    # the actual ID that you know
```
  
### Clean_id 
Apply the cleaning functions at once (similar to `dplyr::mutate`)
```{r}
df %>%
  clean_id(
    cols = c(1, 3),  # reference the desired column index or name to manipulate
    FUN = c("clean_x", "clean_case")  # apply these functions in this order
  )

```  
  
# Where to Find It
The latest version of `identifyr` is available for download from github if you have the devtools package for R. The initial release is available on the Comprehensive R Archive Network (CRAN) and all future major releases will be available on CRAN.
  
### From Github
```{r}
install.packages("devtools")

devtools::install_github("georgemirandajr/identifyr")

```
### From Comprehensive R Archive Network (CRAN)
```{r}
install.packages("identifyr")
```
