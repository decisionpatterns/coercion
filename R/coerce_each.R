#' Coerce each elements of a container class from one class to a different 
#' class
#' 
#' @param x A container object such as a \code{list}, \code{data.frame} or 
#' \code{data.table}
#' @param from A character vector containing the classes to coerce from
#' @param to A character vector containing 
#' @return An object with the same class as \code{x}
#' @examples
#'   coerce_each( iris,  "factor", "character" ) 
#' @export

coerce_each <- function(x, from, to ) UseMethod( "coerce_each" )

#' @return \code{data.table}
#' @rdname coerce_each
#' @export

coerce_each.data.frame <- function(x, from, to ) {
  
  targets <- which( sapply( x, is, from ) )

  for( t in targets )
    x[[ t ]] <- as( x[[ t ]], to  )

  return(x)
}


#' @return \code{data.table}
#' @rdname coerce_each
#' @export

coerce_each.data.table <- function(x, from, to) { 
  NextMethod( "coerce_each" )
}
