function labels = pr3_1_targetFunction(x1vect, x2vect, rad, thk, sep)

%%% Initialization
N = size(x1vect, 1);
labels = zeros(N, 1);

%%% Classification
for i = 1:N
    
    x = x1vect(i);
    y = x2vect(i);
    
    % Red circle
    if     y >= 0    && x^2 + y^2 >= rad^2 && x^2 + y^2 <= (rad + thk)^2
        labels(i) = -1;
    % Blue circle
    elseif y <= -sep && (x-rad-thk/2)^2 + (y+sep)^2 >= rad^2 && (x-rad-thk/2)^2 + (y+sep)^2 <= (rad + thk)^2
        labels(i) = +1;
    end
    
end


end

