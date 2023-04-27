close all; clc; clear
index=6;
%% Setting
param_title= {'fontsize',18, 'fontname','Arial'};
param_label={'fontsize',15,'fontname','Arial'};

save_fig=0;
F_prf=1/99.99e-6;
M=5;
f0=5e6;
fres=5;
dB_scale=0;
padding = 1;
sampled_interpolation = 0;  
interpolation_factor=100;

%% Get data
file_name1=['scope_' num2str(index) '_2.csv'];
file_name2=['scope_' num2str(index) '_4.csv'];
data1 = xlsread(file_name1);
data2 = xlsread(file_name2);
time=data1(3:length(data1)-3,1);
v1=data1(3:length(data1)-3,2);
v2=data2(3:length(data2)-3,2);



%% chose signal
signal = v1;


%% Bandpass filter before sampling
dt=mean(diff(time));
fs = 1/dt;
fn=fs/2;
[c, d]=butter(2, [3e6 7e6]/fn,'bandpass');
signal=filter(c,d,signal);

%% Power
power_signal = (rms(signal))^2;

%% t_start
 idx_start=min(find(v2>max(v2)*0.7));
 t_start = time(idx_start);

% idx_start = max(find(time<-411e-6));
% t_start = time(idx_start);
%% N count
count = t_start;
N=0;                                              %number of elements in sampled array
while count<time(end)
   count = count + 1/F_prf;
   N=N+1;
end

%% Cutting
 idx_nxt=min(find(time>(t_start+ 1/F_prf)));
 t_nxt = time(idx_nxt);
 Is_prf=1/(t_nxt-t_start);
 idx_length= idx_nxt - idx_start;
 signal_array = zeros(N, idx_length);
 idx_count = idx_start;
 height_offset =max(signal)*2;
 cut_time = (1:idx_length)*dt;
figure()
hold on
for i=1:N
    if (idx_count+idx_length-1 < length(signal))
        signal_array(i,:)= signal(idx_count:idx_count+idx_length-1);
        signal_array(i,:) = signal_array(i,:) + height_offset*(i-1);
        plot(cut_time*1e6, signal_array(i,:))
        xlabel('Time(\mus)',param_label{:})
% %         title('Cutted data',param_title{:})
        xlim([0 cut_time(end)*1e6])
        idx_count = idx_count+idx_length;
    end
end

hold off

figure()
plot(cut_time*1e6, sum(signal_array,1)/N);
xlabel('Time(\mus)',param_label{:})
title('Summed Data',param_title{:})


figure()
plot(cut_time*1e6, signal_array(1,:))
xlabel('Time(\mus)',param_label{:})
% title('Cutted data 1',param_title{:})

figure()
plot(time*1e6, signal)
xlabel('Time(\mus)',param_label{:})
ylabel('Voltage (V)',param_label{:})

 a=[6 7]*1e-6;
 dt = mean(diff(time)); 
 t_offset = a(1):10*dt:a(2);
 vel_avg=zeros(1,length(t_offset));
 vel_max=zeros(1,length(t_offset));
 for j=1:length(t_offset)
%% Sampling
time_sam = zeros(1,N);
signal_sam= zeros(1,N);
count= t_start+t_offset(j);
for i= 1:N
    idx= max(find(time<count));
    time_sam(i) = time(idx);
    signal_sam(i) = signal(idx);
    count = count + 1/F_prf;
end

%% Bandpass filter after sampling
dt_sam=mean(diff(time_sam));
fs_sam = 1/dt_sam;
fn_sam=fs_sam/2;
[c, d]=butter(3, [100 F_prf/2*0.8]/fn_sam,'bandpass');
signal_sam=filter(c,d,signal_sam);


%% plot in time domain
% figure()
% hold on
% plot(time*1e6, signal)
% for i=1:length(time_sam)
%     scatter(time_sam(i)*1e6, signal_sam(i),'r')
% end
% hold off
% xlabel('time(\mus)',param_label{:})
% % title(['time offset: ' num2str(t_offset(j)*1e6) '\mus'],param_title{:})
% if save_fig
%  saveas(gcf,['time offset= ' num2str(t_offset(j)*1e6) 'us.jpg'])
% end
% 
% scatter(time_sam*1e6, signal_sam,'r')
% xlabel('Time(\mus)',param_label{:})
% ylabel('Voltage(V)',param_label{:})

%% Fourier transform
L = length(time_sam);
fs=1/mean(diff(time_sam));
if padding
    Lnew = round(fs/fres);
    P = Lnew-L;  
    if P<0
        error('P should be bigger than 0. You should increse the ''fres'' ')
    end
    signal_sam = [signal_sam zeros(1,P)];
else
    Lnew=L;
end

    
Y= fft(signal_sam);                 
f = fs/Lnew*(0:(Lnew/2));
P2 = abs(Y/Lnew);
P1 = P2(1:Lnew/2+1);
P1(2:end-1) = 2*P1(2:end-1);
if dB_scale
    P1 = mag2db(P1); %dB scale conversion
end

avg_f = sum(f.*P1)/sum(P1);
idx1 = find(P1==max(P1));
avg_f = sum(f.*P1)/sum(P1);


%% Plot Fourier Transform
figure()
hold on
plot(f,P1)
plot(f(1),P1(1))
plot(f(2),P1(2))
plot(f(3),P1(3))
hold off
title(['FFT of time offset: ' num2str(t_offset(j)*1e6) '\mus'],param_title{:})
xlabel('frequency',param_label{:})
if dB_scale
    ylabel('Magnitude (dB)')
end
legend(['Max frequency: ' num2str(f(idx1)) 'Hz'],...
[' Velocity: ' num2str(1540*f(idx1)/f0/2*sqrt(2)) 'm/s'],...
[' Velocity: ' num2str(1540*avg_f/f0/2*sqrt(2)) 'm/s'])

if save_fig
 saveas(gcf,['FFT of time offset= ' num2str(t_offset(j)*1e6) 'us.jpg'])
end
 %% Sweep graph 
vel_avg(j)=1540*avg_f/f0/2 *sqrt(2);
vel_max(j)= 1540*f(idx1)/f0/2* sqrt(2);
 end
 
figure();
hold on
scatter(t_offset*1e6,vel_avg*100)
scatter(t_offset*1e6,vel_max*100)
legend('Avg', 'Max')
% title(['Sweeped data     index: ' num2str(index)],param_title{:})
ylabel('velocity (cm/s)',param_label{:})
xlabel('time offset(\mus)',param_label{:})

%% Data
figure();
hold on
% scatter(t_offset*1540/sqrt(2)/2*1e3,vel_avg*100)
scatter(t_offset*1540/sqrt(2)/2*1e3,vel_max*100)
% legend('Avg', 'Max')
% title(['Sweeped data     index: ' num2str(index)],param_title{:})
ylabel('Velocity (cm/s)',param_label{:})
xlabel('Depth (cm)',param_label{:})
