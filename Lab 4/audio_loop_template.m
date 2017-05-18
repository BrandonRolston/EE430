fs=44100;
r=audiorecorder(fs,16,1);
blocktime=0.5; % length of blocks (s)
s=zeros(blocktime*fs,1);
while 1
    record(r);
    t1=clock;
    %%
    % process previously captured block of audio data
    %%
    % plot signal and FT of signal
    subplot(2,1,1);
    plot(s);
    subplot(2,1,2);
    freq=fs*((0:numel(s)-1))/numel(s);
    plot(freq,abs(fft(s)));
    % Further processing (you fill in)
    digit = decodeDTMFblock(s,fs);
    disp(digit)
   
    pause(blocktime-etime(clock,t1));
    pause(r);
    %% get audio data
    s=r.getaudiodata();
    stop(r);
end