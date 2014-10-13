#' Strip unit-like characters from a vector
#' 
#' Strip everything after the first set of number like items
#' @param x vector, usually character. 
#' 
#' @return A vector of the same class as \code{x}, but with the trailing 
#' non-number elements removed. It does not perform a coercion.
#' 
#' @note consider adding an \code{as} parameter to perform coercions. See 2nd 
#' example for comma left in.
#' 
#' @examples
#'   strip_units( '32 ft/s^2')
#'   strip_units( '1,001 nights' )
#' @export

strip_units <- function(x) 
  gsub( perl=TRUE, '[^\\d.,eE].*$', "", x )
