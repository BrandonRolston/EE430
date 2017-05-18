[x,fs] = audioread('lab4_modulated_audio(1).wav');

sound(x, fs);


% get a spectrogram of the audio file
%spectrogram(x,blackman(8000*0.02),0, [] , 8000, 'yaxis')

% Four different observed frequency carriers: 400,1400,2400, and 3400.
% Band limit appears to be 800 Hz.

%Now, apparently, the trick is to multiply the sinusoid of interest by a
%sinusoid that's identical to its carrier. I know that the carrier is of
%the form cos(2*pi*fc*t)), which means that fc should probably be 500,
%1500, 2500, and 3500. I believe that after THAT you apply the lowpass
%filter, which will cut out the other signals that aren't centered.

%% First Signal (500 Hz)

%Multiply the entire signal by the carrier
for k=1:352800
   x1(k) = x(k)*2*cos(2*pi*500*5*(k/fs));
end;

% Uncomment the following Line to See Spectrum of Shifted Signal
% spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

% Create a Low Pass Filter
wc = (2*pi*800)/fs;
h = fir1(200,wc,'low');
x1 = filter(h,1,x1);

% Listen to the clean audio
sound(x1, fs);

% Uncomment this line to see the end result
%spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

%% Second Signal (1500 Hz)

%Multiply the entire signal by the carrier
for k=1:352800
   x1(k) = x(k)*2*cos(2*pi*1500*5*(k/fs));
end;

% Uncomment the following Line to See Spectrum of Shifted Signal
% spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

% Create a Low Pass Filter
wc = (2*pi*800)/fs;
h = fir1(200,wc,'low');
x1 = filter(h,1,x1);

% Listen to the clean audio
sound(x1, fs);

% Uncomment this line to see the end result
%spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

%% Third Signal (2500 Hz)

%Multiply the entire signal by the carrier
for k=1:352800
   x1(k) = x(k)*2*cos(2*pi*2500*5*(k/fs));
end;

% Uncomment the following Line to See Spectrum of Shifted Signal
% spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

% Create a Low Pass Filter
wc = (2*pi*800)/fs;
h = fir1(200,wc,'low');
x1 = filter(h,1,x1);

% Listen to the clean audio
sound(x1, fs);

% Uncomment this line to see the end result
%spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

%% Fourth Signal (3500 Hz)

%Multiply the entire signal by the carrier
for k=1:352800
   x1(k) = x(k)*2*cos(2*pi*3500*5*(k/fs));
end;

% Uncomment the following Line to See Spectrum of Shifted Signal
% spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

% Create a Low Pass Filter
wc = (2*pi*800)/fs;
h = fir1(200,wc,'low');
x1 = filter(h,1,x1);

% Listen to the clean audio
sound(x1, fs);

% Uncomment this line to see the end result
%spectrogram(x1,blackman(8000*0.02),0, [] , 8000, 'yaxis')

