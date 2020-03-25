library(dplyr)
library(caTools) # for sample.split

# Problem 4

# (a)
# Split data
Framingham <- read.csv("Framingham.csv")
FraminghamSplit <- sample.split(Framingham$TenYearCHD,SplitRatio=0.7)
Framingham.train <- filter(Framingham, FraminghamSplit == TRUE)
Framingham.test <- filter(Framingham, FraminghamSplit == FALSE)
nrow(Framingham.train)
nrow(Framingham.test)

# First model using all independent variables
FraminghamAll <- glm(TenYearCHD ~ male + age + education + currentSmoker + 
                       cigsPerDay + BPMeds + prevalentStroke + prevalentHyp +
                       diabetes + totChol + sysBP + diaBP + BMI + heartRate + glucose,
                     family = binomial, data = Framingham.train)
summary(FraminghamAll)

# Remove all independent variables that are not highly significant
FraminghamPart <- glm(TenYearCHD ~ male + age + sysBP + glucose,
                     family = binomial, data = Framingham.train)
summary(FraminghamPart)

FraminghamProbability <- predict(FraminghamAll, type='response', newdata=Framingham.test)
# build confusion matrix
table(Framingham.test$TenYearCHD,FraminghamProbability>0.5)

# (b)
library(ROCit) # for ROC curve

ROCit_obj <- rocit(score=FraminghamProbability,
                   class=Framingham.test$TenYearCHD)
plot(ROCit_obj)

# optimal test
ROCit_obj$TPR[which.max(ROCit_obj$TPR-ROCit_obj$FPR)]
ROCit_obj$FPR[which.max(ROCit_obj$TPR-ROCit_obj$FPR)]
ROCit_obj$Cutoff[which.max(ROCit_obj$TPR-ROCit_obj$FPR)]

# AUC
ROCit_obj$AUC
