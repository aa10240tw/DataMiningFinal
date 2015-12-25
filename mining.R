rm(list=ls(all=TRUE));
library(arules);##association library
library(plyr);#clean data
##read data
origin <- read.csv("carprefs.csv",header = TRUE);
#data need to be factor or logic, and origin must be type data.frame
origin <- as.data.frame(apply(origin,MARGIN = 2,FUN = as.factor));
##association
rules <- apriori(origin,parameter = list(support=0.4,conf=0),control = list());
inspect(rules);