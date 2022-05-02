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
source('visualizacionUI.R')
load("data/modeloSatisfaccion.RData")
load("data/modeloSatisfaccionSalud.RData")
load("data/dfSalud.RData")
load("data/modeloSatisfaccionSeguridad.RData")


ui <- fluidPage(theme=shinytheme("superhero"),
                navbarPage(title = "Nombre Proyecto",
                           tabPanel("Sobre el proyecto",
                                    h4("Explicación general del problema, motivaciones principales y usos de las predicciones del modelo enfocadas en los objetivos del ICBF")   
                           ),
                           tabModeloAbuelos,
                           tabVisualizacion
                           
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
  
  #grafico
  
  output$col <- renderPlot({
    
    
    #colm<-as.numeric(input$var)
    graf<-df_salud[,input$var] %>% table() %>%  barplot(col="purple")
    return(graf)
    
    #colm <- input$var
    #a <- df_salud %>% count(colm)
    #ggplot(a, aes(x=reorder(colm, n), y=n))+
    #geom_col(fill="Purple",alpha=0.4)+
    # coord_flip()+
    #ylab("Cantidad")+
    #xlab("Respuesta")+
    #geom_text(aes(label=n), position = "stack", hjust = -0.1, size=2.5)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

