#' excel_origin
#' 
#' Date origin according to Microsoft Excel
#' 
#' @export 

excel_origin <- structure(-25569, class = "Date") # "1899-12-30"


#' Parse Excel Numeric Date/Time
#' 
#' @param x numeric; vector of Excel date/times expressed as numeric 
#'
#' @details  
#' 
#' At times readxl::read_excel does not get the date and times right and imports
#' them as numeric instead. This converts those numeric date/times to proper
#' Date or POSIXct objects.
#'
#' @return 
#'   A Date object if \code{x} is integer; a POSIXct object if \code{x} is 
#'   numeric. \cr
#'   
#' @seealso 
#'   \code{\link[readxl]{read_excel}}
#'    
#' @examples
#'   p_excel_dt( 40000 )
#'   p_excel_dt( c(40000,NA)) 
#'   p_excel_dt( Sys.Date() )
#'   p_excel_dt( Sys.time() )   
#'   
#'   p_excel_dt( c("12/1/2016 12:01 PM") )
#'   p_excel_dt( c("12/1/2016 12:01 PM", "12/1/2016", NA, "Unparsable", "4365") )
#'   
#' @import lubridate
#' @importFrom na.tools na.replace
#' @export 

p_excel_dt <- function(x) UseMethod('p_excel_dt') 

#' @rdname p_excel_dt
#' @export  
p_excel_dt.default <- function(x) p_excel_dt(as.numeric(x))


#' @rdname p_excel_dt
#' @export
p_excel_dt.numeric <- function(x) {   # limit 24855
  
  ret <- .POSIXct(rep(NA,length(x)))
  
  suppressWarnings( pass <- excel_origin + lubridate::ddays( x ) )
  ret[ ! is.na(pass) ] <- pass[! is.na(pass) ]

  ret
}
  
#' @rdname p_excel_dt 
#' @export
p_excel_dt.Date <- function(x) x

#' @rdname p_excel_dt
#' @export
p_excel_dt.POSIXct <- function(x) x 

#' @rdname p_excel_dt
#' @export
p_excel_dt.character <- function(x) {

  # Try numeric excel date first
  ret <- .POSIXct( rep(NA,length(x)) )
  
  suppressWarnings( pass <- mdy_hms(x) )
  ret <- na.replace(ret,pass)
  if( ! any(is.na(ret) ) ) return(ret)
  
  suppressWarnings( pass <- mdy_hm(x) )
  ret <- na.replace( ret, pass) 
  if( ! any(is.na(ret) ) ) return(ret)
  
  suppressWarnings( pass <- mdy(x) )
  ret <- na.replace( ret, pass )
  if( ! any(is.na(ret) ) ) return(ret)
  
  suppressWarnings( pass <- p_excel_dt( as.numeric(x) ) )
  ret <- na.replace( ret, pass )
 
  return(ret)  
}
