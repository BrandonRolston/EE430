function x = dialSequence(digitarray,toneduration,pauseduration,fs)

output = 0;

for k = 1:length(digitarray);
    tone = generateDTMF(digitarray(k),toneduration,fs);
    silence = generateSilence(pauseduration,fs);
    full = [tone, silence];
    output = [output, full];
end;

x = output;