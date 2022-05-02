tabModeloNinos <- 
  tabPanel( "Modelo para Niños",
    fluidPage(
      
      # Application title
      titlePanel("Predicción de la Satisfacción"),
      
      # Sidebar with a slider input for number of bins
      fluidRow(column(4,
                      wellPanel(
                        h3("Niñez"),
                        selectInput("etnia", label="Es o se reconoce comó: ",
                                    choices = list("Indígena"=1,
                                                   "Gitano (a) (Rom)"=2,
                                                   "Raizal del archipiélago de San Andrés, Providencia y Santa Catalina"=3,
                                                   "Palenquero (a) de San Basilio"=4,
                                                   "Negro (a), mulato (a) (afrodescendiente), afrocolombiano(a)"=5,
                                                   "Ninguno de los anteriores"=6)),
                        
                        selectInput("viveConPadre", label="El Padre vive en el mismo hogar:  ",
                                    choices = list("Sí"=TRUE,
                                                   "No"=FALSE,
                                                   "Fallecido"="Muerto")),
                        selectInput("viveConMadre", label="La Madre vive en el mismo hogar: ",
                                    choices = list("Sí"=TRUE,
                                                   "No"=FALSE,
                                                   "Fallecido"="Muerto")),
                        
                        selectInput("educacionPadres", label="¿Cuál es el máximo nivel de educación de sus padres? (máximo entre los dos)",
                                    choices = list("Ninguna"=0,
                                                   "Primaria"=1,
                                                   "Secundaria"=2,
                                                   "Técnica o Tecnología"=3,
                                                   "Universidad"=4
                                    )),
                        selectInput("escuelaOficial", label="El establecimiento donde estudia es: ",
                                    choices = list("Oficial"="Oficial",
                                                   "No oficial con subsidio"="conSubstito",
                                                   "No oficial sin subsidio"="SinSubstito"
                                    )),
                        
                        selectInput("transporteEscuela", label="¿Qué medio de transporte utiliza principalmente para ir a la institución a la que asiste?",
                                    choices = list("Carro"="Carro",
                                                   "escolar"="escolar",
                                                   "público"="público",
                                                   "pie"="pie",
                                                   "Bicicleta"="Bicicleta",
                                                   "Caballo"="Caballo",
                                                   "canoa"="canoa",
                                                   "Otro"="Otro"
                                    )),
                        
                        selectInput("ubicacionEscuela", label="¿Dónde se ubica la institución a la que asiste?",
                                    choices = list("Un centro urbano donde esta la alcaldía municipal" = 1,	
                                                    "Un corregimiento, inspección de policía o caserío" = 2,
                                                    "Una vereda o campo" = 3)),
                        
                        selectInput("ENFERMEDAD_CRONICA", label="¿Le han diagnosticado que tiene alguna enfermedad crónica?",
                                    choices = list(
                                      "Sí"=TRUE,
                                      "No"=FALSE,
                                      "No sé")),
                        
                        selectInput("actividadUltSemana", label="¿En que actividad ocupó la mayor parte del tiempo la semana pasada?",
                                    choices = list("Trabajando"="Trabajando",
                                                   "Buscando trabajo"="Buscando",
                                                   "Estudiando"="Estudiando",
                                                   "Oficios del hogar"="Oficios_hogar",
                                                   "Incapacitado"="Incapacitado trabajar",
                                                   "Otra"="Otra")),
                        
                        selectInput("lugarTrabajo", label="¿Cuál es su lugar de trabajo?",
                                    choices = list("No trabaja"="no trabajo",
                                                   "La vivienda"="la vivienda",
                                                   "Otra vivienda"="otra vivienda",
                                                   "Puerta a puerta"="Puerta",
                                                   "Calle"="calle",
                                                   "Oficina"="oficina",
                                                   "Campo"="campo",
                                                   "Obra"="obra",
                                                   "Otra"=NA)),
                        
                        selectInput("ingresosAutopercibidos", label="Los ingresos del hogar",
                                    choices = list("No alcanzan para cubrir los gastos mínimos"=1,
                                                   "Sólo alcanza para cubrir los gastos mínimos"=2,
                                                   "Cubre más que los gastos mínimos"=3)),
                        
                        selectInput("INCAP_0", label=" Puede: Oír la voz o los sonidos? ", 
                                    choices = list("No" = 1,
                                                   "con mucha dificultad"=2,
                                                   "con alguna dificultad"=3,
                                                   "Sin dificultad"=4)),
                        
                        selectInput("INCAP_1", label="Puede: Hablar o conversar?", choices = list("No" = 1,
                                                                                                  "con mucha dificultad"=2,
                                                                                                  "con alguna dificultad"=3,
                                                                                                  "Sin dificultad"=4)),
                        
                        selectInput("INCAP_2", label="Puede: Ver de cerca, de lejos o alrededor?", choices = list("No" = 1,
                                                                                                                  "con mucha dificultad"=2,
                                                                                                                  "con alguna dificultad"=3,
                                                                                                                  "Sin dificultad"=4)),
                        
                        selectInput("INCAP_3", label="Puede: Mover el cuerpo, caminar o subir y bajar escaleras?", choices = list("No" = 1,
                                                                                                                                  "con mucha dificultad"=2,
                                                                                                                                  "con alguna dificultad"=3,
                                                                                                                                  "Sin dificultad"=4)),
                        
                        selectInput("INCAP_4", label="Puede: Agarrar o mover objetos con las manos?", choices = list("No" = 1,
                                                                                                                     "con mucha dificultad"=2,
                                                                                                                     "con alguna dificultad"=3,
                                                                                                                     "Sin dificultad"=4)),
                        
                        selectInput("INCAP_5", label="Puede: Entender, aprender, recordar o tomar decisiones por sí mismo(a)?", 
                                    choices = list("No" = 1,
                                                   "con mucha dificultad"=2,
                                                   "con alguna dificultad"=3,
                                                   "Sin dificultad"=4)),
                        
                        
                        selectInput("INCAP_6", label="Puede: Comer, vestirse o bañarse por sí mismo(a)?", 
                                    choices = list("No" = 1,
                                                   "con mucha dificultad"=2,
                                                   "con alguna dificultad"=3,
                                                   "Sin dificultad"=4)),
                        
                        
                        numericInput("tiempoTransporteEscuela", 
                                     "¿Cuántos minutos gasta para ir a la institución a la que asiste?",
                                     10,
                                     min = 0, 
                                     max = 600),
                        
                        numericInput("HORAS_TRABAJO", 
                                     label="¿Cuántas horas a la semana trabaja normalmente?",  
                                     max=120, 
                                     min=0, 
                                     value=1),
                        
                        selectInput("CONDIC_VIDA_HOGAR",
                                    label="¿Actualmente las condiciones de vida en su hogar son?",
                                    choices = list("Muy buenas"=1,
                                                   "Buenas"=2, 
                                                   "Regulares"=3,
                                                   "Malas"=4)),
                        
                        numericInput("PERCAPITA", label="Ingreso per-cápita", min=0, value=1)
                        
                      ),
                        h4("Satisfacción de vida estimada: "),
                        h4(textOutput("29.93448"))
                      )
      ),
      
      )
    )


