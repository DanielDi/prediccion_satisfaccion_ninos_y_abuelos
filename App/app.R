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
library(shinydashboard)
library(shinythemes)
load("data/modeloSatisfaccion.RData")
load("data/modeloSatisfaccionSalud.RData")
# Define UI for application that draws a histogram

ui <- fluidPage(theme=shinytheme("superhero"),
                navbarPage(title = "Nombre Proyecto",
                           tabPanel("Que es  el Proyecto",
                                    h4("Explicacion general del problema, motivaciones principales y usos de las predicciones del modelo enfocadas en los objetivos del ICBF")   
                           ),
                           tabPanel( "Modelo",
                                     fluidPage(
                                       
                                       # Application title
                                       titlePanel("Predicción de la Satisfacción"),
                                       
                                       # Sidebar with a slider input for number of bins 
                                       sidebarLayout(
                                         sidebarPanel(
                                           selectInput("pagoEps", "Quien paga la afiliacion", label="¿Quién paga la afiliación?",
                                                       choices = list("Paga una parte y la otra la empresa"=1,
                                                                      "Le descuentan la pension"=2,
                                                                      "Paga la totalidad de la afiliacion"=3,
                                                                      "Paga completamente la empresa"=4,
                                                                      "No paga, es beneficiario "=5)),
                                           selectInput("calidadEps", label="¿Cómo considera la calidad del prestador de salud?",
                                                       choices = list("Muy buena"=1,
                                                                      "Buena"=2,
                                                                      "Mala"=3,
                                                                      "Muy mala"=4)),
                                           
                                           selectInput("estadoSalud", label="¿Cuál es el estado de salud general?",
                                                       choices = list("Muy bueno"=1,
                                                                      "Bueno"=2,
                                                                      "Regular"=3,
                                                                      "Malo"=4)),
                                           
                                           selectInput("estrato", 
                                                       label="Estrato para la tarifa de servicios de la vivienda",
                                                       choices = list("1. Bajo - Bajo"=1,
                                                                      "2. Bajo"=2,
                                                                      "3. Medio - Bajo"=3,
                                                                      "4. Medio"=4,
                                                                      "5. Medio - Alto"=5,
                                                                      "6. Alto"=6,
                                                                      "8. Planta eléctrica"=8,
                                                                      "0. No cuenta con servicios"=0)),
                                           
                                           sliderInput("estrato",
                                                       "Estrato para la tarifa de servicios de la vivienda",
                                                       min = 0,
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
                           ),
                           tabPanel("Visualizacion",
                                    dashboardPage(title = "HOLA",skin = "red",
                                                  dashboardHeader(),
                                                  dashboardSidebar(),
                                                  dashboardBody()
                                    )

                           )
                           
                ))

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Modelo Salud
  output$prediccionSalud <- renderText({
    entrada <- data.frame()
  })
  
  # Modelo General
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

