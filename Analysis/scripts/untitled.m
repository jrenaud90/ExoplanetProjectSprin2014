function Hd = untitled
%UNTITLED Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.1 and the Signal Processing Toolbox 6.19.
% Generated on: 01-Apr-2014 18:47:49

Fpass = 0.45;  % Passband Frequency
Fstop = 0.55;  % Stopband Frequency
Apass = 1;     % Passband Ripple (dB)
Astop = 60;    % Stopband Attenuation (dB)

h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop);

Hd = design(h, 'equiripple', ...
    'MinOrder', 'any', ...
    'StopbandShape', 'flat');


