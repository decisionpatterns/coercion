#' Convert character to logical 
#' 
#' Converts vector to logical based on user specified parameters for the TRUE 
#' and false values
#' 
#' @name as.logic  
#' @param x vector  to convert to logical
#' @param true Value(s) mapped to \code{TRUE}
#' @param false Value(s) mapped to \code{FALSE}
#' 
#' @details  
#' \code{as.logic} coerces \code{x} into a logical vector in which the values
#' of specified by \code{true} become \code{TRUE}. etc. Values not identified 
#' by \code{true} or \code{false} become \code{NA}
#' 
#' 
#' @return \code{logical} vector version of \code{x}.
#'  
#' @seealso 
#'   \code{\link[base]{as.logical}} \cr
#'   \code{\link[base]{logical}} \cr 
#'   \code{\link[base]{NA}} \cr
#'   
#' @examples
#'    as.logic( iris$Species, true="setosa", false="virginica" )  
#'     
#' @rdname as.logic
#' @export

as.logic <- function(x, true=TRUE, false=FALSE) {
  
  if( is.logical(x) ) return(x)  # makes it idempotent
  tmp <- rep( NA, length(x) ) 
  tmp[ x %in% true ] <- TRUE
  tmp[ x %in% false ] <- FALSE
  
  return(tmp)
}

#' @aliases as.logicYN
#' @examples
#'   yn <- c( "Yes", "NO", "Y", "n" )
#'   as.logicYN(yn)
#' @rdname as.logic
#' @export

as.logicYN <- function(x) 
  as.logic( 
    x
    , true = c("YES","Yes","yes","Y","y")
    , false = c("NO", "No", "no", "N", "n") 
  )


#' @rdname as.logic
#' @export

p_yn <- as.logicYN 