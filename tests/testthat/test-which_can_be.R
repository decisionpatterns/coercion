
context("which_can_be")
x <- c( 1:3, letters[1:3], NA )


test_that( "which_can_be", {

  x %>% which_can_be( "integer" ) %>% expect_equal( c(1,2,3,7))
  
})


test_that( "which_cant_be", {
  
  x %>% which_cant_be( "integer" ) %>% expect_equal( c(4,5,6) )
  
}) 
