rm(list=ls(all=TRUE));
library(arules);
source("rule.R");
item <- c("buying","maint","doors","persons","lug_boot","safety");

index <- function(var)
{
  indices <- 0;
  for( i in 1:length(var))
  {
    indices <- c(indices,which(var[i]==item));
  }
  return (indices);
}

classify <- function(object)
{
  for( i in 1:length(totalRule))
  {
    var <- totalRule[i]@lhs@itemInfo[totalRule[i]@lhs@data@i+1,]$variables;
    var <- trimws(var);
    lev <- totalRule[i]@lhs@itemInfo[totalRule[i]@lhs@data@i+1,]$levels;
    lev <- trimws(lev);
    judge <- (lev == object[index(var)]);
    if(all(judge))
    {
      return (i);
    }
  }
}
