#!/usr/bin/octave -qf

function retval = f(x)
  retval = quad1(x);
endfunction

function retval = quad1(x)
  retval = 2 * x^2 - exp(x);
endfunction

function retval = goldt()
  retval = (sqrt(5) - 1) / 2;
endfunction

eps = 1e-2
a = 0
b = 1

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

printf("\nAnswer:\n");
currA
currB
xmin = (currA + currB) / 2
f(xmin)
