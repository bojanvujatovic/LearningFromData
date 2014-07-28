%%% Defining constants
N       = 50;
N_class = 2 * N;
d       = 1;
d_class = d + 1;

a = [0; 0.1];
sigma = 0.1;

lower_bound = [0];
upper_bound = [1];

%%% Generate dataset
X = [ones(N, 1), rand(N, d) .* repmat(upper_bound - lower_bound, N, 1) + repmat(lower_bound, N, 1)];
y = pr3_13_targetFunction(X, sigma);

X_class_minus = [X, y];
X_class_minus(:, 2:end) = X_class_minus(:, 2:end) - repmat(a', N, 1);
y_class_minus = -ones(N, 1);

X_class_plus = [X, y];
X_class_plus(:, 2:end) = X_class_plus(:, 2:end) + repmat(a', N, 1);
y_class_plus = +ones(N, 1);

X_class = [X_class_minus; X_class_plus];
y_class = [y_class_minus; y_class_plus];

%%% Running Linear regression
fprintf('Linear regression... ');
w_lin = pinv(X) * y;
fprintf('Done!\n');

%%% Running Linear programming for classification
fprintf('Linear programming for classification... ');
% First d variables of optimization vector correspond to w_linprog
% and the rest of N variables correspond to ksi (vailation) values
f  = [zeros(1, d_class + 1), ones(1, N_class)]; % Optimize only the sum of ksis
A  = -[X_class .* repmat(y_class, 1, d_class + 1), eye(N_class)];
b  = -ones(N_class, 1);
Aeq = [];
beq = [];
lb  = [-Inf(1, d_class + 1), zeros(1, N_class)]; % lower bound only for ksis
ub  = Inf(1, d_class + 1 + N_class);
result_linprog = linprog(f, A, b, [], [], lb, ub);
w_class        = result_linprog(1:(d_class + 1));

% Plotting data for classification and w_class
figure; hold on;
pr1_4_plotLine(w_class, 2, lower_bound(1), upper_bound(1));
plot(X_class(find(y_class == -1), 2)', X_class(find(y_class == -1), 3)', 'rx');
plot(X_class(find(y_class == +1), 2)', X_class(find(y_class == +1), 3)', 'bo');

%%% Plotting linear regression scenarion and showing results
w_class_lin = -w_class(1:(d+1)) / w_class(d_class + 1);
figure; hold on;
plot(X(:, 2)', y,  'Color', 'black', 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 18);
pr1_4_plotLine([w_lin;      -1], 1, lower_bound(1), upper_bound(1));
pr1_4_plotLine([w_class_lin;-1], 2, lower_bound(1), upper_bound(1));

%%% Performance comparison - on E_in - same d_VC, so E_out should follow
%   E_out also possible to calculate but not implemented here
fprintf('E_in(w_lin)       = %.4f\n', pr3_13_meanSquaredError(X, y, w_lin));
fprintf('E_in(w_class_lin) = %.4f\n', pr3_13_meanSquaredError(X, y, w_class_lin));

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
