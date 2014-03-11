%%% Defining constants - Part a
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

% Polynomial transkformation
Z = pr3_3_3rdPolyTransform(X);
dtilda = 9;

%%% Linear programming
f = zeros(d + 1, 1);
A = - X .* repmat(y, 1, d + 1);
b = -ones(size(y));
w = linprog(f, A, b);

f = zeros(dtilda + 1, 1);
A = - Z .* repmat(y, 1, dtilda + 1);
b = -ones(size(y));
wtilda = linprog(f, A, b);

%%% Plotting
% Dataset and final hypothesis
figure(1);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
ex3_2_plotLine(w, 1, xlow, xupp);

figure(2);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
pr3_3_plot3rdPolyTransformBorder(wtilda, xlow, xupp, ylow, yupp)

%%% Defining constants - Part b
d     = 2;
N     = 2000;

rad = 10;
thk = 5;
sep = -5;

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

% Polynomial transkformation
Z = pr3_3_3rdPolyTransform(X);
dtilda = 9;

%%% Linear programming
f = zeros(d + 1, 1);
A = - X .* repmat(y, 1, d + 1);
b = -ones(size(y));
w = linprog(f, A, b);

f = zeros(dtilda + 1, 1);
A = - Z .* repmat(y, 1, dtilda + 1);
b = -ones(size(y));
wtilda = linprog(f, A, b);

%%% Plotting
% Dataset and final hypothesis
figure(3);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
ex3_2_plotLine(w, 1, xlow, xupp);

figure(4);
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
pr3_3_plot3rdPolyTransformBorder(wtilda, xlow, xupp, ylow, yupp)


%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;