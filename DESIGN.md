# TODO.md - coercion package TODO list 

## Mixed formats, Conditional Transformation

One often encountered problem in reading in data is handling data in which there was little or no validation of the input. This occurs often with webforms that allow free-text entry for a field that has a natural structure. A typical example is date form-field that does not specify a date format. The data entered may be entered in a number of formats: mm/dd/yyyy or yyyy-mm-dd. Some packages such as *lubridate* or *anytime* attempt to read these values, but envariable they often do not catch all of the values.  Some manual intervention is necessary. 

The manual approach is rather tedious. Here we provide the facilities for trying multiple conversions/transformations choosing the correct one. This is not trivial as 
the results:

 - may not be correct,
 - may not be non-NA values
 - may be ambigous (i.e. multiple coercisions producing valid values)

Coersion should handle this.

For example, `p_excel_dt.character` should first try `mdy_hms`, `mdy` and 
`p_excel_dt.numeric` in that order.


### A CASCADE PROCEDURE

This is like a similar to a vectorized na_replaces

Have a number of coercisions 

 - Initialize NA vector to length of input
 - Try the first using na_replace 
   replace na values with the 

