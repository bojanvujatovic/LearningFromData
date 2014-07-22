% Constants
N_flips  = 6;
N_coins  = 2;
mu = 0.5;

N_trials = 10000;
diff_max = zeros(N_trials, 1);

% Running experiment
fprintf('Running... \n');
for i = 1:N_trials
    
    flips = rand(N_flips, N_coins) < mu;
    nus = sum(flips) / N_flips;
    
    diff_max(i) = max(abs(nus-mu));
end

% Plotting bounds
fprintf('Plotting....\n');
epsilon = 0:0.01:1;

Hoeff_single = ex1_10_Hoeff_single(epsilon, N_flips);

Hoeff = 2 * Hoeff_single;
prob  = pr1_7_prob(epsilon, diff_max);

plot(epsilon, prob, '-');
hold;
plot(epsilon, Hoeff, 'r-');

% Exiting
fprintf('Press to exit...\n');
pause;
close all;