%%% Defining constants
d     = 2;
N     = 100;
Ntest = 1000;
pflip = 0.1;

Ntrials = 20;
T       = 1000;

Eint     = zeros(T, 1);
Einmint  = zeros(T, 1);

Eoutt    = zeros(T, 1);
Eoutmint = zeros(T, 1);

xlow = -1;
xupp =  1;
ylow = -1;
yupp =  1;

%%% Generate dataset
% X
X     = [ones(N    , 1), rand(N    , 2)*(xupp - xlow) + xlow];
Xtest = [ones(Ntest, 1), rand(Ntest, 2)*(xupp - xlow) + xlow];

% Line
xA = rand(1, 1)*(xupp - xlow) + xlow;
yA = rand(1, 1)*(xupp - xlow) + xlow;
xB = rand(1, 1)*(xupp - xlow) + xlow;
yB = rand(1, 1)*(xupp - xlow) + xlow;
k = (yB - yA)/(xB - xA);

wtarget = [k*xA - yA; -k; 1];

% Labels
y     = ex3_2_predict(X    , wtarget);
ytest = ex3_2_predict(Xtest, wtarget);

ypermidx = randperm(N);
ypermidx = ypermidx(1:ceil(pflip * N));
ytestpermidx = randperm(Ntest);
ytestpermidx = ytestpermidx(1:ceil(pflip * Ntest));

y    (ypermidx)     = y    (ypermidx)     * (-1);
ytest(ytestpermidx) = ytest(ytestpermidx) * (-1);

%%% Running Pocket algorithm
for ntrial = 1:Ntrials

    w = zeros(3, 1);
    wmin = w;
    Einmin = 1.1;
    
    for t = 1:T
       
        [xmis, ymis] = ex3_2_pickMisclassified(X, y, w);
        w = w + ymis * xmis;
        
        Ein = ex3_2_calcError(X, y, w);
        if Ein < Einmin
            Einmin = Ein;
            wmin   = w; 
        end
        
        Eint(t)     = Eint(t) + Ein;
        Einmint(t)  = Einmint(t) + Einmin;
        
        Eoutt(t)    = Eoutt(t) + ex3_2_calcError(Xtest, ytest, w);
        Eoutmint(t) = Eoutmint(t) + ex3_2_calcError(Xtest, ytest, wmin);
        
    end
    
    
end

Eint     = Eint /Ntrials;
Einmint  = Einmint /Ntrials;
        
Eoutt    = Eoutt /Ntrials;
Eoutmint = Eoutmint /Ntrials;

% figure(2);
% 
% plot(1:T, Eint);
% hold on;
% plot(1:T, Einmint, 'r-');
% hold on;
% plot(1:T, Eoutt, 'g-');
% hold on;
% plot(1:T, Eoutmint, 'y-');

figure;
ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
hold on;
ex3_2_plotLine(wtarget, 1, xlow, xupp);

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
