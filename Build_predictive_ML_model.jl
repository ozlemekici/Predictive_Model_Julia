## Loading packages and dataset

using DataFrames
using ScikitLearn: fit!, predict, @sk_import, fit_transform!

@sk_import preprocessing:LabelEncoder
@sk_import model_selection:cross_val_score
@sk_import metrics:accuracy_score
@sk_import linear_model:LogisticRegression
@sk_import ensemble:RandomForestClassifier
@sk_import tree:DecisionTreeClassifier


train = readtable("train.csv");
test = readtable("test.csv");
samplesub = readtable("sample_sub.csv");


## Imputing Missing Values from dataset

showcols(train)

train[isna.(train[:LoanAmount]), :LoanAmount] = floor(mean(dropna(train[:LoanAmount])));
train[train[:LoanAmount].==0, :LoanAmount] = floor(mean(dropna(train[:LoanAmount])));
train[isna.(train[:Gender]), :Gender] = mode(dropna(train[:Gender]));
train[isna.(train[:Married]), :Married] = mode(dropna(train[:Married]));
train[isna.(train[:Dependents]), :Dependents] = mode(dropna(train[:Dependents]));
train[isna.(train[:Self_Employed]), :Self_Employed] = mode(dropna(train[:Self_Employed]));
train[isna.(train[:Loan_Amount_Term]), :Loan_Amount_Term] = mode(dropna(train[:Loan_Amount_Term]));
train[isna.(train[:Credit_History]), :Credit_History] = mode(dropna(train[:Credit_History]));


showcols(test)

test[isna.(test[:Gender]), :Gender] = mode(dropna(test[:Gender]));
test[isna.(test[:Dependents]), :Dependents] = mode(dropna(test[:Dependents]));
test[isna.(test[:Self_Employed]), :Self_Employed] = mode(dropna(test[:Self_Employed]));
test[isna.(test[:LoanAmount]), :LoanAmount] = floor(mean(dropna(test[:LoanAmount])));
test[test[:LoanAmount].==0, :LoanAmount] = floor(mean(dropna(test[:LoanAmount])));
test[isna.(test[:Loan_Amount_Term]), :Loan_Amount_Term] = mode(dropna(test[:Loan_Amount_Term]));
test[isna.(test[:Credit_History]), :Credit_History] = mode(dropna(test[:Credit_History]));


## Label Encoding categorical data

labelencoder = LabelEncoder()
categories = [2 3 4 5 6 12 13]

for col in categories
    train[col] = fit_transform!(labelencoder, train[col])
    if col != 13
        test[col] = fit_transform!(labelencoder, test[col])
    end
end


## Building Model

function classification_model(model, predictors)
    y = convert(Array, train[:13])
    X = convert(Array, train[predictors])
    X2 = convert(Array, test[predictors])

    #Fit the model:
    fit!(model, X, y)

    #Make predictions on training set:
    predictions = predict(model, X)

    #Print accuracy
    accuracy = accuracy_score(predictions, y)
    println("\naccuracy: ", accuracy)

    #5 fold cross validation
    cross_score = cross_val_score(model, X, y, cv=5)

    #print cross_val_score
    println("cross_validation_score: ", mean(cross_score))

    #return predictions
    fit!(model, X, y)
    pred = predict(model, X2)
    return pred
end


predictors = [:ApplicantIncome, :CoapplicantIncome, :LoanAmount, :Credit_History, :Loan_Amount_Term, :Gender, :Dependents]

### Logistic Regression

lrmodel = LogisticRegression()
lrpred = classification_model(lrmodel, predictors);

### Decision Tree Classifier

dtcmodel = DecisionTreeClassifier()
dtcpred = classification_model(dtcmodel, predictors);

### Random Forest Classifier

rfmodel = RandomForestClassifier(n_estimators=25, min_samples_split=25, max_depth=7, max_features=1, n_jobs=-1)
rfpred = classification_model(rfmodel, predictors);


## Create Submission File

pred = map(x -> if x == 1
        "Y"
    else
        "N"
    end, lrpred)  #Convert to "Y" and "N" 
outdf = DataFrame(Loan_ID=test[:Loan_ID], Loan_Status=pred)
writetable("sub.csv", outdf)