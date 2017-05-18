%% Part 6

%Load in the audio files
[x1,fs1] = audioread('ee430lab3fixedDTMF-1.wav');
[x2,fs2] = audioread('ee430lab3fixedDTMF-2.wav');
[x3,fs3] = audioread('ee430lab3fixedDTMF-3.wav');
[x4,fs4] = audioread('ee430lab3fixedDTMF-4.wav');
[x5,fs5] = audioread('ee430lab3fixedDTMF-5.wav');
[x6,fs6] = audioread('ee430lab3fixedDTMF-6.wav');

% Feed audio files into the DTMF decoder function
[digit,starttime,endtime] = decodeDTMF(x1,fs1);
fprintf('=====REPORTING DTMF DATA FOR FILE 1=====\nDigit : %s\nStart Time : %f Seconds\nEnd Time : %f Seconds\n',digit, starttime,endtime)

[digit,starttime,endtime] = decodeDTMF(x2,fs2);
fprintf('=====REPORTING DTMF DATA FOR FILE 2=====\nDigit : %s\nStart Time : %f Seconds\nEnd Time : %f Seconds\n',digit, starttime,endtime)

[digit,starttime,endtime] = decodeDTMF(x3,fs3);
fprintf('=====REPORTING DTMF DATA FOR FILE 3=====\nDigit : %s\nStart Time : %f Seconds\nEnd Time : %f Seconds\n',digit, starttime,endtime)

[digit,starttime,endtime] = decodeDTMF(x4,fs4);
fprintf('=====REPORTING DTMF DATA FOR FILE 4=====\nDigit : %s\nStart Time : %f Seconds\nEnd Time : %f Seconds\n',digit, starttime,endtime)

[digit,starttime,endtime] = decodeDTMF(x5,fs5);
fprintf('=====REPORTING DTMF DATA FOR FILE 5=====\nDigit : %s\nStart Time : %f Seconds\nEnd Time : %f Seconds\n',digit, starttime,endtime)

[digit,starttime,endtime] = decodeDTMF(x6,fs6);
fprintf('=====REPORTING DTMF DATA FOR FILE 6=====\nDigit : %s\nStart Time : %f Seconds\nEnd Time : %f Seconds\n',digit, starttime,endtime)