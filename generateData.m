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
