% Generating constants and data set X
N_experiments = 100;
N = 1000;
d = 10;
X = [ones(N, 1), rand(N, d) * 2 - 1];

%%% Picking random target function (hyperplane)
%   Generating matrix for hyperplane calculation
matrix = [ones(d, 1), rand(d, d) * 2 - 1];

%   Calculation each dimension of wtarged by 
%   Laplacian expansion
w_target = zeros(d + 1, 1);
for i = 1:(d + 1)
    matrix_i = matrix;
    matrix_i(:, i) = [];
    w_target(i) = (-1)^(1 + i) * det(matrix_i);
end

% Generate y
y = sign(X * w_target);

if d == 2
    % % Plot f boudary
    % hold;
    % pr1_4_plotline(w_target, 2);
    
    % % Plot points
    % plot(X(find(y == 1), 2)', X(find(y == 1), 3)', 'rx');
    % plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');
end

% Run PLA
num_iterations = zeros(N_experiments, 1);

for n = 1:N_experiments
    
    w = zeros(d + 1, 1);
    [X_mis, y_mis] = pr1_4_misclassified(X, y, w);

    while(size(X_mis, 1) > 0)

        num_iterations(n) = num_iterations(n) + 1;
        rand_row = ceil((1 - rand(1, 1)) * size(X_mis, 1));

        rand_x = X_mis(rand_row,:);
        rand_y = y_mis(rand_row);

        w = w + rand_y * rand_x';

        [X_mis y_mis]= pr1_4_misclassified(X, y, w);
    end;

    % num_iterations(n)

    if d == 2
        % % Ploting w_target, final w and points
        % figure; hold;
        % axis([-1,1,-1,1])
        % pr1_4_plotline(w_target, 1);
        % pr1_4_plotline(w, 2);
        % plot(X(find(y == 1), 2)', X(find(y == 1), 3)', 'rx');
        % plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');
    end
end

hist(num_iterations)

% Exiting
fprintf('Press to exit...\n');
pause;
close all;