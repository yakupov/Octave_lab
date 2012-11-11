function [result] = f(x)
	result = x.^3 .* exp(-2 .* x);
end

function [result] = ff(y)
	result = ((1 - y) .^3 ./  y .^ 5) .* exp(2 - 2 ./ y);
end

function [result] = g(x)
	result = 1 ./ (1 + x .^ 4).^(0.5);
end

gamma = 0.95;
n = 10^5;

a = 0;
b = 1;
U = rand(n, 1) * (b - a) + a;
Y = ff(U);
E = mean(Y) * (b - a)

precision = 1 / sqrt(n)
t = tcdf ((1 - gamma) / 2, n - 1);
s = var(U);
delta = t * s / sqrt(n)
I_n = [E - delta, E + delta]


a = -4;
b = 5;
U = rand(n, 1) * (b - a) + a;
Y = g(U);
E = mean(Y) * (b - a)

precision = 1 / sqrt(n)
t = tcdf ((1 - gamma) / 2, n - 1);
s = var(U);
delta = t * s / sqrt(n)
I_n = [E - delta, E + delta]
