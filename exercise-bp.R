#========================================================================#
# Title: Example of meta-analysis in R
# Author: Tengku Muhd Hanis (https://tengkuhanis.netlify.app/)
# Date: 06-11-2021
#========================================================================#

# Section 1: Basic meta-analysis ------------------------------------------

# Install packages
install.packages("meta")
install.packages("devtools")
devtools::install_github("MathiasHarrer/dmetar", upgrade = "never")
install.packages("robvis")

# Packages
library(meta)
library(dmetar)
library(dplyr)

# Data
source("https://raw.githubusercontent.com/tengku-hanis/Rconference2021/main/data.R")
irt

# Fixed and random effect model ----
ma_irt <- metacont(n.e = n.e, 
                   mean.e = mean.e,
                   sd.e = sd.e,
                   n.c = n.c, 
                   mean.c = mean.c,
                   sd.c = sd.c,
                   studlab = studyID,
                   data = irt,
                   method.tau = "REML", #estimator
                   sm = "SMD",
                   fixed = T, 
                   random = T,
                   prediction = T, 
                   hakn = T, #reduce false positive
                   adhoc.hakn = "iqwig6") #adjust the possible narrow ci caused by hakn
ma_irt

## Update chosen model
ma_irt_RE <- update(ma_irt, fixed = F)

# Forest plot ----
forest(ma_irt_RE, sortvar = TE)

# Funnel plot ----
funnel(ma_irt_RE, studlab = T, xlim = c(-3.5, 1.5))

# Publication bias ----
metabias(ma_irt_RE, plotit = T, method.bias = "Egger") #generic
metabias(ma_irt_RE, plotit = T, method.bias = "Begg") #generic
metabias(ma_irt_RE, plotit = T, method.bias = "Pustejovsky") #specific for cont outcome

# Assess outlier (I^2 > 50%) ----
find.outliers(ma_irt_RE) #cannot have NAs for this

# Influential diagnostics ----
baujat(ma_irt_RE)

ma_inf <- InfluenceAnalysis(ma_irt_RE, random = T) #better

plot(ma_inf, "baujat")
plot(ma_inf, "ES")
plot(ma_inf, "I2")
plot(ma_inf, "influence") #a bit advanced


# Section2: Publication bias ----------------------------------------------
# For significant publication bias (our model not significant)

# Trim and fill method (I^2 should be low) ----
tf <- trimfill(ma_irt_RE)
tf

funnel(tf, studlab = T)


# Section 3: Heterogeneity ------------------------------------------------
# To explain high heterogeneity 

# Subgroup analysis (k > 10) ----
ma_sub <- update(ma_irt_RE, subgroup = age_gp)
ma_sub

forest(ma_sub, sortvar = TE, bylab = "Age group")

# Meta-regression (~ k > 10) ----
ma_irt_reg <- metareg(ma_irt_RE, ~ age_gp, 
                       hakn = T, 
                       intercept = T) 

ma_irt_reg 
exp(ma_iver_reg$beta) #effect estimate of age group >65 is 10% or 1.1 lower than the <65

## Bubble plot of meta-regression
bubble(ma_irt_reg, lwd = 2, lty = 2, col.line = "red", ylim = c(-3, 2), regline = TRUE)


# Miscellanous ------------------------------------------------------------

# Risk of bias ----
library(robvis)

## Available tools/templates
rob_tools()

## Risk of bias data (clinical only)
bias <- 
  read.csv("irt_rob.csv", row.names = NULL) %>%
  select(-X)
bias$Weight <- 1

## Plot
rob_traffic_light(bias, tool = "ROB1", psize = 13)

rob_summary(bias, tool = "ROB1", overall = T, weighted = F)

# Prisma flow of diagram ----

# Shinyapps - https://estech.shinyapps.io/prisma_flowdiagram/
# Not R - http://prisma-statement.org/prismastatement/flowdiagram.aspx

# Resources ---------------------------------------------------------------

# https://www.medrxiv.org/content/10.1101/2021.04.30.21256415v2.full-text
# https://bookdown.org/MathiasHarrer/Doing_Meta_Analysis_in_R/
# https://www.metafor-project.org/  
# https://mcguinlu.shinyapps.io/robvis/
# Rtools - https://clanfear.github.io/CSSS508/docs/compiling.html