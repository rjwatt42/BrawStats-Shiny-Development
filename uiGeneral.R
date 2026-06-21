GeneralTab <-
  
  
  wellPanel(id="GeneralTabset",
            style = paste("background: ",panelcolours$helpC,";","margin-left:0px"),
            tabsetPanel(id="Help",
                        # Help tab
                        tabPanel("Options:",
                        ),
                        tabPanel("Graphics",id="#",
                                 style = paste("background: ",panelcolours$helpC),
                                 tags$table(width = "100%",class="myTable",
                                            tags$tr(
                                              tags$td(width="20%",tags$div(style = labelStyle, "Graphs:")),
                                              tags$td(width="35%",tags$div(style = localPlainStyle, "white")),
                                              tags$td(width="5%",checkboxInput("WhiteGraphs", label=NULL,value=FALSE)),
                                            )
                                 )
                        ),
                        tabPanel("Calculations",id="#",
                                 style = paste("background: ",panelcolours$helpC),
                                 tags$table(width = "100%",class="myTable",
                                            tags$tr(
                                              tags$td(width="20%",tags$div(style = labelStyle, "Calculations:")),
                                              tags$td(width="35%",tags$div(style = localPlainStyle, "shorthand")),
                                              tags$td(width="5%",checkboxInput("shortHand",value=FALSE, label=NULL)),
                                              tags$td(width="40%",tags$div(style = localPlainStyle, ""))
                                            )
                                 )
                        )
            )
  )


