#' Conert mutually exclusive  columns to a factor
#' 
#' @param data data to convert
#' @param names names of columns in \code{data} to treat as mutually exclusive
#' @param ordered logical; whether the factor should be ordered 
#' 
#' @return factor
#' 
#' @note
#'   - This performs the opposite function of the dummies package. \cr
#'   - Ensure the variables are integer or logical or can be coerced to on
#'   - Belong in dummies package
#'   
#' @examples
#'   # as.mutex( ci2, c('saltsnackyuk', 'saltsnackok', 'saltsnackyum' ), ordered=TRUE )
#'   
#' 
#' @export
  
as.mutex <- function( data, names, ordered=FALSE ) {
  
  data <- data[ , names]    # only worry about named columns
  
  if( ! is.character(names) ) stop( "Uh-oh. 'names' must be a character vector.")
  if( any( rowSums( data[ , names ] ) > 1 ) ) stop("Uh-oh. Cannot coerece to a mutex.") 
  
  
  factor( 
    apply( 
      data, 1,  
      function(x) ifelse( any(x==1), names[ which(x == 1 ) ], NA )    
      ) , 
    levels=names, 
    ordered=ordered
  ) 
  
}
