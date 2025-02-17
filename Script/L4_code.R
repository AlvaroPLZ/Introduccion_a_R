### Title: Lab 04
### Author: Álvaro Pérez
### Date: February 14, 2025

# Libraries 

library(tidyverse)

#### Pivoting ####
# pivot_longer()
table4a

table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

# pivot_wider()
table2

table2 %>%
  pivot_wider(names_from = type, values_from = count)

#### Tidy Verbs ####

# separate ()

table3

table3 %>% 
  separate(rate, into = c("cases", "population"))

table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

# unite ()

table5

table5 %>% 
  unite(new, century, year)

table5 %>% 
  unite(new, century, year, sep = "")

#### Missing values ####

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(
    cols = c(`2015`, `2016`), 
    names_to = "year", 
    values_to = "return", 
    values_drop_na = TRUE
  )

