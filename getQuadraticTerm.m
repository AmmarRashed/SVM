function[H] = getQuadraticTerm(X, y)
% A is the quadratic coefficients
N = length(y);
H = zeros(N, N);
for i=1:N
    for j=i:N
        H(i, j) = (y(i) * y(j)) * (X(i, :) * X(j, :)');
        H(j, i) = H(i, j);
    end
end
end
