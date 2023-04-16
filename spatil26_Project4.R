library(tidyverse)
library(ggplot2)

setwd("E:/George Mason/AIT580/Project4Final")
data <- read.csv("USMAP2014.csv")


data$year_month <- paste(data$YEAR, data$MONTH, '01', sep="/")
data

data$year_month <- as.Date(data$year_month, format = "%Y/%m/%d")
data

ym_passengers <- aggregate(Sum_PASSENGERS ~ year_month, data, sum)


ym_passengers = subset(ym_passengers, year_month >= as.Date("2020-04-01") )


ym_passengers

model <- lm(Sum_PASSENGERS ~ year_month, data=ym_passengers)

summary(model)


#par(mfrow=c(2,2))
#plot(model)


ggplot(aes(x=year_month, y=Sum_PASSENGERS), data=ym_passengers) +
  geom_point() + geom_smooth(se=TRUE,method="loess")


months_list = seq(as.Date("2020-08-01"), as.Date("2021-04-01"), by="months")

df <- data.frame(year_month = c(months_list) )
df

preds <- predict(model, df); preds
 


plot2 = data.frame(months_list, preds); plot2

ggplot(aes(x=months_list, y=preds), data=plot2) +
  geom_point() + geom_smooth(se=TRUE,method="loess")


all_data <- data.frame( c(months_list, ym_passengers$year_month ), c(preds, ym_passengers$Sum_PASSENGERS)); all_data

colnames(all_data)
names(all_data)[names(all_data) == "c.months_list..ym_passengers.year_month."] <- "months_list"
names(all_data)[names(all_data) == "c.preds..ym_passengers.Sum_PASSENGERS."] <- "preds"

ggplot(aes(x=months_list, y=log(preds)), data=all_data) +
  geom_line(linetype = "dashed")+
  geom_point() + geom_smooth(se=TRUE,method="loess",linetype = "dashed") + 
  labs(x='Months', y = 'Predictions',title = 'Predicting the Recovery of Airlines')

