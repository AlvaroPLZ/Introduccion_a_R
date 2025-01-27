# Exercise of dplyr package

#install.packages("dplyr")
library(dplyr)
library(tidyverse)

setwd("/Users/alvaroperezlopez/Desktop/Curso R/DATA")
X1976_2020_president <- read_csv("1976-2020-president.csv")

# Rename database 
US_elections <- X1976_2020_president

head(US_elections)
str(US_elections)

# filter()
elect_1976 <- filter(US_elections, year == 1976 & (party_simplified == "DEMOCRAT" | party_simplified == "REPUBLICAN"))

# select() 
votes_1976 <- select(elect_1976,state | party_simplified | candidatevotes)

# arrange()
arrange(votes_1976,candidatevotes)

# rename() 
votes_1976 <- rename(votes_1976,"party"=party_simplified)

# mutate()
elect_1976 <- elect_1976 %>%
  mutate(per_votes = candidatevotes/totalvotes)

# group_by()
votes_1976_party <- votes_1976 %>%
  group_by(party) %>%
  summarise(sum_votes=sum(candidatevotes,na.rm = T))

