### Title: Lab 05: Data Wrangling
### Author: Álvaro Pérez 
### Date: February 24, 2025

library(dplyr)
library(tidyverse)
disgust <- read.csv("https://psyteachr.github.io/msc-data-skills/data/disgust.csv")

#### Main dplyr verbs ####

### select () ###

moral <- disgust %>% select(user_id, moral1:moral7)
names(moral)

sexual <- disgust %>% select(2, 11:17)
names(sexual)

pathogen <- disgust %>% select(-id, -date, -(moral1:sexual7))
names(pathogen)

# Select helpers

u <- disgust %>% select(starts_with("u"))
names(u)

firstq <- disgust %>% select(ends_with("1"))
names(firstq)

pathogen <- disgust %>% select(contains("pathogen"))
names(pathogen)

moral2_4 <- disgust %>% select(num_range("moral", 2:4))
names(moral2_4)

### filter () ###

disgust %>% filter(user_id == 1)

amoral <- disgust %>% filter(
  moral1 == 0, 
  moral2 == 0,
  moral3 == 0, 
  moral4 == 0,
  moral5 == 0,
  moral6 == 0,
  moral7 == 0
)

# everyone who chose either 0 or 7 for question moral1
moral_extremes <- disgust %>% 
  filter(moral1 == 0 | moral1 == 7)

# everyone who chose the same answer for all moral questions
moral_consistent <- disgust %>% 
  filter(
    moral2 == moral1 & 
      moral3 == moral1 & 
      moral4 == moral1 &
      moral5 == moral1 &
      moral6 == moral1 &
      moral7 == moral1
  )

# everyone who did not answer 7 for all 7 moral questions
moral_no_ceiling <- disgust %>%
  filter(moral1+moral2+moral3+moral4+moral5+moral6+moral7 != 7*7)

# Match operator 

no_researchers <- disgust %>%
  filter(!(user_id %in% c(1,2)))

# Dates 
#lubridate

disgust2010 <- disgust %>%
  filter(year(date) == 2010)

### arrange () ###

disgust_order <- disgust %>%
  arrange(date, moral1)

# Reverse the order 

disgust_order_desc <- disgust %>%
  arrange(desc(date))

### mutate() ###

disgust_total <- disgust %>%
  mutate(
    pathogen = pathogen1 + pathogen2 + pathogen3 + pathogen4 + pathogen5 + pathogen6 + pathogen7,
    moral = moral1 + moral2 + moral3 + moral4 + moral5 + moral6 + moral7,
    sexual = sexual1 + sexual2 + sexual3 + sexual4 + sexual5 + sexual6 + sexual7,
    total = pathogen + moral + sexual,
    user_id = paste0("U", user_id)
  )

### summarise () ###

disgust_summary<- disgust_total %>%
  summarise(
    n = n(),
    q25 = quantile(total, .25, na.rm = TRUE),
    q50 = quantile(total, .50, na.rm = TRUE),
    q75 = quantile(total, .75, na.rm = TRUE),
    avg_total = mean(total, na.rm = TRUE),
    sd_total  = sd(total, na.rm = TRUE),
    min_total = min(total, na.rm = TRUE),
    max_total = max(total, na.rm = TRUE)
  )

### group_by () ###

disgust_groups <- disgust_total %>%
  mutate(year = year(date)) %>%
  group_by(year) %>%
  summarise(
    n = n(),
    avg_total = mean(total, na.rm = TRUE),
    sd_total  = sd(total, na.rm = TRUE),
    min_total = min(total, na.rm = TRUE),
    max_total = max(total, na.rm = TRUE),
    .groups = "drop"
  )

#### Additional dplyr one-table verbs ####

### rename () ###

sw <- starwars %>%
  rename(Name = name,
         Height = height,
         Mass = mass,
         `Hair Colour` = hair_color,
         `Skin Colour` = skin_color,
         `Eye Colour` = eye_color,
         `Birth Year` = birth_year)

names(sw)

### distinct () ###

# create a data table with duplicated values
dupes <- tibble(
  id = c( 1,   2,   1,   2,   1,   2),
  dv = c("A", "B", "C", "D", "A", "B")
)

distinct(dupes)

### count () ###

starwars %>%
  group_by(sex) %>%
  summarise(n = n(), .groups = "drop")

count(starwars, sex)

#### Window functions ####

### Offset functions ###

lag_lead <- tibble(x = 1:6) %>%
  mutate(lag = lag(x),
         lag2 = lag(x, n = 2),
         lead = lead(x, default = 0))

### Cumulative aggregates ###

cumulative <- tibble(
  time = 1:10,
  obs = c(2, 2, 1, 2, 4, 3, 1, 0, 3, 5)) %>%
  mutate(
    cumsum = cumsum(obs),
    cummin = cummin(obs),
    cummax = cummax(obs),
    cumany = cumany(obs == 3),
    cumall = cumall(obs < 4)
  )



