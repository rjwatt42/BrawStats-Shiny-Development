source("uiPossibleGraph.R")


MainGraphs <- function() {
  wellPanel(
    style = paste("background: ",maincolours$panelC), 
    tabsetPanel(type="tabs",
                id="Graphs",
                tabPanel("Plan",class="Graphs",
                         style="margin:0px;padding:0px;",
                         plotOutput("PlanPlot")
                ),
                tabPanel("Sample",class="Graphs",
                         style="margin:0px;padding:0px;",
                         plotOutput("SamplePlot")
                ),
                tabPanel("Describe",class="Graphs",
                         style="margin:0px;padding:0px;",
                         plotOutput("DescriptivePlot")
                ),
                tabPanel("Infer",
                         style="margin:0px;padding:0px;",
                         plotOutput("InferentialPlot")
                ),
                tabPanel("Likelihood",
                         style="margin:0px;padding:0px;",
                         plotOutput("LikelihoodPlot")
                ),
                tabPanel("Expect",value="Expect", 
                         style="margin:0px;padding:0px;",
                         plotOutput("ExpectedPlot")
                )
                ,tabPanel("Explore",value="Explore",
                          style="margin:0px;padding:0px;",
                          plotOutput("ExplorePlot")
                )
    ),
  )
}

