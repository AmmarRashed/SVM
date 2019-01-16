clear all;
clc;
rng(42);

[trainX train_y testX test_y] = readData('data.txt');

[trainX2d, vs] = compressPCA(trainX, 2);
testX2d = testX * vs;

%% LSE
plotLSE(trainX2d, train_y, 1);

[w b] = LSE(trainX, train_y);

[e1_train_lse, e1_test_lse, e2_train_lse, ...
    e2_test_lse, train_accuracy_lse, test_accuracy_lse] = ...
    evaluateModel(trainX, train_y, testX, test_y, w, b);

%% SVM
trainX = StandardScaler(trainX);
testX = StandardScaler(testX);

% trainX2d = StandardScaler(trainX2d);
% testX2d = StandardScaler(testX2d);

C = 1;
alg = 'interior-point-convex';
maxIter = 50;
plotSVM(trainX2d, train_y, C, alg, maxIter)


[w, b, SupVec] = trainSVM_QP(trainX, train_y, C, alg, maxIter);

[e1_train_svm, e1_test_svm, e2_train_svm, ...
    e2_test_svm, train_accuracy_svm, test_accuracy_svm] = ...
    evaluateModel(trainX, train_y, testX, test_y, w, b);

LSE_accuracy = [train_accuracy_lse test_accuracy_lse]
SVM_accuracy = [train_accuracy_svm test_accuracy_svm]

LSE_error = [e1_train_lse e1_test_lse; e2_train_lse e2_test_lse]
svm_error = [e1_train_svm e1_test_svm; e2_train_svm e2_test_svm]


Cs = linspace(0.001, 1, 50);
plotAccuracyVsC(Cs, trainX, train_y, testX, test_y, alg, maxIter);