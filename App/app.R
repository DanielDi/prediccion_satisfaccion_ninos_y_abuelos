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
                                           h3("Satisfacción estimada de la salud: "),
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
                                           selectInput("regimen", 
                                                       label="Régimen de seguridad social ",
                                                       choices = list("1. Contributivo (eps)"=1,
                                                                      "2. Especial (Fuerzas armadas, ecopetrol, universidades públicas, magisterio"=2,
                                                                      "3. Subsidiado"=3)),
                                           selectInput("enfermedadCronica", 
                                                       label="¿Le han diagnosticado alguna enfermedad crónica?",
                                                       choices = list("Si"=1,
                                                                      "No"=2)),
                                           h4("Satisfacción estimada de la salud: "),
                                           h4(textOutput("prediccionSalud"))
                                           # sliderInput("condHogar",
                                           #             "Condiciones del Hogar",
                                           #             min = 1,
                                           #             max = 4,
                                           #             value = 1),
                                           # sliderInput("nvEducativo",
                                           #             "Nivel Educativo",
                                           #             min = 1,
                                           #             max = 9,
                                           #             value = 1)
                                         ),
                                         
                                         
                                         # Show a plot of the generated distribution
                                         mainPanel(
                                           # p("Satisfacción estimada de la salud: "),
                                           # textOutput("prediccionSalud")
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
    entrada <- data.frame(CALIDAD_EPS=as.integer(input$calidadEps),
                          ESTADO_SALUD=as.integer(input$estadoSalud),
                          ESTRATO=as.integer(input$estrato),
                          REGIMEN=as.numeric(input$regimen),
                          ENFERMEDAD_CRONICA=as.integer(input$enfermedadCronica))
    salida <- predict(lm_salud, newdata = entrada)
    
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

