function [] = plotAccuracyVsC(Cs, trainX, train_y, testX, test_y, alg, maxIter)
tr_accuracies = zeros(length(Cs), 1);
ts_accuracies = zeros(length(Cs), 1);
for i=1:length(Cs)
    c = Cs(i);
    [w, b, SupVec] = trainSVM_QP(trainX, train_y, c, alg, maxIter);

[e1_train_svm, e1_test_svm, e2_train_svm, ...
    e2_test_svm, train_accuracy_svm, test_accuracy_svm] = ...
    evaluateModel(trainX, train_y, testX, test_y, w, b);

tr_accuracies(i) = train_accuracy_svm;
ts_accuracies(i) = test_accuracy_svm;
end


figure(3);
plot(Cs, tr_accuracies);
hold on;
plot(Cs, ts_accuracies);
xlabel('C');
ylabel('Accuracy');
legend('Train', 'Test');
end