# TODO 

 - p_excel_dt needs to cascade through options perhaps using *anytime* package.
 - can need to be refactor to think how it would work with  
   - recursive objects
   - objects with length
 - possible package name: anyany
 - coerce(x, ..., env)
   ... : list of functions or expressions to try in order element-wise; first 
         function that produces a non-NA value gets priority
   env : environment/data.frame to evaluate ... in
   cf. p_excel_dt
   
   x %>% coerce( mdy_hms, mdy_hm, mdy )
    
   x %>% ifelse(is.na(y),y,z)   
   
 - cast as an alias for coerce?

 - repalce `p_` -> `as_` prefixes.
   - This allows `as_logic` to become `as_logical`
   
 - What is the relationship to setAs? 
  
# Mixed formats

One difficulty is mixed format colums. Usually this occurs when people are 
gathering (or touching) data and validation is lacking. One approach is to 
try multiple coercisions and choosing the correct one. This is not trivial as 
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

