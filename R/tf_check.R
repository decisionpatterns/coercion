#' Check transform
#' 
#' Check transformation values 
#' 
#' @param data table of data to function as environment for `expr`
#' @param expr expression to evaluate
#' @param .all logical whether to display all the observation or
#'   just the failed transformations. (Default: `FALSE``)
#' @param ... arguments to `tf_check` 
#' `
#' @return 
#' 
#' A data.table with the result of the expression followed by the
#' names used from the columns
#' 
#' 
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

tf_check <- function(data, expr, .all=FALSE ) { 
  
  d <- copy(data)
  setDT(d)
  
  expr <- substitute(expr)
  vars <- all.names(expr)
  vars <- intersect(vars, names(data))  # args to expr

  ret <- cbind(
     d[ , .( .OUT=suppressWarnings( eval(expr) ) ) ]
   , d[ , ..vars ]                 # args 
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