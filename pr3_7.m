%%% Defining constants
N = 2000;

Q = 3;

redBackgroundColor =  [255, 148, 148]/255;
blueBackgroundColor = [113, 139, 222]/255;



%%% Generate dataset - separable dataset
fprintf('Case sep = 5 (separable case)\n');
% Parameters
rad = 10;
thk = 5;
sep = 5;

xlow = -rad-thk;
xupp = 2*rad + 3/2*thk;
ylow = -sep-rad-thk;
yupp = rad+thk;

% X, Z and labels
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

[Z, d_tilda] = pr3_3_polyTransform(X, Q);

% Data for plotting
[x1_plot, x2_plot] = meshgrid(xlow:0.1:xupp, ylow:0.1:yupp);
X_plot = [ones(size(x1_plot(:))), x1_plot(:), x2_plot(:)];
Z_plot = pr3_3_polyTransform(X_plot, Q);

%%% Running Linear regression
fprintf('\tLinear regression - no transformation... ');
w_lin = pinv(X) * y;
fprintf('Done!\n');

% Plotting results
figure; hold on;
pr1_4_plotLine(w_lin, 2, xlow, xupp);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Running Linear programming
fprintf('\tLinear programming - no transformation, separable case... ');
f = zeros(3, 1);
A = - X .* repmat(y, 1, 3);
b = -ones(N, 1);
w_linprog = linprog(f, A, b);

% Plotting results
figure; hold on;
pr1_4_plotLine(w_linprog, 2, xlow, xupp);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Running Linear regression - 3rd poly transform
fprintf('\tLinear regression - 3rd poly transform... ');
w_lin = pinv(Z) * y;
fprintf('Done!\n');

% Plotting results
y_plot = sign(Z_plot * w_lin);
figure; hold on;
pr3_3_plotColorRegion(X_plot(find(y_plot == +1), :), blueBackgroundColor);
pr3_3_plotColorRegion(X_plot(find(y_plot == -1), :), redBackgroundColor);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Running Linear programming - 3rd poly transform
fprintf('\tLinear programming - 3rd poly transform, separable case... ');
f = zeros(d_tilda + 1, 1);
A = - Z .* repmat(y, 1, d_tilda + 1);
b = -ones(N, 1);
w_linprog = linprog(f, A, b);

% Plotting results
y_plot = sign(Z_plot * w_linprog);
figure; hold on;
pr3_3_plotColorRegion(X_plot(find(y_plot == +1), :), blueBackgroundColor);
pr3_3_plotColorRegion(X_plot(find(y_plot == -1), :), redBackgroundColor);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');



%%% Generate dataset - separable dataset
fprintf('Case sep = -5 (nonseparable case)\n');
% Parameters
rad = 10;
thk = 5;
sep = -5;

xlow = -rad-thk;
xupp = 2*rad + 3/2*thk;
ylow = -sep-rad-thk;
yupp = rad+thk;

% X, Z and labels
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

[Z, d_tilda] = pr3_3_polyTransform(X, Q);

% Data for plotting
[x1_plot, x2_plot] = meshgrid(xlow:0.1:xupp, ylow:0.1:yupp);
X_plot = [ones(size(x1_plot(:))), x1_plot(:), x2_plot(:)];
Z_plot = pr3_3_polyTransform(X_plot, Q);

%%% Running Linear regression
fprintf('\tLinear regression - no transformation... ');
w_lin = pinv(X) * y;
fprintf('Done!\n');

% Plotting results
figure; hold on;
pr1_4_plotLine(w_lin, 2, xlow, xupp);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Running Linear programming
fprintf('\tLinear programming - no transformation, nonseparable case... ');
% First d variables of optimization vector correspond to w_linprog
% and the rest of N variables correspond to ksi (vailation) values
f  = [zeros(1, 3), ones(1, N)]; % Optimize only the sum of ksis
A  = -[X .* repmat(y, 1, 3), eye(N)];
b  = -ones(N, 1);
Aeq = [];
beq = [];
lb  = [-Inf(1, 3), zeros(1, N)]; % lower bound only for ksis
ub  = Inf(1, 3 + N);
result_linprog = linprog(f, A, b, [], [], lb, ub);
w_linprog      = result_linprog(1:3);

% Plotting results
figure; hold on;
pr1_4_plotLine(w_linprog, 2, xlow, xupp);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Performance comparison - on E_in - same d_VC, so E_out should follow
%   E_out also possible to calculate but not implemented here
fprintf('E_in(w_lin)     = %.4f\n', pr1_5_classificationError(X, y, w_lin));
fprintf('E_in(w_linprog) = %.4f\n', pr1_5_classificationError(X, y, w_linprog));


%%% Running Linear regression - 3rd poly transform
fprintf('\tLinear regression - 3rd poly transform... ');
w_lin = pinv(Z) * y;
fprintf('Done!\n');

% Plotting results
y_plot = sign(Z_plot * w_lin);
figure; hold on;
pr3_3_plotColorRegion(X_plot(find(y_plot == +1), :), blueBackgroundColor);
pr3_3_plotColorRegion(X_plot(find(y_plot == -1), :), redBackgroundColor);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Running Linear programming - 3rd poly transform
fprintf('\tLinear programming - 3rd poly transform, separable case... ');
f = zeros(d_tilda + 1, 1);
A = - Z .* repmat(y, 1, d_tilda + 1);
b = -ones(N, 1);
w_linprog = linprog(f, A, b);

% Plotting results
y_plot = sign(Z_plot * w_linprog);
figure; hold on;
pr3_3_plotColorRegion(X_plot(find(y_plot == +1), :), blueBackgroundColor);
pr3_3_plotColorRegion(X_plot(find(y_plot == -1), :), redBackgroundColor);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');


%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
