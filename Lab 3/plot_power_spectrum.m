function plot_power_spectrum(x,fs)

index = [1:(fs+1)];

figure('Color',[1 1 1]);       
h = plot(index,abs(x.^2));     
xlim([0 fs/2]);                
box off;                        
set(h,'Linewidth',3);          
set(h,'Color', [0.6 0.6 1]);   
hold on;                       
box off;                       
xlabel('Physical Frequency (Hz)');           
ylabel('Power');