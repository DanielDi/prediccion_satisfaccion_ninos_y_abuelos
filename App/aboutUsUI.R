tabAcercaDeNosotros <- tabPanel("Acerca de Nosotros",
                             fluidPage(
                               titlePanel("Integrantes"),
                               fluidRow(
                                 column(4,
                                        wellPanel(
                                          h3("Brayan M. Ortiz Fajardo"),
                                          h4("bortizf@unal.edu.co"),
                                          h5("Ingeniería de Sistemas e Informática")
                                        )
                                 ),
                                 column(4,
                                        wellPanel(
                                          h3("Daniel Espinal Mosquera"),
                                          h4("despinalm@unal.edu.co"),
                                          h5("Ingeniería de Sistemas e Informática")
                                        )
                                 ),
                                 
                                 column(4,
                                        wellPanel(
                                          h3("Juan Sebastián Falcón"),
                                          h4("jfalcong@unal.edu.co"),
                                          h5("Estadística")
                                        )
                                 ),
                               ),
                               fluidRow(
                                 column(4,
                                        wellPanel(
                                          h3("Juan F. Peña Tamayo"),
                                          h4("jpenat@unal.edu.co"),
                                          h5("Ingeniería de Sistemas e Informática")
                                        )
                                 ),
                                 column(4,
                                        wellPanel(
                                          h3("Thalea Marina Hesse"),
                                          h4("thesse@unal.edu.co"),
                                          h5("Ciencia de Datos")
                                        )
                                 )
                               ),
                              
                               fluidRow(
                                 column(6,
                                        wellPanel(
                                          h3("Github"),
                                          a("Link del proyecto", href="https://github.com/DanielDi/prediccion_satisfaccion_ninos_y_abuelos")
                                        )
                                 ),
                                 column(6,
                                        wellPanel(
                                          h3("Vídeo"),
                                          HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/Ka2pWqXS1WA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                                        )
                                 )
                               )
                             )
                             )