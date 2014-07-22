% Generating constants and data set X
N_train = 100;
N_test = 10000;
d = 2;
max_iterations = 1000;

etas = [100 1 0.01 0.0001];

X_train = [ones(N_train, 1), rand(N_train, d) * 2 - 1];
X_test  = [ones(N_test , 1), rand(N_test,  d) * 2 - 1];

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

% Generate ys
y_train = sign(X_train * w_target);
y_test = sign(X_test * w_target);

% Run PLA
for eta = etas
    
    num_iterations = 0;
    w = zeros(d + 1, 1);
    [X_mis, y_mis] = pr1_5_AdalineMisclassified(X_train, y_train, w);

    while size(X_mis, 1) > 0 && num_iterations < max_iterations

        num_iterations = num_iterations + 1;
        rand_row = ceil((1 - rand(1, 1)) * size(X_mis, 1));

        rand_x = X_mis(rand_row,:);
        rand_y = y_mis(rand_row);

        w = w + eta * (rand_y - rand_x * w) * rand_x';

        [X_mis y_mis]= pr1_5_AdalineMisclassified(X_train, y_train, w);
    end;

    if d == 2
        % Ploting w_target, final w and points
        figure; hold;
        axis([-1,1,-1,1])
        pr1_4_plotline(w_target, 1);
        pr1_4_plotline(w, 2);
        plot(X_train(find(y_train == 1), 2)', X_train(find(y_train == 1), 3)', 'rx');
        plot(X_train(find(y_train == -1), 2)', X_train(find(y_train == -1), 3)', 'bo');
    end
    
    E_test = sum(y_test ~= sign(X_test * w)) / N_test
end

% Exiting
fprintf('Press to exit...\n');
pause;
close all;