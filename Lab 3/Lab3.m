%% Part 1: Computing DFT

%% i) Generate 1 Second of an Audible Signal

% Define Variables

fs = 5000;        % Sampling Frequency 
T = (1/fs);       % Sampling Period
f  = 432;         % Signal Frequency (Holistic!)
n  = 0:fs;        % Samples
t  = n*T;         % Sampling Instances

% Define Functions
x  = cos(2*pi*f*t); % Signal

%% ii) Compute the DFT of the Signal

y = zeros(size(x));
index = [1:(fs+1)];
n = 1;
%%
for q = 1:fs
    for k=1:fs
        y(n) = y(n) + x(k)*exp(-2*pi*j*k*n/(fs));
    end
    n = n+1;
end;

%% Here's the graph for 2 (Power Spectrum)

figure('Color',[1 1 1]);       % Figure with White Background
h = plot(index,abs(y.^2));     % Plot the data
box off;                       % No love for the box edges 
set(h,'Linewidth',3);          % I like my lines THICK
set(h,'Color', [0.6 0.6 1]);   % Nice Blue Lines
hold on;                       % Hold that graph
box off;                       % No, no box!
xlabel('DFT Index');           
ylabel('Power');

%% iii) Plot Squares of the Absolute Value of Coefficients v. Physical Frequency

figure('Color',[1 1 1]);       % Figure with White Background
h = plot(index,abs(y.^2));     % Plot the data
xlim([0 fs/2]);
box off;                        
set(h,'Linewidth',3);          % I like my lines THICK
set(h,'Color', [0.6 0.6 1]);   % Nice Blue Lines
hold on;                       % Hold that graph
box off;                       
xlabel('Physical Frequency (Hz)');           
ylabel('Power');

%% iv) Make 4 sinusoids, sum 'em, plot 4 sinusoids.

fs = 5000;
dur = 1;

x1 = generate_wave(1,500,fs,dur);
x2 = generate_wave(0.5,722,fs,dur);
x3 = generate_wave(0.2,351,fs,dur);
x4 = generate_wave(0.7,1023,fs,dur);

x5 = x1+x2+x3+x4;

y = fft(x5);
plot_power_spectrum(y,fs);
xlim([0 1.2*1023]);

%% v) Noisy Power Spectrums

x = generate_wave(1,432,5000,1);
s = 20;

% Notes for various values 's':
% Audible: Up to about 0.8
% Sinusoid is no longer Heard at 0.8-4
% Sinsuoid Becomes hard to discern at 4
% Power Spectrum Becomes a Mess at around 20

xnoisy = x + s*randn(size(x));
y = direct_fourier(xnoisy,fs);
plot_power_spectrum(y,5000);
xlim([0 1.2*432]);

%% Signal to noise ratio

Px = sum(x.^2);
Pn = sum(xnoisy.^2);
SN = Px/Pn
sound(xnoisy, 5000);

% Notes about SNR:
% Audible at SNR > 0.4. (Edge case occurs at s=0.8)
% Sound becomes lost at 0.05 < SNR < 0.4 .
% The sinusoid becomes lost when plotted against time at 0.02 < SNR < 0.05.
% The power spectrum is no longer discernable at SNR < 0.02


%% Plot
index = [1:(fs+1)];

figure('Color',[1 1 1]);       % Figure with White Background
h = plot(index,xnoisy);        % Plot the data
xlim([0 4*432]);
box off;                       
set(h,'Linewidth',3);          
set(h,'Color', [0.6 0.6 1]);   % Nice Blue Lines
hold on;                       % Hold that graph
box off;                       
xlabel('Sample Number');           
ylabel('Amplitude');


%% PART 2) UNKNOWN FREQUENCY

%% i) Hidden sinusoids
[noisy1,fs1] = audioread('lab3prob2sound1.wav');
[noisy2,fs2] = audioread('lab3prob2sound2.wav');
[noisy3,fs3] = audioread('lab3prob2sound3.wav');
[noisy4,fs4] = audioread('lab3prob2sound4.wav');
%%
y1 = fft(noisy1);
y2 = fft(noisy2);
y3 = fft(noisy3);
y4 = fft(noisy4);
%%
plot_power_spectrum(y1,2*fs1);
plot_power_spectrum(y2,2*fs2);
plot_power_spectrum(y3,2*fs3);
plot_power_spectrum(y4,2*fs4);
%% 2&4 are vague, let's try filtering the signal and doing it one more time
% Makin' a FIR Filter
length = 500;
h1 = ones(1,length)/length;

% Create 'denoised' signals
ydesnoised1=conv(noisy2,h1,'same');
ydesnoised2=conv(noisy4,h1,'same');
% Get them transformed
y5 = fft(ydesnoised1);
y6 = fft(ydesnoised2);
% Try Plotting the power spectrum again
plot_power_spectrum(ydesnoised1,2*fs2);
plot_power_spectrum(ydesnoised2,2*fs4);

%There appears to be nothing in these signals, as after filtering, they
%still look like nonsense.

%% Guitar Note
[guitar,fsg] = audioread('guitar-note.wav');
yg = fft(guitar);


index = [1:118272];

figure('Color',[1 1 1]);       % Figure with White Background
h = plot(index,abs(yg.^2));    % Plot the data
xlim([0 fsg/2]);               % Restrict the x-axis
box off;                        
set(h,'Linewidth',3);          
set(h,'Color', [0.6 0.6 1]);   % Nice Blue Lines
hold on;                       % Hold that graph
box off;                       
xlabel('Physical Frequency (Hz)');           
ylabel('Power');
