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
#'   p_excel_dt( c(Sus)) 
#' @import lubridate
#' @export 

p_excel_dt <- function(x) UseMethod('p_excel_dt') 

p_excel_dt.default <- function(x) p_excel_dt(as.numeric(x))

p_excel_dt.numeric <- function(x) excel_origin + lubridate::ddays(x)

p_excel_dt.Date <- function(x) x

p_excel_dt.POSIXct <- function(x) x 