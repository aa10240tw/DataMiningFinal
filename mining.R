rm(list=ls(all=TRUE));
library(arules);##association library
library(plyr);#clean data
##read data
origin <- read.csv("carprefs.csv",header = TRUE);
##data cleaning
