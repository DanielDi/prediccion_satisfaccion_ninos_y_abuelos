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
load("data/modeloSatisfaccionSeguridad.RData")
load("data/dfSalud.RData")

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
  resultadoSalud <- reactive({
    entradaSalud <- data.frame(CALIDAD_EPS=as.integer(input$calidadEps),
                          ESTADO_SALUD=as.integer(input$estadoSalud),
                          ESTRATO=as.integer(input$estrato),
                          REGIMEN=as.integer(input$regimen),
                          ENFERMEDAD_CRONICA=as.integer(input$enfermedadCronica))
    salidaSalud <- predict(lm_salud, newdata = entradaSalud)
    return(salidaSalud)
  })
  
  output$prediccionSalud <- renderText({
    salida <- resultadoSalud()
  })
  
  # Modelo Seguridad Abuelos
  
  resultadoSeguridad <- reactive({
    entrada <- data.frame(ESTADO_CIVIL=as.integer(input$estadoCivil),
                          NIVEL_DE_SEGURIDAD=as.integer(input$nvSeguridad),
                          CONDICIONES_DE_VIDA_HOGAR=as.integer(input$condHogar),
                          ROBO=as.integer(input$robo),
                          OTRO_DELITO=as.integer(input$otroDelito),
                          LEE_ESCRIBE=as.integer(input$leeEscribe))
    
    salida <- predict(lm_seguridad, newdata = entrada)
    return(salida)
  })
  
  output$prediccionSeguridad <- renderText({
    salidaSeguridad <- resultadoSeguridad()
  })
  
  # Modelo General
  output$prediccion <- renderText({
    entrada <- data.frame(X1=resultadoSalud(),
                          X2=resultadoSeguridad(),
                          X3=as.integer(input$nvEducacion),
                          X4=as.numeric(input$condHogar),
                          X5=input$satisfaccionTrabajo)
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

