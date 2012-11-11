n = 10^4
a = 0
b = 1

m = 100;
gamma = 0.95;

FUn = zeros (1, m);
FUnF = zeros (1, m);
FUnT = zeros (1, m);
FU = zeros (1, m);
X = zeros (1, m);
i = 0;
for t0 = 0.2:0.006:0.8
	i = i + 1;
	X(i) = t0;

	U = randn(1, n);# * (b - a) + a;
	Uind = (U < t0) + 0;
	FUn(i) = mean (Uind, 2);
	FU(i) = normcdf (t0, a, b);

	TU = norminv ((1 + gamma) / 2, a, b);
	DUn = TU * sqrt (FUn(i) .* (1 - FUn(i)) / n);
	FUnF(i) = FUn(i) - DUn;
	FUnT(i) = FUn(i) + DUn;
endfor

FU;
FUn;
FUnF;
FUnT;

subplot (1, 1, 1)
xlabel ("x")
ylabel ("F")
grid on
hold on
plot (X, FU, 'r');
stairs (X, FUnF, 'g');
stairs (X, FUnT);


