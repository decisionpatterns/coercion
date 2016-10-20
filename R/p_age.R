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
#' @examples 
#'   
#'   c('34Y', '11M', '12D') %>% p_age           
#'   1:10 %>% p_age
#'   
#' @import magrittr
#' @import stringr
#' @export
 
p_age <- function(x) {

  if( is.numeric(x) ) return(x)
  
  x %<>% str_trim('both')

 ### age
   age <- numeric(length(x))

   age[ x %>% str_detect("Y$") ] <-
     x[ x %>% str_detect("Y$") ] %>% str_replace("Y$","") %>% as.numeric

   age[ x %>% str_detect("M$") ] <-
     x[ x %>% str_detect("M$") ] %>% str_replace("M$","") %>% as.numeric %>% divide_by(12)

   age[ x %>% str_detect("D$") ] <-
     x[ x %>% str_detect("D$") ] %>% str_replace("D$","") %>% as.numeric %>% divide_by(365)

   # DEFAULT:
   age[ x %>% str_detect("[^YMD]$") ] <- 
     x[ x %>% str_detect("[^YMD]$") ] %>% as.numeric()
   
   return(age)
}
