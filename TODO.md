# TODO.md - coercion package TODO list 

## Multiple transformations attempts.

Provide a more robust infra-structure for transformation of values esp
in a pipeline.

 - We need to establish the difference *if any* between: 
    - transformation, 
    - map
    - lookup
    - mutate 
    - coercion, etc.  
   Reorganize/rename accordingly.

 - [ ] as_fct(), as_num(), as_int(), as_dt(), as_date(), as_time(), ...
   - Maybe clear up type(of), mode, class
 
 - [x] dry_run()
   - [ ] Add unique= argument
 
 - [x] Conditional Transformations
       tf_if : Only transform if there are no errors
   - [ ] Rename `tf_try()` to `tf_or()` ? 
   - [ ] Factor `tf_try()`/`tf_or()` to separate package

 - [ ] Allow tf_try to work on table in stead of vectors allowing for
   multiple parameters cf. `dplyr::mutate_if()`
 
 - [ ] Support `data.table`
 
 - [ ] `tf_end` should optionally produce a message about which values 
       could not be transformed.
    
 - [x] Add `dry_run()` that does nothing but report the changes.
       that 
       dt[ , var := var %>% dry_run( ) ]
       
 - [ ] Variant of `dry_run` that works like  
       [ iris, Species :=  Species %>% dry_run() %>%  .... ] or 
       [ iris, Species :=  dry_run(.) %>% Species %>% %>%  .... ] 
 
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
  

