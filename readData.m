function [trainX train_y testX test_y] = readData(inpath)
a = table2array(readtable(inpath));
X = a(:, 1:end-1);
y = a(:, end);
clear a;

C1 = X(y==1, :);
C2 = X(y==0, :);
N1 = int16(0.8 * length(C1));
N2 = int16(0.8 * length(C2));

ind1 = randperm(length(C1));
ind2 = randperm(length(C2));

c1_train = C1(ind1(1:N1), :);
c2_train = C2(ind2(1:N2), :);

c1_test = C1(ind1(N1+1:end), :);
c2_test = C2(ind2(N2+1: end), :);
n1 = length(c1_test);
n2 = length(c2_test);

trainX = [c1_train; c2_train];
train_y = [ones(N1, 1); -ones(N2, 1)];

testX = [c1_test; c2_test];
test_y = [ones(n1, 1); -ones(n2, 1)];

end