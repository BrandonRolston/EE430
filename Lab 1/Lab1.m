%% Lab 1 - Synthesis of Signals from Discrete Spectrum
% By Brandon Rolston

% Hot Boilerplate Action
close all;
clc;
clear all;

%% 1) Synthesize Single Sinusoid

% Define Variables

fs = 44100;       % Sampling Frequency
T = (1/fs);       % Sampling Period
f  = 1;         % Signal Frequency
p  = 0;           % Phase Shift
n  = 0:3*fs;      % Samples
t  = n*T;         % Sampling Instances

% Define Functions

x  = cos(2*pi*f*t+p); % Signal

% Plot The Signal For 3 Seconds

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(t,x);              % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Play The Tone (Probably Want to Comment This Out Later)

fd = 2.5*fs; % When sampling frequency is forced higher, pitch/play rate increases
             % When it is forced lower, the pitch/play rate decreases.

%sound(x,fd);       %<---- UNCOMMENT TO HEAR SIGNAL

%% 2) Synthesize from Spectra
specFreq = [261.626, -261.626, 329.628, -329.628, 391.995, -391.995];
specAmp  = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
startTime = 0;
stopTime = 3;

s = synthesizeFromSpectrum(specFreq,specAmp,fs,startTime,stopTime);

%sound(s,fs);
fs = 44100;       % Sampling Frequency
n  = 0:0.1*fs;    % Samples
t  = n*T;         % Sampling Instances

x1 = cos(2*pi*261.626*t)+cos(2*pi*-261.626*t)+cos(2*pi*329.628*t)+cos(2*pi*-329.628*t)+cos(2*pi*391.995*t)+cos(2*pi*-391.995*t); % Signal
x2 = cos(2*pi*261.626*t+(pi/3))+cos(2*pi*-261.626*t-(pi/3))+cos(2*pi*329.628*t+(pi/3))+cos(2*pi*-329.628*t-(pi/3))+cos(2*pi*391.995*t+(pi/3))+cos(2*pi*-391.995*t-(pi/3)); % Signal (offset)

% Plot The Signal For 0.1 Seconds

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(t,x1);              % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(t,x2);              % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');
%% 3) Plotting Spectrum

Cmajor = [261.626, -261.626, 329.628, -329.628, 391.995, -391.995];
Cminor = [261.626, -261.626, 311.127, -311.127, 391.995, -391.995];
Fmajor = [349.228, -349.228, 440.000, -440.000, 523.251, -523.251];
specAmp = [0.5*exp(j*0.3),0.5*exp(-j*0.3),0.5*exp(j*0.3),0.5*exp(-j*0.3),0.5*exp(j*0.3),0.5*exp(-j*0.3)];

offset = real(log(specAmp))

plotSpectrum(specAmp,Cmajor);
plotSpectrum(specAmp,Cminor);
plotSpectrum(specAmp,Fmajor);

%% 4) Filtering


specFreqIn = [261.626, -261.626, 329.628, -329.628, 391.995, -391.995];
specAmpIn  = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
fLow       = 330;

% Lowpass Test

[x,y] = idealLowpass(specFreqIn,specAmpIn,fLow)

% Highpass Test

specFreqIn = [261.626, -261.626, 329.628, -329.628, 391.995, -391.995];
specAmpIn  = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
fHigh       = 320;

[x,y] = idealHighpass(specFreqIn,specAmpIn,fHigh)

% Bandpass Test

specFreqIn = [261.626, -261.626, 329.628, -329.628, 391.995, -391.995];
specAmpIn  = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
fLow       = 262;
fHigh      = 330;

[x,y] = idealBandpass(specFreqIn,specAmpIn,fLow,fHigh)

%% 5) Random Signals

%Generate Random Frequency
bottomFreq = 50;
topFreq    = 5000;
randFreq   = (topFreq-bottomFreq).*rand(500,1) + bottomFreq;
randFreq2  = -randFreq;
specFreq = [randFreq;randFreq2];

%Generate Random Amplitude
randAmp  = rand(500,1);
randAmp2 = -randAmp;
specAmp = [randAmp;randAmp2];

%Generate Random Phase
randPhase  = rand(500,1).*j; 
randPhase2 = - randPhase;
allPhase   = [randPhase;randPhase2];

%Combine Amplitude and Phase Appropriately
specAmp = specAmp.*allPhase;

% Specify Variables as needed for synthesizeFromSpectrum
fs = 44100;
startTime = 0;
stopTime = 3;

% Plot the generated Values
s = synthesizeFromSpectrum(specFreq,specAmp,fs,startTime,stopTime);

%sound(s,fs); %Uncomment to hear nightmaresounds

% Filter Signals
fCoLow      = 1000; 
fCoHigh     = 3000;
specAmpLow  = specAmp;
specAmpHigh = specAmp;
specAmpBand = specAmp;
    

% Highpass
[x,y] = idealLowpass(specFreq,specAmpLow,fCoLow);
plotSpectrum(y,x);

% Lowhpass
[x,y] = idealHighpass(specFreq,specAmpHigh,fCoHigh);
plotSpectrum(y,x);

% Bandpass
[x,y] = idealBandpass(specFreq,specAmpBand,fCoLow,fCoHigh);
plotSpectrum(y,x);


%% 6) Fourier Coefficients and Spectrum
