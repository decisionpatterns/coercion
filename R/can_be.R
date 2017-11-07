#' can_be
#' 
#' Determine if the a vector can be coerced into the given class
#' 
#' @param object object; 
#' @param class character; name of class to check if it can be coerced
#' 
#' @details 
#' 
#' `can_be` determines if an object can reliably coerced to `class`, returning 
#' `TRUE` if **ALL** values can be coerced. 
#' 
#' It uses the results of`try(as(...))` under the hood.  See `try_as()` for 
#' details .
#' 
#' @return 
#' 
#' A logical scalar indicating whether `object` can be coerced to class `Class`
#' 
#' @seealso 
#'   
#'  - `try_as()` : 
#'  - `methods::as()`
#'  - `methods::canCoerce()`
#'  - `methods::setAs()``
#'   
#' @examples 
#' 
#'   nums <- seq(1.0,2.0,0.2)
#'   ints <- 1:5
#'   chrs <- letters[1:5]
#'   dts  <- seq( Sys.Date(), length.out=5, by="1 week") 
#'   posx <- as.POSIXct( dts )
#'  
#'   cls <- c('numeric','integer','character','Date','POSIXct')
#'   
#'   nums %>% can_be("numeric")
#'   nums %>% can_be("integer")
#'   nums %>% can_be("character")
#'   nums %>% can_be("Date")
#'   nums %>% can_be("POSIXct") 
#'     
#'   ints %>% can_be("numeric")
#'   ints %>% can_be("integer")
#'   ints %>% can_be("character")
#'   ints %>% can_be("Date")
#'   ints %>% can_be("POSIXct") 
#'
#'   chrs %>% can_be("numeric")
#'   chrs %>% can_be("integer")
#'   chrs %>% can_be("character")
#'   chrs %>% can_be("Date")
#'   chrs %>% can_be("POSIXct") 
#' 
#'   dts %>% can_be("numeric")
#'   dts %>% can_be("integer")
#'   dts %>% can_be("character")
#'   dts %>% can_be("Date")
#'   dts %>% can_be("POSIXct") 
#'  
#'   posx %>% can_be("numeric")
#'   posx %>% can_be("integer")
#'   posx %>% can_be("character")
#'   posx %>% can_be("Date")
#'   posx %>% can_be("POSIXct") 
#'   
#'
#' @md                     
#' @return logical 
#' @export

can_be <- function(object, class) {

  # ALL NA are always TRUE
  if( all( is.na(object) ) ) { 
    # what <- deparse(substitute(object))
    warning( 
      paste0( "Object is contains only NA values-- can be, ", class, " by definition") 
    ) 
    return(TRUE) 
 }
  
 try_can_be <-try_as( object, class )  
 is( try_can_be, class )
  
}


#' @rdname can_be
#' @export

can <- function(...) {
  warning( "Function 'can' is deprecated. Use 'can_be' instead.") 
  can_be(...)
}

