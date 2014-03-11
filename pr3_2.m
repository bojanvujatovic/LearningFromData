%%% Defining constants and initialization
Ntrials = 100;

sep_vals = 0.2:0.2:5;
t_vals   = zeros(size(sep_vals));

for n = 1:Ntrials
    n
    for i = 1:length(sep_vals)
        %%% Defining constants
        d     = 2;
        N     = 2000;

        rad = 10;
        thk = 5;
        sep = sep_vals(i);

        xlow = -rad-thk;
        xupp = 2*rad + 3/2*thk;
        ylow = -sep-rad-thk;
        yupp = rad+thk;

        %%% Generate dataset
        % X and labels
        X =  ones(N, d + 1);
        y = zeros(N, 1);

        counter = 1;
        while counter <= 2000

            x1 = rand(1, 1)*(xupp - xlow) + xlow;
            x2 = rand(1, 1)*(yupp - ylow) + ylow;
            label = pr3_1_target(x1, x2, rad, thk, sep);

            if label ~= 0
                X(counter, 2:3) = [x1, x2];
                y(counter)      = label;
                counter = counter + 1;
            end

        end

        %%% Running PLA
        w = zeros(3, 1);
        Ein = 1;
        t = 0;

        while Ein > 0

        %     ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
        %     hold on;
        %     ex3_2_plotLine(w, 1, xlow, xupp);

            [xmis, ymis] = ex3_2_pickMisclassified(X, y, w);
            w = w + ymis * xmis;

        %     plot(xmis(2), xmis(3),'--rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize', 20);
        %     hold off;
        %     pause;
        %     ex3_2_plotData(X, y, xlow, xupp, ylow, yupp);
        %     hold on;
        %     ex3_2_plotLine(w, 1, xlow, xupp);
        %     hold off;

            Ein = ex3_2_calcError(X, y, w);
            t = t + 1;
        end

        t_vals(i) = t_vals(i) + t;

    end
end


%%% Averaging
t_vals = t_vals / Ntrials;

%%% Plotting
figure(1);
plot(sep_vals, t_vals, 'b-');

%%% Ending
fprintf('Press any key to exit...\n');
pause;
close all;
