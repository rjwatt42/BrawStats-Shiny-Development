source("uiReplication.R")
source("uiMetaAn.R")
source("uiWorld.R")

MetaSciTab <-
    # h5("Design"),
    # fluidRow(headerText("Design the sample: size & method")),
    tabsetPanel(id="MetaDesign", type="tabs",
                # sampling tab
                tabPanel("  →",value="MetaScience"
                ),
                # world tab
                worldPanel(),
                # replication tab
                replicationTab(),
                metaAnTab()

                # help tab
                ,tabPanel(helpChar,value="?",
                          style = paste("background: ",subpanelcolours$designC,";"),
                            tags$table(width = "100%",class="myTable",
                                       tags$tr(
                                         tags$div(style = helpStyle, 
                                                  tags$br(HTML("<b>"),"Sampling:",HTML("</b>")),
                                                  tags$br(HTML('&emsp;'), '1. choose the sampling method'),
                                                  tags$br(HTML('&emsp;'), '2. set the sample size'),
                                                  tags$br(HTML('&emsp;'),HTML('&emsp;'), '(see the Prediction diagram change)'),
                                                  tags$br(HTML('&emsp;'), '3. choose a between/within design'),
                                                  tags$br(HTML('&emsp;'),HTML('&emsp;'), '(Categorical IVs only)'),
                                                  tags$br(HTML("<b>"),"Anomalies: ",HTML("</b>")),
                                                  tags$br(HTML('&emsp;'), '1. add in outliers'),
                                                  tags$br(HTML('&emsp;'), '2. sample with non-independence'),
                                                  tags$br(HTML('&emsp;'), '3. apply heteroscedasticity (unequal variance)'),
                                                  tags$br(HTML('&emsp;'), '4. apply limited range to IV or DV'),
                                                  tags$br(HTML('&emsp;'),HTML('&emsp;'), 'a. set the range of IV sampling'),
                                                  tags$br(HTML('&emsp;'),HTML('&emsp;'), 'b. set the range of DV values retained'),
                                         ),
                                       )
                            )
                )
    )
