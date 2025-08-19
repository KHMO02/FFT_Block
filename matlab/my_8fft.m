function X = my_8fft(x,T) %#codegen
twiddle = cast(exp(-1j*2*pi*(0:8-1)/8), 'like', T.twiddle);
X= cast(trim(x,2), 'like', T.X);
Temp = cast(trim(x,2), 'like', T.X);
fid_in1  = fopen('fft_8.txt', 'a');

%stage1
for i = 0:3 
Temp(i+1) = cast(X(i+1) + X(i+4+1), 'like', T.X);
% Temp(i+4+1) = cast((X(i+1) - X(i+1+4))*twiddle(i+1), 'like' , T.X);
diff = cast(X(i+1)- X(i+4+1) , 'like', T.X);
ac = cast(real(diff) * real(twiddle(i+1)), 'like', T.multiply);
bd = cast(imag(diff) * imag(twiddle(i+1)), 'like', T.multiply);
ad = cast(real(diff) * imag(twiddle(i+1)), 'like', T.multiply);
bc = cast(imag(diff) * real(twiddle(i+1)), 'like', T.multiply);
acbd = cast(ac-bd, 'like', T.multiply);
adbc = cast(ad+bc, 'like', T.multiply);
Temp(i+1+4) = cast(trim(acbd,10) + trim(adbc,10)*1i , 'like', T.X);
end
X=Temp;


%stage2
Temp(1:4) = my_4fft(X(1:4),T);
Temp(5:8) = my_4fft(X(5:8),T);
X=Temp;

% stage 3
Temp(1:2) = my_2fft(X(1:2),T);
Temp(3:4) = my_2fft(X(3:4),T);
Temp(5:6) = my_2fft(X(5:6),T);
Temp(7:8) = my_2fft(X(7:8),T);
X=Temp;


%bit reversing
% Temp(2) = X(5);
% Temp(4) = X(7);
% Temp(5) = X(2);
% Temp(7) = X(4);
% X=Temp;
fclose(fid_in1);
end

function X = my_4fft(x,T)
X= cast(x, 'like', T.X);
Temp = cast(x, 'like', T.X);
twiddle = cast(exp(-1j*2*pi*(0:4-1)/4), 'like', T.twiddle);
for i = 0:1
    Temp(i+1) = cast(X(i+1) + X(i+1+2), 'like', T.X);
%     Temp(i+2+1) = cast((X(i+1) - X(i+1+2))*twiddle(i+1), 'like' , T.X);
    diff = cast(X(i+1)- X(i+2+1) , 'like', T.X);
    ac = cast(real(diff) * real(twiddle(i+1)), 'like', T.multiply);
    bd = cast(imag(diff) * imag(twiddle(i+1)), 'like', T.multiply);
    ad = cast(real(diff) * imag(twiddle(i+1)), 'like', T.multiply);
    bc = cast(imag(diff) * real(twiddle(i+1)), 'like', T.multiply);
    acbd = cast(ac-bd, 'like', T.multiply);
    adbc = cast(ad+bc, 'like', T.multiply);
    Temp(i+1+2) = cast(trim(acbd,10) + trim(adbc,10)*1i , 'like', T.X);
end
X=Temp;
end


function X = my_2fft(x,T)
X= cast(x, 'like', T.X);
Temp = cast(x, 'like', T.X);
twiddle = cast(exp(-1j*2*pi*(0:2-1)/2), 'like', T.twiddle);
Temp(1) = cast(X(1) + X(2), 'like', T.X);
% Temp(2) = cast((X(1) - X(2))*twiddle(1), 'like' , T.X);
diff = cast(X(1)- X(2) , 'like', T.X);
ac = cast(real(diff) * real(twiddle(1)), 'like', T.multiply);
bd = cast(imag(diff) * imag(twiddle(1)), 'like', T.multiply);
ad = cast(real(diff) * imag(twiddle(1)), 'like', T.multiply);
bc = cast(imag(diff) * real(twiddle(1)), 'like', T.multiply);
acbd = cast(ac-bd, 'like', T.multiply);
adbc = cast(ad+bc, 'like', T.multiply);
Temp(2) = cast(trim(acbd,10) + trim(adbc,10)*1i , 'like', T.X);
X=Temp;
end

function y = trim(x,n)
y = bitsll(bitsra(x,n),n);
end

