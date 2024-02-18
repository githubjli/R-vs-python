# Install and load the necessary package
#install.packages("lavaan")
library(lavaan)

# Load your data
#install.packages("readxl")
library(readxl)

data <- read_excel("/Users/mac/Desktop/cleandata.xlsx")

# Specify SEM model
model_spec <- '
  # Measurement model for latent variables
  BusTangible =~ BT1 + BT2 + BT4 + BT5 + BT6 + BT7
  BusDriversQuality =~ BD1 + BD2 + BD3 + BD4
  Empathy =~ EMP1 + EMP2 + EMP3 + EMP4 + EMP5
  EnvironmentalPerformance =~ EP1 + EP2 + EP3 + EP4
  CustomerSatisfaction =~ CS1 + CS2 + CS3
  LifeSatisfaction =~ LS1 + LS2 + LS3 + LS4 + LS5

  # Structural model for path relationships
  CustomerSatisfaction ~ BusTangible + BusDriversQuality + Empathy + EnvironmentalPerformance
  LifeSatisfaction ~ CustomerSatisfaction
'

# Fit the SEM model
fit <- sem(model_spec, data = data)

# Get a summary of the fit
summary(fit)

# Get standardized estimates of the model
standardizedSolution(fit)
