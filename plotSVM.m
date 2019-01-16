function [] = plotSVM(X, y, C, alg, maxIter)
[w, b, S] = trainSVM_QP(X, y, C, alg, maxIter);

% marking points on the margins
plot(X(S, 1),X(S, 2),'ko','MarkerSize', 12);

Line = @(x1,x2) w(1)*x1+w(2)*x2+b;
LineA = @(x1,x2) w(1)*x1+w(2)*x2+b+1;
LineB = @(x1,x2) w(1)*x1+w(2)*x2+b-1;

x1min = min(X(:, 1));
x1max = max(X(:, 1));
x2min = min(X(:, 2));
x2max = max(X(:, 2));

handle = ezplot(Line,[x1min x1max x2min x2max]);
set(handle,'Color','k','LineWidth',2);
handleA = ezplot(LineA,[x1min x1max x2min x2max]);
set(handleA,'Color','k','LineWidth',1,'LineStyle',':');
handleB = ezplot(LineB,[x1min x1max x2min x2max]);
set(handleB,'Color','k','LineWidth',1,'LineStyle',':');

end