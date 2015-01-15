#' Coerce to Integer
#' 
#' Coerces a value to numeric by removing any leading non-digit, non-decimal 
#' fields occuring at the end of the character.
#' 
#' @param x values to be coerced to numeric
#' @param strip_units boolean. Whether to strip the unit from the results.
#' 
#' @return A numeric field
#' 
#' @seealso
#'   The stringr package.
#'   
#' @examples
#'   coerce_integer( '32 ft/s^2' )
#'   coerce_integer('1,001 nights' )
#'   
#' @export

coerce_integer <- function(x, strip_units=TRUE) { 
  
  if( strip_units ) x <- strip_units(x) 
           
  x <- gsub( "^\\$", "", x )  # strip leading $ 
  x <- gsub( "\\%$", "", x )  # strip trailing %
  x <- gsub( ",", "", x)      # strip comma

  x <- as.integer( x )
    
  return(x)
  
} 
