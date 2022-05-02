
tabModeloAbuelos <- tabPanel( "Modelo para Abuelos",
  fluidPage(
  
    # Application title
    titlePanel("Predicción de la Satisfacción"),
  
    # Sidebar with a slider input for number of bins
    fluidRow(column(4,
      wellPanel(
        h3("Salud"),
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
        )
      ),
      
      column(4,
             wellPanel(
               h3("Seguridad"),
               selectInput("estadoCivil", label="Estado civil",
                           choices = list("No está casado(a) y vive en pareja hace menos de dos años"=1,
                                          "No está casado(a) y vive en pareja hace dos años o más"=2,
                                          "Está viudo(a)"=3,
                                          "Está separado(a) o divorciado(a)"=4,
                                          "Está soltero(a)"=5,
                                          "Está casado(a)"=6)),
               
               selectInput("nvSeguridad", label="¿cómo se siente en el barrio, pueblo o vereda donde vive??",
                           choices = list("Seguro"=1,
                                          "Inseguro"=2)),
               
               selectInput("condHogar",
                           label="Actualmente las condiciones de vida en su hogar son:",
                           choices = list("Muy buenas"=1,
                                          "Buenas"=2,
                                          "Regulares"=3,
                                          "Malas"=4)),
               
               selectInput("robo",
                           label="Durante el último año, ¿ha sido victima de robo?",
                           choices = list("Sí"=1,
                                          "No"=2)),
               
               selectInput("otroDelito",
                           label="Durante el último año, ¿ha sido victima de otros delitos??",
                           choices = list("Sí"=1,
                                          "No"=2)),
               
               selectInput("leeEscribe",
                           label="¿Sabe leer y escribir?",
                           choices = list("Sí"=1,
                                          "No"=2)),
               h4("Satisfacción estimada de la seguridad: "),
               h4(textOutput("prediccionSeguridad"))
             )
      ),
      
      column(4,
             wellPanel(
               h3("Vida"),
               sliderInput("satisfaccionTrabajo",
                           "¿Qué tan satisfecho se siente con su trabajo?",
                           min = 1,
                           max = 10,
                           value = 1),
               selectInput("nvEducacion",
                           label="¿Cuál su nivel educativo más alto alcanzado?",
                           choices = list("Ninguno"=1,
                                          "Preescolar"=2,
                                          "Básica primaria"=3,
                                          "Básica secundaria"=4,
                                          "Media"=5,
                                          "Técnica"=6,
                                          "Tecnólogo"=7,
                                          "Universitario"=8,
                                          "Postgrado"=9)),
               selectInput("condHogar",
                           label="¿Actualmente las condiciones de vida en su hogar son?",
                           choices = list("Muy buenas"=1,
                                          "Buenas"=2,
                                          "Regulares"=3,
                                          "Malas"=4)),
               h4("Satisfacción estimada con la vida:"),
               h4(textOutput("prediccion"))
             )
      ),

    )
  )
)

