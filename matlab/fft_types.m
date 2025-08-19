function T = fft_types(dt)
switch dt
    case 'double'
        T.x = double([]);
        T.X = double([]);
        T.twiddle = double([]);
    case 'single'
        T.x = single([]);
        T.X = single([]);
        T.twiddle = single([]);
    case 'FxPt'
        T.x = fi([],1,3+9 , 9 , 'fimath', fimath('RoundingMethod', 'Zero'));
        T.X = fi([],1,5+7,7 , 'fimath', fimath('RoundingMethod', 'Zero'));
        T.twiddle = fi([], 1, 2+10, 10, 'fimath', fimath('RoundingMethod', 'Zero'));
        T.multiply = fi([], 1, 24, 17, 'fimath', fimath('RoundingMethod', 'Zero'));
end
end

