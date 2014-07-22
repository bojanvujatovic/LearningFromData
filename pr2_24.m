% Initializations
num_iter = 100000;
w_bar = 0;

% generating random D, calculating w^(D) in each iteration
for i = 1:num_iter
   
    % Generate training examples
    X      = rand(2, 1) * 2 -  1;
    X_bias = [ones(size(X,1),1), X];
    y      = pr2_24_targetFunction(X);
    
    % Linear regression - calculating weights
    w_bar = w_bar + 1/num_iter * pinv(X_bias) * y;
end

w_bar

% Sample points from X space
n_sample = 100000;
X_sample      = linspace(-1, 1, n_sample)';
X_sample_bias = [ones(size(X_sample,1),1), X_sample];
y_sample      = pr2_24_targetFunction(X_sample);

% Eout, var and bias - taking sample from X space
Eout = 0; var = 0; 

for i = 1:num_iter
   
    % Generate training examples
    X      = rand(2, 1) * 2 -  1;
    X_bias = [ones(size(X,1),1), X];
    y      = pr2_24_targetFunction(X);
    
    % Linear regression - calculating weight
    w = pinv(X_bias) * y;
    
    var = var + 1/(num_iter * n_sample) * ...
        (X_sample_bias * w - X_sample_bias * w_bar)' * (X_sample_bias * w - X_sample_bias * w_bar);
    
    Eout = Eout + 1/(num_iter * n_sample) * ...
        (X_sample_bias * w - y_sample)' * (X_sample_bias * w - y_sample);
end

bias =  1/n_sample * (X_sample_bias * w_bar - y_sample)' * (X_sample_bias * w_bar - y_sample);

fprintf('bias: %f\nvar:  %f\nEout: %f\n\n', bias, var, Eout);

% Plotting
fprintf('Plotting...\n');
figure;
plot(X_sample, y_sample, 'b-');
hold on;
plot(X_sample, X_sample_bias * w_bar, 'r-');

% Exiting
fprintf('Press to exit...\n');
pause;
close all;