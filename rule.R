rm(list=ls(all=TRUE));
library(arules);
data <- read.csv("training.csv");
rule <- function(sup,conf)
{
  class <- names(summary(data$class));
  ##association rules
  class <- names(summary(data$class));
  rules <- apriori(data,
                   parameter = list(sup=sup,conf=conf,minlen=2),
                   appearance = list(default="lhs",
                                     rhs=paste0("class=",class)));
  rules <- sort(rules,decreasing = TRUE,by="sup");
  ##remove redudent rule
  if(length(rules)==0)
    return (NA);
  subset.matrix <- is.subset(rules,rules);
  subset.matrix[lower.tri(subset.matrix,diag = TRUE)] <-NA;
  redundent <-colSums(subset.matrix,na.rm=TRUE) >= 1;
  rules <- rules[!redundent];
  
  ##support = showtimes
  strongRule <- NULL;
  interRule <- list();
  for( i in 1:length(rules))
  {
    arule <- rules@lhs@itemInfo[rules[i]@lhs@data@i+1,];
    var <- as.character(arule$variables);
    lev <- as.character(arule$levels);
    num <- list();
    #record index of data which is correspond to arule's lhs 
    for( j in 1:length(var))
    {
      index <- which(data[[var[j]]]==lev[j]);
      num[[j]] <- index;
    }
    #index intersect(because lhs may over 1 and lhs's item is intersetion)
    inter <- num[[1]];
    for(k in 1:length(num)-1)
    {
      inter <- intersect(inter,num[[k+1]]);
    }
    times <- length(inter)/length(data[[1]]);
    # if (support = nums of lhs / nums of data) strongRule++;
    if(rules[i]@quality$support == times)
    {
      strongRule <- append(strongRule,i);
    }
    interRule[[i]] <- inter;
  }
  #union all rule index
  uni <- interRule[[1]];
  for( i in 1:length(interRule)-1)
  {
    uni <- union(uni,interRule[[i+1]]);
  }
  product <- list(rules,uni);
  return (product);
}