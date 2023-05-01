clc;clear;close all;
%%
import_table = readtable('BPF-C4R5+_Plus25DegC.txt','ReadVariableNames', false, 'HeaderLines', 10);
import_table.Properties.VariableNames = ["freq", "mag_s11", "phase_s11", "mag_s21", "phase_s21", "mag_s12", "phase_s12", "mag_s22", "phase_s22"];

freq = import_table{:,'freq'};
mag = import_table{:,"mag_s21"};
phase = import_table{:,"phase_s21"};
freq = freq.*1e6;
phase = unwrap(phase);
%%
figure()
sgtitle('\textbf{Bode Plot}','interpreter','latex');
subplot(2,1,1)
hold on
semilogx(freq,mag,'k')
grid on
set(gca,'TickLabelInterpreter','latex')
ylabel('Magnitude [dB]','interpreter','latex');
xlabel('Frequency [Hz]','interpreter','latex');
xlim([0 14e6])
ylim([-15 1])
hold off
subplot(2,1,2)
hold on
semilogx(freq,phase,'k')
grid on
set(gca,'TickLabelInterpreter','latex')
ylabel('Phase [deg]','interpreter','latex');
xlabel('Frequency [Hz]','interpreter','latex');
xlim([0 14e6])
hold off
