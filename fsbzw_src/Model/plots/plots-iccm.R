#
# Author: Umesh Patil (umesh.patil@gmail.com)
#
# R code for the plots used in the ICCM-2021 paper
# 


#! start fresh
rm(list=ls())
library(tidyverse)
source("plot.fix.R")
source("plot.fix.e1.R")

# Set global parameters
sStep=3       #start step for plotting
eStep=9       #end step for plotting
bSize = 200   # size of the bin (for binning activation values)


# Model for Experiment 2: ----

# MATCH condition
jpeg('mod1-match.jpeg', units='in', width=5, height=3, res=300)
fName = "../R-ACT-R/output/cond-1/act-out-1.txt"
plot.fix(fName, startStep=sStep, endStep=eStep,
         binSize = bSize, cond="match")
dev.off()


# MISMATCH condition
jpeg('mod1-mismatch.jpeg', units='in', width=5, height=3, res=300)
fName = "../R-ACT-R/output/cond-2/act-out-1.txt"
plot.fix(fName, startStep=sStep, endStep=eStep,
         binSize = bSize, cond="mismatch")
dev.off()
#--------------------------------


# Model for Experiment 1: ----

# MATCH condition
jpeg('mod2-match.jpeg', units='in', width=5, height=3, res=300)
fName = "../R-ACT-R/output/cond-E1-a/act-out-1.txt"
plot.fix.e1(fName, startStep=sStep, endStep=eStep,
            binSize = bSize, cond="match")
dev.off()


# MISMATCH condition
jpeg('mod2-mismatch.jpeg', units='in', width=5, height=3, res=300)
fName = "../R-ACT-R/output/cond-E1-b/act-out-1.txt"
plot.fix.e1(fName, startStep=sStep, endStep=eStep,
            binSize = bSize, cond="mismatch")
dev.off()
#--------------------------------

