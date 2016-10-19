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
#' At times readxl::read_excel does not get the days right
#'   
#' @seealso 
#'    \code{\link[readxl]{read_excel}}
#' @return 
#'   as.POSIX_ct
#' 
#' @import lubridate
#' @export 

p_excel_dt <- function(x)  lubridate::excel_origin + ddays(x)
