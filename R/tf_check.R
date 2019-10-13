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
#'  - unexpected where one or more of the args are na
#'  - any missing
#'  - failures : no missing args,  
#'
#' @import data.table      
#' @export 

tf_check <- function( data, expr, key, ... ) UseMethod('tf_check')

#' @rdname tf_check
#' @export 
tf_check.default <- function( data, expr, key, ... ) { 

  if( is.atomic(data) ) { 
    data <- add_subclass(data, "atomic")
    tf_check(data, expr, key, .all )  
  }
 
   
}
 
 
#' @rdname tf_check
#' @export 
tf_check.atomic <- function( data, expr, key, .all ) { 
  data <- data %>% remove_class("atomic")
  "Atomic Method is not implemented"  
}

#' @examples 
#'  
#' # Tables:
#'   
#'   data(iris) 
#'   setDT(iris)
#'   iris[ , Species := Species %>% as.character() ]
#'
#'   iris %>% tf_check( Species %>% as.character() )
#'   iris %>% tf_check( Species %>% as.numeric()  )
#' 
#'   iris %>% setkey( Sepal.Length )
#'   iris %>% tf_check( Species %>% as.character(), .all=TRUE )
#'   
#'   iris %>% tf_pass( Species %>% as.character() )
#'   iris %>% tf_pass( Species %>% as.numeric()  )
#'
#' @rdname tf_check
#' @export 

tf_check.data.frame <- function(data, expr, key=TRUE, ... ) { 
  
  d <- copy(data)
  setDT(d)
  
  expr <- substitute(expr)
  vars <- all.names(expr)
  vars <- intersect(vars, names(data))  # args to expr

  if( key && haskey(d) )
    ret <- d[ , c( key(d), vars ), with=FALSE ] else 
    ret <- d[ , vars , with=FALSE ]
  
  # ADD .OUT TRANSFORMATION
  ret <- cbind(
       ret 
    ,  d[ , .( .OUT=suppressWarnings( eval(expr) ) ) ]
  ) 

  ret <- ret %>% add_class('tf_check')
  format(ret, ... )
  
}


#' @examples 
#' 
#' x <- c(-2:2, NA) %>% 
#'   tf_try( sqrt ) %>% 
#'   tf_try( function(x) sqrt(x+1) ) 
#' 
#' tf_check(x)
#' 
#' @rdname tf_check
#' @export 

tf_check.tf_try <- function(data, expr, key=TRUE , ... ) { 
  
  ret <- data.frame( orig=attr(data, 'orig'), .OUT=data )
  setDT(ret)
  ret <- add_class(ret, "tf_check")
  format(ret, ... )
  
}


#' @rdname tf_check
#' @export 

tf_pass <- function(...) { 
  
  d <- tf_check(..., .all=FALSE ) 
  if( nrow(d) == 0 ) TRUE else FALSE
  
}


#' @details 
#' 
#' `format` formats a tf_check object; argument `all=TRUE` will show all 
#' observations rather than those that fail` 
#' 
#' @examples 
#' 
#' Format: 
#'   
#' 
#' 
#' @rdname tf_check
# @export

format.tf_check <- function(x, all=FALSE ) { 
  
  nms <- names(x)
  vars <- nms %>% setdiff(".OUT")
  
  if( is.data.table(x) && haskey(x) )
    vars <- vars %>% setdiff( key(x) )
  
  # Report failures only
  # A failure is an NA output that has non-NA inputs
  if( ! all ) {
    x <- x[ is.na(.OUT) &                              # Failed Transform 
            ! ( x[ , ..vars ] %>% apply( 1, anyNA ) )    # No Missing args 
         ]
  } 

  x
}
