

install.packages("xgboost")
install.packages("caret")

require(xgboost)

data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test

  library(caret)

bstSparse <- xgboost(data = train$data, label = train$label, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")

bstSparese <- xgboost(data=train$data, label=train$label, max.depth = 2, eta =1 , nthread = 2, nround = 2 , objective = "binary:logistic")

bstDense <- xgboost(data = as.matrix(train$data), label = train$label, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")


dtrain <- xgb.DMatrix(data = train$data, label = train$label)

bst <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic", verbose = 0)
bstDMatrix <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")

bst <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic", verbose = 2)


pred <- predict(bst, test$data)
print(length(pred))

pred
print(head(pred))

prediction <- as.numeric(pred > 0.5)
prediction

err <- mean(as.numeric(pred > 0.5) != test$label)
print(paste("test-error=", err))
