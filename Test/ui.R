#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for app that predicts a players home runs given AB, R, H, BB, 2B and 3B
shinyUI(pageWithSidebar(  
    headerPanel("Predict Home Runs!"),  
    sidebarPanel(
        h4('Enter the following batting stats to predict a players home runs for a season'),
        numericInput('AB', 'At bats (AB)', 300, min=300, max=700, ),
        numericInput('R', 'Runs scored (R)',20, min=20, max=155),
        numericInput('H', 'Hits (H)', 50, min=50, max=300),
        numericInput('BB', 'Walks (BB)', 10, min=7, max=230),
        numericInput('RBI', 'Runs batted in (RBI)', 10, min=10, max=160),
        numericInput('X2B', 'Doubles (2B)',5, min=5, max=60),
        numericInput('X3B', 'Triples (3B)',0, min=0, max=25),
        submitButton('Submit')
    ),
    mainPanel(    
        h3('Results of prediction'),
        h4('You entered'),
       verbatimTextOutput("inputValue"),
        h4('Which resulted in a prediction of '),
        verbatimTextOutput("prediction"),
        h4('The prediction is based upon a linear model using data from the Lahman dataset'),
        h4('http://www.seanlahman.com/baseball-archive/statistics/')
       
    )
))