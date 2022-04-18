using DataFrames

train = readtable("train.csv");


### EDA using DataFrames

size(train)                            #Shape of dataset 

names(train)                           #List of columns

head(train)                            #Dataset overview

showcols(train)                          #Columns overview

describe(train[:LoanAmount]) #Cetral tendency metrics 
#of continous variable

countmap(train[:Property_Area])        #Frequency map for categorical variable, like value_counts() of pandas

