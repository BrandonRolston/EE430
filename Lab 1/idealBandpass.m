function [x,y] = idealBandpass(specFreqIn,specAmpIn,fco1, fco2);
% Ideal Bandpass
% Cuts any incoming signals between the specified frequencies
%
% specFreqIn  = An array of Omega Values
% specAmpIn   = An array of Amplitude values of form A*exp(xj)
% fco1        = Cutoff Frequency (low end)
% fco2        = Cutoff Frequency (high end)
%
% See also: idealHighPass, idealBandPass 
%
% Ver. 1.0 by BR

for k = 1:length(specAmpIn);
    if (abs(specFreqIn(k)) >= fco2) 
        specAmpIn(k) = 0;
    elseif (abs(specFreqIn(k)) <= fco1) 
        specAmpIn(k) = 0;
    end;
end;

x = specFreqIn;
y = specAmpIn;