#' Parse percent value
#' 
#' @param x character; a value that can be coerced to a character that has a 
#' percentage sign at the end
#' 
#' @details 
#' 
#' Returns numeric value with the percentage sign stripped
#' 
#' @import stringr
#' @export

p_percent <- function(x){
  
  gsub( "\\%$", "", x ) %>% as.numeric()
  
}
