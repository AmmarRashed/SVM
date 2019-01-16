function [w, b] = LSE(X, y)
A = [ones(length(X), 1) X];
parameters = inv(A'*A) * (A' * y);
b = parameters(1);
w = parameters(2:end);
end
