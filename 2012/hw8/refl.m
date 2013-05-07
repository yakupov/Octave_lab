#!/usr/bin/octave -qf

function res = genMatrixWithRefl(n, p, q)
	res = zeros(n);
	for i = 1:n
		for j = 1:n
			if (j == i - 1) || (j == 1 && i == 1)
				res(i, j) = q;
			elseif (j == i + 1) || (j == n && i == n)
				res(i, j) = p;
			endif
		endfor
	endfor
endfunction

p = 0.4
q = 1 - p
n = 10^1
M = genMatrixWithRefl(n, p, q);

Pj = zeros(0, n);

for i = 1:n
	if (p == q)
		Pj(i) = 1 / n;
	else
		Pj(i) = ((p / q) ^ (i - 1) - (p / q) ^ i) / (1 - (p / q) ^ n);
	endif
endfor

Pj
M

res = zeros(n + 1);

for j = 1:(n + 1)
	res(1, j) = 1;
endfor 

for i = 2:(n + 1)
	for j = 1:n
		if (j == i - 1)
			res(i, j) = M(j, i - 1) - 1;
		else
			res(i, j) = M(j, i - 1);
		endif
	endfor
	res(i, n + 1) = 0;
endfor

matrSolution = rref(res)




colors = ['c', 'r', 'b', 'k', 'g', 'm', 'y', 'v', 'x', 'p']
count = 10

for c = 1:count
	stepsCount = 10^2
	startPos = round(n / 2)
	pos = startPos

	graph = zeros(1, stepsCount);
	for i = 1:stepsCount
		graph(i) = pos;
		if ((pos > 1) && (pos < n))
			if rand(1,1) > M(pos, pos - 1)
				pos--;
			else
				pos++;
			endif
		elseif (pos == 1) && (rand(1,1) <= M(pos, pos))
			pos++;
		elseif (pos == n) && (rand(1,1) > M(pos, pos))
			pos--;
		endif
	endfor

	graph;

	subplot (1, 1, 1)
	xlabel ("step")
	ylabel ("f(step)")
	grid on
	hold on
	plot (1:stepsCount, graph, colors(c));
endfor
