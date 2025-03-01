### Title: Lab 7
### Author: Álvaro Pérez
### Date: February 28, 2025

### Setup 

# libraries needed for these examples
library(tidyverse)  ## contains purrr, tidyr, dplyr
library(broom) ## converts test output to tidy tables

set.seed(8675309) # makes sure random numbers are reproducible

#### Iteration functions ####

## rep() ##

rep(c("A", "B"), 12)
rep(c("A", "B"), times = 12)
rep(c("A", "B"), c(11, 3))
rep(c("A", "B"), each = 12)
rep(c("A", "B"), times = 3, each = 2)

## seq() ##

seq(0, 10)
seq(0, 100, by = 10)
seq(0, 100, length.out = 13)

## replicate() ##

replicate(n = 3, expr = rnorm(5))
replicate(n = 3, expr = rnorm(5), simplify = FALSE)

#### Custom functions ####

### Structuring a function

function_name <- function(my_args) {
  # process the arguments
  # return some value
}

add1 <- function(my_number) {
  my_number + 1
}

add1(10)

report_p <- function() {
}

### Arguments 

report_p <- function(p) {
}

### Arguments defaults

report_p <- function(p, digits = 3) {
}

report_p <- function(p, digits = 3) {
  if (p < .001) {
    reported = "p < .001"
  } else {
    roundp <- round(p, digits)
    reported = paste("p =", roundp)
  }
  
  reported
}

report_p <- function(p, digits = 3) {
  if (p < .001) {
    reported = "p < .001"
  } else {
    roundp <- round(p, digits)
    reported = paste("p =", roundp)
  }
  
  return(reported)
}

report_p(0.04869)
report_p(0.0000023)

### Scope 

reported <- "not changed"

# inside this function, reported == "p = 0.002"
report_p(0.0023) 

reported # still "not changed"

#### Iterating your own functions ####

## rnorm()

A <- rnorm(20, mean = 5, sd = 1)

## tibble::tibble()

dat <- tibble(
  A = rnorm(20, 5, 1),
  B = rnorm(20, 5.5, 1)
)

## t.test()

t.test(dat$A, dat$B)

## broom::tidy()

tibble(
  A = rnorm(20, 5, 1),
  B = rnorm(20, 5.5, 1)
) %>%
  gather(group, score, A:B) %>%
  t.test(score~group, data = .) %>%
  broom::tidy()

## Custom function: t_sim()

t_sim <- function() {
  tibble(
    A = rnorm(20, 5, 1),
    B = rnorm(20, 5.5, 1)
  ) %>%
    gather(group, score, A:B) %>%
    t.test(score~group, data = .) %>%
    broom::tidy() %>%
    pull(p.value) 
}
t_sim()

## Iterate t_sim()

reps <- replicate(1000, t_sim())
alpha <- .05
power <- mean(reps < alpha)
power

## Set seed

set.seed(90201)

## Add arguments 

t_sim <- function(n = 10, m1=0, sd1=1, m2=0, sd2=1) {
  tibble(
    A = rnorm(n, m1, sd1),
    B = rnorm(n, m2, sd2)
  ) %>%
    gather(group, score, A:B) %>%
    t.test(score~group, data = .) %>%
    broom::tidy() %>%
    pull(p.value) 
}
# Test your function 
t_sim(100)
t_sim(100, 0, 1, 0.5, 1)





