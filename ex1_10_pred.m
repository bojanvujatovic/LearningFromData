function pred = ex1_10_pred(epsilon, nus, mu)

Ntrials = length(nus);
pred = zeros(size(epsilon));

for i = 1:length(epsilon) 
    pred(i) = sum(epsilon(i) < abs(nus - mu)) / Ntrials;
end


end

