context("p_age")

test_that("coerce from age", {
  
  1:5 %>% p_age %>% expect_equal(1:5)
  
  '5y' %>% p_age %>% expect_equal(5)
  '5Y' %>% p_age %>% expect_equal(5)
  '5 Y' %>% p_age %>% expect_equal(5)
  
  '5m' %>% p_age %>% expect_equal(5/12)
  '5M' %>% p_age %>% expect_equal(5/12)
  '5 M' %>% p_age %>% expect_equal(5/12)
  
  '5w' %>% p_age %>% expect_equal(5*7/365.25)
  '5W' %>% p_age %>% expect_equal(5*7/365.25)
  '5 W' %>% p_age %>% expect_equal(5*7/365.25)
  
  '5d' %>% p_age %>% expect_equal(5/365.25)
  '5D' %>% p_age %>% expect_equal(5/365.25)
  '5 D' %>% p_age %>% expect_equal(5/365.25)
  
})
