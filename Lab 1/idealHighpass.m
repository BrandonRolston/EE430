function [x,y] = idealHighpass(specFreqIn,specAmpIn,fco);
% Ideal Lowpass
% Cuts any incoming signals above the specified frequency
%
% specFreqIn  = An array of Omega Values
% specAmpIn   = An array of Amplitude values of form A*exp(xj)
% fco         = Cutoff Frequency
%
% See also: idealHighPass, idealBandPass 
%
% Ver. 1.0 by BR

for k = 1:length(specAmpIn);
    if (abs(specFreqIn(k)) >= fco) 
        specAmpIn(k) = 0;
    end;
end;

x = specFreqIn;
y = specAmpIn;