### Title: Lab 06: Data Relations
### Author: Alvaro Pérez
### Date: February 24, 2025

library(tidyverse)

# Create data 

subject <- tibble(
  id = 1:5,
  gender = c("m", "m", NA, "nb", "f"),
  age = c(19, 22, NA, 19, 18)
)

exp <- tibble(
  id = c(2, 3, 4, 4, 5, 5, 6, 6, 7),
  score = c(10, 18, 21, 23, 9, 11, 11, 12, 3)
)

#### Mutating Joins ####

### left_join () ###

left_join(subject, exp, by = "id")

left_join(exp, subject, by = "id")

### right_join () ###

right_join(subject, exp, by = "id")

### inner_join () ###

inner_join(subject, exp, by = "id")

### full_join () ###

full_join(subject, exp, by = "id")

#### Filtering Joins ####

### semi_join() ###

semi_join(subject, exp, by = "id")
semi_join(exp, subject, by = "id")

### anti_join ###

anti_join(subject, exp, by = "id")
anti_join(exp, subject, by = "id")

#### Binding Joins ####

### bind_rows () ###

new_subjects <- tibble(
  id = 6:9,
  gender = c("nb", "m", "f", "f"),
  age = c(19, 16, 20, 19)
)

bind_rows(subject, new_subjects)

### bind_cols () ###

new_info <- tibble(
  colour = c("red", "orange", "yellow", "green", "blue")
)

bind_cols(subject, new_info)

#### Set Operations ####

### intersect ()

new_subjects <- tibble(
  id = seq(4, 9),
  age = c(19, 18, 19, 16, 20, 19),
  gender = c("f", "f", "m", "m", "f", "f")
)

intersect(subject, new_subjects)

### union ()

union(subject, new_subjects)

### setdiff ()

setdiff(subject, new_subjects)

setdiff(new_subjects, subject)