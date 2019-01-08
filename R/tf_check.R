#' Check transform
#' 
#' Check transformation values 
#' 
#' @param data table of data to function as environment for `expr`
#' @param expr expression to evaluate
#' @param .all logical whether to display all the observation or
#'   just the failed transformations. (Default: `FALSE``)
#' 
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
#' @import data.table      
#' @export 

tf_check <- function(data, expr, .all=FALSE ) { 
  
  d <- copy(data)
  setDT(d)
  
  expr <- substitute(expr)
  vars <- all.names(expr)
  vars <- intersect(vars, names(data))

  ret <- cbind(
     d[ , .( .OUT=eval(expr) ) ]
   , d[ , ..vars ] 
  ) 

  # All transformation 
  if(.all) return(ret)  # Return Everthing 
    
  # Failed Transformation 
  ret[ is.na(.OUT) &                                    # Failed Transform 
       ! (iris[ , ..vars ] %>% apply( 1, anyNA ) )    # No Missing Arguments 
  ]
  
}
