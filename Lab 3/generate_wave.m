function x = generate_wave(amp,freq,samp,length)

T = (1/samp);                 % Sampling Period
n = (0:(length*samp));        % Samples
t = n*T;                      % Sampling Instances

x  = amp*cos(2*pi*freq*t); % Signal