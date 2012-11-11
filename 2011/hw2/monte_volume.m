gamma = 0.95;
n = 10 ^ 4;
dim = 6;

a = 4;
c = 13.8;

X = rand(n, dim);
func = a .^ X;
F = sum(func');

mask = F < c;
count = columns(F(mask))
volume = count / n			#we assume that cube has edges with length == 1

hist(F);

T = norminv((1 + gamma) / 2);
precision = 1 / sqrt(n)
delta_n = T * sqrt(volume * (1 - volume) / n)
I_n = [volume - delta_n, volume + delta_n]



n = 10^6;
X = rand(n, dim);
func = a .^ X;
F = sum(func');

mask = F < c;
count = columns(F(mask))
volume = count / n			#we assume that cube has edges with length == 1

precision = 1 / sqrt(n)
delta_n = T * sqrt(volume * (1 - volume) / n)
I_n = [volume - delta_n, volume + delta_n]

