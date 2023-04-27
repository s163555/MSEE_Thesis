%% CIRCUIT: PA
clear; close all; clc;
path_LTSpice = '"C:/Program Files/LTC/LTspiceXVII/XVIIx64.exe"';
circuit_path = 'C:/Users/Jeppe\OneDrive - Danmarks Tekniske Universitet/10. semester/MSc_Thesis_Teams/Simulation/';
circuit_name = 'Tx_PA';
command = ' -Run -ascii -b ';
%% Simulate and import data
% Run LTSpice simulation
command = [path_LTSpice command '"' circuit_path circuit_name '.asc"'];
dos(command);

% Import data
raw_data = LTspice2Matlab([circuit_path circuit_name '.raw']);

% Display variables
fprintf('var \t name\n')
for i=1:raw_data.num_variables
    fprintf('%d \t\t %s \n', raw_data.selected_vars(i), raw_data.variable_name_list{i})
end
%% Plot data
% Trace numbers
var_va = 6;
var_vb = 1;
var_vo = 9;
var_irout = 26;

Open_TimeVect = raw_data.time_vect;
Open_va = raw_data.variable_mat(var_va,:);
Open_vb = raw_data.variable_mat(var_vb,:);
Open_var_vo = raw_data.variable_mat(var_vo,:);
Open_var_irout = raw_data.variable_mat(var_irout,:);

figure(1)
subplot(3,1,1)
hold on
plot(raw_data.time_vect*1e9, raw_data.variable_mat(var_va,:), 'k');
plot(raw_data.time_vect*1e9, raw_data.variable_mat(var_vb,:), '--k');
title(sprintf('Waveform %s and %s', raw_data.variable_name_list{var_va},raw_data.variable_name_list{var_vb}));
grid minor
ylabel(raw_data.variable_type_list{var_va});
xlabel('Time [ns]' );
xlim([min(raw_data.time_vect*1e9) max(raw_data.time_vect*1e9)])
legend(raw_data.variable_name_list{var_va}, raw_data.variable_name_list{var_vb},'location','best');
hold off
subplot(3,1,2)
hold on
plot(raw_data.time_vect*1e9, raw_data.variable_mat(var_vo,:), 'k');
title(sprintf('Waveform %s', raw_data.variable_name_list{var_vo}));
grid minor
ylabel(sprintf('%s [V]',raw_data.variable_type_list{var_vo}));
xlabel('Time [ns]');
xlim([min(raw_data.time_vect*1e9) max(raw_data.time_vect)*1e9])
%xlim([SimDelay,SimStop]);
%ylim([min(raw_data.variable_mat(var_opa_out,:)-raw_data.variable_mat(var_spk_m,:)),max(raw_data.variable_mat(var_opa_out,:)-raw_data.variable_mat(var_spk_m,:))])
%legend(raw_data.variable_name_list{var_vo},'location','best');
%hold off
%sgt = sgtitle('Open loop','Color','black');
%sgt.FontSize = 20;
subplot(3,1,3)
hold on
plot(raw_data.time_vect*1e9, -raw_data.variable_mat(var_vo,:).*raw_data.variable_mat(var_irout,:), 'k');
%title(sprintf('Waveform -%s %\\cdot% %s', raw_data.variable_name_list{var_vo},raw_data.variable_name_list{var_irout}),'Interpreter','latex');
title(sprintf('Waveform -%s*%s', raw_data.variable_name_list{var_vo},raw_data.variable_name_list{var_irout}));
grid minor
ylabel('Power [W]');
xlabel('Time [ns]' );
xlim([min(raw_data.time_vect*1e9) max(raw_data.time_vect*1e9)])
%legend(raw_data.variable_name_list{var_vo},'location','best');
hold off
%% CIRCUIT: Preamplifier
clear; close all; clc;
path_LTSpice = '"C:/Program Files/LTC/LTspiceXVII/XVIIx64.exe"';
circuit_path = 'C:/Users/Jeppe\OneDrive - Danmarks Tekniske Universitet/10. semester/MSc_Thesis_Teams/Simulation/';
circuit_name = 'Rx_preamp';
command = ' -Run -ascii -b ';
%% Simulate and import data
% Run LTSpice simulation
command = [path_LTSpice command '"' circuit_path circuit_name '.asc"'];
dos(command);

% Import data
raw_data = LTspice2Matlab([circuit_path circuit_name '.raw']);

% Display variables
fprintf('var \t name\n')
for i=1:raw_data.num_variables
    fprintf('%d \t\t %s \n', raw_data.selected_vars(i), raw_data.variable_name_list{i})
end
%% Plot data
% Trace numbers
var_input = 18;
var_opa_out = 14;
var_vga_vip = 7;
var_vga_vin = 6;
var_vga_oh = 15;
var_vga_ol = 16;

Open_TimeVect = raw_data.time_vect;
Open_opa_out = raw_data.variable_mat(var_opa_out,:);
Open_input = raw_data.variable_mat(var_input,:);
Open_vga_vip = raw_data.variable_mat(var_vga_vip,:);
Open_vga_vin = raw_data.variable_mat(var_vga_vin,:);
Open_vga_oh = raw_data.variable_mat(var_vga_oh,:);
Open_vga_ol = raw_data.variable_mat(var_vga_ol,:);

figure(1)
subplot(2,1,1)
hold on
plot(raw_data.time_vect, raw_data.variable_mat(var_input,:), 'k');
plot(raw_data.time_vect, raw_data.variable_mat(var_opa_out,:), '--k');
title(sprintf('Waveform %s and %s', raw_data.variable_name_list{var_input},raw_data.variable_name_list{var_opa_out}));
grid minor
ylabel(raw_data.variable_type_list{var_input});
xlabel('Time [sec]' );
xlim([0 3e-7])
legend(raw_data.variable_name_list{var_input}, raw_data.variable_name_list{var_opa_out},'location','best');
hold off
%subplot(3,1,2)
%hold on
%plot(raw_data.time_vect, raw_data.variable_mat(var_vga_vip,:), 'k');
%plot(raw_data.time_vect, raw_data.variable_mat(var_vga_vin,:), '--k');
%title(sprintf('Waveform %s and %s', raw_data.variable_name_list{var_vga_vip},raw_data.variable_name_list{var_vga_vin}));
%grid on
%ylabel(raw_data.variable_type_list{var_opa_out});
%xlabel('Time [sec]' );
%xlim([SimDelay,SimStop]);
%ylim([min(raw_data.variable_mat(var_opa_out,:)-raw_data.variable_mat(var_spk_m,:)),max(raw_data.variable_mat(var_opa_out,:)-raw_data.variable_mat(var_spk_m,:))])
%legend(raw_data.variable_name_list{var_vga_vip}, raw_data.variable_name_list{var_vga_vin},'location','best');
%hold off
%sgt = sgtitle('Open loop','Color','black');
%sgt.FontSize = 20;
subplot(2,1,2)
hold on
plot(raw_data.time_vect, raw_data.variable_mat(var_vga_oh,:), 'k');
plot(raw_data.time_vect, raw_data.variable_mat(var_vga_ol,:), '--k');
title(sprintf('Waveform %s and %s', raw_data.variable_name_list{var_vga_oh},raw_data.variable_name_list{var_vga_ol}));
grid minor
ylabel(raw_data.variable_type_list{var_opa_out});
xlabel('Time [sec]' );
xlim([0 3e-7])
%xlim([SimDelay,SimStop]);
%ylim([min(raw_data.variable_mat(var_opa_out,:)-raw_data.variable_mat(var_spk_m,:)),max(raw_data.variable_mat(var_opa_out,:)-raw_data.variable_mat(var_spk_m,:))])
legend(raw_data.variable_name_list{var_vga_oh}, raw_data.variable_name_list{var_vga_ol},'location','best');
hold off
%% CIRCUIT: DEMODULATOR
clear; close all; clc;
path_LTSpice = '"C:/Program Files/LTC/LTspiceXVII/XVIIx64.exe"';
circuit_path = 'C:/Users/Jeppe\OneDrive - Danmarks Tekniske Universitet/10. semester/MSc_Thesis_Teams/Simulation/';
circuit_name = 'Rx_demod';
command = ' -Run -ascii -b ';
%% Simulate and import data
% Run LTSpice simulation
command = [path_LTSpice command '"' circuit_path circuit_name '.asc"'];
dos(command);

% Import data
raw_data = LTspice2Matlab([circuit_path circuit_name '.raw']);

% Display variables
fprintf('var \t name\n')
for i=1:raw_data.num_variables
    fprintf('%d \t\t %s \n', raw_data.selected_vars(i), raw_data.variable_name_list{i})
end
%% Plot data
% Trace numbers
var_lop = 9;
var_lon = 10;
var_vga_ol = 7;
var_vga_oh = 6;
var_out_i = 17;
var_out_q = 19;

figure(1)
%subplot(2,1,1)
hold on
plot(raw_data.time_vect, raw_data.variable_mat(var_vga_ol,:), 'k');
plot(raw_data.time_vect, raw_data.variable_mat(var_vga_oh,:), '--k');
title(sprintf('Waveform %s and %s', raw_data.variable_name_list{var_vga_ol},raw_data.variable_name_list{var_vga_oh}));
grid minor
ylabel(raw_data.variable_type_list{var_vga_ol});
xlabel('Time [sec]' );
xlim([1.5e-5 1.53e-5])
legend(raw_data.variable_name_list{var_vga_ol}, raw_data.variable_name_list{var_vga_oh},'location','best');
hold off
figure(2)
%subplot(2,1,2)
hold on
plot(raw_data.time_vect, raw_data.variable_mat(var_lop,:), 'k');
plot(raw_data.time_vect, raw_data.variable_mat(var_lon,:), ':k');
grid minor
legend(raw_data.variable_name_list{var_lop}, raw_data.variable_name_list{var_lon},'location','best');
ylabel(raw_data.variable_type_list{var_lop});
xlabel('Time [sec]' );
xlim([1.5e-5 1.53e-5])
ylim([1.05 1.35])
hold off

figure(3)
hold on
%plot(raw_data.time_vect, movmean(raw_data.variable_mat(var_out_i,:),1000), 'k');
plot(raw_data.time_vect, raw_data.variable_mat(var_out_i,:), 'k');
%plot(raw_data.time_vect, movmean(raw_data.variable_mat(var_out_q,:),1000), '--k');
plot(raw_data.time_vect, raw_data.variable_mat(var_out_q,:), '--k');
title(sprintf('Waveform %s and %s', raw_data.variable_name_list{var_out_i},raw_data.variable_name_list{var_out_q}));
grid minor
ylabel(raw_data.variable_type_list{var_out_i});
xlabel('Time [sec]' );
%xlim([1.5e-5 1.5e-4])
legend(raw_data.variable_name_list{var_out_i}, raw_data.variable_name_list{var_out_q},'location','best');
hold off
%% CIRCUIT: dc-coupler TRANSIENT
clear; close all; clc;
path_LTSpice = '"C:/Program Files/LTC/LTspiceXVII/XVIIx64.exe"';
circuit_path = 'C:/Users/Jeppe\OneDrive - Danmarks Tekniske Universitet/10. semester/MSc_Thesis_Teams/Simulation/';
circuit_name = 'dc-coupler';
command = ' -Run -ascii -b ';
%% Simulate and import data
% Run LTSpice simulation
command = [path_LTSpice command '"' circuit_path circuit_name '.asc"'];
dos(command);

% Import data
raw_data = LTspice2Matlab([circuit_path circuit_name '.raw']);

% Display variables
fprintf('var \t name\n')
for i=1:raw_data.num_variables
    fprintf('%d \t\t %s \n', raw_data.selected_vars(i), raw_data.variable_name_list{i})
end
%% Plot data
% Trace numbers
var_in = 4;
var_out = 1;

figure(1)
hold on
plot(raw_data.time_vect, raw_data.variable_mat(var_in,:), '--k');
plot(raw_data.time_vect, raw_data.variable_mat(var_out,:), 'k');
grid minor
legend(raw_data.variable_name_list{var_in}, raw_data.variable_name_list{var_out},'location','best');
ylabel(raw_data.variable_type_list{var_in});
xlabel('Time [sec]' );
hold off
%% FREQ analysis
clear; close all; clc;
fidi = fopen('dc-coupler.txt');
Dc = textscan(fidi, '%f(%fdB,%f°)', 'CollectOutput',1);
D = cell2mat(Dc);
figure
sgtitle('\textbf{Bode Plot}','interpreter','latex');
subplot(2,1,1)
semilogx(D(:,1), D(:,2),'k')
ylabel('Amplitude [dB]','Interpreter','latex')
grid
subplot(2,1,2)
semilogx(D(:,1), D(:,3),'k')
ylabel('Phase [deg]','Interpreter','latex')
grid
xlabel('Frequency [Hz]','Interpreter','latex')