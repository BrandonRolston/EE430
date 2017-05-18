function x = synthesizeFromSpectrum(specFreq,specAmp,fs,tstart,tend);
% Synthesize From Spectrum
% Attempts to represent a spectra based on the following:
%
% x = synthesizeFromSpectrum(specFreq,specAmp,fs,tstart,tend);
%
% specFreq  = An array of Omega Values
% specAmp   = An array of Amplitude values of form A*exp(xj)
% fs        = Sampling Frequency
% tstart    = Defines start time for sampling frequency
% tend      = Defines end time for sampling frequency
%
% Function Parameters:
% s(t) = specAmp*exp(j*2*pi*SpecFreq*t)
%
% See also: plotSpectrum, 
%
% Ver. 1.0 by BR

T  = (1/(10*fs));            % Sampling Period
n  = tstart*fs:tend*fs; % Sampling Instances
t  = n*T;               % Total Number of Samples

a  = 0;

for k = 1:length(specAmp);
    a = a + specAmp(k)*exp(j*2*pi*specFreq(k)*t);
end;

x = real(a);