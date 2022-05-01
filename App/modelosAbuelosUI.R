
tabModeloAbuelos <- tabPanel( "Modelo para Abuelos",
  fluidPage(
  
    # Application title
    titlePanel("Predicción de la Satisfacción"),
  
    # Sidebar with a slider input for number of bins
    fluidRow(column(4,
      wellPanel(
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
        )
      ),
      
      column(4,
             wellPanel(
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
             )
      ),
      
      

    )
  )
)
