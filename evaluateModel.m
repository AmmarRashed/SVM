function [e1_train, e1_test, e2_train, e2_test, train_acc, test_acc] = ...
    evaluateModel(trainX, train_y, testX, test_y, w, b)

[threshold train_preds e1_train e2_train] = getThreshold(trainX, train_y, w, b);
[test_preds e1_test e2_test] = ClassificationError(testX, test_y, w, b, threshold);

train_acc = sum(train_preds == train_y) / length(train_y);
test_acc = sum(test_preds == test_y) / length(test_y);

end