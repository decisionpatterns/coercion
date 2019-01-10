# Add class
#
# Extends an object by adding one or more classes to an object
#
# @param x object
# @param class character vector of class names
#
# @details
#
# `add_class` adds a subclass to `x`. If it is already a member of the class
# `x` is returned with a warning.
# 
# @return
# object with added class
#
# @md
# @rdname add_class
# @export

add_class <- function(x, class) { 
  structure( x, class = c(class,class(x)) )
}
  
# @details 
# `add_subclass` adds classes to the **front** of the special `class` attribute 
# vector. If `x` is already a member of `class`, `class` becomes its **first** 
# subclass and a warning is given.
# 
# @rdname add_class
# @export

add_subclass <- function(x, class) {
  if( class %in% class(x) ) warning( 'Already a member of: ', class)
  cls <- unique( c( class, class(x) ) )
  structure( x, class = cls ) 
}

# @details
# `add_superclass` adds `class` to the **end** of the special `class` vector. If 
# `x` is already a member of `class`, `class` becomes its **last** 
# superclass and a warning is given. 
#
# @examples 
# 
# x <- 1:3
# x <- add_superclass( x, "foo" )
# class(x)                             # int, foo 
# x <- add_superclass( x, "foo" )      # Warning
# class(x)                             # int, foo
#  
# @rdname add_class
# @export

add_superclass <- function(x, class) {
  if( class %in% class(x) ) warning( 'Already a member of: ', class)
  cls <- unique( fromLast = TRUE, c( class(x), class ) )
  structure( x, class=cls ) 
}


