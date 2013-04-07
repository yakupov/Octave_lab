#!/usr/bin/octave -qf

function retval = f(x)
  retval = els(x);
endfunction

function retval = quad1(x)
  retval = x^2 - 2 * x;
endfunction

function retval = xcosx(x)
  retval = x * cos(x);
endfunction

function retval = els(x)
  retval = -exp(-x) * log(x) * sin(4 * x);
endfunction

function retval = goldt()
  retval = (sqrt(5) - 1) / 2;
endfunction

function retval = isGrowing(x)
  retval = (f(x + 1e-12) - f(x) > 0);
endfunction

function retval = goldMin(a, b, eps)
	currA = a;
	currB = b;
	while (currB - currA > eps)
		x1 = currB - (currB - currA) * goldt();
		x2 = currA + (currB - currA) * goldt();

		if (f(x1) < f(x2)) 
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

locMins = [a, b]
l = a
r = a

while (r < b)
	while (isGrowing(l) && r < b)
		l = l + delta;
		r = l;
	endwhile

	while (!isGrowing(r) && r < b)
		r = r + delta;
	endwhile

	if (r < b)
		locMins = [locMins, goldMin(l, r, eps)]
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

