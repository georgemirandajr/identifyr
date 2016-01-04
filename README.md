# Identifyr 0.1.2

# Purpose 
This package provides efficient tools for cleaning unique identifiers used by the Los Angeles County Probation Department. It contains functions that standardize identifiers in preparation for analysis. There is also a wrapper function that applies multiple identifyr functions at once (similar to `dplyr::mutate`, but does not require explicit column names). 
    
# How to Use It
Users can apply the individual functions to an identifier of interest, or use the wrapper `clean_id()` to indicate the column numbers or names and corresponding functions to apply. The user-supplied columns and the order of the functions must be in the same order.  The result of the wrapper function is a dataframe of the original length with replaced values in the indicated columns. Identifyr utilizes the magrittr pipe operator because it is designed to be used in conjunction with other data cleaning/wrangling packages such as `dplyr` and `tidyr`. 
  
### Cleaning Functions
You can apply one function at a time.
```{r}
clean_x(x)
clean_case(x) 
```
  
You can pass additional arguments to clean_x that verifies the identifier against a reference table.
```{r}
# Example (Do not run):
clean_x(x, using = "CASE", value = "PB000123")

```
  
### Obtain_id
You can obtain an identifier if you have another identifier that could be cross-referenced in the built-in table. Currently, you can obtain either X or CII numbers.
```{r}
obtain_id(obtain = "X", 
  using = "CASE", 
  value = "PB000123")
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
