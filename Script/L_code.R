
#### Author: Álvaro Pérez (Based on Romero Londoño notes)
#### Date: September 17, 2024

library(stargazer)
library(tidyverse)
library(ggplot2)

#For loop practice
data(mtcars)
abovemed <- mtcars %>% filter(cyl >= median(cyl))
belowmed <- mtcars %>% filter(cyl < median(cyl))
for (i in c('mpg','disp','hp','wt')) {
  print(mean(abovemed[[i]])-mean(belowmed[[i]]))
}


#For loop practice 2
data(mtcars)
unique(mtcars$cyl)
for (c in unique(mtcars$cyl)) {
  print(median(filter(mtcars,cyl==c)$mpg))
}


for (c in unique(mtcars$cyl)) {
  print(paste0(c("The median mpg for cyl = ",c,
                 " is ",median(filter(mtcars,cyl==c)$mpg)),
               collapse=''))
}



############################################# 
####### next  ################
############################################# 
#printing only odd numbers
m=20
for (k in 1:m){
  if (!k %% 2){ #checks if number is odd
    next
  }
  print(k)
}

############################################# 
####### break  ################
############################################# 
# finding the first number divisible by 13 greater than 100

for (k in 100:100000){
  if (!k %% 13){ #checks if number is odd
    break
  }
}
print(k)

############################################# 
####### IF STATEMENTS ################
############################################# 
#Identifying prime number
for(num in 1:100){
  # Program to check if the input number is prime or not
  flag = 0
  # prime numbers are greater than 1
  if(num > 1) {
    # check for factors
    flag = 1
    for(i in 2:(num-1)) {
      if ((num %% i) == 0) { 
        flag = 0 #if number is divisible, then not prime
        break #and we can break the loop
      }
    }
  } 
  if(num == 2)    flag = 1
  if(flag == 1) {
    print(paste(num,"is a prime number"))
  } else {
    print(paste(num,"is not a prime number"))
  }
}

############################################# 
####### function ################
############################################# 
#Identifying prime number
prime_num<-function(num){
  # Program to check if the input number is prime or not
  flag = 0
  # prime numbers are greater than 1
  if(num > 1) {
    # check for factors
    flag = 1
    for(i in 2:(num-1)) {
      if ((num %% i) == 0) { 
        flag = 0 #if number is divisible, then not prime
        break #and we can break the loop
      }
    }
  } 
  if(num == 2)    flag = 1
  return(flag)
}
prime_num(2)
prime_num(3)
prime_num(4)
prime_num(6131)
prime_num(4684561123)

############################################# 
####### multiple things    ################
############################################# 
## function to get x raised to the power y 
pow <- function(x, y = 2) { 
  result1 <- x^y
  return(result1)
}
pow(3)
pow(3,3)
############################################# 
############## VISAUALIZATION ###############
#############################################


EnrollmentGradeAge=read.csv("http://mauricio-romero.com/data/class/EnrollmentGradeAge.csv")
pdf("Lectures/figures/Step1.pdf")
barplot(t(EnrollmentGradeAge[,2:6]))
dev.off()
pdf("Lectures/figures/Step2.pdf")
barplot(t(EnrollmentGradeAge[,2:6]),names.arg=EnrollmentGradeAge[,1])
dev.off()
pdf("Lectures/figures/Step3.pdf")
barplot(t(EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1])
dev.off()
pdf("Lectures/figures/Step4.pdf")
barplot(t(100*EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1])
dev.off()
pdf("Lectures/figures/Step5.pdf")
barplot(t(100*EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1],
        col=c("#FAA43A","#5DA5DA","#4D4D4D","#F15854","#60BD68"))
dev.off()
pdf("Lectures/figures/Step6.pdf")
barplot(t(100*EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1],
        col=c("#FAA43A","#5DA5DA","#4D4D4D","#F15854","#60BD68"),
        ylim=c(0,100))
dev.off()
pdf("Lectures/figures/Step7.pdf")
barplot(t(100*EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1],
        col=c("#FAA43A","#5DA5DA","#4D4D4D","#F15854","#60BD68"),
        ylim=c(0,100), cex.lab=1.5,cex.axis=1.5,xlab="Age",ylab="% enrollment")
dev.off()
pdf("Lectures/figures/Step8.pdf")
barplot(t(100*EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1],
        col=c("#FAA43A","#5DA5DA","#4D4D4D","#F15854","#60BD68"),
        ylim=c(0,100), cex.lab=1.5,cex.axis=1.5,xlab="Age",ylab="% enrollment",
        legend.text=c("Early childhood education","Primary","Middle","Secondary","University"),
        args.legend = list(ncol=2,x = "topleft",cex=0.8),
        main="Enrollment by age")
dev.off()
pdf("Lectures/figures/Step9.pdf")
barplot(t(100*EnrollmentGradeAge[1:14,2:6]),names.arg=EnrollmentGradeAge[1:14,1],
        col=c("#FAA43A","#5DA5DA","#4D4D4D","#F15854","#60BD68"),
        ylim=c(0,100), cex.lab=1.5,cex.axis=1.5,xlab="Age",ylab="% enrollment",
        legend.text=c("Early childhood education","Primary","Middle","Secondary","University"),
        args.legend = list(ncol=2,x = "topleft", bty = "n",cex=1.3),
        main="Enrollment by age",axes=F)
axis(side=2,las=1,cex.axis=1.5,lwd=1,cex.lab=1.5)
dev.off()

