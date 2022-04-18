using DataFrames, Plots, StatPlots

train = readtable("train.csv");

head(train, 10)


### Applicant Income Distribution

pyplot()#Set the backend as matplotlib.pyplot
Plots.histogram(dropna(train[:ApplicantIncome]), bins=50, xlabel="ApplicantIncome", labels="Frequency")#Plot histogram



Plots.boxplot(dropna(train[:ApplicantIncome]), xlabel="ApplicantIncome")


### Applicant Income Across Education

Plots.boxplot(train[:Education], train[:ApplicantIncome], labels="ApplicantIncome")

### Loan Amount Distributions

Plots.histogram(dropna(train[:LoanAmount]), bins=50, xlabel="LoanAmount", labels="Frequency")

Plots.boxplot(dropna(train[:LoanAmount]), ylabel="LoanAmount")



### Interactive Visualizations using Plotly as backend

plotly()  #use plotly as backend
Plots.histogram(dropna(train[:ApplicantIncome]), bins=50, xlabel="ApplicantIncome", labels="Frequency")