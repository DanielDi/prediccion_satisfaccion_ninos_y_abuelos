tabVisualizacion <- tabPanel("Visualizacion",
         titlePanel("Graficas"),
         sidebarLayout(
           sidebarPanel("Salud",
             selectInput("var", label="Seleccione la variable",
                         choices = c("Calidad EPS"=2,
                                     "Estado Salud"=3,
                                     "Estrato"=4)
                         )),
           mainPanel(
             p("Grafico de Barras"),
             plotOutput("col")
           )
           
         ),
         sidebarLayout(
           sidebarPanel("Algo",
             selectInput("var", label="Seleccione la variable",
                         choices = c("1"=2,
                                     "2"=3,
                                     "3"=4)
             )),
           mainPanel(
             p("Grafico de Barras"),
             plotOutput("col")
           )
           
         )
         
)