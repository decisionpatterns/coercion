#' @details 
#' 
#' `which_can_be` provides indices of `object`` that **can** be coerced to the given 
#' `class`.  `NA` can always be coerced. 
#' 
#' `which_cant_be` provides indices of `object` that **can't** be coerced to the 
#' given `class`. `NA` can always be coerced.
#' 
#' @return 
#' `which_can_be` returns a integer vector of the indices of values that can be
#' successfully coerced to  the new class.
#' 
#' @seealso 
#'  - `can_be()`
#'  - `base::which()`
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
#'   nums %>% which_can_be("numeric")
#'   nums %>% which_can_be("integer")
#'   nums %>% which_can_be("character")
#'   nums %>% which_can_be("Date")
#'   nums %>% which_can_be("POSIXct") 
#'     
#'   ints %>% which_can_be("numeric")
#'   ints %>% which_can_be("integer")
#'   ints %>% which_can_be("character")
#'   ints %>% which_can_be("Date")
#'   ints %>% which_can_be("POSIXct") 
#'
#'   chrs %>% which_can_be("numeric")
#'   chrs %>% which_can_be("integer")
#'   chrs %>% which_can_be("character")
#'   chrs %>% which_can_be("Date")
#'   chrs %>% which_can_be("POSIXct") 
#' 
#'   dts %>% which_can_be("numeric")
#'   dts %>% which_can_be("integer")
#'   dts %>% which_can_be("character")
#'   dts %>% which_can_be("Date")
#'   dts %>% which_can_be("POSIXct") 
#'  
#'   posx %>% which_can_be("numeric")
#'   posx %>% which_can_be("integer")
#'   posx %>% which_can_be("character")
#'   posx %>% which_can_be("Date")
#'   posx %>% which_can_be("POSIXct") 
#'   
#'   
#'   x <- c( 1:3, letters[1:3], NA )
#'   x %>% which_can_be( "integer" )
#'   x %>% which_cant_be( "integer" )
#'   
#' @md
#' @rdname can_be
#' @export

which_can_be <- function( object, class ) { 
  
  suppressWarnings(
    which( 
      is.na(object)  |   # Existing NA values in object
      ! is.na( try( as(object, class), silent = TRUE ) )  # Values 
    ) 
  )
  
}

#' @md
#' @rdname can_be
#' @export

which_cant_be <- function( object, class ) { 

  suppressWarnings(
    which( 
     ( ! is.na(object) ) &   # Existing NA values in object
     is.na( try( as( object, class), silent = TRUE ) )  # Values 
    ) 
  )
  
}



#' @rdname can_be
#' @export

can_be.which <- function( ... )
  which_can_be(...)
  