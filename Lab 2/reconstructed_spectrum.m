function [specFreq,specAmp] = reconstructed_spectrum(discreteSpecFreq,discreteSpecAmp,fs);

specFreq = ((discreteSpecFreq*fs)/(2*pi));
specAmp = discreteSpecAmp;