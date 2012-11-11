m = 10^2
n = 10^5

a = 0
b = 1
t0 = (a + b) / 3

# F(t0)
FUt0 = unifcdf (t0, a, b)
U = rand(m, n) * (b - a) + a;
Uind = (U < t0) + 0;
FUn = mean (Uind, 2);

nn = (0.98 - 0.9) / 0.005;
g = zeros (1, nn);
l = zeros (1, nn);
gamma = 0.9;

for ii = 1:nn
	U = rand(m, n) * (b - a) + a;
	Uind = (U < t0) + 0;
	FUn = mean (Uind, 2);

	TU = norminv ((1 + gamma) / 2, a, b);
	DUn = TU * sqrt (FUn .* (1 - FUn) / n);
	From = FUn - DUn;
	To = FUn + DUn;

	g(ii) = gamma;
	l(ii) = 0;
	for i = 1:m
		if (FUt0 < From(i) | FUt0 > To(i))
			l(ii) += 1;
		endif
	endfor

	gamma += 0.005;
endfor

g
l
