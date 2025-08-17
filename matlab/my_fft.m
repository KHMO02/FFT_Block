function X = my_fft(x)
twiddle = exp(-1j*2*pi*(0:8-1)/8);
X=x;

%stage1
for i = 0:3 
x(i+1) = X(i+1) + X(i+4+1);
x(i+1+4) = (X(i+1) - X(i+1+4))*twiddle(i+1);
end
X=x;

%stage2
power = [0 2];
j=0;
for i = [0 1 4 5] 
x(i+1) = X(i+1) + X(i+2+1);
x(i+2+1) = (X(i+1)- X(i+2+1))*twiddle(power(j+1)+1);
j = ~j;
end
X=x;

% stage 3
for i=0:3
    x((2*i)+1) = X((2*i)+1) + X((2*i)+1+1);
    x((2*i)+1+1) = (X((2*i)+1)- X((2*i)+1+1))*twiddle(0+1);
    
end
X=x;


%bit reversing
x(2) = X(5);
x(4) = X(7);
x(5) = X(2);
x(7) = X(4);
X=x;

end

