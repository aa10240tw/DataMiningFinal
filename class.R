rm(list=ls(all=TRUE));
library(arules);
source("rule.R");
item <- c("buying","maint","doors","persons","lug_boot","safety");
totalRules <- matrix(ncol = 7,nrow = length(totalRule));
names(totalRules) <- c(item,"class");

##build rule model
for( i in 1:length(totalRule))
{
  var <- totalRule[i]@lhs@itemInfo[totalRule[i]@lhs@data@i+1,]$variables;
  var <- trimws(var);
  lev <- totalRule[i]@lhs@itemInfo[totalRule[i]@lhs@data@i+1,]$levels;
  lev <- trimws(lev);
  class <- totalRule[i]@rhs@itemInfo[totalRule[i]@rhs@data@i+1,]$levels;
  class <- trimws(class);
  totalRules[i,c(match(var, item),7)] <- c(lev,class);
}

##Output totalRule
write.csv(totalRules,"totalRules.csv",row.names = FALSE);
