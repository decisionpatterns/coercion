#' Parse US Currency from text field
#' 
#' @param x character; text currency values
#' 
#' Parses a character represented currency value to numeric value
#' 
#' @examples
#'   factor("$1,000.20") %>% from_currency
#' 
#' @export

p_currency <- function(x) {
  if( is.factor(x) ) x <- as.character(x)
  if( is.character(x) )
    x <- x %>% str_replace("^[$]", "" )  %>% str_replace_all(",","") %>% as.numeric
  return(x)
}
