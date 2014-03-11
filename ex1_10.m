% Defining constants
mu = 0.5;
Ntrials = 10000;
Ncoins  = 1000;
Nflips  = 10;

% Initialization
nu1    = zeros(Ntrials, 1);
nurand = zeros(Ntrials, 1);
numin  = zeros(Ntrials, 1);

% Running experiment
fprintf('Running experiment...\n')
for i = 1:Ntrials
    
    flipping_results = rand(Nflips, Ncoins) < mu;
    nus = sum(flipping_results) / Nflips;
    
    c1    = 1;
    crand = randi(Ncoins, 1, 1);
    [numin(i), cmin]  = min(nus);
    
    nu1(i)    = nus(c1);
    nurand(i) = nus(crand);
    
end

% Plotting histograms
fprintf('Plotting results...\n')

figure(1);
hist(nu1, 11);

figure(2);
hist(nurand, 11);

figure(3);
hist(numin, 11);

% Plotting estimates and Hoeffding's bound
fprintf('Plotting estimates and Hoeffding''s bound...\n')
epsilon = 0:0.05:1;
Hoeff   = ex1_10_Hoeff_single(epsilon, Nflips);
mybound = ex1_10_mybound(epsilon, Nflips);

figure(4);
plot(epsilon, Hoeff, 'r-');
hold;
plot(epsilon, mybound, 'g-');
pred = ex1_10_pred(epsilon, nu1, mu);
plot(epsilon, pred, '-')

figure(5);
plot(epsilon, Hoeff, 'r-');
hold;
plot(epsilon, mybound, 'g-');
pred = ex1_10_pred(epsilon, nurand, mu);
plot(epsilon, pred, '-')

figure(6);
plot(epsilon, Hoeff, 'r-');
% valid bound: plot(epsilon, Hoeff * Ncoins, 'r-');
hold;
plot(epsilon, mybound, 'g-');
pred = ex1_10_pred(epsilon, numin, mu);
plot(epsilon, pred, '-')

% Exitting
fprintf('Press any key to exit...\n')
pause;
close all;