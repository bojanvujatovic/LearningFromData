function mybound = ex110_mybound(epsilon, N)

mybound = zeros(size(epsilon));
for i = 1:length(epsilon)
    e = epsilon(i);
    
    lower_limit = ceil(N * (0.5 - e)) ;
    upper_limit = floor(N * (0.5 + e));
    
    if lower_limit > N
        continue;
    end
    if upper_limit < 0
        continue;
    end
    
    if lower_limit < 0
        lower_limit = 0;
    end
    if upper_limit > N
        upper_limit = N;
    end
    
    for j = lower_limit:upper_limit
        mybound(i) = mybound(i) + nchoosek(N, j);
    end
    mybound(i) =  1 - mybound(i) * 2^(-N);
    
    
    
end

end

