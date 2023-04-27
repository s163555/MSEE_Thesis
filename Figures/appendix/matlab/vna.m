clc;clear;close all;
%%
mag = readtable('TRACE01.CSV','ReadVariableNames', false, 'HeaderLines', 3);
phase = readtable('TRACE02.CSV','ReadVariableNames', false, 'HeaderLines', 3);
mag.Properties.VariableNames = ["x","y","zero"];
phase.Properties.VariableNames = ["x","y","zero"];

figure()
sgtitle('\textbf{Bode Plot}','interpreter','latex');
subplot(2,1,1)
hold on
%plot(mag.x,mag.y,'k')
semilogx(mag.x,mag.y,'k')
grid minor
set(gca,'TickLabelInterpreter','latex')
ylabel('Magnitude [dB]','interpreter','latex');
xlabel('Frequency [Hz]','interpreter','latex');
%xlim([900e3 11e6])
ylim([-15 1])
hold off
subplot(2,1,2)
hold on
%plot(phase.x,unwrap(phase.y),'k')
semilogx(phase.x,unwrap(phase.y),'k')
grid minor
set(gca,'TickLabelInterpreter','latex')
ylabel('Phase [deg]','interpreter','latex');
xlabel('Frequency [Hz]','interpreter','latex');
xlim([0 14e6])
hold off
