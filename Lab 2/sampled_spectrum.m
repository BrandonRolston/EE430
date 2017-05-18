function [discreteSpecFreq,discreteSpecAmp] = sampled_spectrum(specFreq,specAmp,fs);

for k = 1:length(specAmp);
    if (specFreq(k) > (fs/2))
        while (specFreq(k) > fs/2)
            specFreq(k) = specFreq(k) - fs;
        end;
    elseif (specFreq(k) < (-fs/2))
        while (specFreq(k) < (-fs/2))
            specFreq(k) = specFreq(k) + fs;
        end;
    end;
end;

discreteSpecFreq = (specFreq*2*pi/(fs));
discreteSpecAmp = specAmp;