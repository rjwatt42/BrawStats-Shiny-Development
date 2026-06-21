
metaAnTab<-function(prefix="") {
  metaAnTabReserve<-
    tabPanel("MetaAnalysis",
             style = paste("background: ",subpanelcolours$analysisC),
             tags$table(width = "100%",class="myTable",
                        tags$tr(
                          tags$td(width = "20%", tags$div(style = paste(localStyle,"text-align: left"), "MetaAnalysis:")),
                          tags$td(width = "5%", 
                                  checkboxInput("MetaAnalysisOn",label=NULL,value=braw.def$evidence$metaAnalysis$On)
                          ),
                          tags$td(width = "25%"),
                          tags$td(width = "25%"),
                          tags$td(width = "25%")
                        ),
             ),
             # conditionalPanel(condition="input.MetaAnalysisOn",
                              tags$table(width = "100%",class="myTable",
                                         tags$tr(
                                           tags$td(width = "20%", tags$div(style = paste(localPlainStyle), "Estimate:")),
                                           tags$td(width = "30%", 
                                                   selectInput("MetaAnalysisType",label=NULL,
                                                               choices=c("fixed","random","world"),
                                                               selected=braw.def$evidence$metaAnalysis$analysisType,
                                                               selectize=FALSE)
                                           ),
                                           tags$td(width = "25%",tags$div(style = paste(localPlainStyle), "estimate bias")),
                                           tags$td(width = "5%",checkboxInput("MetaAnalysisBias",label=NULL,value=braw.def$evidence$metaAnalysis$analyseBias)),
                                           tags$td(width = "20%")
                                         ),
                              ),
                              conditionalPanel(condition="input.MetaAnalysisType=='world'",
                                               tags$table(width = "100%",class="myTable",
                                                          tags$tr(
                                                            tags$td(width = "20%", tags$div(style = paste(localPlainStyle), "PDF:")),
                                                            tags$td(width = "40%", 
                                                                    selectInput("MetaAnalysisPDF",label=NULL,
                                                                                choices=c("Single","Gauss","Exp","GenExp","Gamma","Simple","All"),
                                                                                selected=braw.def$evidence$metaAnalysis$modelPDF,
                                                                                selectize=FALSE)
                                                            ),
                                                            tags$td(width = "15%",tags$div(style = paste(localPlainStyle), "Nulls")),
                                                            tags$td(width = "5%",checkboxInput("MetaAnalysisNulls",label=NULL,value=braw.def$evidence$metaAnalysis$analyseNulls))
                                                          ),
                                               ),
                              ),
                              tags$table(width = "100%",class="myTable",
                                         tags$tr(
                                           tags$td(width = "20%", tags$div(style = paste(localPlainStyle), "Method:")),
                                           tags$td(width = "40%", 
                                                   selectInput("MetaAnalysisMethod",label=NULL,
                                                               choices=c("MLE","Trim&Fill"),
                                                               selected=braw.def$evidence$metaAnalysis$method,
                                                               selectize=FALSE)
                                           ),
                                           tags$td(width = "40%")
                                         )
                              ),
                              tags$table(width = "100%",class="myTable",
                                         tags$tr(
                                           tags$td(width = "20%", tags$div(style = paste(localPlainStyle), "prior:")),
                                           tags$td(width = "40%", 
                                                   selectInput("MetaAnalysisPrior",label=NULL,
                                                               choices=c("none","uniform","world"),
                                                               selected=braw.def$evidence$metaAnalysis$analysisPrior,
                                                               selectize=FALSE)
                                           ),
                                           tags$td(width = "35%", tags$div(style = paste(localPlainStyle), "assume bias:")),
                                           tags$td(width = "5%", 
                                                   checkboxInput("MetaAnalysisAssumeBias",label=NULL,value=braw.def$evidence$metaAnalysis$sourceBias)
                                           ),
                                         ),
                              ),
                              tags$table(width = "100%",class="myTable",
                                         tags$tr(
                                           tags$td(width = "30%", tags$div(style = paste(localPlainStyle), "no studies:")),
                                           tags$td(width = "20%", numericInput("MetaAnalysisNStudies",label=NULL,value=braw.def$evidence$metaAnalysis$nstudies)
                                           ),
                                           tags$td(width="50%")
                                         )
                              )
             # )
    )

  metaAnTab<-metaAnTabReserve
}
