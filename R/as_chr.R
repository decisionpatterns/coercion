#' Convert to character
#' 
#' @param x logical vector
#' @param na string; value to set for `NA` (missing values)
#' 
#' @details 
#' 
#' `as_chr` converts `x` to character.  It is smarter versions of 
#' [base::as.character()].
#'  
#' @seealso 
#'  - [base::as.character()] which is a primitive method for which 
#'    S3 classes cannot be defined.
#'    
#'  - [na.tools](https://cran.r-project.org/web/packages/na.tools/index.html) 
#'  package for functions that replace and impute `NA` in vectors.    

#' @export 

as_chr <- function(x, ..., na ) UseMethod("as_chr")

#' @details 
#' 
#' The default method wraps [base::as.character()].
#' 
#' @rdname as_chr
#' @export

as_chr.default <- function(x, ..., na ) { 
  x <- as.character(x, ... )
  
  if( ! missing(na) )
    x[ is.na(x) ] <- na
  
  x
}

#' @param true string for TRUE value
#' @param false string for FALSE value
#' 
#' @details 
#' 
#' The method for `logical` values allows for mapping `TRUE`, `FALSE` and
#' `NA` values to  
#' values to  `
#' Using non-default values for `true` or `false` results in non-invertible 
#' transformation. (true="T", false="F" is also invertible )
#' 
#' This also allows for setting `TRUE` or `FALSE` values to `NA`
#' 
#' @examples 
#'   v <- c(TRUE, FALSE, NA )
#'   as_chr(v) 
#'   as_chr(v, "T", "F" )
#'   as_chr(v, true="T", false=NA )
#'
#' @rdname as_chr 
#' @export 
as_chr.logical <- function(x, true="TRUE", false="FALSE", na) { 
  
  x <- ifelse(x,true,false)   
  if( ! missing(na) ) 
    x[ is.na(x) ] <- na
  
  x
}


