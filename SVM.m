% clear all;
clc;
rng(42);

N = 10000;
n = 1000;
cov1 = [0 -0.5;-1 0];
m1 = [0 0];

cov2 = [1 -1; 0 1];
m2 = [5 5];

[trainX train_y] = generateData(N, m1, cov1, m2, cov2);
[validX valid_y]= generateData(n, m1, cov1, m2, cov2);

plotLSE(trainX, train_y, 1);

[w errors] = trainSVM(trainX, train_y, 1, 200);

figure(2);
plot(errors);

function[w errors] = trainSVM(X, y, learningRate, iterations)
[N, d] = size(X);
w = zeros(d, 1);
errors = zeros(iterations, 1);
for epoch=1:iterations
    error = 0;
    for i=1:length(X)
        classification = y(i) * X(i, :) * w;
        weightUpdate = - 2 * w/epoch;
        % misclassified
        if classification < 1
            w = w + learningRate * ((X(i) * y(i)) + weightUpdate);
            error = error + 1;
        else  % correctly classified
            w = w + learningRate * weightUpdate;
        end
    end
    errors(epoch) = error;
end
errors = errors / length(X);
end

function [] = plotLSE(X, y, fig)
figure(fig);
A = [ones(length(X), 1) X];
[w b] = LSE(A, y);
plotClasses(X, y);
plotDecisionSurface(fig, X, b, w);

end

function[] = plotClasses(X, y)
C1 = X(y==1, :);
C2 = X(y==-1, :);

scatter(C1(:, 1), C1(:, 2), 'r');
hold on;
scatter(C2(:, 1), C2(:, 2), 'b');
hold on;
end

function [X, y] = generateData(N, m1, cov1, m2, cov2)
d = length(m1);  % dimensionality
X = zeros(N, d);
y = zeros(N, 1);

C1 = m1 + randn(N/2, d) * cov1;
C2 = m2 + randn(N/2, d) * cov2;
X = [C1;C2];
y = [ones(length(C1), 1); -ones(length(C2), 1)];
ind = randperm(length(y));
X = X(ind, :);
y = y(ind, :);
end

function [w, b] = LSE(A, y)
parameters = inv(A'*A) * (A' * y);
b = parameters(1);
w = parameters(2:end);
end

function [] = plotDecisionSurface(fig, X, b, w)
% b + w(1)*x1 + w(2)*x2 = 0
% x2 = - (b + w(1)*x)/w(2)

x1 = X(:, 1);
x2 = X(:, 2);
x1sorted = sort(x1);
decisionSurface = - (b + w(1)*x1sorted) / w(2);

figure(fig);
plot(x1sorted, decisionSurface, 'g');
maxX1 = max(x1);
minX1 = min(x1);
diff1 = maxX1 - minX1;

maxX2 = max(x2);
minX2 = min(x2);
diff2 = maxX2 - minX2;
xlim([minX1-diff1/10, maxX1+diff1/10]);
ylim([minX2-diff2/10, maxX2+diff2/10]);
legend(["Healthy", "Alzheimer", "Decision Surface"]);
end
