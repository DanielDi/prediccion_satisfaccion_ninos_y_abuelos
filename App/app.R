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
source('modelosAbuelosUI.R')
load("data/modeloSatisfaccion.RData")
load("data/modeloSatisfaccionSalud.RData")

ui <- fluidPage(theme=shinytheme("superhero"),
                navbarPage(title = "Nombre Proyecto",
                           tabPanel("Sobre el proyecto",
                                    h4("Explicación general del problema, motivaciones principales y usos de las predicciones del modelo enfocadas en los objetivos del ICBF")   
                           ),
                           tabModeloAbuelos,
                           tabPanel("Visualizacion",
                                    dashboardPage(title = "HOLA",skin = "red",
                                                  dashboardHeader(),
                                                  dashboardSidebar(),
                                                  dashboardBody()
                                    )

                           )
                           
                ))

server <- function(input, output) {
  # Modelo Salud Abuelos
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

