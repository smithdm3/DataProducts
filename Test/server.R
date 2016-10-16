#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(UsingR)

require(Lahman)
require(dplyr)

set.seed(4589)

begYear <- 2000
minAtBats <- 300
data(Batting)
dataToUse <- filter(Batting, yearID>=begYear, AB>=minAtBats)
inTrain <- sample(seq_len(nrow(dataToUse)),size=floor(0.5*nrow(dataToUse)))
training <- dataToUse[inTrain,]
testing <- dataToUse[-inTrain,]

modelHR <- glm(HR~AB+R+H+BB+RBI+X2B+X3B-1,data=training)

shinyServer(  
    function(input, output) {
      
        inputData <- reactive({list("AB"=input$AB, "R"=input$R, "H"=input$H, "BB"=input$BB, "RBI"=input$RBI, "X2B"=input$X2B, "X3B"=input$X3B)})
        inputString <- reactive({paste("AB:",input$AB," R:",input$R, " H:",input$H, " BB:",input$BB, " RBI:",input$RBI," 2B:",input$X2B, " 3B:",input$X3B)})
        output$inputValue <- renderText({inputString()})
        output$prediction <- renderPrint(unname(round(predict(modelHR, {inputData()}),digits=0)))
    }
)