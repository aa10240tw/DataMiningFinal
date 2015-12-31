rm(list=ls(all=TRUE));
source("class.R");
test <- read.csv("test.csv");
num <- 0;
for(i in 1:length(test[[1]]))
{
  object <- test[i,][1:6];
  ruleNum <- classify(object);
  predict <- totalRule[ruleNum]@rhs@itemInfo[totalRule[ruleNum]@rhs@data@i+1,]$level;
  predict <- trimws(predict);
  if(predict == test[i,][7])
  {
    num=num+1;
  }
}
num