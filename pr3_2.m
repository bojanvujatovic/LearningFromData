%%% Defining constants and variables
N        = 2000;
N_trials = 100;

rad  = 10;
thk  = 5;
seps = 0.2:0.2:5;
n_iterations = zeros(size(seps));

msg = '';

%%% Running experiment - 
%   for every sep value N_trials times

for i = 1:N_trials
    
    fprintf(repmat('\b', 1, numel(msg)));
    msg = sprintf('Done: %.2f%%\n', i/N_trials);
    fprintf('Done: %.2f%%\n', i/N_trials);
    
    for j = 1:length(seps)        
        sep = seps(j);
 
        %%% Generate dataset
        % X and labels
        X =  ones(N, 3);
        y = zeros(N, 1);

        xlow = -rad-thk;
        xupp = 2*rad + 3/2*thk;
        ylow = -sep-rad-thk;
        yupp = rad+thk;

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

        %%% Running PLA
        w_perceptron = zeros(3, 1);
        Ein = 1;
        [xmis, ymis] = pr1_4_pickMisclassified(X, y, w_perceptron);

        while length(ymis) > 0
            w_perceptron = w_perceptron + ymis * xmis;
            [xmis, ymis] = pr1_4_pickMisclassified(X, y, w_perceptron);
            n_iterations(j) = n_iterations(j) + 1/N_trials;
        end
        
    end
end

%%% Plotting dependency sep and n_iterations
figure;
plot(seps, n_iterations);

%%% Ending
fprintf('\nPress any key to exit...\n');
pause;
close all;
