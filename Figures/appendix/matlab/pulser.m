clc;clear;close all;

t1 = readtable('digital.csv', 'ReadVariableNames', false, 'HeaderLines', 1);
t1.Properties.VariableNames = ["time","PWM","PWMN","PULSE","GATE","PRF","CLK"];
%%
%figure(1)
fig = figure('units','inch','position',[0,10,10,2*3.3/3]);
subplot(6,1,1)
hold on
title('CLK','Interpreter','latex')
stairs(t1.time,t1.CLK,'k','DisplayName','Output')
set(gca,'TickLabelInterpreter','latex')
xlim([min(t1.time) max(t1.time)])
hold off
subplot(6,1,2)
hold on
title('PRF','Interpreter','latex')
stairs(t1.time,t1.PRF,'k','DisplayName','Input')
set(gca,'TickLabelInterpreter','latex')
xlim([min(t1.time) max(t1.time)])
hold off
subplot(6,1,3)
hold on
title('PWM','Interpreter','latex')
stairs(t1.time,t1.PWM,'k','DisplayName','Input')
set(gca,'TickLabelInterpreter','latex')
xlim([min(t1.time) max(t1.time)])
hold off
subplot(6,1,4)
hold on
title('PWMN','Interpreter','latex')
stairs(t1.time,t1.PWMN,'k','DisplayName','Input')
set(gca,'TickLabelInterpreter','latex')
xlim([min(t1.time) max(t1.time)])
hold off
subplot(6,1,5)
hold on
title('PULSE','Interpreter','latex')
stairs(t1.time,t1.PULSE,'k','DisplayName','Input')
set(gca,'TickLabelInterpreter','latex')
xlim([min(t1.time) max(t1.time)])
hold off
subplot(6,1,6)
hold on
title('GATE','Interpreter','latex')
stairs(t1.time,t1.GATE,'k','DisplayName','Input')
set(gca,'TickLabelInterpreter','latex')
xlim([min(t1.time) max(t1.time)])
xlabel('Time [s]','interpreter','latex');
hold off
