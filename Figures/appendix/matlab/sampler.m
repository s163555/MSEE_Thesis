clc;clear;close all;

t1 = readtable('tek0001ALL.csv', 'ReadVariableNames', false, 'HeaderLines', 20);
t1.Properties.VariableNames = ["time","output","pulse","input"];

figure(1)
subplot(3,1,1)
hold on
title('Demodulated input waveform','interpreter','latex');
plot(t1.time,t1.input,'k')
set(gca,'TickLabelInterpreter','latex')
grid minor
ylabel('Voltage [V]','interpreter','latex');
%xlabel('Time [sec]' );
hold off
subplot(3,1,2)
hold on
title('Sample pulse input','interpreter','latex');
plot(t1.time,t1.pulse,'k')
set(gca,'TickLabelInterpreter','latex')
grid minor
ylabel('Voltage [V]','interpreter','latex');
%xlabel('Time [sec]' );
hold off
subplot(3,1,3)
hold on
title('Sampled demodulated output','interpreter','latex');
plot(t1.time,t1.output,'k')
set(gca,'TickLabelInterpreter','latex')
grid minor
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
hold off
