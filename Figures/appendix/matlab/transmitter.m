clc;clear;close all;

t1 = readtable('scope_202_1.csv', 'ReadVariableNames', false, 'HeaderLines', 1);
t2 = readtable('scope_202_2.csv','ReadVariableNames', false, 'HeaderLines', 1);
t4 = readtable('scope_202_4.csv','ReadVariableNames', false, 'HeaderLines', 1);

figure(1)
subplot(2,1,1)
hold on
title('PWM Input to gate driver','interpreter','latex');
plot(t1.Var1,movmean(t1.Var2,25),'k','DisplayName','INA')
plot(t2.Var1,movmean(t2.Var2,25),':k','DisplayName','INB')
set(gca,'TickLabelInterpreter','latex')
grid minor
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
legend('show','interpreter','latex')
hold off
subplot(2,1,2)
hold on
title('Power stage output voltage','interpreter','latex');
plot(t4.Var1,t4.Var2,'k')
set(gca,'TickLabelInterpreter','latex')
grid minor
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
hold off