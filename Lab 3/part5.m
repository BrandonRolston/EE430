%This looks boring, because most of the practical parts are stuck in
%functions.

x = dialSequence('65456665556666545666655654',0.2,0.1,8000);
soundsc(x,8000)

spectrogram(x,blackman(8000*0.02),0, [] , 8000, 'yaxis')