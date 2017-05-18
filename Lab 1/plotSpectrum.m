function plotSpectrum(specFreq,specAmp);
% Plot Spectrum
% Plots a spectrum based on the following:
%
% x = plotSpectrum(specFreq,specAmp);
%
% specFreq  = An array of Omega Values
% specAmp   = An array of Amplitude values of form A*exp(xj)
%
% See also: synthesizeFromSpectrum, 
%
% Ver. 1.0 by BR

offset = imag(log(specAmp));

% Grid of 2 x 1
figure('Color',[1 1 1]);
%subplot(2,1,1);
h = stem(specAmp,specFreq);
box off;
grid on;
hold on;
set(h,'Linewidth',3);
set(h,'Color',[0.4 0.4 1]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis tight;

% subplot(2,1,2);
% h = stem(offset,specFreq);
% box off;
% grid on;
% hold on;
% set(h,'Linewidth',3);
% set(h,'Color',[0.4 0.4 1]);
% xlabel('Frequency (Hz)');
% ylabel('Radians');
% axis tight;