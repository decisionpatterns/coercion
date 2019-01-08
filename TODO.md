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


### Solution multiple transformations attempts.

Provide a more robust infra-structure for transformation of values esp
in a pipeline.

 - [x] Conditional Transformations
       tf_if : Only transform if there are no errors
   - [ ] Rename `tf_try()` to `tf_or()` ? 
   - [ ] Factor `tf_try()`/`tf_or()` to separate package

 - Allow tf_try to work on table in stead of vectors allowing for
   multiple parameters.
 
##  

 - A method to `fix` the files
 
 
## As.logic

Parse various values into a logical statement. 

 - as.logic() 
   - Add `na` parameter
   - support regex for `true`, `false`, `na` 
   - as_logic
   
 - Create other classes that mask logical with other vales Yes/No
   

## General parsers 

Parsers: `p_`

- [x] p_age : parses an age/duration suffixed with `[YyMmWwDd]` and express the age in years.

 - [ ] Consider factoring out p_ functions as part of a **mutators**, *transformers* or 
       *parsers* package.

 - [-] can_be_all -- see which_can_be

 - p_excel_dt needs to cascade through options perhaps using *anytime* package.
 - can need to be refactor to think how it would work with  
   - recursive objects
   - objects with length
 - possible package name: anyany`
 
 - [ ] logical variant of `which_can_be` and `which_cant_be`
 - [ ] strict argument of `which_can_be` and `which_cant_be`

 - coerce(x, ..., env)
   ... : list of functions or expressions to try in order element-wise; first 
         function that produces a non-NA value gets priority
   env : environment/data.frame to evaluate ... in
   cf. p_excel_dt
   
   x %>% coerce( mdy_hms, mdy_hm, mdy )
    
   x %>% ifelse(is.na(y),y,z)   
   
 - [-] cast as an alias for coerce? No. Why so complicated?

 - repalce `p_` -> `as_` prefixes.
   - This allows `as_logic` to become `as_logical`
   
 - What is the relationship to setAs? 
  

