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
library(magrittr)

source('modelosAbuelosUI.R')
source('modeloNiños.R')
source('visualizacionUI.R')
source('aboutUsUI.R')
load('data/dfNinos.RData')
load("data/modeloSatisfaccionNiños.RData")
load("data/modeloSatisfaccion.RData")
load("data/modeloSatisfaccionSalud.RData")
load("data/modeloSatisfaccionSeguridad.RData")
load("data/dfSalud.RData")
load("data/dfSeguridad.RData")
load("data/dfdatos.RData")

ui <- fluidPage(theme=shinytheme("united"),
                navbarPage(title = "SatisfÁ",
                           tabPanel("Acerca de SatisFá, mi FaFá",
                                    
                                    h4("El Instituto Colombiano de Bienestar Familiar es una entidad que trabaja por la prevención y protección integral de la primera infancia, la niñez, la adolescencia y el bienestar general de las familias en Colombia, llegando a millones de colombianos mediante sus programas, estrategias y servicios de atención.  En el marco de los objetivos de esta institución se encontró que el ICBF actualmente no cuenta con una herramienta para conocer en prospectiva, y de forma adecuada y efectiva la satisfacción general de vida tanto de niños como de adultos en la tercera edad. Es para ellos de vital importancia conocer esta información pues es un indicador fundamental a tener en cuenta a la hora de crear programas preventivos y de protección que tienen como objetivo el mejoramiento de vida de la población destinataria. Por esto se busca implementar en el ICBF tanto los modelos sub-modelos como el modelo de satisfacción general, para que sea usado por la institución en pro de mejorar futuros planeamientos en todo proyecto social que involucre niños y adultos de la tercera edad como población objetivo."),
                                    img(src="LOGO.png", height = 400, width = 400),img(src="icbf.png", height = 400, width = 400)
                           ),

                           tabModeloAbuelos,
                           tabModeloNinos,

                           tabVisualizacion,
                           tabAcercaDeNosotros
                           
                )
      )

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
  
  output$salud <- renderPlot({
    
    
    colm<-as.numeric(input$var_salud)
    graf<-df_salud[,colm] %>% table() %>%  barplot(col="cornflowerblue")
    return(graf)
    
  })
  
  output$seguridad <- renderPlot({
    
    colm<-as.numeric(input$var_seguridad)
    graf<-df_seguridad[,colm] %>% table() %>%  barplot(col="azure3")
    return(graf)
  })
  
  output$vida <- renderPlot({
    
    colm<-as.numeric(input$var_vida)
    graf<-datos[,colm] %>% table() %>%  barplot(col="darkseagreen")
    return(graf)
  })
  
  #Modelo niños
  output$prediccionNinos <- renderText({
    
    INCAP <- as.integer(input$INCAP_0)+as.integer(input$INCAP_1)+as.integer(input$INCAP_2)+as.integer(input$INCAP_3)+as.integer(input$INCAP_4)+as.integer(input$INCAP_5)+as.integer(input$INCAP_6)
    
    entrada <- data.frame(INCAP=as.integer(INCAP),
                          PERCAPITA=as.numeric(input$PERCAPITA) ,
                          INCRESOS_AUTOPERCIBIDOS_HOGAR=as.numeric(input$ingresosAutopercibidos) ,
                          UBICACION_ESCUELA=as.integer(input$ubicacionEscuela),
                          EDUCACION_PADRES=as.numeric(input$educacionPadres),
                          CONDIC_VIDA_HOGAR=as.numeric(input$CONDIC_VIDA_HOGAR),
                          TIEMPO_TRANSPORTE_ESC=as.integer(input$tiempoTransporteEscuela),
                          HORAS_TRABAJO =as.integer(input$HORAS_TRABAJO),
                          ETNIA=factor(input$etnia, levels=levels(df_ninos$ETNIA)),
                          VIVE_CON_PADRE =factor(input$viveConPadre, levels=levels(df_ninos$VIVE_CON_PADRE)),
                          VIVE_CON_MADRE =factor(input$viveConMadre, levels=levels(df_ninos$VIVE_CON_MADRE)),
                          ESCUELA_OFICIAL =factor(input$escuelaOficial, levels=levels(df_ninos$ESCUELA_OFICIAL)),
                          TRANSPORTE_ESCUELA=addNA(factor(input$transporteEscuela, levels=levels(df_ninos$TRANSPORTE_ESCUELA))),
                          ENFERMEDAD_CRONICA=addNA(factor(input$ENFERMEDAD_CRONICA, levels=levels(df_ninos$ENFERMEDAD_CRONICA))),
                          ACTIVIDAD_ULT_SEMANA=addNA(factor(input$actividadUltSemana, levels=levels(df_ninos$ACTIVIDAD_ULT_SEMANA))),
                          LUGAR_TRABAJO=addNA(factor(input$lugarTrabajo, levels=levels(df_ninos$LUGAR_TRABAJO)))
    )
    salida <- predict(ctreeNiños, entrada)
    salida <- as.integer(salida / 5.6)
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server)

