% Constants
Nflips  = 6;
Ncoins  = 2;
mu = 0.5;

Ntrials = 1000000;
numax = zeros(Ntrials, 1);

% Running experiment
fprintf('Running... \n');
for i = 1:Ntrials
    
    flips = rand(Nflips, Ncoins) < mu;
    nus = sum(flips) / Nflips;
    
    numax(i) = max(nus);
end

% Plotting bounds
fprintf('Plotting....\n');
epsilon = 0:0.02:1;

Hoeffsingle = ex110_Hoeff_single(epsilon, Nflips);

Hoeff = Hoeffsingle + Hoeffsingle - Hoeffsingle .* Hoeffsingle;
pred  = ex110_pred(epsilon, numax, mu);

plot(epsilon, pred, '-');
hold;
plot(epsilon, Hoeff, 'r-');


% Exiting
fprintf('Press to exit...\n');
pause;
close all;