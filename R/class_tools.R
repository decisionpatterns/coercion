# S3 Class tools 
# 
# Utilities for working with S3 classes
# 
# @param x S3 object to modify inheritance/classes
# @param class character; name(s) of class(es) to modify
# 
# `append_class` adds `class` to the front of the class atttribute. 
# If `x` is already a member of the class a warning is issued and `x` is 
# returned.
# 
# `remove_class` removes `class` from the class attribute.
# 
# @return 
#   Object `x` with its class attribute modified
#   
# @seealso 
#   \code{\link[base]{class}} \cr
#   
# @examples
#   foo <- "bar"
#   class(foo) <- "baz"
#   foo <- append_class(foo, "qux") 
#   class(foo)  # qux, baz                    
#               
#   foo <- "bar"
#   class(foo) <- "baz"
#   foo <- prepend_class(foo, "qux") 
#   class(foo)  # qux, baz                   
#    
#   foo <- remove_class(foo, "baz")
#   class(foo)  # quz  
#                      
# @md
# @rdname class-tools
# @export

append_class <- function(x,class) {
  
  if( class %in% class(x) ) { 
    warning( "x is already ", class, " class")  
    return(x)
  }
  
  class(x) <- append( class(x), class, 0)  
  x
  
}

# @rdname class-tools
# @export
remove_class <- function(x,class){
  class(x) <- setdiff( class(x), class)
  x
}

# @rdname class-tools
# @export
prepend_class <- function(x, class) { 
  class(x) <- append( class, class(x), 0) 
  x
}
