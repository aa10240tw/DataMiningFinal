rm(list=ls(all=TRUE));
library(arules);
training <- read.csv("training.csv");
class <- names(summary(training$class));
##total
rules <- apriori(training,parameter = list(sup=0.001,conf=1),appearance = list(rhs = paste0("class=",class),default="lhs"));
rules <- sort(rules,decreasing = TRUE,by="lift");
subset.matrix <- is.subset(rules,rules);
subset.matrix[lower.tri(subset.matrix,diag = T)] <-NA;
redudent <-colSums(subset.matrix,na.rm=T) >= 1;
rules <- rules[!redudent];
inspect(rules);

##group
eachData <- list();
for(i in 1:length(class))
{
  data <- training[which(training$class== class[i]),];
  rules <- apriori(data,parameter = list(sup=0.5,conf=0.5,minlen=2),appearance = list(rhs = paste0("class=",class[i]),default="lhs"));
  rules <- sort(rules,by="support");
  if(length(rules)!=0)
  {
    subset.matrix <- is.subset(rules,rules);
    subset.matrix[lower.tri(subset.matrix,diag = T)] <-NA;
    redudent <-colSums(subset.matrix,na.rm=T) > 1;
    rules <- rules[!redudent];
  }
  eachData <- c(eachData,rules);
  inspect(eachData[[i]]); 
}
