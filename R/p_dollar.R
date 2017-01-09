#' Parse US Currency from text field
#' 
#' @param x character; text currency values
#' 
#' Parses a character represented numeric USD value by removing \code{$} and 
#' \code{","} values.
#' 
#' @seealso 
#'   \code{scales::dollar} which is the inverse operations that expresses a 
#'   numeric value as a scalar
#'   
#' @examples
#'   factor("$1,000.20") %>% from_currency
#' 
#' @export

p_dollar <- function(x) {
  if( is.factor(x) ) x <- as.character(x)
  if( is.character(x) )
    x <- x %>% str_replace("^[$]", "" )  %>% str_replace_all(",","") %>% as.numeric
  return(x)
}
