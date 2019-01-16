function [w, b, SupVec] = trainSVM_QP(X, y, C, algorithm, iterations)
% C soft margin of SVM (0 if the two classes are linearly separable)
% algorithm: for solving the QP problem:
% trust-region-reflective
% or
% interior-point-convex
% iterations: maximum number of iterations

N = length(y);
H = getQuadraticTerm(X, y);  % Quadratic term
f = -ones(N, 1); % Linear term

% Equality constraints
% y'*alpha = 0;  % linear constraint
Aeq = y';
beq = 0;
% Inequality constraints
% lb <=  alpha  <= ub
lb = zeros(N, 1);  % alpha >= 0
ub = C * ones(N, 1);

options = optimset('Algorithm',algorithm,...
    'Display','off',...
    'MaxIter',iterations);

alpha=quadprog(H,f,[],[],Aeq,beq,lb,ub,[],options)';

% set very small values to zero for faster processing
practicalZero=(abs(alpha)<max(abs(alpha))/1e5);
alpha(practicalZero)=0;


% w = sum (alpha(i) * y(i) * X(i))
SupVec =find(alpha>0 & alpha<C);  % support vectors
w=0;
for i=SupVec
    w=w+alpha(i)*y(i)*X(i, :);
end

w = w';

b=mean(y(SupVec)-X(SupVec, :)*w);

end
