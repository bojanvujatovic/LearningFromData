% Generating constants and data set X
N_experiments = 100;
N = 1000;
d = 10;

lower_bound = -ones(1, d);
upper_bound =  ones(1, d);

X = [ones(N, 1), rand(N, d) .* repmat(upper_bound - lower_bound, N, 1) + repmat(lower_bound, N, 1)];

plotting_data = 0;
plotting_results = 0;

%%% Picking random target function (hyperplane)
%   Generating matrix for hyperplane calculation
matrix = [ones(d, 1), rand(d, d) .* repmat(upper_bound - lower_bound, d, 1) + repmat(lower_bound, d, 1)];

%   Calculation each dimension of wtarged by 
%   Laplacian expansion
w_target = zeros(d + 1, 1);
for i = 1:(d + 1)
    matrix_i = matrix;
    matrix_i(:, i) = [];
    w_target(i) = (-1)^(1 + i) * det(matrix_i);
end

% Generate y
y = pr1_4_targetFunction(X, w_target);

% Plot f boudary and points
if d == 2 && plotting_data == 1
    hold;
    pr1_4_plotline(w_target, 2, lower_bound(1), upper_bound(1));
    
    % Plot points
    plot(X(find(y == 1), 2)', X(find(y == 1), 3)', 'rx');
    plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');
end

% Run PLA
num_iterations = zeros(N_experiments, 1);

for n = 1:N_experiments
    
    w = zeros(d + 1, 1);
    [x_mis, y_mis] = pr1_4_pickMisclassified(X, y, w);

    while(size(x_mis, 1) > 0)
        num_iterations(n) = num_iterations(n) + 1;
        w = w + y_mis * x_mis;

        [x_mis, y_mis] = pr1_4_pickMisclassified(X, y, w);
    end;

    % Ploting w_target, final w and points
    if d == 2 && plotting_results == 1
        figure; hold;
        axis([lower_bound(1),upper_bound(1),lower_bound(2), upper_bound(2)])
        pr1_4_plotline(w_target, 1, lower_bound(1), upper_bound(1));
        pr1_4_plotline(w, 2, lower_bound(1), upper_bound(1));
        plot(X(find(y == 1), 2)', X(find(y == 1), 3)', 'rx');
        plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');
    end
end

hist(num_iterations)

% Exiting
fprintf('Press to exit...\n');
pause;
close all;