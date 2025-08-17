function X = my_8fft(x,T) %#codegen
twiddle = cast(exp(-1j*2*pi*(0:8-1)/8), 'like', T.twiddle);
X= cast(x, 'like', T.X);

%stage1
for i = 0:3 
x(i+1) = X(i+1) + X(i+4+1);
x(i+1+4) = (X(i+1) - X(i+1+4))*twiddle(i+1);
end
X=x;

%stage2
x(1:4) = my_4fft(X(1:4),T);
x(5:8) = my_4fft(X(5:8),T);
X=x;

% stage 3
x(1:2) = my_2fft(X(1:2),T);
x(3:4) = my_2fft(X(3:4),T);
x(5:6) = my_2fft(X(5:6),T);
x(7:8) = my_2fft(X(7:8),T);
X=x;


%bit reversing
x(2) = X(5);
x(4) = X(7);
x(5) = X(2);
x(7) = X(4);
X=x;

end

function X = my_4fft(x,T)
X= cast(x, 'like', T.X);
twiddle = cast(exp(-1j*2*pi*(0:4-1)/4), 'like', T.twiddle);
for i = 0:1
    x(i+1) = X(i+1) + X(i+1+2);
    x(i+1+2) = (X(i+1)- X(i+2+1))*twiddle(i+1);
end
X=x;
end


function X = my_2fft(x,T)
X= cast(x, 'like', T.X);
twiddle = cast(exp(-1j*2*pi*(0:2-1)/2), 'like', T.twiddle);
x(1) = X(1) + X(2);
x(2) = (X(1)- X(2))*twiddle(0+1);
X=x;
end

