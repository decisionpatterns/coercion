#' dry_run 
#' 
#' Like the identity function but reports on changes in values caused by the 
#' application of the function.
#' 
#' @param x object
#' @param fun function 
#' 
#' @return `x` reporting with a message about changes to those values
#'  
#' @examples
#'   c(-2:2) %>% dry_run( sqrt ) 
#'   c(-2:2) %>% dry_run( sqrt, "all" )
#'   c(-2:2) %>% dry_run( sqrt, "changed" )
#'   c(-2:2) %>% dry_run( sqrt, "unchanged" )   
#' 
#' 
#'   data(iris)
#'   setDT(iris)
#'   iris[ , Species := Species %>% dry_run( toupper ) ] 
#'   
#'   iris$Species # unchanged
#'   
#' @export 

dry_run <- function( x, fun, type=c("all") ) { 
  
  df <- data.frame(orig=x, new=suppressWarnings( fun(x) ) )

  # Side-effect: report on changes
  out <- { 
    if( type=="changed" ) {
      wh <- which( 
        ( df$orig != df$new ) | 
        ( ! is.na(df$orig) & is.na(df$new) )
      )
      wh <- na.omit(wh)
      df[ wh, ]
  
    } else if( type=="unchanged" ) { 
      wh <- which( 
          is.na(df$orig) | 
          ( ( !is.na(df$orig) ) & ( df$orig == df$new ) )  
        )
      wh <- na.omit(wh)
      df[ wh, ]
      
    } else {
      df
    }
  }
  
  print(out)
  
  return(x)  
}

