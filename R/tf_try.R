#' Try multiple transformations
#' 
#' Attempt multiple transformations of a vector
#'   
#' @param x vector
#' @param fun function to try out on vector
#' @param ... additional arguments to pass to fun
#' 
#' @details 
#' 
#'   `tf_try` transforms the data but keep track of the original vector
#' allowing for multiple attempts at transforming the vectors 
#' 
#'      x %>% 
#'        tf_try( ... ) %>% 
#'        tf_try( .... ) %>% 
#'        tf_end()             # optional 
#' 
#' This is very handy for transforming data that allowed or didn't enforce a 
#' particular format such as a date.
#' 
#' @examples 
#'   
#'  # Contrived example sqrt(-x) 
#'   -2:2 %>%  
#'     tf_try( sqrt ) %>% 
#'     tf_try( . %>% abs %>% sqrt )
#'   
#'  # Shift x  
#'   -2:2 %>%  
#'     tf_try( sqrt ) %>% 
#'     tf_try( function(x) sqrt( x+ abs(min(x)) ) ) 
#'  
#'   c(-2,1,0,NA,1,2) %>% 
#'     tf_try( sqrt ) %>% 
#'     tf_try( function(x) sqrt( x+ abs(min(x)) ) ) 
#'      
#' @export 

tf_try <- function(x, fun, ...) { 

  if( is.tf_try(x) ) { 
    # Identify previous failures 
    orig <- attr(x, 'orig')
    wh <- is.na(x) & ! is.na(orig)   # i.e. Previous failures 
    
    x[ wh ] <- suppressWarnings( fun( orig[wh] ) )
    ret <- x 
    
  } else {
  
    ret <- suppressWarnings( 
             fun(x, ...) %>% 
               add_subclass('tf_try') %>%
               add_orig(x)
           )
  } 
  
  ret
}


# Track the origin value of an object
add_orig <- function(x,orig) 
  structure( x, orig=orig )


#' @rdname tf_try
#' @export 

is.tf_try <- function(x) is(x, "tf_try")


#' @rdname tf_try
#' @export 

print.tf_try <- function(x, ...) {
  x %>% 
    remove_class('tf_try') %>% 
    setattr( 'orig', NULL ) %>% 
    print()
}

#' @details 
#' 
#' `tf_end` stops the trying of values by stripping the `tf_try` class
#' and stops recording the original values.
#' 
#' @rdname tf_try
#' @export 

tf_end <- function(x) { 
   x %>% 
    remove_class('tf_try') %>% 
    setattr( 'orig', NULL )
}
