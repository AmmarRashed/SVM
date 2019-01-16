function [] = plotLSE(X, y, fig)
figure(fig);
[w b] = LSE(X, y);
plotClasses(X, y);
plotDecisionSurface(fig, X, b, w, 1);
end
