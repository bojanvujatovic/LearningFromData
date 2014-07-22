function prob = pr1_7_prob(epsilon, diff_max)

prob = zeros(size(epsilon));

for i = 1:length(epsilon)
    prob(i) = sum(diff_max > epsilon(i)) / length(diff_max);
end

end

