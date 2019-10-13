#' Check transform 
#' 
#' Check transformation values 
#' 
#' @return 
#' 
#' A data.table with 
#' 
#'  - unexpected where one or more of the args are na
#'  - any missing
#'  - failures : no missing args,  
#'
#' @examples 
#' 
#'   data(iris) 
#'   setDT(iris)
#'   iris[ , Species := Species %>% as.character() ]
#'
#'   iris %>% tf_check( Species %>% as.character() )
#'   iris %>% tf_check( Species %>% as.numeric()  )
#' 
#'   iris %>% tf_pass( Species %>% as.character() )
#'   iris %>% tf_pass( Species %>% as.numeric()  )
#' 
#' @import data.table      
#' @export 

tf_check <- function(data, expr, .key=TRUE, .all=FALSE ) { 
  
  d <- copy(data)
  setDT(d)
  
  expr <- substitute(expr)
  vars <- all.names(expr)
  vars <- intersect(vars, names(data))  # args to expr

  if( .key && haskey(d) )
    ret <- d[ , c( key(d), vars ), with=FALSE ] else 
    ret <- d[ , vars , with=FALSE ]
  
  # ADD .OUT TRANSFORMATION
  ret <- cbind(
       ret 
    ,  d[ , .( .OUT=suppressWarnings( eval(expr) ) ) ]
  ) 

  # All transformation 
  if(.all) return(ret)  # Return Everthing 
    
  # Failed Transformation 
  ret[ is.na(.OUT) &                                    # Failed Transform 
       ! ( data[ , ..vars ] %>% apply( 1, anyNA ) )     # No Missing args 
  ]
  
}


#' @rdname tf_check
#' @export 

tf_pass <- function(...) { 
  
  d <- tf_check(..., .all=FALSE ) 
  if( nrow(d) == 0 ) TRUE else FALSE
  
}