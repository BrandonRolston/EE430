%% Lab 2 - Exploration of Aliasing
% By Brandon Rolston

% Hot Boilerplate Action
close all;
clc;
clear all;

%% 1) Effect of Sampling / Reconstruction on Spectrum

% Necessary Variables
fs = 3050;                                 % Sampling Frequency
specFreq = [510,-510,300,-300,1501,-500];  % Specified Frequencies
specAmp = [0.5,-0.5,0.8,-0.8,1,-1];        % Specified Amplitudes (for the frequencies above)

[discreteSpecFreq,discreteSpecAmp] = sampled_spectrum(specFreq,specAmp,fs);   % Gets discrete values

% Testing Values
discreteSpecFreq
discreteSpecAmp

% Transform Back
[specFreq,specAmp] = reconstructed_spectrum(discreteSpecFreq,discreteSpecAmp,fs);

% Assuming no aliases, these values will be the same as above
specFreq
specAmp

%% 2) Testing the Effects of Samping

% s(t) has the following parameters:
specFreq = [-60,-30,-20,20,30,60];     % Specified Frequencies
specAmp = [3-2j,5,-j,j,5,3+2j];        % Specified Amplitudes (for the frequencies above)

% Make fs big enough to prevent aliasing
fs = 120;

% plot the spectrum of s(t)
plotSpectrum(specFreq,specAmp);

% Plot s(t) using a reasonable time window
tw = [0:1/fs:0.5];
x = synthesizeFromSpectrum(specFreq,specAmp,fs,0,0.5);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the discrete spectrum of s(t)
[sampFreq,sampAmp] = sampled_spectrum(specFreq,specAmp,fs);
plotSpectrum(sampFreq,sampAmp);

x = synthesizeFromSpectrum(sampFreq,sampAmp,fs,0,0.5);
figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the reconstructed spectrum of s(t)
[specFreq,specAmp] = reconstructed_spectrum(sampFreq,sampAmp,fs);

plotSpectrum(specFreq,specAmp);
x = synthesizeFromSpectrum(specFreq,specAmp,fs,0,0.5);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

%% Part 2

% Choose a new, alias creating fs
fs = 100;
tw = [0:1/fs:0.5];

% s(t) has the following parameters:
specFreq = [-60,-30,-20,20,30,60];     % Specified Frequencies
specAmp = [3-2j,5,-j,j,5,3+2j];        % Specified Amplitudes (for the frequencies above)

% Same plots as before:

% plot the spectrum of s(t)
plotSpectrum(specFreq,specAmp);
x = synthesizeFromSpectrum(specFreq,specAmp,fs,0,0.5);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the discrete spectrum of s(t)
[sampFreq,sampAmp] = sampled_spectrum(specFreq,specAmp,fs);
plotSpectrum(sampFreq,sampAmp);

x = synthesizeFromSpectrum(sampFreq,sampAmp,fs,0,0.5);
figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the reconstructed spectrum of s(t)
[nspecFreq,nspecAmp] = reconstructed_spectrum(sampFreq,sampAmp,fs);

plotSpectrum(nspecFreq,nspecAmp);
xn = synthesizeFromSpectrum(nspecFreq,nspecAmp,fs,0,0.5);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,xn);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

%% Part 3: Do part 2 again, but lowpass filter it.

% Choose a new, alias creating fs
fs = 100;
tw = [0:1/fs:0.5];

% s(t) has the following parameters:
specFreq = [-60,-30,-20,20,30,60];     % Specified Frequencies
specAmp = [3-2j,5,-j,j,5,3+2j];        % Specified Amplitudes (for the frequencies above)

% Same plots as before:

% plot the spectrum of s(t)
plotSpectrum(specFreq,specAmp);
x = synthesizeFromSpectrum(specFreq,specAmp,fs,0,0.5);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the discrete spectrum of s(t)
[specFreq,specAmp] = idealLowpass(specFreq,specAmp,(fs/2));
[sampFreq,sampAmp] = sampled_spectrum(specFreq,specAmp,fs);
plotSpectrum(sampFreq,sampAmp);

x = synthesizeFromSpectrum(sampFreq,sampAmp,fs,0,0.5);
figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the reconstructed spectrum of s(t)
[nspecFreq,nspecAmp] = reconstructed_spectrum(sampFreq,sampAmp,fs);

plotSpectrum(nspecFreq,nspecAmp);
xn = synthesizeFromSpectrum(nspecFreq,nspecAmp,fs,0,0.5);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,xn);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');


%% Actual Number 3 from 2a.

% New s(t)!

% s(t) has the following parameters:
specFreq = [550,-550,350,-350];     % Specified Frequencies
specAmp = [0.25+j*(pi/2),0.25-j*(pi/2),0.25-j*(pi/2),0.25+j*(pi/2)];        % Specified Amplitudes (for the frequencies above)

% New Sampling Rate
fs = 1000;
tw = [0:1/fs:0.025];

%Plot the same stuff as before, in the same way.
% plot the spectrum of s(t)
plotSpectrum(specFreq,specAmp);

% Plot s(t) using a reasonable time window
x1 = synthesizeFromSpectrum(specFreq,specAmp,fs,0,0.025);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x1);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the discrete spectrum of s(t)
[sampFreq,sampAmp] = sampled_spectrum(specFreq,specAmp,fs);
plotSpectrum(sampFreq,sampAmp);

x = synthesizeFromSpectrum(sampFreq,sampAmp,fs,0,0.025);
figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the reconstructed spectrum of s(t)
[specFreq,specAmp] = reconstructed_spectrum(sampFreq,sampAmp,fs);

plotSpectrum(specFreq,specAmp);
x2 = synthesizeFromSpectrum(specFreq,specAmp,fs,0,0.025);

figure('Color',[1 1 1]);    % Figure with White Background
h = plot(tw,x2);             % Plot the data
box off;                    % No love for the box edges 
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

%% Plot them on the same Axis, show they agree at t=n/fs

% s(t)
figure('Color',[1 1 1]);    
h = plot(tw,x1);             
box off;                     
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

% s^(t)
h = plot(tw,x2);            
box off;                     
set(h,'Linewidth',3);
set(h,'Color', [1 0.6 0.6]);
hold on;
box off;


% Show they agree
check = [0:1/fs:0.025]; %the 10 is to compensate for the "workaround" to reproduce the sample
h = stem(check,x1);            
box off;                     
set(h,'Linewidth',1);
set(h,'Color', [0 0 0]);
hold on;
box off;


