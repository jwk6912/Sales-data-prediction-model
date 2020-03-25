###############
# This exercise has 3 parts:
# 1. Basic Manipulation in R
# 2. Basic data structure in R
# 3. WHO example

#####################
# 1. INTRODUCTION TO R

# Everything following a hash sign is a comment

# Open the file "Discussion_1.R"

# File -> Open Document
# Navigate to where you saved the files you downloaded for this class, select this script file, and click open.


# 1.1 BASIC CALCULATIONS IN R

# Always type commands after the greater-than sign in the console

# Or run lines in a script file
# Highlight the line
# Mac, Command-Enter
# PC, Control-r.

# Try running these lines:
8*6
2^16 


# The [1] is just R's way of labeling the output.

# Incomplete command. R will show you a + sign - hit escape
2^
  
# Scroll through previous commands using up and down arrows
  
# Your turn:
# Compute 283455 divided by 3.67778
283455/3.67778
  
  
# 1.2 VARIABLES 

# Basic variable naming rules: 
# Don't use spaces (periods or capital letters instead)
# Don't start names with a number
# Variable names are case sensitive - capital and lowercase letters are different

# Variable assignment
SquareRoot2 <- sqrt(2) 
# RStudio has a keyboard shortcut for the arrow operator <-
# Alt +  -
# or 
SquareRoot2Two = sqrt(2)

# See the value by typing its name
SquareRoot2Two

# list of all of the variables you have created.
ls()

# Your turn:
# Create a variable called "SecondsDay" that is equal to the number of seconds in a day, and output its value.

# 1.3 DATA TYPES

# Numerics
my_numeric <- 42

# Logical: boolean values
my_logical <- TRUE

# Your turn:
# Create a characters variable, it can be text or string.
# my_character <- 
my_character <- 'hi'
my_character
ls()
# 1.4 FUNCTION

# A function can take in several arguments or inputs, and returns an output value.
# Ex: square root and absolute value functions:
sqrt(2)
abs(-65)

# Thousands of functions in R
# http://www.statmethods.net/management/functions.html

# Get help on any function:
?sqrt
help(sqrt)

# Check arguments of a function
args(sample)

# List all functions containing the string
apropos("samp")

# 1.5 PACKAGES
library()   # see all packages installed 
search()    # see packages currently loaded
# install.packages('dplyr')
?filter
library(dplyr)
?filter

# 1.6 SETTING THE WORKING DIRECTORY.

# (Make sure the csv file and the .R file are in the same folder)
# There are three methods:
# Method 1. (Easiest)
# Go to Session -> Set Working Directory -> To Source File Location.
# This changes the working directory to the one in which you open this file.

# Method 2.
# Go to Session -> Set Working Directory -> Choose directory -> Select the location of the folder you want.

# Method 3.
# Session -> Set Working Directory -> To Files Pane Location 
# will set the working directory to the folder you see on the right side.

# To change that, click on the "..." symbol on the line with the Home symbol, and 
# navigate to the desired folder.

# Method 4.
# By command
getwd()
setwd("C:/Users/jungwon_kim/Berkeley/Course/SPRING 20 IEOR 242/Discussions/Discussion_1")
getwd()

#####################
# 2. Basic data structure in R

# 2.1 (column) vector
a <- c(1,2,3,4,5)
2*a

# element-wise multiplication
b <- c(2,1,3,2,1)
a*b

# Your turn:
# element-wise comparison, to see if a is greater than b
a>b
# inner product
a%*%b

# selection (index from 1 rather than 0)
a[1]
a[c(3,5,1)] #c means combine so it will give a column vector


# Your turn: select a[2],a[3],a[4]
a[2:4]
# a[2:4]

# character vector
names(a) <- c("Mon","Tue","Wed","Thu","Fri")
a

# 2.2 factor
# factor is used to store categorical variables
gender <- c("M", "F", "F", "M", "M")
factor_gender <- factor(gender)
# change the name of levels
levels(factor_gender) <- c("Female", "Male")

summary(gender)
summary(factor_gender)

# Comparing ordered factor
GPA <- factor(c('A','B','A','C','B'),ordered=TRUE,levels=c('C','B','A'))
# Your turn: compare GPA[2] and GPA[3]



# 2.3 matrix
A =  matrix(c(1, 3, 2, 2, 8, 9), ncol = 3) #by defalt it arrange it by number of column 
B = matrix(c(1, 3, 2, 2, 8, 9), byrow = TRUE, nrow = 3) #you should set the value to arrange it by row

# matrix multiplication
A%*%B 
# transpose
t(A)
B
A
# inverse
C = matrix(c(1, 3, 2, 2), ncol = 2)
D = solve(C)
C%*%D
#to inverse a matrix you have to solve it by C and matmul C and D 


# 2.4 DataFrame
mtcars
name <- c('James','Mark')
age <- c(25,40)
df <- data.frame(name,age)
# Structure of the data
str(df)
# Statistical summary of the data:
summary(df)

# Display a few data points at the "head" (start) of the dataset
# The first 6 records
head(df)
# The last few records
tail(df)

# Use $ to select variable
df$name #selecting name label 

#####################
# 3. WHO example

# Read in the data file 
WHO = read.csv("WHO.csv") 
getwd()

# On the right hand side, in the Environment tab, click on the table symbol on the
# WHO line -> you should see the data in the familiar Excel format.
# Delete an object
# rm(WHO)

# Your turn: check the structure and statistical summary of WHO
summary(WHO)

# Your turn: have a look at the first few rows of WHO
head(WHO)

# Recent statistics from the World Health Organization (WHO)
# The variables are: 
# the name of the country
# the region the country is in
# the population in thousands
# the percentage of the population under 15 and over 60
# the fertility rate (average number of children per woman)
# the Life Expectancy in years
# the Child Mortality rate (the number of children who die by age 5 per 1000 births)
# the number of cellular subscribers per 100 population
# the literacy rate among adults aged >= 15
# the gross national income per capita
# the percentage of male children enrolled in primary school
# the percentage of female children enrolled in primary school

# Subset with only the countries in Europe
WHO.Europe <- filter(WHO, WHO$Region == "Europe")

str(WHO.Europe)

# Other subsets:
WHO.AsiaEurope <- filter(WHO, WHO$Region == "Europe" | WHO$Region == "South-East Asia" | WHO$Region == "Eastern Mediterranean")

str(WHO.AsiaEurope)
summary(WHO.AsiaEurope$Region)

# Save data frame to a csv file
write.csv(WHO.AsiaEurope, "WHO_AsiaEurope.csv", row.names=FALSE)

# Your turn:
# How many countries have population greater than 50 million? 
Answer <- filter(WHO, WHO$Population > 50000)
nrow(Answer)


# BASIC DATA ANALYSIS

# To access a variable in a data frame, you always have to link it to the data frame with the dollar sign.
WHO$LifeExpectancy
# This will give you an error!

# Now, run this.
WHO$LifeExpectancy

# Statistics about this variable
mean(WHO$LifeExpectancy)
max(WHO$LifeExpectancy)
min(WHO$LifeExpectancy)

# Standard deviation
sd(WHO$LifeExpectancy)
summary(WHO$LifeExpectancy)

summary(WHO$GNI) 
# what's different here? 

# Identify countries corresponding to max and min

LifeExpectancyMinID <- which.min(WHO$LifeExpectancy)
WHO$Country[LifeExpectancyMinID]
LifeExpectancyMinID
LifeExpectancyMaxID <- which.max(WHO$LifeExpectancy)
WHO$Country[LifeExpectancyMaxID]
LifeExpectancyMaxID

#comparing life expectancy with 

# Your turn:
# What is the largest population value among all countries?
PopulationMaxID <- which.max(WHO$Population)
WHO$Country[PopulationMaxID]
WHO$Population[PopulationMaxID]
# Which country has the largest population?


# Dealing with NA (Missing data)
# Try:

sd(WHO$LiteracyRate)

# We need to remove the NA's before we can compute statistics. To do that, try

sd(WHO$LiteracyRate, na.rm=TRUE)

# na.rm stands for na.remove.
# It doesn't consider the points with na.

