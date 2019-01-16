function[w errors] = trainSVM_SGD(X, y, learningRate, iterations)
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