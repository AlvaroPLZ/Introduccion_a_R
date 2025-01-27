#### Title: Lecture 1 - Getting started with R
#### Author: Álvaro Pérez
#### Date: August 27, 2024
#### Last uopdate: January 26, 2025

rm(list=ls()) #delete everything in memory

setwd("/Users/alvaroperezlopez/Desktop/Curso R")
library(stargazer)
library(tidyverse)
library(ggplot2)


#Generate 500 heads and tails
data <- sample(c("Heads","Tails"),500,replace=TRUE)
#Calculate the proportion of heads
mean(data=="Heads")
#This line should give an error - it didn't work!
data <- sample(c("Heads","Tails"),500,replace=BLUE)
#This line should give a warning
#It did SOMETHING but maybe not what you want
mean(data)
#This line won't give an error or a warning
#But it's not what we want!
mean(data=="heads")



#Plot something
data(LifeCycleSavings)
plot(density(LifeCycleSavings$pop75),
     main='Percent of Population over 75')

#Same plot ggplot style
data(LifeCycleSavings)
#in case you dont have the ggplot2 package already you need to install it
#install.packages("ggplot2") 
library(ggplot2)
ggplot(LifeCycleSavings,aes(x=pop75))+
  stat_density(geom='line')+
  ggtitle('Percent of Population over 75')


###Some basic operations
data(mtcars) #load mtcars data
mean(mtcars$mpg) #mean of the variable mpg
mean(mtcars$wt) #mean of the variable wt
372+565 #add two numbers
log(exp(1)) #natural log of e^1
2^9 # 2 to the power of 9
(1+1)^9 #another way to do 2^9

#Creating some objects
a <- 4
b <- sqrt(16)+10
#Printing those objects
a
b
#Printing some objects we create, without storing them
3
a+b

#What does a look like if we take the square root of it?
sqrt(a)
#What does it look like if we add 1 to it?
a + 1
#If we look at it, do we see a number?
is.numeric(a)

#Looked like with 1 added, but a wasn't changed
a
#Let's save a+1 as something else
b <- a + 1
#And let's overwrite a with its square root
a <- sqrt(a)
a
b

#creating a string object
address <- "321 Fake St."
address
is.character(address)

#Creating a logical object and doing some logic manipulations
c <- TRUE
is.logical(c)
is.character(a)
is.logical(is.numeric(a))

#Making some logical comparisons
a > 100
a > 100 | b == 5

#Logic to numeric 
as.numeric(FALSE)
TRUE + 3

#Some logic statements
is.logical(is.numeric(FALSE))
is.numeric(2) + is.character('hello')
is.numeric(2) & is.character(3)
TRUE | FALSE
TRUE & FALSE

#Creating a factor object
e <- as.factor('left-handed')
levels(e) <- c('left-handed','right-handed','ambidextrous')
e

#creating some vectors
d <- c(5,6,7,8)
c(is.numeric(d),is.vector(d))
d[2] #calling the second position of the vector

#Some basic operations with vectors
mean(d)
c(sum(d),sd(d),prod(d))

#more operations to a vector
d + 1
d + d
d > 6

w=c(1,2)

d+w

#More vectors, this time a factor vector
continents <- as.factor(c('Asia','Asia','Asia',
                          'N America','Europe',
                          'Africa','Africa'))
table(continents)
continents[4]

#Checking whether an object is part of a vector
3 %in% c(3,4)
c('Nick','James') %in% c('James','Andy','Sarah')


#More vector manipulations
1:8
rep(4,3)
rep(c('a','b'),4)
numeric(5)
character(6)
sample(1:20,3)
sample(c("Heads","Tails"),6,replace=TRUE)


#Final test
f <- c(2,3,4,5)
f^2
f + c(1,2,3,4)
c(f,6)
is.numeric(f)
mean(f >= 4)
f*c(1,2,3)
length(f)
length(rep(1:4,3))
f/2 == 2 | f < 3
as.character(f)
f[1]+f[4]
c(f,f,f,f)
f[f[1]]
f[c(1,3)]
f %in% (1:4*2)

