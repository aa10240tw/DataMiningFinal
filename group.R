rm(list=ls(all=TRUE));
library(arules);##association library
##read data
origin <- read.csv("car.csv");
##clean data
origin <- as.data.frame(apply(origin,2,as.factor));
summary(origin);