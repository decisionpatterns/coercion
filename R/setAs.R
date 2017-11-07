#' Conversions 
#' 
#' S4 Converts a character to facor
#' 
#' @name as
#' @family character
#' @aliases as,character
#' @import methods

methods::setAs( from='character', to='factor', function(from) factor(from) )


#' @name as
#' @family logical

methods::setAs( from="logical", to="factor", function(from) as.factor(from) )
