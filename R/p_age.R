#' parse age
#' 
#' parse age formatted as 34Y, 12M, 20D, etc. to an age in years
#' 
#' @param x character; age represented as  numeric with a Y, M, D suffic
#' 
#' @details 
#'   Parses a character string to yield an age in years.
#' 
#' @return 
#'   numeric age in years
#'
#' @seealso 
#'  - tf_try() 
#'  
#' @examples 
#'   
#'   c( '25', '34Y', '11 M', '12d', '25 w' ) %>% p_age           
#'   1:5 %>% p_age
#'   
#' @import magrittr
#' @import stringr
#' @export
 
p_age <- function(x) {

  
  if( is.numeric(x) ) return(x)  # Already numeric.
  
  x %<>% str_trim('both')    # Remove white-space
  
  age <- numeric(length(x))  # Final output

  # NUMERICS TAKEN TO BE YEARS
  suppressWarnings({ 
    nums <- as.numeric(x) 
  }) 
  age[ ! is.na(nums) ] <- nums[ ! is.na(nums) ]
  
  
  # YEARS 
  
  age[ x %>% str_detect("[Yy]$") & ! is.na(x) ] <-  
    x[ x %>% str_detect("[Yy]$") & ! is.na(x) ] %>% str_replace("\\s*[Yy]$",'') %>%
    as.numeric  
  
   # ... years
   pattern <- regex('years?$', ignore_case = TRUE )  
   replace <- ''
   age[ x %>% str_detect(pattern) & ! is.na(x) ] <-  
    x[ x %>% str_detect(pattern) & ! is.na(x) ] %>% str_replace(pattern,replace) %>%
    as.numeric  
  
   # ... yo
   pattern <- regex('yo', ignore_case = TRUE )  
   replace <- ''
   age[ x %>% str_detect(pattern) & ! is.na(x) ] <-  
    x[ x %>% str_detect(pattern) & ! is.na(x) ] %>% str_replace(pattern,replace) %>%
    as.numeric 
   
  
  # MONTHS
  age[ x %>% str_detect("[Mm]$") & ! is.na(x) ] =
    x[ x %>% str_detect("[Mm]$") & ! is.na(x) ] %>% str_replace("\\s*[Mm]$",'') %>%
    as.numeric %>% divide_by(12)

  # DAYS
  age[ x %>% str_detect("[Dd]$") & ! is.na(x) ] =
    x[ x %>% str_detect("[Dd]$") & ! is.na(x) ] %>% str_replace("\\s*[Dd]$",'') %>%
    as.numeric %>% divide_by(365.25)

  # WEEKS
  age[ x %>% str_detect("[Ww]$") & ! is.na(x)] =
    x[ x %>% str_detect("[Ww]$") & ! is.na(x) ] %>% str_replace("\\s*[Ww]$",'') %>%
    as.numeric %>% multiply_by(7) %>% divide_by(365.25)

  return(age)

}
