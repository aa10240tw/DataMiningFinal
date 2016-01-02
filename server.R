rm(list=ls(all=TRUE));
library(shinyapps);
library(rsconnect);
library(shiny);
shinyServer(function(input, output){
  predict <- function(){
    object <- c(input$buying,input$maint,input$doors,input$persons,
                input$lug_boot,input$safety);
    totalRules <- read.csv("totalRules.csv",header = TRUE,stringsAsFactors = FALSE);
    transRules <- t(totalRules);
    transRules <- transRules[1:6,];
    predict <- NULL;
    #find corresponding elements in transRules
    object <- as.character(object);
    compare <- as.matrix(sapply(transRules == object,as.integer));
    #compute compare's colsums and totalrule's colsums
    #compare's colsums == totalrule's colsums -> entirely corresponding
    dim(compare) <- c(6,80);
    predictNum <- colSums(compare,na.rm=TRUE);
    originNum <- rowSums(totalRules[,1:6] != T,na.rm=TRUE);
    #fronter rule will be selected earlier
    target <- which(predictNum==originNum)[1];
    predict <- c(predict,totalRules[target,7]);
    if(predict=="unacc"){
      predict <- "unaccaptale";
    }
    else if(predict=="acc"){
      predict <- "accaptale";
    }
    else if(predict=="vgood"){
      predict <- "very good";
    }
      
    return (predict);
  }
  allPredict <- function()
  {
    source("test.R");
    success <- test[-error,]
    return (success);
  }
  output$persontext <- renderText({ 
      outputtxt <- predict();
      c("We predict that:","You think the car is ",outputtxt)
  })
  output$publictext1 <- renderText({ 
    source("test.R");
    c("Correct Rate:",round(correctRate,2));
  })
  output$publictext2 <- renderText({ 
    c("Predict Rule:(increasing order)")
  })
  output$publictable <- renderTable({ 
    source("test.R");
    totalRules
  })
  
})

