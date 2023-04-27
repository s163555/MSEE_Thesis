clc;clear;close all;

%out_t2 = readtable('demodulator/scope_204_2.csv','ReadVariableNames', false, 'HeaderLines', 1);
%out_t4 = readtable('demodulator/scope_204_4.csv','ReadVariableNames', false, 'HeaderLines', 1);
%in_t2 = readtable('demodulator/scope_206_2.csv','ReadVariableNames', false, 'HeaderLines', 1);
%in_t4 = readtable('demodulator/scope_206_4.csv','ReadVariableNames', false, 'HeaderLines', 1);
t2 = readtable('demodulator/tek0010ALL.csv','ReadVariableNames', false, 'HeaderLines', 20);
t1 = readtable('demodulator/tek0011ALL.csv','ReadVariableNames', false, 'HeaderLines', 20);
t1.Properties.VariableNames = ["time","ch1","ch2","ch3","ch4"];
t2.Properties.VariableNames = ["time","ch1","ch2","ch3","ch4"];
%%
figure(1)
hold on
%title('Demodulated signal $f_d=1~\mathrm{kHz}$','interpreter','latex');
plot(t1.time,movmean(t1.ch1,200),'k')
plot(t1.time,movmean(t1.ch4,200),'k-.','Color','[0.5 0.5 0.5]')
plot(t1.time,t1.ch2,'--k')
plot(t1.time,t1.ch3,':k')
grid minor
set(gca,'TickLabelInterpreter','latex')
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
%xlim([-2e-4 2e-4])
legend('Demodulated signal $I$ 1~kHz','Demodulated signal $Q$ 1~kHz','Differential signal A 5.001~MHz','Differential signal B 5.001~MHz 180\angle','Location','best','interpreter','latex')
hold off
% create a new pair of axes inside current figure
axes('position',[.65 .5125 .25 .25])
hold on
box on % put box around new pair of axes
indexOfInterest = (t1.time < 1.5e-7) & (t1.time > -1.5e-7); % range of t near perturbation
%indexOfInterest = (t < 11*pi/8) & (t > 9*pi/8)
%indexOfInterestp = indexOfInterest.';
plot(t1.time(indexOfInterest),t1.ch2(indexOfInterest),'--k') % plot on new axes
plot(t1.time(indexOfInterest),t1.ch3(indexOfInterest),':k') % plot on new axes
set(gca,'TickLabelInterpreter','latex')
axis tight
grid on
ylim([min(t1.ch2) max(t1.ch2)])
hold off
%%
figure(2)
%subplot(2,1,1)
hold on
%title('Received signal $f_d=5.3~\mathrm{MHz}$','interpreter','latex');
plot(t2.time,movmean(t2.ch2,10),':k')
plot(t2.time,movmean(t2.ch3,10),'--k')
plot(t2.time,t2.ch4,'k')
grid minor
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
xlim([-0.15e-6 0.15e-6])
set(gca,'TickLabelInterpreter','latex')
legend('Differential signal A 5.001~MHz','Differential signal B 5.001~MHz 180\angle','Local Oscillator $L_{OSC4}=$ 20~MHz','Location','best','interpreter','latex')
hold off
%subplot(2,1,2)
%hold on
%title('Local Oscillator signal $L_{\mathrm{osc4}}=20~\mathrm{MHz}$','interpreter','latex');
%plot(t2.time,t2.ch3,'k')
%plot(t2.time,t2.ch4,'k')
%grid minor
%ylabel('Voltage [V]');
%xlabel('Time [sec]' );
%xlim([3e-6 3.2e-6])
%hold off
