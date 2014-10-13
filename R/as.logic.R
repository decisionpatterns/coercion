#' Convert character to logical 
#' 
#' Converts vector to logical based on user specified parameters for the TRUE 
#' and false values
#' 
#' @name as.logic  
#' @param x Variable to convert to logical
#' @param true Value(s) mapped to \code{TRUE}
#' @param false Value(s) mapped to \code{FALSE}
#' 
#' @return \code{logical}
#' 
#' @details  
#' Values not identified by \code{true} or \code{false} become \code{NA}
#'  
#' @seealso \code{\link{as.logical}}, \code{\link{logical}}, \code{\link{NA}}
#'
#' @examples
#' as.logic( iris$Species, true="setosa", false="virginica" )   
#' @rdname as.logic
#' @export

as.logic <- function(x, true=TRUE, false=FALSE) {
  
  tmp <- rep( NA, length(x) ) 
  tmp[ x %in% true ] <- TRUE
  tmp[ x %in% false ] <- FALSE
  
  return(tmp)
}

#' @name as.logicYN
#' @examples
#' yn <- c( "Yes", "NO", "Y", "n" )
#' as.logicYN(yn)
#' @rdname as.logic
#' @export

as.logicYN <- function(x) 
  as.logic( 
    x
    , true = c("YES","Yes","yes","Y","y")
    , false = c("NO", "No", "no", "N", "n") 
  )
