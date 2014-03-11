%%% Defining constants
d     = 2;
N     = 2000;

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
while counter <= 2000
   
    x1 = rand(1, 1)*(xupp - xlow) + xlow;
    x2 = rand(1, 1)*(yupp - ylow) + ylow;
    label = pr3_1_target(x1, x2, rad, thk, sep);
    
    if label ~= 0
        X(counter, 2:3) = [x1, x2];
        y(counter)      = label;
        counter = counter + 1;
    end
    
end

%%% Running PLA
w = zeros(3, 1);
Ein = 1;
t = 0;

while Ein > 0
    
%     ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
%     hold on;
%     ex3_2_plotLine(w, 1, xlow, xupp);
    
    [xmis, ymis] = ex3_2_pickMisclassified(X, y, w);
    w = w + ymis * xmis;
    
%     plot(xmis(2), xmis(3),'--rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize', 20);
%     hold off;
%     pause;
%     ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
%     hold on;
%     ex3_2_plotLine(w, 1, xlow, xupp);
%     hold off;
    
    Ein = ex3_2_calcError(X, y, w);
    t = t + 1;
end

figure(1);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
ex3_2_plotLine(w, 1, xlow, xupp);
hold off;

%%% Running Linear Regression
wlin = pinv(X) * y;
figure(2);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
ex3_2_plotLine(wlin, 1, xlow, xupp);
hold off;
    

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
