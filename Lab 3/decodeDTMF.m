function [digit,starttime,endtime]=decodeDTMF(x1,fs)

% Normalize the signal
x1 = NormalizeSignal(x1);

% Find the signal's Start and End Points
indexstart = FindSignalStart(x1);
indexend   = FindSignalEnd(x1);

% Create a "smaller" version of the original signal, with only the relevant
% part
subx1 = x1(indexstart:indexend);

% Let's get some power
y = fft(subx1);

% Plot confirms values obtained
plot_power_spectrum(y,length(y)-1);

% Because of the "mirroring", we need to omit frequency data above the
% halfway mark
cutoff = round(0.5*length(y),0);

test = abs(y(1:cutoff)); 

% Create a threshold value so that the function doesn't report back very
% small values
threshold = (max(test)/2);

% Each Signal has two relevant frequencies: A 'low' and a 'high'
% These values are found, and then rounded (because my method of cutting
% the signal introduces a little error)
low = round(find(test>threshold,1)*(fs/length(y)), -1);
high = round(find(test>threshold,1, 'last')*(fs/length(y)), -1);

% Fortunately, all of the frequencies are more than 10 apart, so there
% shouldn't be any overlap in using this method of rounding.

% Every possible combination of addition for anticipated signals results in
% a unique number. Easier to build a case structure for.

combined = low+high;

%And a Hacky Case Structure to Output the correct string
switch combined
    case 1910
        digit = '1';
    case 2040
        digit = '2';
    case 2180
        digit = '3';
    case 1980
        digit = '4';
    case 2110
        digit = '5';
    case 2250
        digit = '6';
    case 2060
        digit = '7';
    case 2190
        digit = '8';
    case 2330
        digit = '9';
    case 2150
        digit = '*';   
    case 2280
        digit = '0';
    case 2420
        digit = '#';        
    otherwise
        digit = 'UNKNOWN';
end

% Last bit is to report back the time the signal starts and ends.
starttime = indexstart/fs;
endtime = indexend/fs;