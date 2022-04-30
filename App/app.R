#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
load("data/modeloSatisfaccion.RData")
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Predicción de la Satisfacción"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("nvSalud",
                  "Satisfacción de Salud",
                  min = 0,
                  max = 10,
                  value = 1),
      sliderInput("nvSeguridad",
                  "Satisfacción de Seguridad",
                  min = 0,
                  max = 10,
                  value = 1),
      sliderInput("nvEducacion",
                  "Satisfacción de Educación",
                  min = 1,
                  max = 9,
                  value = 1),
      sliderInput("condHogar",
                  "Condiciones del Hogar",
                  min = 1,
                  max = 4,
                  value = 1),
      sliderInput("nvEducativo",
                  "Nivel Educativo",
                  min = 1,
                  max = 9,
                  value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("prediccion")
      # plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$prediccion <- renderText({
    entrada <- data.frame(X1=input$nvSalud,
                          X2=input$nvSeguridad,
                          X3=input$nvEducacion,
                          X4=input$condHogar,
                          X5=input$nvEducativo)
    salida <- predict(lm1,newdata = entrada)
    return(salida)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
