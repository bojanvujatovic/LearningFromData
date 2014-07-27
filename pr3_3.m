%%% Defining constants
N            = 2000;
N_iterations = 1000000;

rad = 10;
thk = 5;
sep = -5;

xlow = -rad-thk;
xupp = 2*rad + 3/2*thk;
ylow = -sep-rad-thk;
yupp = rad+thk;

Q = 3;

redBackgroundColor =  [255, 148, 148]/255;
blueBackgroundColor = [113, 139, 222]/255;

%%% Generate dataset
% X and labels
X =  ones(N, 3);
y = zeros(N, 1);

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

%%% Running pocket algorithm - no transformation
w = zeros(3, 1);
w_min = w;
E_in_min = 1;
E_in_min_vals = zeros(size(1, N_iterations));

msg = '';
for t = 1:N_iterations
    
    if mod(t, N_iterations/500) == 0
        fprintf(repmat('\b', 1, numel(msg)));
        msg = sprintf('Pocket algorithm - no transformation... Done: %.2f%%', t/N_iterations*100);
        fprintf('Pocket algorithm - no transformation... Done: %.2f%%', t/N_iterations*100);
    end
    
    [xmis, ymis] = pr1_4_pickMisclassified(X, y, w);
    w = w + ymis * xmis;
    
    E_in = pr1_5_classificationError(X, y, w);
    if E_in < E_in_min
        E_in_min = E_in;
        w_min = w;
    end
    
    E_in_min_vals(t) = E_in_min;
end

%%% Plotting
% Ein vs time
figure;
plot(1:N_iterations, E_in_min_vals);

% Dataset and final hypothesis
figure;
pr1_4_plotLine(w_min, 1, xlow, xupp);
hold on;
plot(X(find(y ==  1), 2)', X(find(y ==  1), 3)', 'rx');
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'bo');

%%% Running Linear regression and plotting
fprintf('\nLinear regression - no transformation... ');
w_lin = pinv(X) * y;
fprintf('Done!\n');
pr1_4_plotLine(w_lin, 2, xlow, xupp);

%%% Performance comparison - on E_in - same d_VC, so E_out should follow
%   E_out also possible to calculate but not implemented here
fprintf('E_in(w_pocket) = %.4f\n', pr1_5_classificationError(X, y, w_min));
fprintf('E_in(w_lin)    = %.4f\n', pr1_5_classificationError(X, y, w_lin));

%%% Running pocket algorithm - 3rd poly transformation
[Z, d_tilda] = pr3_3_polyTransform(X, Q);

w = zeros(d_tilda + 1, 1);
w_min = w;
E_in_min = 1;
E_in_min_vals = zeros(size(1, N_iterations));

[zmis, ymis] = pr1_4_pickMisclassified(Z, y, w);

msg = '';
for t = 1:N_iterations
    
    if mod(t, N_iterations/500) == 0
        fprintf(repmat('\b', 1, numel(msg)));
        msg = sprintf('Pocket algorithm - 3rd poly transformation... Done: %.2f%%', t/N_iterations*100);
        fprintf('Pocket algorithm - 3rd poly transformation... Done: %.2f%%', t/N_iterations*100);
    end
    
    w = w + ymis * zmis;
    
    E_in = pr1_5_classificationError(Z, y, w);
    if E_in < E_in_min
        E_in_min = E_in;
        w_min = w;
    end
    
    E_in_min_vals(t) = E_in_min;
    
    [zmis, ymis] = pr1_4_pickMisclassified(Z, y, w);
    if length(ymis) == 0
        fprintf('\nFound w for which E_in(w) = 0. Plotting...\n');
        break
    end
end

%%% Plotting
% Ein vs time
figure;
plot(1:t, E_in_min_vals);

% Data and bound
figure; hold on;
[x1_plot, x2_plot] = meshgrid(xlow:0.1:xupp, ylow:0.1:yupp);
X_plot = [ones(size(x1_plot(:))), x1_plot(:), x2_plot(:)];
Z_plot = pr3_3_polyTransform(X_plot, Q);
y_plot = sign(Z_plot * w);

pr3_3_plotColorRegion(X_plot(find(y_plot == +1), :), blueBackgroundColor);
pr3_3_plotColorRegion(X_plot(find(y_plot == -1), :), redBackgroundColor);

plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
