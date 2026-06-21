# world tab

worldPanel<-function(prefix="",asTable=FALSE,doAnyway=FALSE) {
  
  worldTable<-tabPanel("World",value="World",
                       style = paste("background: ",subpanelcolours$hypothesisC),
                       tags$table(width = "100%",class="myTable",
                                  tags$tr(
                                    tags$td(width = "20%", tags$div(style = localStyle, "Effects:")),
                                    tags$td(width = "5%",
                                            checkboxInput(paste0(prefix, "world_on"), label=NULL, value=braw.def$hypothesis$effect$world$On)
                                    ),
                                    tags$td(width = "25%"),
                                    tags$td(width = "50%")
                                  )
                       ),
                       # conditionalPanel("input.world_on",
                       tags$table(width = "100%",class="myTable",
                                  tags$tr(
                                    tags$td(width = "40%", tags$div(style = localStyle, "Population pdf:")),
                                    tags$td(width = "30%",
                                            selectInput(paste0(prefix, "world_distr"), label=NULL,
                                                        c("Single" = "Single",
                                                          "Double" = "Double",
                                                          "Uniform" = "Uniform",
                                                          "Gauss"="Gauss",
                                                          "Exp" = "Exp",
                                                          "Gamma" = "Gamma",
                                                          "GenExp" = "GenExp",
                                                          ">"=">",
                                                          "<"="<"),width="100%",
                                                        selected=braw.def$hypothesis$effect$world$PDF,
                                                        selectize=FALSE)
                                    ),
                                    tags$td(width = "15%",
                                            selectInput(paste0(prefix,"world_distr_rz"), label=NULL,
                                                        c("r" = "r",
                                                          "z" = "z"),width="100%",
                                                        selected=braw.def$hypothesis$effect$world$RZ,
                                                        selectize=FALSE)
                                    ),
                                    tags$td(width = "15%",
                                            conditionalPanel(condition=paste0("input.",prefix,"world_distr!=='Uniform'"),
                                                             numericInput(paste0(prefix, "world_distr_k"),label=NULL,
                                                                          min = -1,
                                                                          max = 1,
                                                                          step = 0.05,
                                                                          value = braw.def$hypothesis$effect$world$PDFk)
                                            )
                                    )
                                  ),
                                  tags$tr(
                                    tags$td(width = "40%", tags$div(style = localStyle, "p(R₊)")),
                                    tags$td(width = "30%", numericInput(paste0(prefix, "world_distr_Nullp"), 
                                                                        label=NULL,min=0,max=1, step=0.05,value=braw.def$hypothesis$effect$world$pRplus)),
                                    tags$td(width = "15%", tags$div(style = localStyle, "abs:")),
                                    tags$td(width = "15%",
                                            checkboxInput(paste0(prefix, "world_abs"), label=NULL, value=braw.def$hypothesis$effect$world$worldAbs)
                                    )
                                  )
                       ),
                       tags$table(width = "100%",class="myTable",
                                  tags$tr(
                                    tags$td(width = "20%", tags$div(style = localStyle, "Samples:")),
                                    tags$td(width = "5%",
                                            checkboxInput(paste0(prefix, "sNRand"), label=NULL, value=braw.def$design$sNRand)
                                    ),
                                    tags$td(width = "25%"),
                                    tags$td(width = "50%")
                                  )
                       ),
                       tags$table(width = "100%",class="myTable",
                                  tags$tr(
                                    tags$td(width="40%",
                                            tags$div(style = localStyle, "gamma:")
                                    ),
                                    tags$td(width = "30%", 
                                            numericInput("sNRandSD",label=NULL,value=braw.def$design$sNRandSD,min=0,step=0.5)
                                    ),
                                    tags$td(width="30%")
                                  )
                       )
                                    
  )
  # )
  
  return(worldTable)
}

