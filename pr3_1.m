%%% Defining constants
N   = 2000;

rad = 10;
thk = 5;
sep = 5;

xlow = -rad-thk;
xupp = 2*rad + 3/2*thk;
ylow = -sep-rad-thk;
yupp = rad+thk;

%%% Generate dataset
% X and labels
X =  ones(N, 3);
y = zeros(N, 1);

counter = 1;
while counter <= N
    x1 = rand(1, 1)*(xupp - xlow) + xlow;
    x2 = rand(1, 1)*(yupp - ylow) + ylow;
    label = pr3_1_targetFunction(x1, x2, rad, thk, sep);
    
    if label ~= 0
        X(counter, 2:3) = [x1, x2];
        y(counter)      = label;
        counter = counter + 1;
    end
end

%%% Running PLA
w_perceptron = zeros(3, 1);
Ein = 1;
[xmis, ymis] = pr1_4_pickMisclassified(X, y, w_perceptron);

while length(ymis) > 0
    w_perceptron = w_perceptron + ymis * xmis;
    
    [xmis, ymis] = pr1_4_pickMisclassified(X, y, w_perceptron);
end

%%% Plotting PLA results
figure;
pr1_4_plotLine(w_perceptron, 1, xlow, xupp);
hold on;
plot(X(find(y == 1), 2)', X(find(y == 1), 3)', 'rx');
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');

%%% Running Linear Regression and plotting
w_lin = pinv(X) * y;

figure;
pr1_4_plotLine(w_lin, 1, xlow, xupp);
hold on;
plot(X(find(y == 1), 2)', X(find(y == 1), 3)', 'rx');
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');
    
%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
