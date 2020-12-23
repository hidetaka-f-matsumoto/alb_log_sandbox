library(tidyverse)
library(lubridate, warn.conflicts = FALSE)

args <- commandArgs(trailingOnly=TRUE)
data <- read_csv(args[1])
data %>%
  mutate(time_group = round_date(data$time, '5 mins')) %>%
  group_by(time_group) %>%
  summarize(target_count = n_distinct(target)) %>%
  ggplot(mapping = aes(x = time_group, y = target_count)) +
    layer(geom = "bar", stat = "identity", position = "identity") +
    ylim(0, 50)
