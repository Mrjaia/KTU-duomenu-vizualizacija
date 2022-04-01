library(tidyverse)
data <- read_csv("../data/lab_sodra.csv")

kodas <- 561000
datakodas <- data %>%
  filter(ecoActCode == kodas)

#1 užduotis
datakodas %>%
  ggplot(aes(x = avgWage)) +
  geom_histogram(bins = 50)


#2 užduotis
top5 <- datakodas %>%
  group_by(name, code) %>%
  summarise(wage = max(avgWage)) %>%
  arrange(desc(wage)) %>%
  head(5)

datakodas %>%
  filter(name %in% top5$name) %>%
  ggplot(aes(x = month, y = avgWage, color = name)) +
  geom_line() +
  theme_bw()

#3 užduotis

datakodas %>%
  filter(name %in% top5$name)%>%
  arrange(desc(numInsured)) %>%
  distinct(name, .keep_all = TRUE) %>%
  select(name, numInsured) %>%
  ggplot(aes(x= reorder(name, -numInsured), y=numInsured, group=name)) +
  geom_col(aes(fill = name)) +
  theme_light() +
  labs(x = "name", y = "apdraustieji")





