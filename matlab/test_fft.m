clear; clc; close all

%design parameters
L = 8;
nSeeds = 200;
error = zeros(nSeeds,1);
T = fft_types('FxPt');

for seed = 1: nSeeds
    rng(seed);
    %inputs
    x_double = randn(L,1) + 1i* randn(L,1);
    x= cast(x_double, 'like', T.x);

    if seed==1
        buildInstrumentedMex my_8fft -args {x,T}
    end
    %alorithm
    y = my_8fft_mex(x,T);
    
    %Expexted result
    y_exp = fft(x_double);
    error(seed) = abs(mean(double(y) - y_exp));
end

figure; plot(1:nSeeds, error, 'LineWidth', 2);
xlabel('seed', 'FontSize', 14); xlabel('error', 'FontSize', 14);
signalPower = mean(abs(y_exp).^2);
errorPower = mean(abs(double(y) - y_exp).^2);
sqnr = 10 * log10(signalPower / errorPower);