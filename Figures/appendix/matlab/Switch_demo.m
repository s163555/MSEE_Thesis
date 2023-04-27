clc;clear;close all;

t2 = readtable('230317/scope_114_2.csv','ReadVariableNames', false, 'HeaderLines', 1);
t4 = readtable('230317/scope_114_4.csv','ReadVariableNames', false, 'HeaderLines', 1);

figure(1)
subplot(2,1,1)
hold on
title('Transmitted signal','interpreter','latex');
plot(t4.Var1,t4.Var2,'k')
grid minor
ylabel('Voltage [V]','interpreter','latex');
%xlabel('Time [sec]','interpreter','latex');
set(gca,'TickLabelInterpreter','latex')
xlim([9.8942e-5 1.21698e-4])
hold off
subplot(2,1,2)
hold on
title('Received signal','interpreter','latex');
plot(t2.Var1,t2.Var2,'k')
grid minor
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
set(gca,'TickLabelInterpreter','latex')
xlim([9.8942e-5 1.21698e-4])
hold off