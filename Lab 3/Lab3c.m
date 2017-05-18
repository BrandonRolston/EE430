[morse,fs] = audioread('noisymorsecode.wav');
morsepower = fft(morse);

index = [1:43221];

figure('Color',[1 1 1]);       % Figure with White Background
h = plot(index,abs(morsepower.^2));    % Plot the data
xlim([0 fs/2]);               % Restrict the x-axis
box off;                      
set(h,'Linewidth',3);          
set(h,'Color', [0.6 0.6 1]);   % Nice Blue Lines
hold on;                       % Hold that graph
box off;                       
xlabel('Physical Frequency (Hz)');           
ylabel('Power');


%% Band for 2701-ish
h = fir1(5,[(3*pi/19.9) (3*pi/18.95)]);
x = filter(h,1,morse);
y = fft(x);
plot_power_spectrum(y,43220);
xlim([0 fs/2]);

%% Plot signal against time

n = (0:43220);        % Samples

figure('Color',[1 1 1]);       % Figure with White Background
h = plot(n,x);    % Plot the data
box off;                      
set(h,'Linewidth',3);         
set(h,'Color', [0.6 0.6 1]);   % Nice Blue Lines
hold on;                       % Hold that graph
box off;                       
xlabel('Time');           
ylabel('Amplitude');

sound(x, fs);