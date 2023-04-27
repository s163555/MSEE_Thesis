clc;clear;close all;

%out_t2 = readtable('scope_208_2.csv','ReadVariableNames', false, 'HeaderLines', 1);
%out_t4 = readtable('scope_208_4.csv','ReadVariableNames', false, 'HeaderLines', 1);
%in_t2 = readtable('scope_208_1.csv','ReadVariableNames', false, 'HeaderLines', 1);
t1 = readtable('tek0012ALL.csv','ReadVariableNames', false, 'HeaderLines', 20);
t1.Properties.VariableNames = ["time","input","outa","outb"];


figure(1)
subplot(2,1,1)
title('AC coupled input signal','interpreter','latex');
hold on
plot(t1.time,t1.input,'k','DisplayName','Input')
%plot(out_t4.Var1,out_t4.Var2,'k','DisplayName','LOP')
grid minor
ylabel('Voltage [V]','interpreter','latex');
set(gca,'TickLabelInterpreter','latex')
%xlabel('Time [sec]' );
xlim([-0.2e-6 0.2e-6])
%l=legend('show');
hold off
subplot(2,1,2)
%figure(2)
hold on
title('Amplified differential signal with DC coupling','interpreter','latex');
plot(t1.time,movmean(t1.outa,10),'k')
plot(t1.time,movmean(t1.outb,10),'--k')
grid minor
ylabel('Voltage [V]','interpreter','latex');
xlabel('Time [sec]','interpreter','latex');
set(gca,'TickLabelInterpreter','latex')
xlim([-0.2e-6 0.2e-6])
legend('Differential signal A 5.001~MHz','Differential signal B 5.001~MHz 180\angle','Location','best','interpreter','latex')
hold off
%set(l,'Interpreter','Latex');