X = [1 1 1.5;
     1 10 1.5;
     1 2 2;
     1 1 2];
 
 y = [-1 -1, 1, 1]';
 
 N = length(y);
     

%%% Running Linear programming
fprintf('\tLinear programming - no transformation, separable case... ');
% First d variables of optimization vector correspond to w_linprog
% and the rest of N variables correspond to ksi (vailation) values
f  = [zeros(1, 3), ones(1, N)]; % Optimize only the sum of ksis
A  = -[X .* repmat(y, 1, 3), eye(N)];
b  = -ones(N, 1);
Aeq = [];
beq = [];
lb  = [-Inf(1, 3), zeros(1, N)];
ub  = Inf(1, 3 + N);
result_linprog = linprog(f, A, b, [], [], lb, ub);
w_linprog      = result_linprog(1:3);

% Plotting results
figure; hold on;
pr1_4_plotLine(w_linprog, 2, xlow, xupp);
plot(X(find(y == -1), 2)', X(find(y == -1), 3)', 'rx');
plot(X(find(y == +1), 2)', X(find(y == +1), 3)', 'bo');


%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;