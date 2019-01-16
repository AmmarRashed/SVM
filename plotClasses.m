function[C1, C2] = plotClasses(X, y)
C1 = X(y==1, :);
C2 = X(y==-1, :);

scatter(C1(:, 1), C1(:, 2), 'r');
hold on;
scatter(C2(:, 1), C2(:, 2), 'bs');
hold on;
end
