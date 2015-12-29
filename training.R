rm(list=ls(all=TRUE));
library(arules);
training <- read.csv("training.csv");
class <- names(summary(training$class));
##association rules
rules <- apriori(training,
                 parameter = list(sup=0.017,conf=0.7,minlen=2),
                 appearance = list(rhs = paste0("class=",class),
                                   default="lhs"));
rules <- sort(rules,decreasing = TRUE,by="conf");
##remove redudent rule
subset.matrix <- is.subset(rules,rules);
subset.matrix[lower.tri(subset.matrix,diag = TRUE)] <-NA;
redundent <-colSums(subset.matrix,na.rm=TRUE) >= 1;
rules <- rules[!redundent];
capture.output(inspect(rules),file="output.txt");