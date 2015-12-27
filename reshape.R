rm(list=ls(all=TRUE));
library(arules);##association library
##read data
origin <- read.csv("car.csv");
##clean data
origin <- as.data.frame(apply(origin,2,as.factor));
training <- data.frame();
test <- data.frame();
for(i in 1:length(origin[[1]]))
{
  if(i %% 2==0){
    training <- rbind(training,origin[i,]);
  }else{
    test <- rbind(test,origin[i,]);
  }
}
write.csv(training,"training.csv",row.names = FALSE);
write.csv(test,"test.csv",row.names = FALSE);
