function [] = ex3_2_plotData(X, y, xlow, xupp, ylow, yupp)

idxpos = find(y == +1);
idxneg = find(y == -1);

plot(X(idxpos, 2)', X(idxpos, 3)', 'bo');
hold on;
plot(X(idxneg, 2)', X(idxneg, 3)', 'rx');

axis([xlow xupp ylow yupp]);
hold off;
end

