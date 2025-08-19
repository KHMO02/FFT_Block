x = cast([11+5j 10+1j], 'like', fi([],1,12,7));
X= cast(x, 'like', T.X);
twiddle = cast(exp(-1j*2*pi*(0:2-1)/2), 'like', T.twiddle);
x(1) = cast(X(1) + X(2), 'like', T.x);
x(2) = cast((X(1)- X(2))*(1.5+4j), 'like', T.x);
X=x