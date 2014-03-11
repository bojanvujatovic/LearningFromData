%%% Defining constants
d     = 2;
N     = 2000;

rad = 10;
thk = 5;
sep = -5;

xlow = -rad-thk;
xupp = 2*rad + 3/2*thk;
ylow = -sep-rad-thk;
yupp = rad+thk;

% Initialization
t_vals = 1:1000000;
Einmin_vals = zeros(size(t_vals));

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

% %%% Part a-d
% % Running Pocket Algorithm
% w = zeros(3, 1);
% wmin = w;
% Einmin = 1;
% t = 1;
% 
% while t <= 1000000
%     
% %     ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
% %     hold on;
% %     ex3_2_plotLine(w, 1, xlow, xupp);
%     
%     [xmis, ymis] = ex3_2_pickMisclassified(X, y, w);
%     w = w + ymis * xmis;
%     
%     
%     
% %     plot(xmis(2), xmis(3),'--rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize', 20);
% %     hold off;
% %     pause;
% %     ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
% %     hold on;
% %     ex3_2_plotLine(w, 1, xlow, xupp);
% %     hold off;
%     
%     Ein = ex3_2_calcError(X, y, w);
%     if Ein < Einmin
%         Einmin = Ein;
%         wmin = w;
%     end
%     
%     Einmin_vals(t) = Einmin;
%     
%     if mod(t, 50000) == 0
%         t
%     end
%     
%     t = t + 1;
% end
% 
% %%% Plotting
% % Ein vs time
% figure(1);
% plot(t_vals, Einmin_vals);
% 
% % Dataset and final hypothesis
% figure(2);
% ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
% hold on;
% ex3_2_plotLine(wmin, 1, xlow, xupp);
% 
% % Running Linear regression
% wlin = pinv(X) * y;
% ex3_2_plotLine(wlin, 1, xlow, xupp);

%%% Part e
X = pr3_3_3rdPolyTransform(X);
dtilda = 9;
t_vals = 1:1000000;
Einmin_vals = zeros(size(t_vals));

% Running Pocket Algorithm
w = zeros(dtilda + 1, 1);
wmin = w;
Einmin = 1;
t = 1;

while t <= 1000000
    
    [xmis, ymis] = ex3_2_pickMisclassified(X, y, w);
    w = w + ymis * xmis;
    
    Ein = ex3_2_calcError(X, y, w);
    if Ein < Einmin
        Einmin = Ein;
        wmin = w;
    end
    
    Einmin_vals(t) = Einmin;
    
    if mod(t, 50000) == 0
        t
    end
    
    t = t + 1;
    
    if Ein == 0
        break;
    end
end

%%% Plotting
% Ein vs time
figure(3);
plot(t_vals, Einmin_vals);

% Data and bound
figure(4);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
pr3_3_plot3rdPolyTransformBorder(w, xlow, xupp, ylow, yupp)

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
