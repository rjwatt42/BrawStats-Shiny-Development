#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shinyBS")
library("shinyjs")
library("shinyWidgets")

source("uiHeaderText.R") # headers to each tab

source("uiHypothesis.R")
source("uiHelp.R")
source("uiDesign.R")
source("uiAnalysis.R")
source("uiMetaSci.R")
source("uiEvidence.R")
source("uiExplore.R")
source("uiFiles.R")
source("uiGeneral.R")

source("uiWorld.R")
source("uiPrior.R")

source("uiMainGraph.R")
source("uiMainReport.R")

# source("uiInspectDiagram.R")

  graphH="50vh"
  graphH1="60vh"
  reportH="35vh"
  reportH1="60vh"
  popH="30vh"
  graphW=8

  fontSize="1.2vw"

shinyUI(fluidPage(
    useShinyjs(),
    
    tags$style(type="text/css",".recalculating {opacity: 1.0;}" ),   

    tags$head(tags$style(paste0("#HypothesisPlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#WorldPlot{height:","25vh"," !important;}"))),
    tags$head(tags$style(paste0("#DesignPlot{height:","25vh"," !important;}"))),
    
    tags$head(tags$style(paste0("#PopulationPlot{height:",popH," !important;}"))),
    tags$head(tags$style(paste0("#PredictionPlot{height:",popH," !important;}"))),
    
    
    tags$head(tags$style(paste0("#PlanPlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#SamplePlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#DescriptivePlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#InferentialPlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#ExpectedPlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#ExplorePlot{height:",graphH," !important;}"))),
    tags$head(tags$style(paste0("#PossiblePlot{height:",graphH," !important;}"))),

    tags$head(tags$style(paste0("#SamplePlot1{height:",graphH1," !important;}"))),
    tags$head(tags$style(paste0("#DescriptivePlot1{height:",graphH1," !important;}"))),
    tags$head(tags$style(paste0("#InferentialPlot1{height:",graphH1," !important;}"))),
    tags$head(tags$style(paste0("#ExpectedPlot1{height:",graphH1," !important;}"))),
    tags$head(tags$style(paste0("#ExplorePlot1{height:",graphH1," !important;}"))),
    tags$head(tags$style(paste0("#PossiblePlot1{height:",graphH1," !important;}"))),

    tags$head(tags$style(paste0("#PlanReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#SampleReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#DescriptiveReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#InferentialReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#LikelihoodReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#ExpectedReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#ExploreReport{height:",reportH," !important;}"))),
    tags$head(tags$style(paste0("#PossibleReport{height:",reportH," !important;}"))),

    tags$head(tags$style(paste0("#SampleReport1{height:",reportH1," !important;}"))),
    tags$head(tags$style(paste0("#DescriptiveReport1{height:",reportH1," !important;}"))),
    tags$head(tags$style(paste0("#InferentialReport1{height:",reportH1," !important;}"))),
    tags$head(tags$style(paste0("#LikelihoodReport1{height:",reportH1," !important;}"))),
    tags$head(tags$style(paste0("#ExpectedReport1{height:",reportH1," !important;}"))),
    tags$head(tags$style(paste0("#ExploreReport1{height:",reportH1," !important;}"))),
    tags$head(tags$style(paste0("#PossibleReport1{height:",reportH1," !important;}"))),

    tags$head(tags$script('
                        var width = 0;
                        $(document).on("shiny:connected", function(e) {
                          width = window.innerWidth;
                          Shiny.onInputChange("width", width);
                        });
                        var height = 0;
                        $(document).on("shiny:connected", function(e) {
                          height = window.innerHeight;
                          Shiny.onInputChange("height", height);
                        });
                        '
                        )),
    
    tags$script('
    pressedKeyCount = 0;
    $(document).on("keydown", function (e) {
       Shiny.onInputChange("pressedKey", pressedKeyCount++);
       Shiny.onInputChange("keypress", e.which);
    });
    $(document).on("keyup", function (e) {
       Shiny.onInputChange("releasedKey", pressedKeyCount++);
       Shiny.onInputChange("keyrelease", e.which);
    });
    '),
    
    tags$head(
        tags$script(
            "$(document).on('shiny:inputchanged', function(event) {
          if (event.name != 'changed') {
            Shiny.setInputValue('changed', event.name);
          }
        });"
        )
    ),

    tags$head(
        tags$style(type = 'text/css', paste("#SampleReport         {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#DescriptiveReport    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#InferentialReport    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#LikelihoodReport    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#ExpectedReport    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#ExploreReport    {background-color: ", maincolours$graphC, ";}"))
    ),
    tags$head(
        tags$style(type = 'text/css', paste("#SampleGraph         {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#DescriptiveGraph    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#InferentialGraph    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#ExpectedGraph    {background-color: ", maincolours$graphC, ";}")),
        tags$style(type = 'text/css', paste("#ExploreGraph    {background-color: ", maincolours$graphC, ";}"))
    ),
    
    tags$style(type="text/css", ".shiny-file-input-progress { display: none }"),
    
    tags$head(
        tags$style(HTML( # labels 
            paste0(".label {font-size: ",fontSize ,";}")
        )),
        tags$style(HTML( # textInput
            paste0(".form-control {font-size: ",fontSize ,"; height:20px; padding:0px 0px;}")
        )),
        tags$style(HTML( # selectInput
            paste0(".selectize-input {font-size: ",fontSize ,"; height:12px; width:60px; padding:0px; margin-right:-10px; margin-top:-5px;margin-bottom:-5px; min-height:10px;}"),
            paste0(".selectize-dropdown { font-size: ",fontSize ,";line-height:10px}")
        )),
        tags$style(HTML( # helpText
            paste0(".help-block {font-size: ",fontSize ,"; height:20px; padding:0px 0px; margin-top:25px; margin-bottom:-5px; min-height:10px;}")
            )),
        tags$style(HTML( # action button
          paste0("button {font-size:",fontSize ,";font-weight:bold;color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:4px;margin-right:12px;margin-top:4px;margin-left:0px}"),
          paste0(".col-sm-4 button {font-size:",fontSize ,";font-weight:bold;color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:4px;margin-right:12px;margin-top:4px;margin-left:0px}"),
          paste0(".col-sm-3 button {font-size:",fontSize ,";font-weight:bold;color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:4px;margin-right:12px;margin-top:4px;margin-left:0px}")
        )),
        tags$style(HTML( # tab panels
            paste0(".tabbable > .nav > li > a {font-weight: normal; font-size: ",fontSize ,"; padding:2px; margin:1px; color:#222222; background-color:#dddddd}"),
            ".tabbable > .nav > .active > a {font-weight: bold; color:black;  background-color:white; }",
            paste0(".nav-tabs {font-size: ",fontSize ,"; padding:0px; margin-bottom:0px;} "),
        )),
        tags$style(HTML( # tab panes
          ".tab-content {margin:0px;padding:0px;}"
        )),
        # tags$style(HTML( # tab panes
        #   ".tab-pane {margin:0px;padding-left:20px; padding-right:5px; padding-bottom:2px; padding-top:2px;}"
        # )),
        tags$style(HTML( # tab panes
          ".tab-pane {margin:0px;padding:0px;}"
        )),
        tags$style(HTML( # well panels
                ".well {padding:5px; margin:0px;margin-bottom:8px;margin-left:0px;margin-right:0px;} ",
        )),
        tags$style(HTML( # checkbox
            ".checkbox {line-height: 10px;margin:0px;padding:0px;padding-left:4px;}"
        )),
           # help panel specifics
        tags$style(HTML(paste(".help-block b {color:", maincolours$panelC,  "!important;margin:0px;padding:0px;margin-bottom:8px;font-size:",fontSize ,"; font-weight:bold;}")
        )),
        tags$style(HTML(paste(".help-block a {color:", maincolours$panelC,  "!important;margin:0px;padding:0px;margin-bottom:8px;font-size:",fontSize ,"; font-weight:normal;font-style: italic;}")
        )),
        tags$style(HTML(paste0(".btn-file {padding:0px; margin: 0px; font-size:",fontSize ,"; font-weight:Bold; color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:8px;margin-right:12px;margin-top:0px;margin-left:0px}")
        )),
    ),
    tags$head( # alignment of controls  
      tags$style(type="text/css",".table label{ display: table-cell; text-align: center;vertical-align: middle; }  .form-group { display: table-row;}")
    ),
    tags$head( # alignment of controls
      tags$style(".myTable {margin:0px;padding:0px;margin-left:0px;margin-right:0px;}")
    ),
    tags$head(
      tags$style(
        HTML(paste0(".shiny-notification {background-color:", maincolours$panelC,";color:#FFFFFF;position:fixed;top: calc(5%);left: calc(51%);}"
        ))
      )
    ),
    
    # basic controls
    sidebarLayout(
                 sidebarPanel(
                     style = paste("background: ",maincolours$panelC,";margin-left: -10px;margin-right: -21px;padding-right: -21px;margin-top:5px;"),
                     verticalLayout(
                         # Help panel                
                         # HelpTab,
                         wellPanel(id="PlanPanels",
                                   style = paste("background: ",panelcolours$helpC),
                                   fluidRow(headerText("Plan hypothesis, design & analysis")),
                                   tabsetPanel(id="Design", type="tabs",
                                   # sampling tab
                                   tabPanel("Plan:",value="Plan"),
                                   tabPanel("Hypothesis",value="Hypothesis",HypothesisTab),
                                   tabPanel("Design",value="Design",DesignTab),
                                   tabPanel("Analysis",value="Analysis",AnalysisTab),
                                   tabPanel("MetaScience",value="MetaSci",MetaSciTab),
                                   )
                         ),
                         # Evidence panel
                         EvidenceTab,
                         # Explore panel
                         ExploreTab,
                         # Files panel
                         FilesTab,
                         GeneralTab
                     ),
                     width = 4
                 ),
                 # 
                 # results
                 mainPanel(
                     style = paste("background: ",maincolours$windowC,";margin-left: 10px;padding-left: 0px;margin-right: -10px;padding-right: -10px;margin-top:5px;"), 
                     uiOutput("mainColumns"),
                     bsModal(id="debugOutput", title="tested Outputs", trigger="testedOutputButton", size = "large",plotOutput("plotPopUp")),
                     # inspectDiagram,
                     width = 7
                 ),
        ),
        setBackgroundColor(maincolours$windowC)
    )
)
