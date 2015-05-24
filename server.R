library(shiny)

initializePredictor <- function()
{
    library(caret)
    library(randomForest)
    
    library (datasets)
    library ( e1071 )
    
    set.seed(3433)
    
    data ( iris )
    inTrain <- createDataPartition(iris$Species, p = 3/4)[[1]]
    training <- iris[ inTrain,]
    testing <- iris[-inTrain,]
    fitRf <- train(Species~., training, method="rf")
    return( fitRf)
}

pieLabel <- function (a, b)
{
    x <- paste(a, "(")
    x <- paste(x, as.character (b))
    x <- paste (x, ")")
    return ( x )
}

mlPredictor <- initializePredictor()
correctAnswers <- 0
incorrectAnswers <- 0
# Define server logic required to generate and plot a random distribution

shinyServer(function(input, output, clientData, session) {
    
    observe({
        if (input$resetValues == 0)
            return()
        isolate({
        updateNumericInput(session, "sepalLength", value = runif(1, 0.0, 10.0))            
        updateNumericInput(session, "sepalWidth", value = runif(1, 0.0, 10.0))            
        updateNumericInput(session, "petalLength", value = runif(1, 0.0, 10.0))            
        updateNumericInput(session, "petalWidth", value = runif(1, 0.0, 10.0))            
                
    })
    
    })
    
    
    observe({
        if (input$verify == 0)
            return()
        isolate({
            Sepal.Length <- input$sepalLength
            Sepal.Width <- input$sepalWidth
            Petal.Length <- input$petalLength
            Petal.Width <- input$petalWidth
            userData <- data.frame(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width )
            predictedresult <- as.character(predict( mlPredictor, userData )[[1]])
            #userResult <- as.character(result[[1]])
            petalUserPrediction <- 
                if ( input$petalUserPrediction == 1 ) "setosa"
                else if ( input$petalUserPrediction == 2) "versicolor"
                else "virginica"
            
            
            result <- paste(predictedresult, petalUserPrediction)
            if (predictedresult == petalUserPrediction)
            {
                correctAnswers <<- correctAnswers + 1
                output$userResult <- renderPrint({ "Great Job!!!" })
            }
            else
            {
                incorrectAnswers <<- incorrectAnswers + 1
                output$userResult <- renderPrint({"Your choice was incorrect. Please try again!!!"})
            }
            
            if (correctAnswers + incorrectAnswers > 0)
            {
                output$numberOfGames <-  renderPrint({ correctAnswers + incorrectAnswers })
                output$distPlot <- renderPlot({        
                    slices <- c(correctAnswers, incorrectAnswers)
                    lbls <- c(pieLabel("Correct", correctAnswers),
                          pieLabel("Incorrect", incorrectAnswers))
                    pie(slices, labels = lbls, main="Key Performance Indicator")
                })
            }
            
        })
        
    })    

    
})

