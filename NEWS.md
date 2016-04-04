# Identifyr 0.1.3

## Release 0.1.3 contains a new function, `obtain_id`, to obtain identifiers when a user supplies one known identifier. An enhancement was made to `clean_x` that allows user to specify whether or not the X number should be cross-referenced with a built-in table (via obtain_id). The built-in reference table only contains X-Numbers, Case Numbers (PB) and CII numbers at the time of this release. It does not include any other personal identifiers such as name or date of birth. 

## This latest release resolves an issue with the new function `obtain_id`, as well as the `clean_x` function, which are dependent upon the built-in dataset. The built-in dataset is now working properly.

## Also, this latest release renames the function `clean_pb` to `clean_case`. The functionality is exactly the same, but future versions will generalize this function to work with all Probation case numbers, including those that do not have the prefix of "pb".
