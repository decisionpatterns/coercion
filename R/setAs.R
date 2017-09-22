# Set coercion funtions. 
#' Convert character to factor
#' 
#' Converts a character to facor
#' 
#' @name as
#' @family character
#' @aliases as,character

setAs( from='character', to='factor', function(from) factor(from) )


#' @name as
#' @family logical

setAs( from="logical", to="factor", function(from) as.factor(from) )
