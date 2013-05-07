#!/usr/bin/octave -qf

function retval = f(x)
  retval = els(x);
endfunction

function retval = els(x)
  retval = -exp(-x) .* log(x) .* sin(4 .* x);
endfunction

function retval = goldt()
  retval = (sqrt(5) - 1) / 2;
endfunction

function retval = polyGrowing(x, pol)
  retval = (polyval(pol, x + 1e-12) - polyval(pol, x) > 0);
endfunction

function retval = goldMinPoly(a, b, eps, pol)
	currA = a;
	currB = b;
	while (currB - currA > eps)
		x1 = currB - (currB - currA) * goldt();
		x2 = currA + (currB - currA) * goldt();

		if (polyval(pol, x1) < polyval(pol, x2)) 
			currB = x2;
		else
			currA = x1;
		endif
	endwhile
	
	retval = (currA + currB) / 2;
endfunction


eps = 1e-3
delta = 1e-2
a = 0
b = 6

step = 1e-2
grid = a:step:b;
res = f(grid);

#delete NANs
i = 1;
while i <= length(res)
	if isnan(res(i))
		res(i) = [];
		grid(i) = [];
	else
		i++;
	endif
endwhile

polyDeg = 1
err = eps + 1

while err > eps
	polyDeg++
	err

	poly = polyfit(grid, res, polyDeg);
	resPol = polyval(poly, grid);

	err = 0;
	for i = 1:length(res)
		err = max(err, (res(i) - resPol(i))^2);
	endfor
endwhile

err
polyDeg
poly

locMins = [a, b]
l = a
r = a
while (r < b)
	while (polyGrowing(l, poly) && r < b)
		l = l + delta;
		r = l;
	endwhile

	while (!polyGrowing(r, poly) && r < b)
		r = r + delta;
	endwhile

	if (r < b)
		locMins = [locMins, goldMinPoly(l, r, eps, poly)];
		l = r;
	endif
endwhile

printf("\nAnswer:\n");
locMins
minx = a;
for cmin = locMins
	if (f(cmin) < f(minx) || isnan(f(minx)))
		minx = cmin;
	endif
endfor
minx
f(minx)
