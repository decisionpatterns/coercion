#' Determine if the a vector can be coerced into the given clas
#' 
#' @param object object; 
#' @param class character; name of class to check if it can be coerced
#' 
#' @details 
#' 
#' \code{can}` relies on \code{try} and \code{as} to attempt to coerce 
#' \code{object} to a certain class. T 
#' 
#' 
#' @return 
#' 
#' A logical vector with the same length of \code{object} is returned. Values 
#' are \code{TRUE} where \code{as} did not return an \code{NA}.
#' 
#' 
#' @seealso 
#'   \code{\link[methods]{canCoerce}}
#'   \code{\link[methods]{setAs}}
#'   
#' @examples 
#'   can( 1.0, 'integer' )
#'   can( "foo", 'integer' )
#'   can( "1.234", 'numeric' )
#'   can( "1.234", 'integer' )
#'         
#'   can( c("ABC","123"), 'integer')
#'   # [1] FALSE  TRUE           
#'                     
#' @return logical 
#' @export

can <- function( object, class ) {
  
  show.errors <- getOption("show.error.messages")
  if( show.errors == TRUE )
    options( show.error.messages=FALSE )
    
  try( {cancan <- as(object,class)}, silent=TRUE )
  if( show.errors == TRUE )
    options( show.error.messages=show.errors )
  
  ! is.na(cancan)
  
}

can_be <- can
