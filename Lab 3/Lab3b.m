%% Part 3: FIR Design

%% i) Using fir1
fs = 8000;

%% Lowpass
h = fir1(20,pi/8,'low');
figure('Color',[1 1 1]);       % Figure with White Background
freqz(h);

h = fir1(200,pi/8,'low');
figure('Color',[1 1 1]);       % Figure with White Background
freqz(h);

%% Highpass
h = fir1(20,pi/8,'high');
figure('Color',[1 1 1]);       % Figure with White Background
freqz(h);

h = fir1(200,pi/8,'high');
figure('Color',[1 1 1]);       % Figure with White Background
freqz(h);

%% Bandpass (500-700)
h = fir1(20,[pi/8 pi/5.714]);
figure('Color',[1 1 1]);       % Figure with White Background
freqz(h);

h = fir1(200,[pi/8 pi/5.714]);
figure('Color',[1 1 1]);       % Figure with White Background
freqz(h);

%% Generate Signal
dur = 1;
fs = 8000;

x1 = generate_wave(1,157,fs,dur);
x2 = generate_wave(1,637,fs,dur);
x3 = generate_wave(1,853,fs,dur);
x4 = x1+x2+x3;

y = fft(x4);
plot_power_spectrum(y,fs);
xlim([0 1.2*853]);

%% Filter Signal

% Low
h = fir1(200,pi/32,'low');
x5 = filter(h,1,x4);
y2 = fft(x5);
plot_power_spectrum(y2,fs);
xlim([0 1.2*853]);
%%
%High 
h1 = fir1(200,(pi/32),'high');
x6 = filter(h1,1,x4);
y3 = fft(x6);
plot_power_spectrum(y3,fs);
xlim([0 1.2*853]);

%%
% Band
h2 = fir1(200,[pi/32 pi/20]);
x7 = filter(h2,1,x4);
y4 = fft(x7);
plot_power_spectrum(y4,fs);
xlim([0 1.2*853]);

%% Random Noise
noise=randn(fs,1);

passnoise = filter(h2,1,noise);
y4 = fft(passnoise);
plot_power_spectrum(noise,(fs-1));

sound(passnoise, fs);

