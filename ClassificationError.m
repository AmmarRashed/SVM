function [preds e1 e2] = ClassificationError(X, y, w, b, threshold)
preds = X * w + b;
ys_c1 = preds(y==1);
ys_c2 = preds(y==-1);
e1 =  sum(ys_c2 > threshold) / length(ys_c2); % p(C1|C2)
e2 =  sum(ys_c1 <= threshold) / length(ys_c1); % p(C2|C1)
preds = preds > threshold;
preds = (preds - 1) * 2 + 1;  % shift from (0, 1) to (-1, 1);
end