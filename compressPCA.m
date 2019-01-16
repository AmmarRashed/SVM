function [X_compressed, vs] = compressPCA(X, dims)
[V D] = eig(cov(X));
eigen_vals = zeros(length(D));
for i=1:length(D)
    eigen_vals(i) = D(i, i);
end
[sorted, order] = sort(eigen_vals, 'desc');
vs = zeros(length(V), dims);
for i=1:dims
    vs(:, i) = V(:, order(i));
end
X_compressed = X * vs;
end
