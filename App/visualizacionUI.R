tabVisualizacion <- tabPanel("Gráficos Estadísticos",
  fluidPage(
         titlePanel("Gráficas"),
         sidebarLayout(
           sidebarPanel("Salud",
             selectInput("var_salud", label="Seleccione la variable",
                         choices = c("Calidad EPS"=2,
                                     "Estado Salud"=3,
                                     "Estrato"=4,
                                     "Regimen"=5,
                                     "Enfermedad Crónica"=6)
                         )),
           mainPanel(
             p("Gráfico de Barras"),
             plotOutput("salud")
           )
         ),
         sidebarLayout(
           sidebarPanel("Seguridad",
                        selectInput("var_seguridad", label="Seleccione la variable",
                                    choices = c("Estado Civil"=2,
                                                "Sexo"=3,
                                                "Estrato"=4,
                                                "Nivel de Seguridad"=5,
                                                "Condiciones de Vida en el Hogar"=6,
                                                "Robos"=7,
                                                "Otros Delitos"=8,
                                                "Lee y Escribe"=9)
                        )),
           mainPanel(
             p("Grafico de Barras"),
             plotOutput("seguridad")
           )
         ),
         sidebarLayout(
           sidebarPanel("Vida",
                        selectInput("var_vida", label="Seleccione la variable",
                                    choices = c("Salud Autopercibida"=2,
                                                "Seguridad Autopercibida"=3,
                                                "Nivel de Educación"=4,
                                                "Condición de Vida del Hogar"=5,
                                                "Trabajo Autopercibido"=6)
                        )),
           mainPanel(
             p("Gráfico de Barras"),
             plotOutput("vida")
           )
         )
  )
         
)