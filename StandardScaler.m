function [X] = StandardScaler(X)
m = mean(X);
s = std(X);
X = (X - m) ./ s;
end