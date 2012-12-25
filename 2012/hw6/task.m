#!/usr/bin/octave -qf

Xmin = 0
Xmax = 100
Xlen = 10^2
delta = (Xmax - Xmin) / Xlen
sigma = 1

#dim = 3
#C = [2, 1, 7]

dim = 2
C = [2, 1]

X = Xmin:delta:(Xmax-delta);
Y = polyval (C, X) + sigma * randn (1, Xlen);

M = zeros (dim, dim + 1);

for i = 1:dim
	for j = 1:dim
		M(i, j) = sum(X .^ (i + j - 2));
	endfor
	M(i, dim + 1) = sum((X .^ (i - 1)) .* Y);
endfor

M
Mres = rref(M)

pf = polyfit (X, Y, dim);
pf_C = pf (2:end)

subplot (1, 1, 1)
xlabel ("x")
ylabel ("y")
grid on
hold on
plot (X, Y1 = polyval (C, X), "r");
plot (X, Y2 = polyval (pf_C, X), "g");
plot (X, Y, 'x');

if dim == 2
	cov = sum(X .* Y) / Xlen - (sum(X) / Xlen) * (sum(Y) / Xlen)
	meanX = sum(X) / Xlen
	meanY = sum(Y) / Xlen
	s2 = sum((X - meanX) .^ 2) / Xlen

	Areg = cov / s2
	Breg = meanY - Areg * meanX
	plot (X, Yreg = polyval ([Areg, Breg], X), "m");
endif

