#### Author: Álvaro Pérez(Based on Romero Londoño's notes)
#### Date: September 24, 2024

library(stargazer)
library(tidyverse)
library(ggplot2)

#set seed so we get the same results
set.seed(6544813)

#generate 501 coin flips
coins <- sample(c("Heads","Tails"),500,replace=T)
mean(coins=='Heads')
#proportion of heads
mean(coins=='Heads')
pdf("Lectures/figures/barplot_coin.pdf")
barplot(prop.table(table(coins)))
dev.off()

#THE GGPLOT2 WAY
#ggplot(as.data.frame(coins),aes(x=coins))+geom_bar()

#Lets do a simulation repeating the process 2000 times
#A blank vector to hold our results
propHeads <- c()

#Let's run this simulation 2000 times
for (i in 1:2000) {
  #Re-create data using the true model
  coinsdraw <- sample(c("Heads","Tails"),500,replace=T)
  #Re-perform our analysis
  result <- mean(coinsdraw=="Heads")
  #And store the result
  propHeads[i] <- result
}

#Let's see what we get on average
stargazer(as.data.frame(propHeads),type='text')

#And let's look at the distribution of our findings
pdf("Lectures/figures/Distribution_coin.pdf")
hist(propHeads,xlab="Proportion Heads",main="Mean of 500 Coin Flips over 2000 Samples",freq=F,breaks=15)
abline(v=mean(propHeads),col='red',lwd=2)
dev.off()
#THE GGPLOT2 WAY
# ggplot(as.data.frame(propHeads),aes(x=propHeads))+stat_density(geom='line')+
#   geom_vline(aes(xintercept=mean(propHeads)),col='red')+
#   xlab("Proportion Heads")+
#   ggtitle("Mean of 501 Coin Flips over 2000 Samples")

#Generating some normal data
normaldata <- rnorm(5)
normaldata

normaldata <- rnorm(2000)
pdf("Lectures/figures/Normal.pdf")
hist(normaldata,xlab="Random Value",main="Random Data from Normal Distribution",probability=TRUE)
dev.off()


#Generating some uniform data

uniformdata <- runif(5)
uniformdata

uniformdata <- runif(2000)
pdf("Lectures/figures/Uniform.pdf")
hist(uniformdata,xlab="Random Value",main="Random Data from Uniform Distribution",probability=TRUE)
dev.off()




#Law of large numbers

## Generate data with 1000 coin flips 
## Pprob of head and tail is the same
data <- sample(c("Heads","Tails"),1000,replace=TRUE) 
## Create random variable (one if heads, zero if tails)
X<-as.numeric(data=="Heads")
# Calculate the proportion of heads of the first n observations
X_n<-cumsum(X)/(1:1000)
#Plot the results
pdf("Lectures/figures/LLN.pdf")
plot(1:1000,X_n,bty="L",ylim=c(0,1),
     ylab="Average",xlab="Tosses",type="l",lwd=2,
     cex.lab=1.5,cex.axis=1.5,cex.main=1.5)
abline(h=0.5,lty=2,col=2,lwd=2)
dev.off()
