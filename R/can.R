#' Determine if the a vector can be coerced into the given clas
#' 
#' @param object object; 
#' @param class character; name of class to check if it can be coerced
#' 
#' @seealso 
#'   \code{\link[methods]{canCoerce}}
#'   \code{\link[methods]{setAs}}
#'   
#' @examples 
#'   can( 1.0, 'integer' )
#'   can( "foo", 'integer' )
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
