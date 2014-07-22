% Initializations
num_iter = 100000;

w_a_bar = 0;
w_b_bar = 0;
w_c_bar = 0;
close all;

% (ii) - generating random D, calculating w^(D)
%        in each iteration
for i = 1:num_iter
   
    % Generate training examples
    X      = rand(2, 1) * 2 -  1;
    X_bias = [ones(size(X,1),1), X];
    y      = pr2_23_targetFunction(X);
    
    % Linear regression - calculating weights
    w_a_bar = w_a_bar + 1/num_iter * pinv(X_bias) * y;
    w_b_bar = w_b_bar + 1/num_iter * pinv(X) * y;
    w_c_bar = w_c_bar + 1/num_iter * sum(y)/length(y);
end

w_a_bar
w_b_bar
w_c_bar

% Sample points from X space
n_sample = 100000;
X_sample      = linspace(-1, 1, n_sample)';
X_sample_bias = [ones(size(X_sample,1),1), X_sample];
y_sample      = pr2_23_targetFunction(X_sample);

% (iii) Eout, var and bias - taking sample from X space
Eout_a = 0; var_a = 0;
Eout_b = 0; var_b = 0; 
Eout_c = 0; var_c = 0;

for i = 1:num_iter
   
    % Generate training examples
    X      = rand(2, 1) * 2 -  1;
    X_bias = [ones(size(X,1),1), X];
    y      = pr2_23_targetFunction(X);
    
    % Linear regression - calculating weight
    w_a = pinv(X_bias) * y;
    w_b = pinv(X) * y;
    w_c = sum(y)/length(y);
    
    var_a = var_a + 1/(num_iter * n_sample) * ...
        (X_sample_bias * w_a - X_sample_bias * w_a_bar)' * (X_sample_bias * w_a - X_sample_bias * w_a_bar);
    
    var_b = var_b + 1/(num_iter * n_sample) * ...
        (X_sample * w_b - X_sample * w_b_bar)' * (X_sample * w_b - X_sample * w_b_bar);
    
    var_c = var_c + 1/num_iter * ...
        (w_c - w_c_bar)' * (w_c - w_c_bar);
    
    
    Eout_a = Eout_a + 1/(num_iter * n_sample) * ...
        (X_sample_bias * w_a - y_sample)' * (X_sample_bias * w_a - y_sample);
    
    Eout_b = Eout_b + 1/(num_iter * n_sample) * ...
        (X_sample * w_b - y_sample)' * (X_sample * w_b - y_sample);

    Eout_c = Eout_c + 1/(num_iter * n_sample) * ...
        (w_c - y_sample)' * (w_c - y_sample);
end

bias_a =  1/n_sample * (X_sample_bias * w_a_bar - y_sample)' * (X_sample_bias * w_a_bar - y_sample);
bias_b =  1/n_sample * (X_sample * w_b_bar - y_sample)' * (X_sample * w_b_bar - y_sample);
bias_c =  1/n_sample * (w_c_bar - y_sample)' * (w_c_bar - y_sample);

fprintf('bias_a: %f\nvar_a:  %f\nEout_a: %f\n\n', bias_a, var_a, Eout_a);
fprintf('bias_b: %f\nvar_b:  %f\nEout_b: %f\n\n', bias_b, var_b, Eout_b);
fprintf('bias_c: %f\nvar_c:  %f\nEout_c: %f\n\n', bias_c, var_c, Eout_c);

% Exiting
fprintf('Press to exit...\n');
pause;
close all;