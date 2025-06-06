# =========================================
# plot predicted fixations (Experiment 2)
# =========================================
plot.fix <- function(fName="", startStep=3, endStep=9,
                     binSize = 20, cond="match"){
  
  clr1="#08519C"
  clr2="gray55"
  
  mainLab = ifelse(cond == "match", "Match condition", "Misatch condition")
  divergence = ifelse(cond == "match", 1367, 1765)
  
  dt.act = read.table(file = fName, header=T)
  
  # for each row assign fixation probability (1 or 0) to each picture
  # based on the activation
  # !! need a better decision criteria when the activations are the same;
  # !! right now it assigns '1' to both
  
  dt.act$knopf.fix = dt.act$flasche.fix = 0
  dt.act$knopf.fix = ifelse(dt.act$knopf.act >= dt.act$flasche.act, 1, 0)
  dt.act$flasche.fix = ifelse(dt.act$flasche.act >= dt.act$knopf.act, 1, 0)
  
  dt.act = subset(dt.act, stepNo %in% c(startStep:endStep))
  dt.act$bin = round(dt.act$time / binSize) * binSize
  
  dt.sum = dt.act %>%
    group_by(bin) %>%
    summarise(knopfMeanFix = sum(knopf.fix)*100/(sum(flasche.fix) + sum(knopf.fix)), 
              flascheMeanFix = sum(flasche.fix)*100/(sum(flasche.fix) + sum(knopf.fix)), n = n())
  
  # lines instead of fitting curves
  lwd = 2
  par(mar=c(2,3.5,1,1), col.main=clr2) #mai=, 
  plot(ylim=c(0,100), xlim=c(900,3200), dt.sum$bin, dt.sum$knopfMeanFix, 
       xaxt="n", 
       col=clr1, type = 'n',
       ylab="", xlab="", 
       main= "", cex.main=1.5)
  # main= mainLab, cex.main=1.5)
  
  mtext(side = 1, text = "Stages from possessive onward", line = 0.4)
  mtext(side = 2, text = "Predicted fixation probability", line = 2.5)
  lines(c(800,3400), c(50, 50), col=clr2, lwd=1, lty=3)
  
  lines(dt.sum$bin, dt.sum$knopfMeanFix, col=clr1, lwd=lwd, type="b")
  points(dt.sum$bin, dt.sum$knopfMeanFix, col=clr1, pch = 19, cex=0.8)

  lines(dt.sum$bin, dt.sum$flascheMeanFix, col=clr1, lty=3, lwd=lwd)
  points(dt.sum$bin, dt.sum$flascheMeanFix, col=clr1, pch = 19, cex=1)

#  text(1367, 70, "↓", col="red", cex=2)
#  lines(c(1367, 1367), c(35, 65), col=colors()[58], lwd=lwd)
  lines(c(divergence, divergence), c(30, 70), col="#DE425B", lwd=lwd)
  
  dt.min = subset(dt.act, stepNo %in% c(startStep:endStep)) %>%
    group_by(stepNo, simNo) %>%
    summarise(min = min(time))
  
  dt.meanOnset = dt.min %>%
    group_by(stepNo) %>%
    # group_by(labelSteps) %>%
    summarise(meanOnset = mean(min))
  
  stepsNames = c("possessive", "adjective", "noun")
  yPos = c(72, 77, 82)
  
  labelSteps = c(1, 4, 6)
  j = 1
  for(i in labelSteps){
    lines(x=c(dt.meanOnset[i,2], dt.meanOnset[i,2]), y=c(-5, 105), col=clr2, lwd=1.5, lty=2)
    text(dt.meanOnset[i,2]-130, yPos[j], stepsNames[j], srt=90, pos=4, cex=0.7, col=clr2, font=4)
    j = j+1
  }
}
# =========================================

