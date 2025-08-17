clear; clc; close all

%design parameters
L = 8;
nSeeds = 200;
error = zeros(nSeeds,1);

for seed = 1: nSeeds
    rng(seed);
    %inputs
    x = randn(L,1) + 1i* randn(L,1);
    
    %alorithm
    y = my_8fft(x);
    
    %Expexted result
    y_exp = fft(x);
    error(seed) = abs(mean(y - y_exp));
end

figure; plot(1:nSeeds, error, 'LineWidth', 2);
xlabel('seed', 'FontSize', 14); xlabel('error', 'FontSize', 14);