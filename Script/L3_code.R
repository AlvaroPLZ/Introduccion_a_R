#### Author: Álvaro Pérez
#### Date: February 9, 2025

#### 1. Setup ####

install.packages("dataskills")
library(dataskills)
install.packages("plotly")
library(plotly)
install.packages("cowplot")
library(cowplot)
library(ggplot2)
library(tidyverse)

pets <- read_csv("https://psyteachr.github.io/msc-data-skills/data/pets.csv", col_types = "cffiid")
data("pets")

#### 2. Basic Plots ####

plot(x = pets$pet)

plot(x = pets$pet, y = pets$score)

plot(x = pets$age, y = pets$weight)

hist(pets$score, breaks = 20)

#### 3. GGplots ####

ggplot()

mapping <- aes(x = pet, 
               y = score, 
               colour = country, 
               fill = country)
ggplot(data = pets, mapping = mapping)

ggplot(pets, aes(pet, score, colour = country, fill = country)) +
  geom_violin(alpha = 0.5) +
  labs(x = "Pet type",
       y = "Score on an Important Test",
       colour = "Country of Origin",
       fill = "Country of Origin",
       title = "My first plot") +
  theme_bw(base_size = 15)

#### 4. Common Plot Types ####

# Bar plot
ggplot(pets, aes(pet)) +
  geom_bar()

# Density plot
ggplot(pets, aes(score)) +
  geom_density()

ggplot(pets, aes(score, fill = pet)) +
  geom_density(alpha = 0.5)

#Frequency polygons
ggplot(pets, aes(score, color = pet)) +
  geom_freqpoly(binwidth = 5)

#Histogram
ggplot(pets, aes(score)) +
  geom_histogram(binwidth = 5, fill = "white", color = "black")

ggplot(pets, aes(score, fill=pet)) +
  geom_histogram(binwidth = 5, alpha = 0.5, 
                 position = "dodge")

#Boxplot
ggplot(pets, aes(pet, score, fill=pet)) +
  geom_boxplot(alpha = 0.5)

#Violinplot
ggplot(pets, aes(pet, score, fill=pet)) +
  geom_violin(draw_quantiles = .5,
              trim = FALSE, alpha = 0.5,)

#Scatter plot
ggplot(pets, aes(age, score, color = pet)) +
  geom_point()

#Line graph
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm")

#### 5. Custommisation ####

# Labels 
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm") +
  labs(title = "Pet score with Age",
       x = "Age (in Years)",
       y = "score Score",
       color = "Pet Type")

ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm") +
  ggtitle("Pet score with Age") +
  xlab("Age (in Years)") +
  ylab("score Score") +
  scale_color_discrete(name = "Pet Type")

#Colours
ggplot(pets, aes(pet, score, colour = pet, fill = pet)) +
  geom_violin() +
  scale_color_manual(values = c("darkgreen", "dodgerblue", "orange")) +
  scale_fill_manual(values = c("#CCFFCC", "#BBDDFF", "#FFCC66"))

#Themes 
ggplot(pets, aes(age, score, color = pet)) +
  geom_smooth(formula = y ~ x, method="lm") +
  theme_minimal(base_size = 18)

# Save as file 
box <- ggplot(pets, aes(pet, score, fill=pet)) +
  geom_boxplot(alpha = 0.5)

violin <- ggplot(pets, aes(pet, score, fill=pet)) +
  geom_violin(alpha = 0.5)

ggsave("demog_violin_plot.png", width = 5, height = 7)

ggsave("demog_box_plot.jpg", plot = box, width = 5, height = 7)

#### 6. Combination Plots ####

#Violinbox plot
ggplot(pets, aes(pet, score, fill = pet)) +
  geom_violin(show.legend = FALSE) + 
  geom_boxplot(width = 0.2, fill = "white", 
               show.legend = FALSE)

#Violin-point-range plot
ggplot(pets, aes(pet, score, fill=pet)) +
  geom_violin(trim = FALSE, alpha = 0.5) +
  stat_summary(
    fun = mean,
    fun.max = function(x) {mean(x) + sd(x)},
    fun.min = function(x) {mean(x) - sd(x)},
    geom="pointrange"
  )

#Violin-jitter plot
# sample_n chooses 50 random observations from the dataset
ggplot(sample_n(pets, 50), aes(pet, score, fill=pet)) +
  geom_violin(
    trim = FALSE,
    draw_quantiles = c(0.25, 0.5, 0.75), 
    alpha = 0.5
  ) + 
  geom_jitter(
    width = 0.15, # points spread out over 15% of available width
    height = 0, # do not move position on the y-axis
    alpha = 0.5, 
    size = 3
  )

#Scatter-line graph
ggplot(sample_n(pets, 50), aes(age, weight, colour = pet)) +
  geom_point() +
  geom_smooth(formula = y ~ x, method="lm")

#Grid of plots 
gg <- ggplot(pets, aes(pet, score, colour = pet))
nolegend <- theme(legend.position = "none")

vp <- gg + geom_violin(alpha = 0.5) + nolegend + ggtitle("Violin Plot")
bp <- gg + geom_boxplot(alpha = 0.5) + nolegend + ggtitle("Box Plot")
cp <- gg + stat_summary(fun = mean, geom = "col", fill = "white") + nolegend + ggtitle("Column Plot")
dp <- ggplot(pets, aes(score, colour = pet)) + geom_density() + nolegend + ggtitle("Density Plot")

plot_grid(vp, bp, cp, dp, labels = LETTERS[1:4])

#### 7.Overlapping Discrete Data ####

#Reducing Opacity
ggplot(pets, aes(age, score, colour = pet)) +
  geom_point(alpha = 0.25) +
  geom_smooth(formula = y ~ x, method="lm")

#Proportional Dot Plots
ggplot(pets, aes(age, score, colour = pet)) +
  geom_count()

pets %>%
  group_by(age, score) %>%
  summarise(count = n(), .groups = "drop") %>%
  ggplot(aes(age, score, color=count)) +
  geom_point(size = 2) +
  scale_color_viridis_c()

#### 8.Overlapping Cotinuous Data ####

#2D Density Plot 
ggplot(pets, aes(age, score)) +
  geom_density2d()

ggplot(pets, aes(age, score)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon") +
  scale_fill_viridis_c()

#2D Histogram 
ggplot(pets, aes(age, score)) +
  geom_bin2d(binwidth = c(1, 5))

#Hexagonal Heatmap
ggplot(pets, aes(age, score)) +
  geom_hex(binwidth = c(1, 5))

#Correlation Heatmap
heatmap <- pets %>%
  select_if(is.numeric) %>% # get just the numeric columns
  cor() %>% # create the correlation matrix
  as_tibble(rownames = "V1") %>% # make it a tibble
  gather("V2", "r", 2:ncol(.)) # wide to long (V2)

ggplot(heatmap, aes(V1, V2, fill=r)) +
  geom_tile() +
  scale_fill_viridis_c()

#### 9. Interactive Plots ####

demog_plot <- ggplot(pets, aes(age, score, fill=pet)) +
  geom_point() +
  geom_smooth(formula = y~x, method = lm)

ggplotly(demog_plot)


