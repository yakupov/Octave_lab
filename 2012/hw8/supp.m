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

#add suppession
M(1, 1) = 1;
M(1, 2) = 0;
M(n, n) = 1;
M(n, n - 1) = 0;

Px0 = zeros(0, n);
Pxn = zeros(0, n);

for i = 1:n
	if (p == q)
		Px0(i) = 1 - (i - 1) / (n - 1);
		Pxn(i) = (i - 1) / (n - 1);
	else
		Px0(i) = ((q / p) ^ (i - 1) - (q / p) ^ (n - 1)) / (1 - (q / p) ^ (n - 1))
		Pxn(i) = (1 - (q / p) ^ i) / (1 - (q / p) ^ (n - 1))
	endif
endfor

Px0
Pxn
M


count = 10

for c = 1:count
	stepsCount = 10^2
	startPos = round(n / 2)
	pos = startPos

	graph = zeros(1, stepsCount);
	for i = 1:stepsCount
		graph(i) = pos;
		if ((pos > 1) && (pos < n))
			if rand(1, 1) > M(pos, pos - 1)
				pos--;
			else
				pos++;
			endif
		elseif (pos == 1)
			break;
		elseif (pos == n)
			for j = i:stepsCount
				graph(j) = n;
			endfor
			break;
		endif
	endfor

	graph;

	grid on
	hold on
	subplot (count / 2, 2, c), 
	xlabel ("step")
	ylabel ("f(step)")
	plot (1:stepsCount, graph, "r")
	
endfor
