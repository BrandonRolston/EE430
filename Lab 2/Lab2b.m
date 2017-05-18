%% 4) Denoising an Audio Signal

% Load a file
[x,fs] = audioread('sample2.wav');
% Play the sound
%sound(x, fs);

%% Part 2

T = (1/fs);           % Sampling Period
n  = 0:19.34399*fs;   % Samples
t  = n*T;             % Sampling Instances

% Plot that file
figure('Color',[1 1 1]);    
h = plot(t,x);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');



%% Part 3

% Make Some Noise
n=randn(size(x));

%Get some power
Px = sum(x.^2);

% Create Constants
s1 = sqrt(Px/(4*numel(x)));
s2 = sqrt(Px/(0.64*numel(x)));

% Create noisy signals
xn1 = x+s1*n;
xn2 = x+s2*n;

% listen to the noise
%sound(xn1,fs);
%sound(xn2,fs);
%%
% Plot the Noisy Signals
figure('Color',[1 1 1]);    
h = plot(t,xn1);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');


figure('Color',[1 1 1]);    
h = plot(t,xn2);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

%% Part 4

% Makin' a FIR Filter
num = 5;
h = ones(1,num)/num;

% Create 'denoised' signals
ydesnoised1=conv(xn1,h,'same');
ydesnoised2=conv(xn2,h,'same');

% Listen to new signals
%sound(ydesnoised1,fs);
%sound(ydesnoised2,fs);

% Plot the cleaned Signals
figure('Color',[1 1 1]);    
h = plot(t,ydesnoised1);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');


figure('Color',[1 1 1]);    
h = plot(t,ydesnoised2);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Time (s)');
ylabel('Amplitude');

%% Part 5

% New Powers of Denoised Signals
Pd1 = sum((x-ydesnoised1).^2);
Pd2 = sum((x-ydesnoised2).^2);

% Find the SNR of these denoised signals
SNR1 = Px/Pd1
SNR2 = Px/Pd2

% Find Optimal FIR Filter Length
Power1 = [1:100];
Power2 = [1:100];
valueN = [1:100];

for k=1:100
    num = k;
    h = ones(1,num)/num;
    ydesnoised1=conv(xn1,h,'same');
    ydesnoised2=conv(xn2,h,'same');
    Pd1 = sum((x-ydesnoised1).^2);
    Pd2 = sum((x-ydesnoised2).^2);
    Power1(k) = Px/Pd1;
    Power2(k) = Px/Pd2;
end;

% Plot my findings
figure('Color',[1 1 1]);    
h = plot(valueN,Power1);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Value N');
ylabel('Power');

figure('Color',[1 1 1]);    
h = plot(valueN,Power2);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('Value N');
ylabel('Power');

%% Create Optimized Audio

% Makin' a FIR Filter
num1 = 9;
num2 = 21;
h1 = ones(1,num1)/num1;
h2 = ones(1,num2)/num2;

% Create 'denoised' signals
ydesnoised1=conv(xn1,h1,'same');
ydesnoised2=conv(xn2,h2,'same');

% Listen to new signals
%sound(ydesnoised1,fs);
%sound(ydesnoised2,fs);

%% Frequency Response of FIR Filter

% Five Numbers of an order 4 FIR Filter
ech = [2,3,4,1,2];

% Choose a single normalized Frequency
w = ((.4)*pi);

% How big we goin'?
size = 500;

% Create a 'holder' array
x = zeros(1,size);

% Fill that array with a sine wave
for n = 1:size
    x(n) = cos(w*n);
end;

% Convolute the signal with the filter
y = conv(x,ech,'valid');

% plot y
plot(y);

%% What's the magnitude?
max(abs(y))

%% Loop over a bunch of w, save amplitude to an array

ech = [2,3,4,1,2];
array = [1:100];
value = [1:100];
value = value*0.01;

for k=1:100
    
    % Create a normalized Frequency
    w = ((k*0.01)*pi);

    % How big we goin'?
    size = 100;

    % Create a 'holder' array
    x = zeros(1,size);

    % Fill that array with a sine wave
    for n = 1:size
        x(n) = cos(w*n);
    end;

    % Convolute the signal with the filter
    y = conv(x,ech,'valid');

    % Save the Magnitude to an array
    array(k) = max(y);
end;

% Plot Magnitude v. w

figure('Color',[1 1 1]);    
h = plot(value,array);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('w (percentage of pi');
ylabel('Magnitude');

%% w v. H(w)

% Let's start by setting up H.
H=[1:100];

for k=1:100
    H(k) = abs(ech(1)+(ech(2)*exp(-j*value(k)))+(ech(3)*exp(-j*2*value(k)))+(ech(4)*exp(-j*4*value(k))));
end;

% Plot the graph

figure('Color',[1 1 1]);    
h = plot(value,H);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('w (percentage of pi');
ylabel('abs(H(w))');

%% Repeat the last two parts, with a filter with net sum = 0
ech = [2,1,-1,-2];
array = [1:100];
value = [1:100];
value = value*0.01;

for k=1:100
    
    % Create a normalized Frequency
    w = ((k*0.01)*pi);

    % How big we goin'?
    size = 100;

    % Create a 'holder' array
    x = zeros(1,size);

    % Fill that array with a sine wave
    for n = 1:size
        x(n) = cos(w*n);
    end;

    % Convolute the signal with the filter
    y = conv(x,ech,'valid');

    % Save the Magnitude to an array
    array(k) = max(abs(y));
end;

% Plot Magnitude v. w

figure('Color',[1 1 1]);    
h = plot(value,array);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('w (percentage of pi');
ylabel('Magnitude');

%% w v. H(w)

% Let's start by setting up H.
H=[1:100];

for k=1:100
    H(k) = ech(1)+(ech(2)*exp(-j*value(k)))+(ech(3)*exp(-j*2*value(k)))+(ech(4)*exp(-j*4*value(k)));
end;

absH = abs(H);

% Plot the graph

figure('Color',[1 1 1]);    
h = plot(value,absH);             
box off;                    
set(h,'Linewidth',3);
set(h,'Color', [0.6 0.6 1]);
hold on;
box off;
xlabel('w (percentage of pi');
ylabel('abs(H(w))');

%% Use freqz

% Seems like 'b' is my h. 'a' would be the denominator
% which, in this case, is just 1.

b = ech;
a = 1;

[h,w] = freqz(b,a,100);

% try plotting it.
plot(value,h)
