### Title: Lab 08 
### Author: Alvaro Perez
### Date: March 8, 2025

#### Setup ####

# libraries needed for these examples
library(tidyverse)
library(plotly)
install.packages("faux")
library(faux)

set.seed(8675309) # makes sure random numbers are reproducible

#### Univariate Distributions ####

### Uniform Distribution

## Continuous 
u <- runif(100000, min = 0, max = 1)

# plot to visualise
ggplot() + 
  geom_histogram(aes(u), binwidth = 0.05, boundary = 0,
                 fill = "white", colour = "black")

## Discrete 

rolls <- sample(1:6, 10000, replace = TRUE)

# plot the results
ggplot() + 
  geom_histogram(aes(rolls), binwidth = 1, 
                 fill = "white", color = "black")

#You can also use sample to sample from a list of named outcomes.

pet_types <- c("cat", "dog", "ferret", "bird", "fish")
sample(pet_types, 10, replace = TRUE)

# Ferrets are a much less common pet than cats and dogs, so our sample isn’t very realistic. You can set the probabilities of each item in the list with the prob argument.

pet_types <- c("cat", "dog", "ferret", "bird", "fish")
pet_prob <- c(0.3, 0.4, 0.1, 0.1, 0.1)
sample(pet_types, 10, replace = TRUE, prob = pet_prob)

### Binomial distribution

# 20 individual coin flips of a fair coin
rbinom(20, 1, 0.5)
# 20 individual coin flips of a baised (0.75) coin
rbinom(20, 1, 0.75)

rbinom(10, 20, 0.5)

flips <- rbinom(1000, 20, 0.5)

ggplot() +
  geom_histogram(
    aes(flips), 
    binwidth = 1, 
    fill = "white", 
    color = "black"
  )

### Normal distribution 

dv <- rnorm(1e5, 10, 2)

# proportions of normally-distributed data 
# within 1, 2, or 3 SD of the mean
sd1 <- .6827 
sd2 <- .9545
sd3 <- .9973

ggplot() +
  geom_density(aes(dv), fill = "white") +
  geom_vline(xintercept = mean(dv), color = "red") +
  geom_vline(xintercept = quantile(dv, .5 - sd1/2), color = "darkgreen") +
  geom_vline(xintercept = quantile(dv, .5 + sd1/2), color = "darkgreen") +
  geom_vline(xintercept = quantile(dv, .5 - sd2/2), color = "blue") +
  geom_vline(xintercept = quantile(dv, .5 + sd2/2), color = "blue") +
  geom_vline(xintercept = quantile(dv, .5 - sd3/2), color = "purple") +
  geom_vline(xintercept = quantile(dv, .5 + sd3/2), color = "purple") +
  scale_x_continuous(
    limits = c(0,20), 
    breaks = seq(0,20)
  )

### Poisson 

texts <- rpois(n = 365, lambda = 20)

ggplot() +
  geom_histogram(
    aes(texts), 
    binwidth = 1, 
    fill = "white", 
    color = "black"
  )

#### Multivariate Distributions ####

### Bivariate Normal 

n   <- 1000 # number of random samples
# name the mu values to give the resulting columns names
mu <- c(x = 10, y = 20) # the means of the samples
sd <- c(5, 6)   # the SDs of the samples

rho <- 0.5  # population correlation between the two variables

# correlation matrix
cor_mat <- matrix(c(  1, rho, 
                      rho,   1), 2) 

# create the covariance matrix
sigma <- (sd %*% t(sd)) * cor_mat

# sample from bivariate normal distribution
bvn <- MASS::mvrnorm(n, mu, sigma) 

# Plot your sampled variables 
bvn %>%
  as_tibble() %>%
  ggplot(aes(x, y)) +
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "lm") +
  geom_density2d()

### Multivariate Normal 

n <- 200 # number of random samples
mu <- c(x = 10, y = 20, z = 30) # the means of the samples
sd <- c(8, 9, 10)   # the SDs of the samples

rho1_2 <- 0.5 # correlation between x and y
rho1_3 <- 0   # correlation between x and z
rho2_3 <- 0.7 # correlation between y and z

# correlation matrix
cor_mat <- matrix(c(     1, rho1_2, rho1_3, 
                         rho1_2,      1, rho2_3,
                         rho1_3, rho2_3,      1), 3) 

sigma <- (sd %*% t(sd)) * cor_mat
bvn3 <- MASS::mvrnorm(n, mu, sigma)

cor(bvn3) # check correlation matrix

# 3D Plot
#set up the marker style
marker_style = list(
  color = "#ff0000", 
  line = list(
    color = "#444", 
    width = 1
  ), 
  opacity = 0.5,
  size = 5
)

# convert bvn3 to a tibble, plot and add markers
bvn3 %>%
  as_tibble() %>%
  plot_ly(x = ~x, y = ~y, z = ~z, marker = marker_style) %>%
  add_markers()

### Faux

bvn3 <- rnorm_multi(
  n = n, 
  vars = 3,
  mu = mu, 
  sd = sd,
  r = c(rho1_2, rho1_3, rho2_3),
  varnames = c("x", "y", "z")
)

check_sim_stats(bvn3)

#### Tests ####

### Exact binomial test

n <- 10
fair_coin <- rbinom(1, n, 0.5)
biased_coin <- rbinom(1, n, 0.6)

binom.test(fair_coin, n, p = 0.5)
binom.test(biased_coin, n, p = 0.5)

## Sampling function 
sim_binom_test <- function(n, bias, p = 0.5) {
  # simulate 1 coin flip n times with the specified bias
  coin <- rbinom(1, n, bias)
  # run a binomial test on the simulated data for the specified p
  btest <- binom.test(coin, n, p)
  # return the p-value of this test
  btest$p.value
}
sim_binom_test(100, 0.6)

## Calculate power 
my_reps <- replicate(1e4, sim_binom_test(100, 0.6))

alpha <- 0.05 # this does not always have to be 0.05

mean(my_reps < alpha)
#Plot
ggplot() + 
  geom_histogram(
    aes(my_reps), 
    binwidth = 0.05, 
    boundary = 0,
    fill = "white", 
    color = "black"
  )

### T-test

sim_norm <- rnorm(100, 0.5, 1)
t.test(sim_norm, mu = 0)

#Run an independent-samples t-test by comparing two lists of values.
a <- rnorm(100, 0.5, 1)
b <- rnorm(100, 0.7, 1)
t_ind <- t.test(a, b, paired = FALSE)
t_ind

## Sampling function 
names(t_ind)
t_ind$statistic

sim_t_ind <- function(n, m1, sd1, m2, sd2) {
  # simulate v1
  v1 <- rnorm(n, m1, sd1)
  
  #simulate v2
  v2 <- rnorm(n, m2, sd2)
  
  # compare using an independent samples t-test
  t_ind <- t.test(v1, v2, paired = FALSE)
  
  # return the p-value
  return(t_ind$p.value)
}

sim_t_ind(100, 0.7, 1, 0.5, 1)

## Calculate power 

my_reps <- replicate(1e4, sim_t_ind(100, 0.7, 1, 0.5, 1))

alpha <- 0.05
power <- mean(my_reps < alpha)
power

power.t.test(n = 100, 
             delta = 0.2, 
             sd = 1, 
             sig.level = alpha, 
             type = "two.sample")

ggplot() + 
  geom_histogram(
    aes(my_reps), 
    binwidth = 0.05, 
    boundary = 0,
    fill = "white", 
    color = "black"
  )

### Correlation 

dat <- rnorm_multi(
  n = 100, 
  vars = 2, 
  r = -0.5,
  varnames = c("x", "y")
)

cor(dat$x, dat$y)

cor(dat$x, dat$y, method = "spearman")

## Sampling function 

sim_cor_test <- function(n = 100, r = 0) {
  dat <- rnorm_multi(
    n = n, 
    vars = 2, 
    r = r,
    varnames = c("x", "y")
  )
  
  ctest <- cor.test(dat$x, dat$y)
  ctest$p.value
}
sim_cor_test(50, .5)

## Calculate power 

my_reps <- replicate(1e4, sim_cor_test(50, 0.5))

alpha <- 0.05
power <- mean(my_reps < alpha)
power

pwr::pwr.r.test(n = 50, r = 0.5)

#### Example ####

# Please go to the Rmd for the example 



