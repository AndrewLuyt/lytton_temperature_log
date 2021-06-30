# Plot a line graph of minute-by-minute temperatures in Lytton,
# and a density plot of the minute-to-minute difference in temperature
# on June 29 vs June 28.
# Andrew Luyt
# 29 June 2021

library(tidyverse)
library(lubridate)
library(gridExtra)  # to arrange multiple ggplots in the same window

to_f <- function(c) {
  c * 1.8 + 32
}

# just grab the CSV and convert the UTC time to local
lytton = read_csv("../lytton_log.csv")
lytton$datetime <- as_datetime(lytton$datetime, tz="America/Vancouver")
lytton <- distinct(lytton)

lastrow <- lytton[length(lytton$official_temp),]
maxrow <- lytton[min(which(lytton$official_temp == max(lytton$official_temp))),]

plot1 <- ggplot(data=lytton, aes(x=datetime, y=official_temp)) +
  geom_line() +
  geom_point(data=maxrow, mapping=aes(x=datetime, y=official_temp), col='red', size=3) +
  geom_label(data = maxrow, mapping = aes(x=datetime, y=official_temp),
             label=maxrow$official_temp,
             position=position_nudge(y=1)) +
  # geom_label(data = lastrow, mapping = aes(x=datetime, y=official_temp),
  #            label=lastrow$official_temp,
  #            position=position_nudge(y=1)) +
  scale_x_datetime(timezone = "America/Vancouver") +
  labs(title = 'Temperature in Lytton B.C.', x = 'Local Time', y='Temp (Celsius)')

# how hot is it today vs yesterday, minute-by-minute?  Just join on exact times.
# There are numerous non-matching times so it might be "better" to cut() the
# data into e.g. 5-minute intervals and take a mean for each group...
# but no. Keep it simple.
library(data.table)
lytton$time <- as.ITime(lytton$datetime)
yesterday <- lytton %>% filter(day(datetime) == 28)
today <- lytton %>% filter(day(datetime) == 29)
compared <- inner_join(today, yesterday, by="time")
compared <- compared %>%
  mutate(temp_diff = official_temp.x - official_temp.y) %>%
  distinct()

plot2 <- ggplot(compared, aes(temp_diff)) +
  geom_density(size=1) +
  labs(title = "How much hotter is it today in Lytton, minute-to-minute?",
       x = "Temperature difference",
       subtitle = paste("Median difference:",
                        round(median(compared$temp_diff), 2)))

grid.arrange(plot1,plot2, nrow=2)
