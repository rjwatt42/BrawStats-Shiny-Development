MainReports <- function() {
  wellPanel(id="MainReports",
            style = paste("background: ",maincolours$panelC),
            tabsetPanel(type="tabs",
                        id="Reports",
                        tabPanel("Plan",
                                 style="margin:0px;padding:0px;",
                                 htmlOutput("PlanReport")
                        ),
                        tabPanel("Sample",
                                 style="margin:0px;padding:0px;",
                                 htmlOutput("SampleReport")
                        ),
                        tabPanel("Describe",
                                 style="margin:0px;padding:0px;",
                                 htmlOutput("DescriptiveReport")
                                 ),
                        tabPanel("Infer",
                                 style="margin:0px;padding:0px;",
                                 htmlOutput("InferentialReport")
                        ),
                        tabPanel("Likelihood",
                                 style="margin:0px;padding:0px;",
                                 htmlOutput("LikelihoodReport")
                        )
                        ,tabPanel("Expect",value="Expect",
                                  style="margin:0px;padding:0px;",
                                  htmlOutput("ExpectedReport"))
                        ,tabPanel("Explore",value="Explore",
                                  style="margin:0px;padding:0px;",
                                  htmlOutput("ExploreReport")
                                  )
            )
  )
}

