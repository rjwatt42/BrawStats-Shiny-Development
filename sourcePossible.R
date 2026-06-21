##################################################################################    
# LIKELIHOOD
# UI changes
# set ui variable from UI
# calculations
# outputs
#    

possibleResult<-list(samples=c(),populations=c())
# UI changes
# if the tabs are selected
possibleUpdateTabs<-observeEvent(input$PossiblePanel,{
  if (input$PossiblePanel=="Samples" || input$PossiblePanel=="Populations")
  {
    updateTabsetPanel(session, "Graphs",
                      selected = "Possible")
    updateTabsetPanel(session, "Reports",
                      selected = "Possible")
    showPossible<<-input$PossiblePanel
  }
},priority=100)

# update samples from populations and vice versa
# we check to make sure that we are only copying from the current tab to the hidden one
observeEvent(c(input$possiblePSampRho),
             {
               if (input$PossiblePanel=="Populations") {
                 updateNumericInput(session,"possibleSampRho",value=input$possiblePSampRho)
               }
             })
observeEvent(c(input$possibleSampRho),
             {
               if (input$PossiblePanel=="Samples") {
                 updateNumericInput(session,"possiblePSampRho",value=input$possibleSampRho)
               }
             })



# set likelihood variable from UI 
updatePossible<-function(){
  IV<-updateIV()
  DV<-updateDV()
  effect<-updateEffect()
  
  if (switches$doWorlds) {
    world<-makeWorld(On=input$world_on,PDF=input$world_distr,RZ=input$world_distr_rz, 
                PDFk=input$world_distr_k,
                pRplus=input$world_distr_Nullp
    )
  } else {
    world<-makeWorld(On=FALSE,PDF="Single",RZ="R", 
                PDFk=effect$rIV,
                pRplus=0
    )     
  }
  
  switch (showPossible,
          "Populations"={
            possible<-
              list(type=showPossible,
                   UsePrior=input$likelihoodUsePrior,
                   UseSource=input$possibleUseSource,
                   prior=makeWorld(On=TRUE,PDF=input$Prior_distr,RZ=input$Prior_distr_rz, 
                              PDFk=input$Prior_distr_k,
                              pRplus=input$Prior_Nullp
                   ),
                   world=world,
                   design=list(sampleN=input$sN,sampleNRand=input$sNRand,sampleNRandSD=input$sNRandK),
                   targetSample=input$possiblePSampRho,targetPopulation=effect$rIV,
                   ResultHistory=ResultHistory,
                   sigOnly=input$possible_sigonly,
                   possibleTheory=input$possibleTheory,
                   possibleSimSlice=input$possibleSimSlice,correction=input$correction,
                   possibleHQ=input$possibleHQ,
                   appendSim=input$possibleP_append,possibleLength=as.numeric(input$possibleP_length),
                   view=input$possibleView,show=input$possibleShow,azimuth=input$possibleAzimuth,elevation=input$possibleElevation,range=input$possibleRange,boxed=input$possibleBoxed,
                   textResult=FALSE
              )
          },
          "Samples"={
            possible<-
              list(type=showPossible,
                   UsePrior=input$likelihoodUsePrior,
                   UseSource=input$possibleUseSource,
                   prior=makeWorld(On=TRUE,PDF=input$Prior_distr,RZ=input$Prior_distr_rz, PDFk=input$Prior_distr_k,
                              pRplus=input$Prior_Nullp),
                   world=world,
                   design=list(sampleN=input$sN,sampleNRand=input$sNRand,sampleNRandSD=input$sNRandK),
                   targetSample=input$possibleSampRho,targetPopulation=effect$world$PDFk,
                   cutaway=input$possible_cutaway,
                   sigOnly=input$possible_sigonly,
                   ResultHistory=ResultHistory,
                   possibleTheory=input$possibleTheory,possibleSimSlice=input$possibleSimSlice,correction=input$correction,
                   possibleHQ=input$possibleHQ,
                   appendSim=input$possible_append,possibleLength=as.numeric(input$possible_length),
                   view=input$possibleView,show=input$possibleShow,azimuth=input$possibleAzimuth,elevation=input$possibleElevation,range=input$possibleRange,boxed=input$possibleBoxed,
                   textResult=FALSE
              )
            # if (possible$show=="Power") possible$show<-"Normal"
          }
  )

  if (possible$world$On==FALSE) {
    possible$world$PDF<-"Single"
    possible$world$RZ<-"r"
    possible$world$PDFk<-effect$rIV
    possible$world$pRplus<-0
  }
  if (is.null(oldPossible)) {
    possible$world$PDFk<-checkNumber(possible$world$PDFk)
    possible$prior$PDFk<-checkNumber(possible$prior$PDFk)
    possible$world$pRplus<-checkNumber(possible$world$pRplus)
    possible$prior$pRplus<-checkNumber(possible$prior$pRplus)
    
    possible$design$sampleNRandK<-checkNumber(possible$design$sampleNRandK)
  } else {
    possible$world$PDFk<-checkNumber(possible$world$PDFk,oldPossible$world$PDFk)
    possible$prior$PDFk<-checkNumber(possible$prior$PDFk,oldPossible$prior$PDFk)
    possible$world$pRplus<-checkNumber(possible$world$pRplus,oldPossible$world$pRplus)
    possible$prior$pRplus<-checkNumber(possible$prior$pRplus,oldPossible$prior$pRplus)
    
    possible$design$sampleNRandK<-checkNumber(oldPossible$design$sampleNRandK)
  }
  oldPossible<<-possible
  possible
}

possibleAnalysis<-eventReactive(c(input$PossiblePanel,
                                    input$possible_run,input$possibleP_run,
                                    input$possiblePSampRho,
                                    input$likelihoodUsePrior,input$possibleUseSource,
                                    input$Prior_distr,input$Prior_distr_rz,input$Prior_distr_k,input$Prior_Nullp,
                                    input$rIV,
                                    input$world_on,input$world_distr,input$world_distr_rz,input$world_distr_k,input$world_distr_Nullp,
                                    input$sN,input$sNRand,input$sNRandSD,input$sOn,input$sReplPowerOn,input$sReplPower,
                                    input$EvidencenewSample,
                                    input$possibleTheory,input$possible_sigonly,
                                    input$possibleSimSlice,input$correction,
                                    input$possibleHQ,
                                    input$possibleShow
),{

  req(input$changed)
  
  if (is.element(input$changed,c("possibleP_run")) && is.na(input$possiblePSampRho)) {
    hmm("Please set target sample effect size")
    return(possibleResult)
  }
  if (is.element(input$changed,c("PossiblePanel","possible_run","possibleP_run","possiblePSampRho",
                                 "world_on","world_distr","world_distr_rz","world_distr_k","world_distr_Nullp",
                                 "Prior_distr","Prior_distr_rz","Prior_distr_k","Prior_Nullp",
                                 "possibleTheory",
                                 "sN","sNRand","sNRandSD")))
  {
    showPossible<-input$PossiblePanel
  }
  IV<-updateIV()
  DV<-updateDV()
  
  effect<-updateEffect()
  design<-updateDesign()
  evidence<-updateEvidence()
  result<-sampleAnalysis()
  possible<-updatePossible()
  
  if ((input$possible_run+input$possibleP_run>0)){
    if (switches$showProgress)
      showNotification(paste0("Possible ",possible$type," : starting"),id="counting",duration=Inf,closeButton=FALSE,type="message")
    possibleRes<-possibleRun(IV,DV,effect,design,evidence,possible,metaResult,doSample = TRUE)
    if (switches$showProgress)
      removeNotification(id="counting")
    keepSamples<-FALSE
  } else {
    possibleRes<-possibleRun(IV,DV,effect,design,evidence,possible,metaResult,doSample = FALSE)
    keepSamples<-all(unlist(lapply(seq(3),function(i)possibleRes$possible$world[[i]]==possibleResult$samples$possible$world[[i]])))
    keepSamples<-keepSamples && all(unlist(lapply(seq(3),function(i)possibleRes$possible$design[[i]]==possibleResult$populations$possible$design[[i]])))
  }
  
  switch (showPossible,
          "Samples"={          
            possibleResult$samples<<-possibleRes
            possibleSResultHold<<-list(sSims=possibleResult$samples$Sims$sSims,sSimBins=possibleResult$samples$Sims$sSimBins,sSimDens=possibleResult$samples$Sims$sSimDens)
          },
          "Populations"={
            possibleResult$populations<<-possibleRes
          }
  )
  possibleResult
}
)

makePossibleGraph<-function(){
  if (!is.element(showPossible,c("Samples","Populations"))) {return(nullPlot())}
  IV<-updateIV()
  DV<-updateDV()
  if (is.null(IV) || is.null(DV)) {return(nullPlot())}
  
  effect<-updateEffect()
  design<-updateDesign()
  
  # this guarantees that we update without recalculating if possible
  possible<-updatePossible()
  doIt<-c(ResultHistory)
  
  possibleResult<-possibleAnalysis()
  
  drawPossible(IV,DV,effect,design,possible,possibleResult)
}

# likelihood outputs    
# show likelihood analysis        
output$PossiblePlot <- renderPlot( {
  LKtype<-c(input$PossiblePanel,input$EvidencenewSample)
  par(cex=1.2)
  makePossibleGraph()
})

output$PossiblePlot1 <- renderPlot( {
  LKtype<-c(input$PossiblePanel,input$EvidencenewSample)
  par(cex=1.2)
  makePossibleGraph()
})

# report likelihood analysis        
makePossibleReport<-function() {
  if (!is.element(showPossible,c("Samples","Populations"))) {return(nullPlot())}
  IV<-updateIV()
  DV<-updateDV()
  if (is.null(IV) || is.null(DV)) {return(nullPlot())}
  
  effect<-updateEffect()
  design<-updateDesign()
  
  possible<-updatePossible()
  possibleResult<-possibleAnalysis()
  
  reportPossible(Iv,DV,effect,design,possible,possibleResult)
}

output$PossibleReport <- renderPlot({
  makePossibleReport()
})
output$PossibleReport1 <- renderPlot({
  makePossibleReport()
})

##################################################################################    

