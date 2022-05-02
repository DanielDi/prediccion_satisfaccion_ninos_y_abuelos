tabVisualizacion <- tabPanel("Visualizacion",
  fluidPage(
         titlePanel("Graficas"),
         sidebarLayout(
           sidebarPanel("Salud",
             selectInput("var", label="Seleccione la variable",
                         choices = c("Calidad EPS"=2,
                                     "Estado Salud"=3,
                                     "Estrato"=4,
                                     "Regimen"=5,
                                     "Enfermedad Crónica"=6)
                         )),
           mainPanel(
             p("Grafico de Barras"),
             plotOutput("col")
           )
           
         )
  )
         
)