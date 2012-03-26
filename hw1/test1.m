#!/usr/bin/octave -qf

function res = E(x, p)
	res = 0;
	for i = 1 : length(x)
		res += x(i) * p(i);
	endfor
endfunction


function res = D(x, p)
	x2 = x;
	for i = 1 : length(x2)
		x2(i) *= x2(i);
	endfor
	
	res = E (x2, p) - E(x, p) ^ 2;
endfunction


function res = cov(X, Y, P)
	#find pX, pY
	global pX = X;
	for i = 1: length(X)
		pX(i) = sum (P(i, 1: length(Y)));
	endfor
	
	global pY = Y;
	for i = 1: length(Y)
		pY(i) = sum (P(1: length(X), i));
	endfor

	#find XY and p(XY)
	global XY
	global pXY
	
	for i = 1: length(X)
		for j = 1: length(Y)
			XYij = X(i) * Y(j);
			flag = false;
			
			for k = 1: length(XY)
				if (XY(k) == XYij)
					pXY(k) += P(j, i);
					flag = 1;
					break;
				endif
			endfor	
			
			if (!flag)
				XY = [XY, XYij];
				pXY = [pXY, P(j, i)];
			endif
		endfor
	endfor
		
	res = E(XY, pXY) - E(X, pX) * E(Y, pY);
endfunction


function res = gx(x, X, Y, P)
	if (length(x) != 1)
		error ("gx(x, X, Y, P): wrong input");
	endif
	
	global pX = X;
	for i = 1: length(X)
		pX(i) = sum (P(i, 1: length(Y)));
	endfor
	
	global pY = Y;
	for i = 1: length(Y)
		pY(i) = sum (P(1: length(X), i));
	endfor
	
	res = E(Y, pY) + (cov (X, Y, P)/ D(X, pX)) * (x - E(X, pX));
endfunction


function res = gy(y, X, Y, P)
	if (length(y) != 1)
		error ("gy(y, X, Y, P): wrong input");
	endif
	
	global pX = X;
	for i = 1: length(X)
		pX(i) = sum (P(i, 1: length(Y)));
	endfor
	
	global pY = Y;
	for i = 1: length(Y)
		pY(i) = sum (P(1: length(X), i));
	endfor
	
	res = E(X, pX) + (cov (X, Y, P)/ D(Y, pY)) * (y - E(Y, pY));
endfunction


#P, X, Y should be there:
load input.mat

#echo 'em
X
Y
P

#find pX, pY
global pX = X;
for i = 1: length(X)
	pX(i) = sum (P(i, 1: length(Y)));
endfor

global pY = Y;
for i = 1: length(Y)
	pY(i) = sum (P(1: length(X), i));
endfor

#echo 'em
pX
pY

#covariation:
printf ("covariation(X, Y):\n%f\n\n", cov (X, Y, P));
printf ("covariation(Y, X):\n%f\n\n", cov (Y, X, P));

#r:
printf ("r:\n%f\n\n", cov(X, Y, P)/(sqrt(D(X, pX) * D(Y, pY))));

gX = X;
gY = Y;

for i = 1:length(X)
	gX(i) = gx(X(i), X, Y, P);
endfor


for i = 1:length(Y)
	gY(i) = gy(Y(i), X, Y, P);
endfor

gX
gY

subplot (1, 2, 1)
xlabel ("x")
ylabel ("g(x)")
refresh()
plot (X, gX);
grid on
hold on

subplot (1, 2, 2)
plot (Y, gY);
grid on
hold on

