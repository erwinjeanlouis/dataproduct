library(shiny)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(
    titlePanel("Would you like to play a game..."),
    
    sidebarPanel(
        p("This simple application is designed
      to test your knowledge of petal charateristics of the iris flower. There are four important features (measured in inches) of the petal you need to understand. The petal width, petal length, sepal width and sepal length.
      You can either choose these values yourself or ask the computer to randomly select the values.
      Once you entered the values, you need to guess at the type of petal. Then, press the verify button and the friendy computer (called AI) will tell if you got it right.
      The computer was trained to know the right answer based on a Random Forest machine learning using the iris dataset in R.
      The computer keeps track of right and wrong answers and shows you a pie chart of your progress.
      "),
        a(href = "http://en.wikipedia.org/wiki/Iris_flower_data_set", "For more information, Click Here!"),
        
        plotOutput("distPlot")
    ),
    
    mainPanel(
    wellPanel(
    fluidRow(
        column(4,
               numericInput("sepalLength", label = h3("Sepal Length"), value = 1)),
    
        column(8,
               numericInput("sepalWidth", label = h3("Sepal Width"), value = 2))),
    
    fluidRow(
        column(4,               
            numericInput("petalLength", label = h3("Petal Length"), value = 5)),
        column(8,
            numericInput("petalWidth", label = h3("Petal Width"), value = 4))),
    
    actionButton("resetValues", label = "Random Petal Features")
    ),
    hr(),
    
    # Copy the chunk below to make a group of checkboxes
    radioButtons("petalUserPrediction", label = h3("Please select the species based on the petal features above"), 
                       choices = list("setosa" = 1, "versicolor" = 2, "virginica" = 3),
                       selected = 1),
    
    fluidRow(
        column(4,               
            actionButton("verify", label = "Verify Answer")),
        column(8,
            verbatimTextOutput("userResult")))
    
   
)))
#)