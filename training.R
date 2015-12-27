rm(list=ls(all=TRUE));
training <- read.csv("training.csv");
rules <- apriori(training,parameter = list(sup=0.3,conf=0.7));
inspect(rules)