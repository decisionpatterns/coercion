#' parse age
#' 
#' parse age formatted as 34Y, 12M, 20D, etc.
#' 
#' @param x character; age represented as  numeric with a Y, M, D suffic
#' 
#' @return 
#'   numeric age in years
#'   
#' @examples 
#'   
#'   c('34Y', '11M', '12D') %>% p_age           
#' 
#' @export
 
p_age <- function(x) {

  x %<>% str_trim("both")

 ### age
   age <- numeric(length(x))

   age[ x %>% str_detect("Y$") ] <-
     x[ x %>% str_detect("Y$") ] %>% str_replace("Y$","") %>% as.numeric

   age[ x %>% str_detect("M$") ] <-
     x[ x %>% str_detect("M$") ] %>% str_replace("M$","") %>% as.numeric %>% divide_by(12)

   age[ x %>% str_detect("D$") ] <-
     x[ x %>% str_detect("D$") ] %>% str_replace("D$","") %>% as.numeric %>% divide_by(365)

   return(age)
}
