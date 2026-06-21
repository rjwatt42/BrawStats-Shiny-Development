##################################################################################    
# SYSTEM diagrams   
# hypothesis diagram
# population diagram
# prediction diagram

output$PlanReport <- renderUI({
  if (debug) debugPrint("PlanReport")
  doIt<-editVar$data
  hypothesis<-updateHypothesis()
  design<-updateDesign()
  g<-reportSystem(hypothesis=hypothesis,design=design)
  if (debug) debugPrint("PlanReport - exit")
  HTML(g)
})

output$PlanPlot <- renderPlot({
  if (debug) debugPrint("PlanPlot")
  doIt<-editVar$data
  hypothesis<-updateHypothesis()
  design<-updateDesign()
  g<-showSystem("all",hypothesis=hypothesis,design=design)
  if (debug) debugPrint("PlanPlot - exit")
  g
})

output$HypothesisPlot<-renderPlot({
  doIt<-c(editVar$data,input$WhiteGraphs,input$RZ)
  if (debug) debugPrint("HypothesisPlot")
  
  hypothesis<-updateHypothesis()
  if (is.null(hypothesis$IV2))
    g<-showHypothesis(hypothesis,plotArea=c(0,0.1,1,0.8))
  else 
    g<-showHypothesis(hypothesis,plotArea=c(0.15,0.1,0.7,0.8))
  
  if (debug) debugPrint("HypothesisPlot - exit")
  g
}
)

# world diagram
output$WorldPlot<-renderPlot({
  doIt<-c(editVar$data,input$WhiteGraphs,input$RZ)
  if (debug) debugPrint("WorldPlot")
  
  hypothesis<-updateHypothesis()
  g<-showWorld(hypothesis,plotArea=c(0.1,0.1,0.8,0.8))
  
  if (debug) debugPrint("WorldPlot - exit")
  g
}
)


output$DesignPlot<-renderPlot({
  doIt<-c(editVar$data,input$WhiteGraphs)
  design<-updateDesign()
  if (debug) debugPrint("WorldPlot2")
  
  g<-showDesign(design,plotArea=c(0.1,0.1,0.8,0.8))
  
  if (debug) debugPrint("WorldPlot2 - exit")
  g
}
)

# population diagram
output$PopulationPlot <- renderPlot({
  doIt<-c(editVar$data,input$WhiteGraphs,input$RZ)
  if (debug) debugPrint("PopulationPlot")

  hypothesis<-updateHypothesis()
  g<-showPopulation(hypothesis,plotArea=c(0.1,0.1,0.8,0.8))
  
  if (debug) debugPrint("PopulationPlot - exit")
  g
})  

# prediction diagram
output$PredictionPlot <- renderPlot({
  doIt<-c(editVar$data,input$WhiteGraphs,input$RZ)
  if (debug) debugPrint("PredictionPlot")

  hypothesis<-updateHypothesis()
  design<-updateDesign()
  evidence<-updateEvidence()
  g<-showPrediction(hypothesis,design,evidence,plotArea=c(0.1,0.1,0.8,0.8))
  
  if (debug) debugPrint("PredictionPlot - exit")
  g
})  
##################################################################################    
