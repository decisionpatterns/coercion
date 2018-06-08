#' try_as
#' 
#' @param object object
#' @param class string; name of class
#' 
#' @details 
#' 
#' `try_as` attempts to convert `object` to `class`.
#' 
#'  warnings are surpressed; errors return NULL  
#' 
#' @seealso 
#'  - [can_be()]
#'  
#' @md  
#' @return 
#'   a object of the new class or `NULL` if as produces an error 
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
#'   nums %>% try_as("numeric")
#'   nums %>% try_as("integer")
#'   nums %>% try_as("character")
#'   nums %>% try_as("Date")
#'   nums %>% try_as("POSIXct") 
#'     
#'   ints %>% try_as("numeric")
#'   ints %>% try_as("integer")
#'   ints %>% try_as("character")
#'   ints %>% try_as("Date")
#'   ints %>% try_as("POSIXct") 
#'
#'   chrs %>% try_as("numeric")
#'   chrs %>% try_as("integer")
#'   chrs %>% try_as("character")
#'   chrs %>% try_as("Date")
#'   chrs %>% try_as("POSIXct") 
#' 
#'   dts %>% try_as("numeric")
#'   dts %>% try_as("integer")
#'   dts %>% try_as("character")
#'   dts %>% try_as("Date")
#'   dts %>% try_as("POSIXct") 
#'  
#'   posx %>% try_as("numeric")
#'   posx %>% try_as("integer")
#'   posx %>% try_as("character")
#'   posx %>% try_as("Date")
#'   posx %>% try_as("POSIXct") 
#'   
#' @md
#' @importFrom methods as
#' @export

try_as <- function( object, class ) {
  
  ret <- tryCatch( 
    { as(object,class) }
    , warning=function(w){}
    , error=function(e) return(NULL)
    # , finally=NULL 
  )
  
  if( ! exists("ret", inherits=FALSE ) ) return(NULL)
  
  return(ret)
  
}
