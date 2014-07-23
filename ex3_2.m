%%% Defining constants
d        = 2;
N_train  = 100;
N_test   = 1000;
p_revert = 0.1;

N_trials = 20;
T        = 1000;

E_in_t     = zeros(T, 1);
E_in_min_t  = zeros(T, 1);

E_out_t     = zeros(T, 1);
E_out_min_t = zeros(T, 1);

lower_bound = -ones(1, d);
upper_bound = +ones(1, d);

%%% Generate dataset

X_train = [ones(N_train, 1), rand(N_train, d) .* repmat(upper_bound - lower_bound, N_train, 1) + repmat(lower_bound, N_train, 1)];
X_test  = [ones(N_test , 1), rand(N_test , d) .* repmat(upper_bound - lower_bound, N_test , 1) + repmat(lower_bound, N_test , 1)];

% Picking random target function (hyperplane)
% Generating matrix for hyperplane calculation
matrix = [ones(d, 1), rand(d, d) .* repmat(upper_bound - lower_bound, d, 1) + repmat(lower_bound, d, 1)];

% Calculation each dimension of wtarged by 
% Laplacian expansion
w_target = zeros(d + 1, 1);
for i = 1:(d + 1)
    matrix_i = matrix;
    matrix_i(:, i) = [];
    w_target(i) = (-1)^(1 + i) * det(matrix_i);
end

% Labels - generating and reverting for data set
y_train = pr1_4_targetFunction(X_train, w_target);
y_test  = pr1_4_targetFunction(X_test,  w_target);

y_revert_idx = randsample(N, ceil(p_revert * N));
y_train(y_revert_idx) = (-1) * y_train(y_revert_idx);

%%% Running Pocket algorithm
for ntrial = 1:N_trials

    w        = zeros(d + 1, 1);
    w_min    = w;
    E_in_min = 1;
    
    for t = 1:T
       
        [x_mis, y_mis] = pr1_4_pickMisclassified(X_train, y_train, w);
        w = w + y_mis * x_mis;
        E_in = pr1_5_classificationError(X_train, y_train, w);
        
        if E_in < E_in_min
            E_in_min = E_in;
            w_min    = w; 
        end
        
        E_in_t(t)      = E_in_t(t)     + 1/N_trials * E_in;
        E_in_min_t(t)  = E_in_min_t(t) + 1/N_trials * E_in_min;
        
        E_out_t(t)     = E_out_t(t)     + 1/N_trials * pr1_5_classificationError(X_test, y_test, w);
        E_out_min_t(t) = E_out_min_t(t) + 1/N_trials * pr1_5_classificationError(X_test, y_test, w_min);
        
    end
end

% Plotting results
figure;
plot(1:T, E_in_t);
hold on;
plot(1:T, E_in_min_t, 'r-');
plot(1:T, E_out_t, 'g-');
plot(1:T, E_out_min_t, 'y-');

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
