function [x1sorted, decisionSurface] = plotDecisionSurface(fig, X, b, w, p)
% b + w(1)*x1 + w(2)*x2 = 0
% x2 = - (b + w(1)*x)/w(2)

x1 = X(:, 1);
x2 = X(:, 2);
[x1sorted idx] = sort(x1);
decisionSurface = - (b + w(1)*x1sorted) / w(2);

figure(fig);
if p==1
    plot(x1sorted, decisionSurface, 'g');
end
maxX1 = max(x1);
minX1 = min(x1);
diff1 = maxX1 - minX1;

maxX2 = max(x2);
minX2 = min(x2);
diff2 = maxX2 - minX2;
xlim([minX1-diff1/10, maxX1+diff1/10]);
ylim([minX2-diff2/10, maxX2+diff2/10]);
end
