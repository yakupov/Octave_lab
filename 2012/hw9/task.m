#!/usr/bin/octave -qf

function res = f(x, t)
	deg = 4;
	res = 1 ./(1 + (x - t/2) .^ deg);
end

function res = err(x1, x2, n)
	res = sum((x2 - x1) .^ 2) / n;
end

function res = ff(cx, m, w)
	res = zeros (1, m + m + 1);
	for jj = -m:m
		res(jj + m + 1) = exp(i * jj * w * cx); 
	endfor
end


step = 0.15
m = 3;
T = 4
w = 2 * pi / T;
noiseScale = 0.1;
a = 0
b = T
x = a:step:b;
n = length(x)


y = f(x, T);
ywnoise = y + noiseScale * randn(1, n);

M = zeros(n, m);
for ii = 1:n
	for jj = -m:m
		M(ii, jj + m + 1) = exp(i * jj * w * x(ii)); 
	endfor
endfor

theta = (inv(M' * M) * M') * ywnoise'

step = 0.05
x = a:step:b;
y = f(x, T);
n = length(x)
ywnoise = y + noiseScale * randn(1, n);

ytest = zeros(1, n);
for ii = 1:n
	ytest(ii) = real(ff(x(ii), m, w) * theta);
endfor

err(ywnoise, y, n)
err(ytest, y, n)

hold on
grid on
subplot (1, 1, 1), 
xlabel ("x")
ylabel ("y")
plot (x, y, "r")
plot (x, ytest, "g")
plot (x, ywnoise, "b")

