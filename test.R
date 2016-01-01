## Test
rm(list=ls(all=TRUE));
## Read totalRules & test data
test <- read.csv("test.csv",stringsAsFactors = FALSE);

## Classify
totalRules <- read.csv("totalRules.csv",header = TRUE,stringsAsFactors = FALSE);
transRules <- t(totalRules);
transRules <- transRules[1:6,];
predict <- NULL;
for(i in 1:length(test[[1]]))
{
  #find corresponding elements in transRules
  object <- as.character(test[i,c(1:6)]);
  compare <- as.matrix(sapply(transRules == object,as.integer));
  #compute compare's colsums and totalrule's colsums
  #compare's colsums == totalrule's colsums -> entirely corresponding
  dim(compare) <- c(6,80);
  predictNum <- colSums(compare,na.rm=TRUE);
  originNum <- rowSums(totalRules[,1:6] != T,na.rm=TRUE);
  #fronter rule will be selected earlier
  target <- which(predictNum==originNum)[1];
  predict <- c(predict,totalRules[target,7]);
}
error <- which(predict != test$class);
errorNum <- length(error);
errorRate <- errorNum / length(test$buying);
correctRate <- 1 - errorRate;
