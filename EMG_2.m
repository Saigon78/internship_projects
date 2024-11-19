close all
clear all
clc

cd('Data\Ergonomie experiment\Shimmer\')
import = importdata("mop_bucket\right\03_EMG_mop_bucket_R.csv");
% import = importdata("i-mop_xl\right\05_EMG_imop_XL_R.csv");
front_delt_left = import.data(:,5)*1000;

%% Removing uncoherent data (3 SD)
standard_deviation=std(front_delt_left);
average=mean(front_delt_left);
for j=1:length(front_delt_left)
    if front_delt_left(j)> (average+10*standard_deviation)|| front_delt_left(j)< (average-10*standard_deviation)
    front_delt_left(j)=nan;
    end
end

% import_max = importdata('Internship\Data\Ergonomie experiment\Shimmer\max_contractions\right\front_delt\03_mEMG_FD_R.csv');
import_max = importdata('Internship\Data\Ergonomie experiment\Shimmer\max_contractions\right\lat_delt\03_mEMG_LD_R.csv');
max_contraction_FD = import_max.data(:,5)*1000;

%% Task RMS

n = length(front_delt_left);

for i = 1:n-300
   
   window1 = front_delt_left(i:i+300);
   rms_classical(i) = fct_rms(window1);
   
end

L = length(rms_classical);
window_size = 200;

for j = 1:L-window_size
    
    window_1 = rms_classical(j:j+window_size);
    roll_avg_window_classical(j) = mean(window_1);
    
end

%% Max Contraction RMS

n=length(max_contraction_FD);

for i = 1:n-300
   
   window1 = max_contraction_FD(i:i+300);
   rms_max(i) = fct_rms(window1);
   
end

L = length(rms_max);
window_size = 200;

for j = 1:L-window_size
    
    window_1 = rms_max(j:j+window_size);
    roll_avg_window_max(j) = mean(window_1);
    
end

max_FD = max(roll_avg_window_max);

R_FD_Pourcentage_1 = (roll_avg_window_classical / max_FD)*100;

%% Time

time = time_column(512,roll_avg_window_classical');
S1 = seconds(time);
M1 = minutes(S1);

%% Removing uncoherent data (3 SD)
standard_deviation=std(front_delt_left);
average=mean(front_delt_left);
for j=1:length(front_delt_left)
    if front_delt_left(j)> (average+10*standard_deviation)|| front_delt_left(j)< (average-10*standard_deviation)
    front_delt_left(j)=nan;
    end
end

%% i-mop

% import = importdata("mop_bucket\right\03_EMG_mop_bucket_R.csv");
import = importdata("i-mop_xl\right\03_EMG_imop_XL_R.csv");
front_delt_left = import.data(:,5)*1000;

%% Removing uncoherent data (3 SD)
standard_deviation=std(front_delt_left);
average=mean(front_delt_left);
for j=1:length(front_delt_left)
    if front_delt_left(j)> (average+12*standard_deviation)|| front_delt_left(j) < (average-12*standard_deviation)
    front_delt_left(j)=nan;
    end
end

% import_max = importdata('Internship\Data\Ergonomie experiment\Shimmer\max_contractions\right\front_delt\03_mEMG_FD_R.csv');
import_max = importdata('Internship\Data\Ergonomie experiment\Shimmer\max_contractions\right\lat_delt\03_mEMG_LD_R.csv');
max_contraction_FD = import_max.data(:,5)*1000;

%% Task RMS

n = length(front_delt_left);

for i = 1:n-300
   
   window1 = front_delt_left(i:i+300);
   rms_classical(i) = fct_rms(window1);
   
end

L = length(rms_classical);
window_size = 200;

for j = 1:L-window_size
    
    window_1 = rms_classical(j:j+window_size);
    roll_avg_window_classical(j) = mean(window_1);
    
end

%% Max Contraction RMS

n=length(max_contraction_FD);

for i = 1:n-300
   
   window1 = max_contraction_FD(i:i+300);
   rms_max(i) = fct_rms(window1);
   
end

L = length(rms_max);
window_size = 200;

for j = 1:L-window_size
    
    window_1 = rms_max(j:j+window_size);
    roll_avg_window_max(j) = mean(window_1);
    
end

max_FD = max(roll_avg_window_max);

R_FD_Pourcentage_2 = (roll_avg_window_classical / max_FD)*100;

%% Removing uncoherent data (3 SD)
standard_deviation=std(front_delt_left);
average=mean(front_delt_left);
for j=1:length(front_delt_left)
    if front_delt_left(j)> (average+10*standard_deviation)|| front_delt_left(j)< (average-10*standard_deviation)
    front_delt_left(j)=nan;
    end
end

%% Time

time = time_column(512,roll_avg_window_classical');
S2 = seconds(time);
M2 = minutes(S2);

%% plot

L1 = length(R_FD_Pourcentage_1);
x10_1 = 10*ones(1,L1);

L2 = length(R_FD_Pourcentage_2);
x10_2 = 10*ones(1,L2);

figure

subplot(1,2,1)
plot(S1, R_FD_Pourcentage_1, 'DurationTickFormat','hh:mm:ss')
hold on
plot(S1, x10_1)
title('Mop and bucket','FontSize',20)
xlabel('Time (min)','FontSize',18)
ylabel('%MVC','FontSize',18)

set(gca,'FontSize', 16)

subplot(1,2,2)
plot(S2, R_FD_Pourcentage_2, 'DurationTickFormat','hh:mm:ss')
hold on
plot(S2, x10_2)
title('i-mop XL','FontSize',20)
xlabel('Time (min)','FontSize',18)
ylabel('%MVC','FontSize',18)

set(gca,'FontSize', 16)