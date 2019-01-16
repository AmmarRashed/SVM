function [x] = transform(x, w, b);
x = x * w' + b;
end
