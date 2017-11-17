clear all;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% This script analyzes the spike_data output file, the final weights,%%%
%%%% and the individual weights to visualize the change in weights over
%%%% time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load ../4_25_BiasedITC/Data_Input_biased/Data_InternalSynConns.txt
%load ../4_25_BiasedITC/Data_Input_biased/Data_InputSynConns.txt
%load ../4_25_BiasedITC/InputWeights_4_25_biased/allfinalwgtInp.dat
%allfinalwgtInp = sortrows(allfinalwgtInp);

%%%% Text File format
Spike_Data = dlmread('../Data_Output/Spikes/Spike_Data');

%%%%% NetPyNE format
% load model_output-20170628_125631.mat;
% loaded = [transpose(simData.spkt), transpose(simData.spkid)];
% loaded = sortrows(loaded, 2);
%aa = find(loaded(:,2)>120);
%Spike_Data=loaded(aa,1:2);

Hab_CS_on = cell(5,4);
Con_CS_on = cell(5,4);
Ext_CS_on = cell(20,4);
Hab_CS_off = cell(5,8);
Con_CS_off = cell(5,8);
Ext_CS_off = cell(20,8);
Hab_Trial = 5;
Con_Trial = 5;
Ext_Trial = 20;

%%Find times when CS is ON in 5 second bins
%%Hab_CS_on is 5 x 4 cell. Columns are bins, rows are trials.
%%Trial 1(40-45s,45-50s,50-55s,55-60s)
%%Trial 2(100-105s,105-110s,110-115s,115-120s)
%%Trial 3(160-165s,165-170s,170-175s,175-180s)
%%Trial 4(220-225s,225,230s,230-235s,235-240s)
%%Trial 5(280-285s,285-290s,290-295s,295-300s)
for i=1:Hab_Trial
Hab_CS_on{i,1} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+40000 & Spike_Data(:,1)<=60000*(i-1)+40000+5000),:);
Hab_CS_on{i,2} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+40000+5000 & Spike_Data(:,1)<=60000*(i-1)+40000+10000),:);
Hab_CS_on{i,3} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+40000+10000 & Spike_Data(:,1)<=60000*(i-1)+40000+15000),:);
Hab_CS_on{i,4} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+40000+15000 & Spike_Data(:,1)<=60000*(i-1)+40000+20000),:);
end

%%Same for conditioning 
%%NEED TO EXCLUDE TIME WHEN SHOCK IS ON
for i=1:Con_Trial
Con_CS_on{i,1} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+40000 & Spike_Data(:,1)<=300000+60000*(i-1)+40000+5000),:);
Con_CS_on{i,2} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+40000+5000 & Spike_Data(:,1)<=300000+60000*(i-1)+40000+10000),:);
Con_CS_on{i,3} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+40000+10000 & Spike_Data(:,1)<=300000+60000*(i-1)+40000+15000),:);
Con_CS_on{i,4} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+40000+15000 & Spike_Data(:,1)<=300000+60000*(i-1)+40000+19000),:);%%%%
end

%%Extinction
for i=1:Ext_Trial
Ext_CS_on{i,1} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+40000 & Spike_Data(:,1)<=720000+60000*(i-1)+40000+5000),:);
Ext_CS_on{i,2} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+40000+5000 & Spike_Data(:,1)<=720000+60000*(i-1)+40000+10000),:);
Ext_CS_on{i,3} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+40000+10000 & Spike_Data(:,1)<=720000+60000*(i-1)+40000+15000),:);
Ext_CS_on{i,4} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+40000+15000 & Spike_Data(:,1)<=720000+60000*(i-1)+40000+20000),:);
end

%%Find times when CS is OFF in 5 second bins 
%%Trial 1(0-5s,5-10s,10-15s,15-20s,20-25s,25-30s,30-35s,35-40s)
%%Trial 2(60-65s,65-70s,70-75s,75-80s,80-85s,85-90s,90-95s,95-100s)
%%etc
for i=1:Hab_Trial
Hab_CS_off{i,1} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1) & Spike_Data(:,1)<60000*(i-1)+5000),:);
Hab_CS_off{i,2} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+5000 & Spike_Data(:,1)<60000*(i-1)+10000),:);
Hab_CS_off{i,3} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+10000 & Spike_Data(:,1)<60000*(i-1)+15000),:);
Hab_CS_off{i,4} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+15000 & Spike_Data(:,1)<60000*(i-1)+20000),:);
Hab_CS_off{i,5} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+20000 & Spike_Data(:,1)<60000*(i-1)+25000),:);
Hab_CS_off{i,6} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+25000 & Spike_Data(:,1)<60000*(i-1)+30000),:);
Hab_CS_off{i,7} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+30000 & Spike_Data(:,1)<60000*(i-1)+35000),:);
Hab_CS_off{i,8} = Spike_Data(find(Spike_Data(:,1)>=60000*(i-1)+35000 & Spike_Data(:,1)<60000*(i-1)+40000),:);
end

for i=1:Con_Trial
Con_CS_off{i,1} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1) & Spike_Data(:,1)<300000+60000*(i-1)+5000),:);
Con_CS_off{i,2} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+5000 & Spike_Data(:,1)<300000+60000*(i-1)+10000),:);
Con_CS_off{i,3} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+10000 & Spike_Data(:,1)<300000+60000*(i-1)+15000),:);
Con_CS_off{i,4} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+15000 & Spike_Data(:,1)<300000+60000*(i-1)+20000),:);
Con_CS_off{i,5} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+20000 & Spike_Data(:,1)<300000+60000*(i-1)+25000),:);
Con_CS_off{i,6} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+25000 & Spike_Data(:,1)<300000+60000*(i-1)+30000),:);
Con_CS_off{i,7} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+30000 & Spike_Data(:,1)<300000+60000*(i-1)+35000),:);
Con_CS_off{i,8} = Spike_Data(find(Spike_Data(:,1)>=300000+60000*(i-1)+35000 & Spike_Data(:,1)<300000+60000*(i-1)+40000),:);
end

for i=1:Ext_Trial
Ext_CS_off{i,1} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1) & Spike_Data(:,1)<720000+60000*(i-1)+5000),:);
Ext_CS_off{i,2} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+5000 & Spike_Data(:,1)<720000+60000*(i-1)+10000),:);
Ext_CS_off{i,3} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+10000 & Spike_Data(:,1)<720000+60000*(i-1)+15000),:);
Ext_CS_off{i,4} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+15000 & Spike_Data(:,1)<720000+60000*(i-1)+20000),:);
Ext_CS_off{i,5} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+20000 & Spike_Data(:,1)<720000+60000*(i-1)+25000),:);
Ext_CS_off{i,6} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+25000 & Spike_Data(:,1)<720000+60000*(i-1)+30000),:);
Ext_CS_off{i,7} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+30000 & Spike_Data(:,1)<720000+60000*(i-1)+35000),:);
Ext_CS_off{i,8} = Spike_Data(find(Spike_Data(:,1)>=720000+60000*(i-1)+35000 & Spike_Data(:,1)<720000+60000*(i-1)+40000),:);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%We now have spikes times and IDs separated into bins and trials%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Now we separate them further based on spike IDs%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CeM_Hab_CS_on = cell(5,4);
CeM_Con_CS_on = cell(5,4);
CeM_Ext_CS_on = cell(20,4);
CeM_Hab_CS_off = cell(5,8);
CeM_Con_CS_off = cell(5,8);
CeM_Ext_CS_off = cell(20,8);

CeL_Hab_CS_on = cell(5,4);
CeL_Con_CS_on = cell(5,4);
CeL_Ext_CS_on = cell(20,4);
CeL_Hab_CS_off = cell(5,8);
CeL_Con_CS_off = cell(5,8);
CeL_Ext_CS_off = cell(20,8);


for i=1:Hab_Trial
CeM_Hab_CS_on{i,1} = Hab_CS_on{i,1}(find(Hab_CS_on{i,1}(:,2)<=259),:);
CeM_Hab_CS_on{i,2} = Hab_CS_on{i,2}(find(Hab_CS_on{i,2}(:,2)<=259),:);
CeM_Hab_CS_on{i,3} = Hab_CS_on{i,3}(find(Hab_CS_on{i,3}(:,2)<=259),:);
CeM_Hab_CS_on{i,4} = Hab_CS_on{i,4}(find(Hab_CS_on{i,4}(:,2)<=259),:);
end

for i=1:Con_Trial
CeM_Con_CS_on{i,1} = Con_CS_on{i,1}(find(Con_CS_on{i,1}(:,2)<=259),:);
CeM_Con_CS_on{i,2} = Con_CS_on{i,2}(find(Con_CS_on{i,2}(:,2)<=259),:);
CeM_Con_CS_on{i,3} = Con_CS_on{i,3}(find(Con_CS_on{i,3}(:,2)<=259),:);
CeM_Con_CS_on{i,4} = Con_CS_on{i,4}(find(Con_CS_on{i,4}(:,2)<=259),:);
end

for i=1:Ext_Trial
CeM_Ext_CS_on{i,1} = Ext_CS_on{i,1}(find(Ext_CS_on{i,1}(:,2)<=259),:);
CeM_Ext_CS_on{i,2} = Ext_CS_on{i,2}(find(Ext_CS_on{i,2}(:,2)<=259),:);
CeM_Ext_CS_on{i,3} = Ext_CS_on{i,3}(find(Ext_CS_on{i,3}(:,2)<=259),:);
CeM_Ext_CS_on{i,4} = Ext_CS_on{i,4}(find(Ext_CS_on{i,4}(:,2)<=259),:);
end

for i=1:Hab_Trial
CeM_Hab_CS_off{i,1} = Hab_CS_off{i,1}(find(Hab_CS_off{i,1}(:,2)<=259),:);
CeM_Hab_CS_off{i,2} = Hab_CS_off{i,2}(find(Hab_CS_off{i,2}(:,2)<=259),:);
CeM_Hab_CS_off{i,3} = Hab_CS_off{i,3}(find(Hab_CS_off{i,3}(:,2)<=259),:);
CeM_Hab_CS_off{i,4} = Hab_CS_off{i,4}(find(Hab_CS_off{i,4}(:,2)<=259),:);
CeM_Hab_CS_off{i,5} = Hab_CS_off{i,5}(find(Hab_CS_off{i,5}(:,2)<=259),:);
CeM_Hab_CS_off{i,6} = Hab_CS_off{i,6}(find(Hab_CS_off{i,6}(:,2)<=259),:);
CeM_Hab_CS_off{i,7} = Hab_CS_off{i,7}(find(Hab_CS_off{i,7}(:,2)<=259),:);
CeM_Hab_CS_off{i,8} = Hab_CS_off{i,8}(find(Hab_CS_off{i,8}(:,2)<=259),:);
end

for i=1:Con_Trial
CeM_Con_CS_off{i,1} = Con_CS_off{i,1}(find(Con_CS_off{i,1}(:,2)<=259),:);
CeM_Con_CS_off{i,2} = Con_CS_off{i,2}(find(Con_CS_off{i,2}(:,2)<=259),:);
CeM_Con_CS_off{i,3} = Con_CS_off{i,3}(find(Con_CS_off{i,3}(:,2)<=259),:);
CeM_Con_CS_off{i,4} = Con_CS_off{i,4}(find(Con_CS_off{i,4}(:,2)<=259),:);
CeM_Con_CS_off{i,5} = Con_CS_off{i,5}(find(Con_CS_off{i,5}(:,2)<=259),:);
CeM_Con_CS_off{i,6} = Con_CS_off{i,6}(find(Con_CS_off{i,6}(:,2)<=259),:);
CeM_Con_CS_off{i,7} = Con_CS_off{i,7}(find(Con_CS_off{i,7}(:,2)<=259),:);
CeM_Con_CS_off{i,8} = Con_CS_off{i,8}(find(Con_CS_off{i,8}(:,2)<=259),:);
end

for i=1:Ext_Trial
CeM_Ext_CS_off{i,1} = Ext_CS_off{i,1}(find(Ext_CS_off{i,1}(:,2)<=259),:);
CeM_Ext_CS_off{i,2} = Ext_CS_off{i,2}(find(Ext_CS_off{i,2}(:,2)<=259),:);
CeM_Ext_CS_off{i,3} = Ext_CS_off{i,3}(find(Ext_CS_off{i,3}(:,2)<=259),:);
CeM_Ext_CS_off{i,4} = Ext_CS_off{i,4}(find(Ext_CS_off{i,4}(:,2)<=259),:);
CeM_Ext_CS_off{i,5} = Ext_CS_off{i,5}(find(Ext_CS_off{i,5}(:,2)<=259),:);
CeM_Ext_CS_off{i,6} = Ext_CS_off{i,6}(find(Ext_CS_off{i,6}(:,2)<=259),:);
CeM_Ext_CS_off{i,7} = Ext_CS_off{i,7}(find(Ext_CS_off{i,7}(:,2)<=259),:);
CeM_Ext_CS_off{i,8} = Ext_CS_off{i,8}(find(Ext_CS_off{i,8}(:,2)<=259),:);
end

for i=1:Hab_Trial
CeL_Hab_CS_on{i,1} = Hab_CS_on{i,1}(find(Hab_CS_on{i,1}(:,2)>=260),:);
CeL_Hab_CS_on{i,2} = Hab_CS_on{i,2}(find(Hab_CS_on{i,2}(:,2)>=260),:);
CeL_Hab_CS_on{i,3} = Hab_CS_on{i,3}(find(Hab_CS_on{i,3}(:,2)>=260),:);
CeL_Hab_CS_on{i,4} = Hab_CS_on{i,4}(find(Hab_CS_on{i,4}(:,2)>=260),:);
end

for i=1:Con_Trial
CeL_Con_CS_on{i,1} = Con_CS_on{i,1}(find(Con_CS_on{i,1}(:,2)>=260),:);
CeL_Con_CS_on{i,2} = Con_CS_on{i,2}(find(Con_CS_on{i,2}(:,2)>=260),:);
CeL_Con_CS_on{i,3} = Con_CS_on{i,3}(find(Con_CS_on{i,3}(:,2)>=260),:);
CeL_Con_CS_on{i,4} = Con_CS_on{i,4}(find(Con_CS_on{i,4}(:,2)>=260),:);
end

for i=1:Ext_Trial
CeL_Ext_CS_on{i,1} = Ext_CS_on{i,1}(find(Ext_CS_on{i,1}(:,2)>=260),:);
CeL_Ext_CS_on{i,2} = Ext_CS_on{i,2}(find(Ext_CS_on{i,2}(:,2)>=260),:);
CeL_Ext_CS_on{i,3} = Ext_CS_on{i,3}(find(Ext_CS_on{i,3}(:,2)>=260),:);
CeL_Ext_CS_on{i,4} = Ext_CS_on{i,4}(find(Ext_CS_on{i,4}(:,2)>=260),:);
end

for i=1:Hab_Trial
CeL_Hab_CS_off{i,1} = Hab_CS_off{i,1}(find(Hab_CS_off{i,1}(:,2)>=260),:);
CeL_Hab_CS_off{i,2} = Hab_CS_off{i,2}(find(Hab_CS_off{i,2}(:,2)>=260),:);
CeL_Hab_CS_off{i,3} = Hab_CS_off{i,3}(find(Hab_CS_off{i,3}(:,2)>=260),:);
CeL_Hab_CS_off{i,4} = Hab_CS_off{i,4}(find(Hab_CS_off{i,4}(:,2)>=260),:);
CeL_Hab_CS_off{i,5} = Hab_CS_off{i,5}(find(Hab_CS_off{i,5}(:,2)>=260),:);
CeL_Hab_CS_off{i,6} = Hab_CS_off{i,6}(find(Hab_CS_off{i,6}(:,2)>=260),:);
CeL_Hab_CS_off{i,7} = Hab_CS_off{i,7}(find(Hab_CS_off{i,7}(:,2)>=260),:);
CeL_Hab_CS_off{i,8} = Hab_CS_off{i,8}(find(Hab_CS_off{i,8}(:,2)>=260),:);
end

for i=1:Con_Trial
CeL_Con_CS_off{i,1} = Con_CS_off{i,1}(find(Con_CS_off{i,1}(:,2)>=260),:);
CeL_Con_CS_off{i,2} = Con_CS_off{i,2}(find(Con_CS_off{i,2}(:,2)>=260),:);
CeL_Con_CS_off{i,3} = Con_CS_off{i,3}(find(Con_CS_off{i,3}(:,2)>=260),:);
CeL_Con_CS_off{i,4} = Con_CS_off{i,4}(find(Con_CS_off{i,4}(:,2)>=260),:);
CeL_Con_CS_off{i,5} = Con_CS_off{i,5}(find(Con_CS_off{i,5}(:,2)>=260),:);
CeL_Con_CS_off{i,6} = Con_CS_off{i,6}(find(Con_CS_off{i,6}(:,2)>=260),:);
CeL_Con_CS_off{i,7} = Con_CS_off{i,7}(find(Con_CS_off{i,7}(:,2)>=260),:);
CeL_Con_CS_off{i,8} = Con_CS_off{i,8}(find(Con_CS_off{i,8}(:,2)>=260),:);
end

for i=1:Ext_Trial
CeL_Ext_CS_off{i,1} = Ext_CS_off{i,1}(find(Ext_CS_off{i,1}(:,2)>=260),:);
CeL_Ext_CS_off{i,2} = Ext_CS_off{i,2}(find(Ext_CS_off{i,2}(:,2)>=260),:);
CeL_Ext_CS_off{i,3} = Ext_CS_off{i,3}(find(Ext_CS_off{i,3}(:,2)>=260),:);
CeL_Ext_CS_off{i,4} = Ext_CS_off{i,4}(find(Ext_CS_off{i,4}(:,2)>=260),:);
CeL_Ext_CS_off{i,5} = Ext_CS_off{i,5}(find(Ext_CS_off{i,5}(:,2)>=260),:);
CeL_Ext_CS_off{i,6} = Ext_CS_off{i,6}(find(Ext_CS_off{i,6}(:,2)>=260),:);
CeL_Ext_CS_off{i,7} = Ext_CS_off{i,7}(find(Ext_CS_off{i,7}(:,2)>=260),:);
CeL_Ext_CS_off{i,8} = Ext_CS_off{i,8}(find(Ext_CS_off{i,8}(:,2)>=260),:);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Now there are cells containing spike times and IDs corresponding  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% to the three subnuclei. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%% We now want to calculate the spontaneous activity of the cells %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%SSpikes_CeM_Hab_CS_off is a 5 x 8 cell that contains 260 x 1 matrices
%%indicating how many times each cell spiked during a particular trial and
%%bin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for i=1:Hab_Trial
        for j = 1:260
		for k = 1:8
        SSpikes_CeM_Hab_CS_off{i,k}(j,1) = length(find(CeM_Hab_CS_off{i,k}(:,2) == j-1));
%         if (j>=76)
%         SSpikes_CeM_Hab_CS_off{i,k}(j,1) = SSpikes_CeM_Hab_CS_off{i,k}(j,1)/2;
% 		end
        end
        end
 end
 
%%Spon_Freq_CeM contains the average number of spikes for cells 0-259
%%during Habituation when CS is off
Spon_freq_CeM =  [mean(SSpikes_CeM_Hab_CS_off{1,1}) mean(SSpikes_CeM_Hab_CS_off{2,1}) mean(SSpikes_CeM_Hab_CS_off{3,1}) mean(SSpikes_CeM_Hab_CS_off{4,1}) mean(SSpikes_CeM_Hab_CS_off{5,1});
				  mean(SSpikes_CeM_Hab_CS_off{1,2}) mean(SSpikes_CeM_Hab_CS_off{2,2}) mean(SSpikes_CeM_Hab_CS_off{3,2}) mean(SSpikes_CeM_Hab_CS_off{4,2}) mean(SSpikes_CeM_Hab_CS_off{5,2});
				  mean(SSpikes_CeM_Hab_CS_off{1,3}) mean(SSpikes_CeM_Hab_CS_off{2,3}) mean(SSpikes_CeM_Hab_CS_off{3,3}) mean(SSpikes_CeM_Hab_CS_off{4,3}) mean(SSpikes_CeM_Hab_CS_off{5,3});
				  mean(SSpikes_CeM_Hab_CS_off{1,4}) mean(SSpikes_CeM_Hab_CS_off{2,4}) mean(SSpikes_CeM_Hab_CS_off{3,4}) mean(SSpikes_CeM_Hab_CS_off{4,4}) mean(SSpikes_CeM_Hab_CS_off{5,4});
				  mean(SSpikes_CeM_Hab_CS_off{1,5}) mean(SSpikes_CeM_Hab_CS_off{2,5}) mean(SSpikes_CeM_Hab_CS_off{3,5}) mean(SSpikes_CeM_Hab_CS_off{4,5}) mean(SSpikes_CeM_Hab_CS_off{5,5});
				  mean(SSpikes_CeM_Hab_CS_off{1,6}) mean(SSpikes_CeM_Hab_CS_off{2,6}) mean(SSpikes_CeM_Hab_CS_off{3,6}) mean(SSpikes_CeM_Hab_CS_off{4,6}) mean(SSpikes_CeM_Hab_CS_off{5,6});
				  mean(SSpikes_CeM_Hab_CS_off{1,7}) mean(SSpikes_CeM_Hab_CS_off{2,7}) mean(SSpikes_CeM_Hab_CS_off{3,7}) mean(SSpikes_CeM_Hab_CS_off{4,7}) mean(SSpikes_CeM_Hab_CS_off{5,7});
				  mean(SSpikes_CeM_Hab_CS_off{1,8}) mean(SSpikes_CeM_Hab_CS_off{2,8}) mean(SSpikes_CeM_Hab_CS_off{3,8}) mean(SSpikes_CeM_Hab_CS_off{4,8}) mean(SSpikes_CeM_Hab_CS_off{5,8}) ];

              
              
%%Spontaneous_CeM is [sp1 sp2 sp3 sp4 sp5] where each sp is the average
%%spikes during each trial of habituation when CS is OFF
Spontaneous_CeM = mean(Spon_freq_CeM/5)


std_CeM =  	     [std(SSpikes_CeM_Hab_CS_off{1,1}) std(SSpikes_CeM_Hab_CS_off{2,1}) std(SSpikes_CeM_Hab_CS_off{3,1}) std(SSpikes_CeM_Hab_CS_off{4,1}) std(SSpikes_CeM_Hab_CS_off{5,1});
				  std(SSpikes_CeM_Hab_CS_off{1,2}) std(SSpikes_CeM_Hab_CS_off{2,2}) std(SSpikes_CeM_Hab_CS_off{3,2}) std(SSpikes_CeM_Hab_CS_off{4,2}) std(SSpikes_CeM_Hab_CS_off{5,2});
				  std(SSpikes_CeM_Hab_CS_off{1,3}) std(SSpikes_CeM_Hab_CS_off{2,3}) std(SSpikes_CeM_Hab_CS_off{3,3}) std(SSpikes_CeM_Hab_CS_off{4,3}) std(SSpikes_CeM_Hab_CS_off{5,3});
				  std(SSpikes_CeM_Hab_CS_off{1,4}) std(SSpikes_CeM_Hab_CS_off{2,4}) std(SSpikes_CeM_Hab_CS_off{3,4}) std(SSpikes_CeM_Hab_CS_off{4,4}) std(SSpikes_CeM_Hab_CS_off{5,4});
				  std(SSpikes_CeM_Hab_CS_off{1,5}) std(SSpikes_CeM_Hab_CS_off{2,5}) std(SSpikes_CeM_Hab_CS_off{3,5}) std(SSpikes_CeM_Hab_CS_off{4,5}) std(SSpikes_CeM_Hab_CS_off{5,5});
				  std(SSpikes_CeM_Hab_CS_off{1,6}) std(SSpikes_CeM_Hab_CS_off{2,6}) std(SSpikes_CeM_Hab_CS_off{3,6}) std(SSpikes_CeM_Hab_CS_off{4,6}) std(SSpikes_CeM_Hab_CS_off{5,6});
				  std(SSpikes_CeM_Hab_CS_off{1,7}) std(SSpikes_CeM_Hab_CS_off{2,7}) std(SSpikes_CeM_Hab_CS_off{3,7}) std(SSpikes_CeM_Hab_CS_off{4,7}) std(SSpikes_CeM_Hab_CS_off{5,7});
				  std(SSpikes_CeM_Hab_CS_off{1,8}) std(SSpikes_CeM_Hab_CS_off{2,8}) std(SSpikes_CeM_Hab_CS_off{3,8}) std(SSpikes_CeM_Hab_CS_off{4,8}) std(SSpikes_CeM_Hab_CS_off{5,8}) ];

Standard_Devi_CeM = mean(std_CeM/5)




%%%% Repeat the above process for CeL %%%%%

 for i=1:Hab_Trial
        for j = 1:240
		for k = 1: 8
        SSpikes_CeL_Hab_CS_off{i,k}(j,1) = length(find(CeL_Hab_CS_off{i,k}(:,2) == j+259));
%         if ((j>=65 && j<=96)||(j>=222))
%         SSpikes_CeL_Hab_CS_off{i,k}(j,1) = SSpikes_CeL_Hab_CS_off{i,k}(j,1)/2;
%		end
        end
        end
 end

% Calculate spontaneous frequency of each cell 
for j=1:size(SSpikes_CeL_Hab_CS_off,1)
    for i=1:size(SSpikes_CeL_Hab_CS_off,2)
        aa(:,i)=SSpikes_CeL_Hab_CS_off{j,i}(:,1)/5;
    end
    bb(j,:) = mean(aa,2);
    clear aa;
end
Spon_freq_CeL_cells = mean(bb,1)';
clear bb;

for j=1:size(SSpikes_CeM_Hab_CS_off,1)
    for i=1:size(SSpikes_CeM_Hab_CS_off,2)
        aa(:,i)=SSpikes_CeM_Hab_CS_off{j,i}(:,1)/5;
    end
    bb(j,:) = mean(aa,2);
    clear aa;
end
Spon_freq_CeM_cells = mean(bb,1)';
 
Spon_freq_CeL =  [mean(SSpikes_CeL_Hab_CS_off{1,1}) mean(SSpikes_CeL_Hab_CS_off{2,1}) mean(SSpikes_CeL_Hab_CS_off{3,1}) mean(SSpikes_CeL_Hab_CS_off{4,1}) mean(SSpikes_CeL_Hab_CS_off{5,1});
				  mean(SSpikes_CeL_Hab_CS_off{1,2}) mean(SSpikes_CeL_Hab_CS_off{2,2}) mean(SSpikes_CeL_Hab_CS_off{3,2}) mean(SSpikes_CeL_Hab_CS_off{4,2}) mean(SSpikes_CeL_Hab_CS_off{5,2});
				  mean(SSpikes_CeL_Hab_CS_off{1,3}) mean(SSpikes_CeL_Hab_CS_off{2,3}) mean(SSpikes_CeL_Hab_CS_off{3,3}) mean(SSpikes_CeL_Hab_CS_off{4,3}) mean(SSpikes_CeL_Hab_CS_off{5,3});
				  mean(SSpikes_CeL_Hab_CS_off{1,4}) mean(SSpikes_CeL_Hab_CS_off{2,4}) mean(SSpikes_CeL_Hab_CS_off{3,4}) mean(SSpikes_CeL_Hab_CS_off{4,4}) mean(SSpikes_CeL_Hab_CS_off{5,4});
				  mean(SSpikes_CeL_Hab_CS_off{1,5}) mean(SSpikes_CeL_Hab_CS_off{2,5}) mean(SSpikes_CeL_Hab_CS_off{3,5}) mean(SSpikes_CeL_Hab_CS_off{4,5}) mean(SSpikes_CeL_Hab_CS_off{5,5});
				  mean(SSpikes_CeL_Hab_CS_off{1,6}) mean(SSpikes_CeL_Hab_CS_off{2,6}) mean(SSpikes_CeL_Hab_CS_off{3,6}) mean(SSpikes_CeL_Hab_CS_off{4,6}) mean(SSpikes_CeL_Hab_CS_off{5,6});
				  mean(SSpikes_CeL_Hab_CS_off{1,7}) mean(SSpikes_CeL_Hab_CS_off{2,7}) mean(SSpikes_CeL_Hab_CS_off{3,7}) mean(SSpikes_CeL_Hab_CS_off{4,7}) mean(SSpikes_CeL_Hab_CS_off{5,7});
				  mean(SSpikes_CeL_Hab_CS_off{1,8}) mean(SSpikes_CeL_Hab_CS_off{2,8}) mean(SSpikes_CeL_Hab_CS_off{3,8}) mean(SSpikes_CeL_Hab_CS_off{4,8}) mean(SSpikes_CeL_Hab_CS_off{5,8}) ];
				  
Spontenous_CeL = mean(Spon_freq_CeL/5)

std_CeL =  	     [std(SSpikes_CeL_Hab_CS_off{1,1}) std(SSpikes_CeL_Hab_CS_off{2,1}) std(SSpikes_CeL_Hab_CS_off{3,1}) std(SSpikes_CeL_Hab_CS_off{4,1}) std(SSpikes_CeL_Hab_CS_off{5,1});
				  std(SSpikes_CeL_Hab_CS_off{1,2}) std(SSpikes_CeL_Hab_CS_off{2,2}) std(SSpikes_CeL_Hab_CS_off{3,2}) std(SSpikes_CeL_Hab_CS_off{4,2}) std(SSpikes_CeL_Hab_CS_off{5,2});
				  std(SSpikes_CeL_Hab_CS_off{1,3}) std(SSpikes_CeL_Hab_CS_off{2,3}) std(SSpikes_CeL_Hab_CS_off{3,3}) std(SSpikes_CeL_Hab_CS_off{4,3}) std(SSpikes_CeL_Hab_CS_off{5,3});
				  std(SSpikes_CeL_Hab_CS_off{1,4}) std(SSpikes_CeL_Hab_CS_off{2,4}) std(SSpikes_CeL_Hab_CS_off{3,4}) std(SSpikes_CeL_Hab_CS_off{4,4}) std(SSpikes_CeL_Hab_CS_off{5,4});
				  std(SSpikes_CeL_Hab_CS_off{1,5}) std(SSpikes_CeL_Hab_CS_off{2,5}) std(SSpikes_CeL_Hab_CS_off{3,5}) std(SSpikes_CeL_Hab_CS_off{4,5}) std(SSpikes_CeL_Hab_CS_off{5,5});
				  std(SSpikes_CeL_Hab_CS_off{1,6}) std(SSpikes_CeL_Hab_CS_off{2,6}) std(SSpikes_CeL_Hab_CS_off{3,6}) std(SSpikes_CeL_Hab_CS_off{4,6}) std(SSpikes_CeL_Hab_CS_off{5,6});
				  std(SSpikes_CeL_Hab_CS_off{1,7}) std(SSpikes_CeL_Hab_CS_off{2,7}) std(SSpikes_CeL_Hab_CS_off{3,7}) std(SSpikes_CeL_Hab_CS_off{4,7}) std(SSpikes_CeL_Hab_CS_off{5,7});
				  std(SSpikes_CeL_Hab_CS_off{1,8}) std(SSpikes_CeL_Hab_CS_off{2,8}) std(SSpikes_CeL_Hab_CS_off{3,8}) std(SSpikes_CeL_Hab_CS_off{4,8}) std(SSpikes_CeL_Hab_CS_off{5,8}) ];

Standard_Devi_CeL = mean(std_CeL/5)

for i=1:5
    for j=1:8
        Spon_freq_CeL_PKCDm(j,i) = mean(SSpikes_CeL_Hab_CS_off{i,j}(1:120,:));
        std_CeL_PKCDm(j,i) = std(SSpikes_CeL_Hab_CS_off{i,j}(1:120,:));
    end
end

for i=1:5
    for j=1:8
        Spon_freq_CeL_PKCDm_RS(j,i) = mean(SSpikes_CeL_Hab_CS_off{i,j}(1:65,:));
        std_CeL_PKCDm_RS(j,i) = std(SSpikes_CeL_Hab_CS_off{i,j}(1:65,:));
    end
end

for i=1:5
    for j=1:8
        Spon_freq_CeL_PKCDm_LTB(j,i) = mean(SSpikes_CeL_Hab_CS_off{i,j}(80:120,:));
        std_CeL_PKCDm_LTB(j,i) = std(SSpikes_CeL_Hab_CS_off{i,j}(80:120,:));
    end
end

Spontenous_CeL_PKCDm = mean(Spon_freq_CeL_PKCDm/5)
Spontenous_CeL_PKCDm_RS = mean(Spon_freq_CeL_PKCDm_RS/5)
Spontenous_CeL_PKCDm_LTB = mean(Spon_freq_CeL_PKCDm_LTB/5)
						


Standard_Devi_CeL_PKCDm = mean(std_CeL_PKCDm/5)
Standard_Devi_CeL_PKCDm_RS = mean(std_CeL_PKCDm_RS/5)
Standard_Devi_CeL_PKCDm_LTB = mean(std_CeL_PKCDm_LTB/5)
						
Spon_freq_CeL_PKCDp =  [mean(SSpikes_CeL_Hab_CS_off{1,1}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,1}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,1}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,1}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,1}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,2}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,2}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,2}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,2}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,2}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,3}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,3}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,3}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,3}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,3}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,4}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,4}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,4}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,4}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,4}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,5}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,5}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,5}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,5}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,5}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,6}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,6}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,6}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,6}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,6}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,7}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,7}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,7}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,7}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,7}(121:240,:));
						mean(SSpikes_CeL_Hab_CS_off{1,8}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{2,8}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{3,8}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{4,8}(121:240,:)) mean(SSpikes_CeL_Hab_CS_off{5,8}(121:240,:)) ];

Spontenous_CeL_PKCDp = mean(Spon_freq_CeL_PKCDp/5)

						
std_CeL_PKCDp =[std(SSpikes_CeL_Hab_CS_off{1,1}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,1}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,1}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,1}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,1}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,2}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,2}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,2}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,2}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,2}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,3}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,3}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,3}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,3}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,3}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,4}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,4}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,4}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,4}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,4}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,5}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,5}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,5}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,5}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,5}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,6}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,6}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,6}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,6}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,6}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,7}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,7}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,7}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,7}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,7}(121:240,:));
				std(SSpikes_CeL_Hab_CS_off{1,8}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{2,8}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{3,8}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{4,8}(121:240,:)) std(SSpikes_CeL_Hab_CS_off{5,8}(121:240,:)) ];

Standard_Devi_CeL_PKCDp = mean(std_CeL_PKCDp/5)	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% This ends the calculation of spontaneuous activity %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%% The next section identifies CS_on and CS_off cells %%%%%%%%%%

%%%%% Find number of spikes for each CeM cell when CS is off and store in
%%%%% CeM_Hab_CS_off_Cells. Do the same for when CS is on.
for i=1:Hab_Trial
    for j=1:260
	for k = 1:8
CeM_Hab_CS_off_Cells{i,k}(j,1) = (length(find(CeM_Hab_CS_off{i,k}(:,2)==j-1)));
end
for l = 1:4
CeM_Hab_CS_on_Cells{i,l}(j,1) = length(find(CeM_Hab_CS_on{i,l}(:,2)==j-1));
    end
	end
    for j=261:500
		for k = 1:8
CeL_Hab_CS_off_Cells{i,k}(j-260,1) = (length(find(CeL_Hab_CS_off{i,k}(:,2)==j-1)));
end
for l = 1:4
CeL_Hab_CS_on_Cells{i,l}(j-260,1) = length(find(CeL_Hab_CS_on{i,l}(:,2)==j-1));
end
    end
end

%%%%% Do the same for conditioning
for i=1:Con_Trial
    for j=1:260
		for k = 1:8
CeM_Con_CS_off_Cells{i,k}(j,1) = (length(find(CeM_Con_CS_off{i,k}(:,2)==j-1)));
end
	for l = 1:4
CeM_Con_CS_on_Cells{i,l}(j,1) = length(find(CeM_Con_CS_on{i,l}(:,2)==j-1));
end
    end
    
    for j=261:500
			for k = 1:8
CeL_Con_CS_off_Cells{i,k}(j-260,1) = (length(find(CeL_Con_CS_off{i,k}(:,2)==j-1)));
end
		for l = 1:4
CeL_Con_CS_on_Cells{i,l}(j-260,1) = length(find(CeL_Con_CS_on{i,l}(:,2)==j-1));
end
    end
    
end

%%%%%% For Early Extinction (First five trials)
for i=1:Ext_Trial-15  % Early Extinction
    for j=1:260
		for k = 1:8
CeM_Ext_CS_off_Cells{i,k}(j,1) = (length(find(CeM_Ext_CS_off{i,k}(:,2)==j-1)));
end
	for l = 1:4
CeM_Ext_CS_on_Cells{i,l}(j,1) = length(find(CeM_Ext_CS_on{i,l}(:,2)==j-1));
end
    end
    for j=261:500
			for k = 1:8
CeL_Ext_CS_off_Cells{i,k}(j-260,1) = (length(find(CeL_Ext_CS_off{i,k}(:,2)==j-1)));
end
		for l = 1:4
CeL_Ext_CS_on_Cells{i,l}(j-260,1) = length(find(CeL_Ext_CS_on{i,l}(:,2)==j-1));
end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Mean_CeM_Hab_CS_off_Cells is 260 x 5 matrix that contains the average
%%%% number of spikes for each trial of Habituation when CS is off.
%%%% MMean_CeM_Hab_CS_off_Cells is the mean spikes for all the trials of
%%%% habituation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:260
for i = 1:Hab_Trial
aa = [CeM_Hab_CS_off_Cells{i,1}(j,1), CeM_Hab_CS_off_Cells{i,2}(j,1), CeM_Hab_CS_off_Cells{i,3}(j,1), CeM_Hab_CS_off_Cells{i,4}(j,1), CeM_Hab_CS_off_Cells{i,5}(j,1), CeM_Hab_CS_off_Cells{i,6}(j,1), CeM_Hab_CS_off_Cells{i,7}(j,1), CeM_Hab_CS_off_Cells{i,8}(j,1)];
Mean_CeM_Hab_CS_off_Cells(j,i) = mean(aa); 
Std_CeM_Hab_CS_off_Cells(j,i) = std(aa);
clear aa;
bb = [CeM_Hab_CS_on_Cells{i,1}(j,1), CeM_Hab_CS_on_Cells{i,2}(j,1), CeM_Hab_CS_on_Cells{i,3}(j,1), CeM_Hab_CS_on_Cells{i,4}(j,1)];
Mean_CeM_Hab_CS_on_Cells(j,i) = mean(bb); 
Std_CeM_Hab_CS_on_Cells(j,i) = std(bb);
clear bb;
end
MMean_CeM_Hab_CS_off_Cells(j,1) = mean(Mean_CeM_Hab_CS_off_Cells(j,:));
MStd_CeM_Hab_CS_off_Cells(j,1) = mean(Std_CeM_Hab_CS_off_Cells(j,:));

MMean_CeM_Hab_CS_on_Cells(j,1) = mean(Mean_CeM_Hab_CS_on_Cells(j,:));
MStd_CeM_Hab_CS_on_Cells(j,1) = mean(Std_CeM_Hab_CS_on_Cells(j,:));
end


for j=1:240
for i = 1:Hab_Trial
aa = [CeL_Hab_CS_off_Cells{i,1}(j,1), CeL_Hab_CS_off_Cells{i,2}(j,1), CeL_Hab_CS_off_Cells{i,3}(j,1), CeL_Hab_CS_off_Cells{i,4}(j,1), CeL_Hab_CS_off_Cells{i,5}(j,1), CeL_Hab_CS_off_Cells{i,6}(j,1), CeL_Hab_CS_off_Cells{i,7}(j,1), CeL_Hab_CS_off_Cells{i,8}(j,1)];   
Mean_CeL_Hab_CS_off_Cells(j,i) = mean(aa);
Std_CeL_Hab_CS_off_Cells(j,i) = std(aa);
clear aa;
bb = [CeL_Hab_CS_on_Cells{i,1}(j,1), CeL_Hab_CS_on_Cells{i,2}(j,1), CeL_Hab_CS_on_Cells{i,3}(j,1), CeL_Hab_CS_on_Cells{i,4}(j,1)];
Mean_CeL_Hab_CS_on_Cells(j,i) = mean(bb);
Std_CeL_Hab_CS_on_Cells(j,i) = std(bb);
clear bb;
end
MMean_CeL_Hab_CS_off_Cells(j,1) = mean(Mean_CeL_Hab_CS_off_Cells(j,:));
MStd_CeL_Hab_CS_off_Cells(j,1) = mean(Std_CeL_Hab_CS_off_Cells(j,:));

MMean_CeL_Hab_CS_on_Cells(j,1) = mean(Mean_CeL_Hab_CS_on_Cells(j,:));
MStd_CeL_Hab_CS_on_Cells(j,1) = mean(Std_CeL_Hab_CS_on_Cells(j,:));
end


for j=1:260
for i = 1:Con_Trial
aa = [CeM_Con_CS_off_Cells{i,1}(j,1), CeM_Con_CS_off_Cells{i,2}(j,1), CeM_Con_CS_off_Cells{i,3}(j,1), CeM_Con_CS_off_Cells{i,4}(j,1), CeM_Con_CS_off_Cells{i,5}(j,1), CeM_Con_CS_off_Cells{i,6}(j,1), CeM_Con_CS_off_Cells{i,7}(j,1), CeM_Con_CS_off_Cells{i,8}(j,1)];  
Mean_CeM_Con_CS_off_Cells(j,i) = mean(aa);
Std_CeM_Con_CS_off_Cells(j,i) = std(aa);  
clear aa;    
bb = [CeM_Con_CS_on_Cells{i,1}(j,1), CeM_Con_CS_on_Cells{i,2}(j,1), CeM_Con_CS_on_Cells{i,3}(j,1), CeM_Con_CS_on_Cells{i,4}(j,1)];
Mean_CeM_Con_CS_on_Cells(j,i) = mean(bb);
Std_CeM_Con_CS_on_Cells(j,i) = std(bb);
clear bb;
end
MMean_CeM_Con_CS_off_Cells(j,1) = mean(Mean_CeM_Con_CS_off_Cells(j,:));
MStd_CeM_Con_CS_off_Cells(j,1) = mean(Std_CeM_Con_CS_off_Cells(j,:));

MMean_CeM_Con_CS_on_Cells(j,1) = mean(Mean_CeM_Con_CS_on_Cells(j,:));
MStd_CeM_Con_CS_on_Cells(j,1) = mean(Std_CeM_Con_CS_on_Cells(j,:));
end


for j=1:240
for i = 1:Con_Trial
aa = [CeL_Con_CS_off_Cells{i,1}(j,1), CeL_Con_CS_off_Cells{i,2}(j,1), CeL_Con_CS_off_Cells{i,3}(j,1), CeL_Con_CS_off_Cells{i,4}(j,1), CeL_Con_CS_off_Cells{i,5}(j,1), CeL_Con_CS_off_Cells{i,6}(j,1), CeL_Con_CS_off_Cells{i,7}(j,1), CeL_Con_CS_off_Cells{i,8}(j,1)];   
Mean_CeL_Con_CS_off_Cells(j,i) = mean(aa);
Std_CeL_Con_CS_off_Cells(j,i) = std(aa);
clear aa;
bb = [CeL_Con_CS_on_Cells{i,1}(j,1), CeL_Con_CS_on_Cells{i,2}(j,1), CeL_Con_CS_on_Cells{i,3}(j,1), CeL_Con_CS_on_Cells{i,4}(j,1)];
Mean_CeL_Con_CS_on_Cells(j,i) = mean(bb);
Std_CeL_Con_CS_on_Cells(j,i) = std(bb);
clear bb;
end
MMean_CeL_Con_CS_off_Cells(j,1) = mean(Mean_CeL_Con_CS_off_Cells(j,:));
MStd_CeL_Con_CS_off_Cells(j,1) = mean(Std_CeL_Con_CS_off_Cells(j,:));

MMean_CeL_Con_CS_on_Cells(j,1) = mean(Mean_CeL_Con_CS_on_Cells(j,:));
MStd_CeL_Con_CS_on_Cells(j,1) = mean(Std_CeL_Con_CS_on_Cells(j,:));
end

for j=1:260
for i = 1:Ext_Trial-15  % Early Extinction
aa = [CeM_Ext_CS_off_Cells{i,1}(j,1), CeM_Ext_CS_off_Cells{i,2}(j,1), CeM_Ext_CS_off_Cells{i,3}(j,1), CeM_Ext_CS_off_Cells{i,4}(j,1), CeM_Ext_CS_off_Cells{i,5}(j,1), CeM_Ext_CS_off_Cells{i,6}(j,1), CeM_Ext_CS_off_Cells{i,7}(j,1), CeM_Ext_CS_off_Cells{i,8}(j,1)];  
Mean_CeM_Ext_CS_off_Cells(j,i) = mean(aa);
Std_CeM_Ext_CS_off_Cells(j,i) = std(aa);  
clear aa;    
end
MMean_CeM_Ext_CS_off_Cells(j,1) = mean(Mean_CeM_Ext_CS_off_Cells(j,:));
MStd_CeM_Ext_CS_off_Cells(j,1) = mean(Std_CeM_Ext_CS_off_Cells(j,:));
end


for j=1:240
for i = 1:Ext_Trial-15 % Early Extinction
aa = [CeL_Ext_CS_off_Cells{i,1}(j,1), CeL_Ext_CS_off_Cells{i,2}(j,1), CeL_Ext_CS_off_Cells{i,3}(j,1), CeL_Ext_CS_off_Cells{i,4}(j,1), CeL_Ext_CS_off_Cells{i,5}(j,1), CeL_Ext_CS_off_Cells{i,6}(j,1), CeL_Ext_CS_off_Cells{i,7}(j,1), CeL_Ext_CS_off_Cells{i,8}(j,1)];   
Mean_CeL_Ext_CS_off_Cells(j,i) = mean(aa);
Std_CeL_Ext_CS_off_Cells(j,i) = std(aa);
clear aa;
end
MMean_CeL_Ext_CS_off_Cells(j,1) = mean(Mean_CeL_Ext_CS_off_Cells(j,:));
MStd_CeL_Ext_CS_off_Cells(j,1) = mean(Std_CeL_Ext_CS_off_Cells(j,:));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Now we perform the general calculation for zscore: 
%%%% zscore = (# spikes CS_on_or_off - MMean spikes CS_off) / MStd CS_off %%%%%%%%
%%%% zscore is the number of std away from spontaneous activity (CS off)
%%%% zscores are calculated for individual cells and stored in
%%%% ZScore_CeX_YY_CS_ZZ_Cells, a 5 x 4 cell.
%%%% Where X = M or L, YY = Hab, Cond, Ext, ZZ = on or off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:Hab_Trial
    for j=1:260
	for l = 1:4
ZScore_CeM_Hab_CS_on_Cells{i,l}(j,1) = (CeM_Hab_CS_on_Cells{i,l}(j,1)- MMean_CeM_Hab_CS_off_Cells(j,1))/MStd_CeM_Hab_CS_off_Cells(j,1);
ZScore_CeM_Hab_CS_off_Cells{i,l}(j,1) = (CeM_Hab_CS_off_Cells{i,l}(j,1)- MMean_CeM_Hab_CS_off_Cells(j,1))/MStd_CeM_Hab_CS_off_Cells(j,1);
    end
	end
     for j=1:240
	 	for l = 1:4
ZScore_CeL_Hab_CS_on_Cells{i,l}(j,1) = (CeL_Hab_CS_on_Cells{i,l}(j,1)- MMean_CeL_Hab_CS_off_Cells(j,1))/MStd_CeL_Hab_CS_off_Cells(j,1);
ZScore_CeL_Hab_CS_off_Cells{i,l}(j,1) = (CeL_Hab_CS_off_Cells{i,l}(j,1)- MMean_CeL_Hab_CS_off_Cells(j,1))/MStd_CeL_Hab_CS_off_Cells(j,1);
    end
	end
end


for i=1:Con_Trial
    for j=1:260
		for l = 1:4
ZScore_CeM_Con_CS_on_Cells{i,l}(j,1) = (CeM_Con_CS_on_Cells{i,l}(j,1)- MMean_CeM_Con_CS_off_Cells(j,1))/MStd_CeM_Con_CS_off_Cells(j,1);
ZScore_CeM_Con_CS_off_Cells{i,l}(j,1) = (CeM_Con_CS_off_Cells{i,l}(j,1)- MMean_CeM_Con_CS_off_Cells(j,1))/MStd_CeM_Con_CS_off_Cells(j,1);
    end
	end
     for j=1:240
	 	for l = 1:4
ZScore_CeL_Con_CS_on_Cells{i,l}(j,1) = (CeL_Con_CS_on_Cells{i,l}(j,1)- MMean_CeL_Con_CS_off_Cells(j,1))/MStd_CeL_Con_CS_off_Cells(j,1);
ZScore_CeL_Con_CS_off_Cells{i,l}(j,1) = (CeL_Con_CS_off_Cells{i,l}(j,1)- MMean_CeL_Con_CS_off_Cells(j,1))/MStd_CeL_Con_CS_off_Cells(j,1);
    end
	end
end

for i=1:Ext_Trial-15 % Early Extinction
    for j=1:260
		for l = 1:4
ZScore_CeM_Ext_CS_on_Cells{i,l}(j,1) = (CeM_Ext_CS_on_Cells{i,l}(j,1)- MMean_CeM_Ext_CS_off_Cells(j,1))/MStd_CeM_Ext_CS_off_Cells(j,1);
ZScore_CeM_Ext_CS_off_Cells{i,l}(j,1) = (CeM_Ext_CS_off_Cells{i,l}(j,1)- MMean_CeM_Ext_CS_off_Cells(j,1))/MStd_CeM_Ext_CS_off_Cells(j,1);
    end
	end
     for j=1:240
	 	for l = 1:4
ZScore_CeL_Ext_CS_on_Cells{i,l}(j,1) = (CeL_Ext_CS_on_Cells{i,l}(j,1)- MMean_CeL_Ext_CS_off_Cells(j,1))/MStd_CeL_Ext_CS_off_Cells(j,1);
ZScore_CeL_Ext_CS_off_Cells{i,l}(j,1) = (CeL_Ext_CS_off_Cells{i,l}(j,1)- MMean_CeL_Ext_CS_off_Cells(j,1))/MStd_CeL_Ext_CS_off_Cells(j,1);
    end
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% End of zscore calculations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% Now we wish to identify CS_On and CS_off cells %%%%%%%%%%%%%%%%%%%%%%%

%%%% If zscore is above 1.96, store cell ID in CeL_On
%%%% If zscore is below -1.96, store cell ID in CeL_Off
count = 1;
count1 = 1;
CeL_Off = [];
CeL_On = [];
%%%% Here we look at the zscores of the 4th and 5th trials of conditioning

for j=1:240
bb = [ZScore_CeL_Con_CS_on_Cells{4,1}(j,1),ZScore_CeL_Con_CS_on_Cells{4,2}(j,1),ZScore_CeL_Con_CS_on_Cells{4,3}(j,1),ZScore_CeL_Con_CS_on_Cells{4,4}(j,1),ZScore_CeL_Con_CS_on_Cells{5,1}(j,1),ZScore_CeL_Con_CS_on_Cells{5,2}(j,1),ZScore_CeL_Con_CS_on_Cells{5,3}(j,1),ZScore_CeL_Con_CS_on_Cells{5,4}(j,1)];
Z_means(j,1) = mean(bb);
if(mean(bb)>=1.96)
    CeL_On(count,1) = j+260;
    count = count+1;
end
if(mean(bb)<=-1.96)
    CeL_Off(count1,1) = j+260;
    count1 = count1+1;
end
clear bb;
end

%%%% Here only bin 1 of trials 4 and 5 are considered -- why?
%%%% Because activity dies off quickly during habituation
count3 =1;
count4 = 1;
for j=1:240
bb = [ZScore_CeL_Hab_CS_on_Cells{4,1}(j,1),ZScore_CeL_Hab_CS_on_Cells{5,1}(j,1)];
if(mean(bb)>=1.96)
    Hab_CeL_On(count3,1) = j+260;
    count3 = count3+1;
end
if(mean(bb)<=-1.96)
    Hab_CeL_Off(count4,1) = j+260;
    count4 = count4+1;
end
clear bb;
end

count5 = 1;
count6 = 1;
for j=1:260
bb = [ZScore_CeM_Hab_CS_on_Cells{4,1}(j,1),ZScore_CeM_Hab_CS_on_Cells{5,1}(j,1)];
if(mean(bb)>=1.96)
    Hab_CeM_Inc(count5,1) = j;
    count5 = count5+1;
end
if(mean(bb)<=-1.96)
    Hab_CeM_Dec(count6,1) = j;
    count6 = count6+1;
end
clear bb;
end

CeM_Inc = [];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Show spontaneous firing rates %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mean_Spont_CeM=mean(Spontaneous_CeM)
std_Spont_CeM=mean(Standard_Devi_CeM)

mean_Spont_CeLPKCdm=mean(Spontenous_CeL_PKCDm)
std_Spont_CeLPKCdm=mean(Standard_Devi_CeL_PKCDm)

mean_Spont_CeLPKCdp=mean(Spontenous_CeL_PKCDp)
std_Spont_CeLPKCdp=mean(Standard_Devi_CeL_PKCDp)

mean_CeL = mean(Spontenous_CeL)
std_CeL=mean(Standard_Devi_CeL)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Analyzing individuals %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter1=1;counter2=1;counter3=1;counter4=1;counter5=1;
for i=1:240
    if Z_means(i,1)>=2
        HIGH(counter1,1)=i+260;
        counter1=counter1+1;
    end
    if Z_means(i,1)>=1.5 && Z_means(i,1)<2
        HIGHMED(counter2,1)=i+260;
        counter2=counter2+1;
    end
    if Z_means(i,1)>=-1.5 && Z_means(i,1)<1.5
        MED(counter3,1)=i+260;
        counter3=counter3+1;
    end
    if Z_means(i,1)<-1.5 && Z_means(i,1)>-2
        LOWMED(counter4,1)=i+260;
        counter4=counter4+1;
    end
    if Z_means(i,1)<=-2
        LOW(counter5,1)=i+260;
        counter5=counter5+1;
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Plot individual weights over time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LAtoDPweight=2.5;
% LAtoDMweight=2.5;
% InputWeights={};
% InFolder = 'InputWeights_5_30_R2';
% Files = dir('InputWeights_5_30_R2/*_to_*_Wt_Inp');
% formout='InputWeights_5_30_R2/%d_to_%d_Wt_Inp';
% load 'InputWeights_5_30_R2/allfinalwgtInp.dat';
% 
% counter=1;
% counter2=1;
% for j=1:length(Files)
% str=Files(j).name;
% loc=sprintf('InputWeights_5_30_R2/%s',str);
%     for i=261:380
%         cell=num2str(i);
%         if(~isempty(strfind(loc,cell)))
%             InputWeights{1,counter}=dlmread(loc);
%             counter=counter+1;
%         end
%     end
%     for i=381:500
%         cell=num2str(i);
%         if(~isempty(strfind(loc,cell)))
%             InputWeights{2,counter2}=dlmread(loc);
%             counter2=counter2+1;
%         end
%     end
% end



% %%%% M is PKCDP, M2 is PKCDM
% M=[InputWeights{2,:}];
% M2=[InputWeights{1,:}];
% 
% counter=1;
% counter2=1;
% 
% 
% for i=1:size(M,2)
%     if(M(size(M,1),i)-M(1,i)<0)
%         PKCDP_Shrank(:,counter)=M(:,i);
%         counter=counter+1;
%     end
%     if(M(size(M,1),i)-M(1,i)>0)
%         PKCDP_Grew(:,counter2)=M(:,i);
%         counter2=counter2+1;
%     end
% end
% 
% counter=1;
% counter2=1;
% for i=1:size(M2,2)
%     if(M2(size(M2,1),i)-M2(1,i)<0)
%         PKCDM_Shrank(:,counter)=M2(:,i);
%         counter=counter+1;
%     end
%     if(M2(size(M2,1),i)-M2(1,i)>0)
%         PKCDM_Grew(:,counter2)=M2(:,i);
%         counter2=counter2+1;
%     end
% end
% 
% avg_DPshrinkers=mean(PKCDP_Shrank,2);
% avg_DPgrowers=mean(PKCDP_Grew,2);
% avg_DMshrinkers=mean(PKCDM_Shrank,2);
% avg_DMgrowers=mean(PKCDM_Grew,2);
% 
% 
% avg_over_time_PKCDP=mean(M,2);
% avg_over_time_PKCDM=mean(M2,2);
% 
% x_axis=[0:1:length(avg_over_time_PKCDP)-1]';
% figure(1);
% plot(x_axis,avg_over_time_PKCDP(:,1),'k');
% hold on;
% plot(x_axis,avg_DPshrinkers(:,1),'r');
% hold on;
% plot(x_axis,avg_DPgrowers(:,1),'b');
% legend('average','depressed cells','potentiated cells');
% title('avg weights of LA to PKCDP over time');
% ylim([2.45 4]);
% 
% figure(2);
% plot(x_axis,avg_over_time_PKCDM(:,1),'k');
% hold on;
% plot(x_axis,avg_DMshrinkers(:,1),'r');
% hold on;
% plot(x_axis,avg_DMgrowers(:,1),'b');
% legend('average','depressed cells','potentiated cells');
% title('avg weights of LA to PKCDM over time');
% ylim([2.45 4]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Would be interesting to plot the input weights before and after %%%%%%
%%%% conditioning. We are looking for PKCdP weights to shrink and    
%%%% PKCdM weights to grow. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter=1;
counter2=1;
counter3=1;
counter4=1;
for i=1:length(allfinalwgtInp)
    if (allfinalwgtInp(i,1)>0 && allfinalwgtInp(i,1)<=40) && (allfinalwgtInp(i,2)>=261 && allfinalwgtInp(i,2)<=380)
        LA2CeLPKCDm(counter,1:4)=allfinalwgtInp(i,1:4);
        counter=counter+1;
    end
    if (allfinalwgtInp(i,1)>80 && allfinalwgtInp(i,1)<=100) && (allfinalwgtInp(i,2)>=261 && allfinalwgtInp(i,2)<=380)
        LA2CeLPKCDm(counter,1:4)=allfinalwgtInp(i,1:4);
        counter=counter+1;
    end
    if (allfinalwgtInp(i,1)>0 && allfinalwgtInp(i,1)<=40) && (allfinalwgtInp(i,2)>=381 && allfinalwgtInp(i,2)<=500)
        LA2CeLPKCDp(counter2,1:4)=allfinalwgtInp(i,1:4);
        counter2=counter2+1;
    end
    if (allfinalwgtInp(i,1)>80 && allfinalwgtInp(i,1)<=100) && (allfinalwgtInp(i,2)>=381 && allfinalwgtInp(i,2)<=500)
        LA2CeLPKCDp(counter2,1:4)=allfinalwgtInp(i,1:4);
        counter2=counter2+1;
    end
    if (allfinalwgtInp(i,1)>40 && allfinalwgtInp(i,1)<=80) && (allfinalwgtInp(i,2)>=261 && allfinalwgtInp(i,2)<=380)
        BA2CeLPKCDm(counter3,1:4)=allfinalwgtInp(i,1:4);
        counter3=counter3+1;
    end
    %%%% ADD BAnor
    if (allfinalwgtInp(i,1)>40 && allfinalwgtInp(i,1)<=80) && (allfinalwgtInp(i,2)>=381 && allfinalwgtInp(i,2)<=500)
        BA2CeLPKCDp(counter4,1:4)=allfinalwgtInp(i,1:4);
        counter4=counter4+1;
    end
end

PlotWeights(3,LA2CeLPKCDm, LA2CeLPKCDp, BA2CeLPKCDm)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% REGRESSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Inputs_Ce is our matrix for regression. It contains 10 columns of
%%%% inputs: laf, laer, lanor, baf, baer, banor, itc, shock, other CeL, and
%%%% its own CeL nucleus.
%%%% Column 11 is the average spiking rate during habituation when CS is
%%%% off. Column 12 is the average spiking rate during habituation when CS
%%%% is on.

%%%% Here we find the cell IDs of the internal connections.
% for i=1:500
%     T1=find(Data_InternalSynConns(:,i)==21)';
%     T2=find(Data_InternalSynConns(:,i)==22)';
%     T3=find(Data_InternalSynConns(:,i)==33)';
%     T4=find(Data_InternalSynConns(:,i)==34)';
%     T5=[T1,T2,T3,T4];
%     for j=1:length(T5)
%         INT_Conns(i,j)=T5(1,j);
%     end
%     clear T3;clear T2;clear T1;clear T4;clear T5;
%     clear cellT;
% end

%  for i=1:length(find(CeL_Off)~=0)
%     cellT=CeL_Off(i,1);
%     T=find(Data_InternalSynConns(:,cellT)~=0)';
%     for j=1:length(T)
%         INT_Conns2(i,j)=T(1,j);
%     end
%     clear T;
%     clear cellT;
%  end   

 
 %%%% Inputs_Ce(9:13) gives the number of High, HighMed, Med, LowMed, and
 %%%% Low intrinsic inputs
Spon_freq_cells=[Spon_freq_CeM_cells; Spon_freq_CeL_cells];
 
Inputs_Ce = Input_Connections(Data_InputSynConns, 65,15,40);
Intrinsic_Ce = Intrinsic_Connections(Data_InternalSynConns,Spon_freq_cells,65,15,40,HIGH,HIGHMED,MED,LOWMED,LOW);

%%%% Then we add four other columns showing the spiking rate during
%%%% habituation and conditioning with CS on/off.
% Inputs_Ce(1:260,15)=MMean_CeM_Hab_CS_off_Cells(:,1)/5;
% Inputs_Ce(261:500,15)=MMean_CeL_Hab_CS_off_Cells(:,1)/5;
% Inputs_Ce(1:260,16)=MMean_CeM_Hab_CS_on_Cells(:,1)/5;
% Inputs_Ce(261:500,16)=MMean_CeL_Hab_CS_on_Cells(:,1)/5;
% 
% Inputs_Ce(1:260,17)=MMean_CeM_Con_CS_off_Cells(:,1)/5;
% Inputs_Ce(261:500,17)=MMean_CeL_Con_CS_off_Cells(:,1)/5;
% Inputs_Ce(1:260,18)=MMean_CeM_Con_CS_on_Cells(:,1)/5;
% Inputs_Ce(261:500,18)=MMean_CeL_Con_CS_on_Cells(:,1)/5;

%%%%Columns 9 & 10 have the number of intrinsic inputs but we also want 5
%%%%new columns with number of HIGH, HIGHMED, MED, MEDLOW, and LOW cells 



% X = [ones(240,1),Inputs_Ce(261:500,1:7)];
% Y = [Inputs_Ce(261:500,15)]; %% Y is the spiking rate during habituation CS OFF
% 
% 
% 
% [B2,B2INT, R, RINT, STATS]=regress(Y,X);
% 
% Inputs_CeL=Inputs_Ce(261:500,:);
% 
% for i=1:240
%     scat(i,1) = Inputs_Ce(260+i,1)+Inputs_Ce(260+i,2)+Inputs_Ce(260+i,4)+Inputs_Ce(260+i,5);
%     scat(i,2) = Inputs_Ce(260+i,7);
%     scat(i,3) = Inputs_Ce(260+i,15);
% end
% 
% figure
% for i=1:length(scat)
%     if(scat(i,3)>=2.5)
%         scatter3(scat(i,1),scat(i,2),scat(i,3),'red','filled')
%         hold on;
%     end
%     if(scat(i,3)<2.5)
%         scatter3(scat(i,1),scat(i,2),scat(i,3),'blue','filled')
%         hold on;
%     end
% end
% xlabel('excitation')
% ylabel('inhibition')
% zlabel('spiking rate')

% figure(4);
% lab={'laf','laer','lanor','baf','baer','banor','ITC','SHOCK','other CeL','self'};
% 
% for i=1:10
%     m = sortrows(Inputs_CeL,i);
%     for j=0:max(m(:,i))
%         bb = find(m(:,i)==j);
%         %%%% Plot for CON CS OFF
%         av(1,j+1) = mean(m(bb(1,1):bb(length(bb),1),17));
%         %%%% Plot for CON CS ON
%         av2(1,j+1) = mean(m(bb(1,1):bb(length(bb),1),18));
%     end
%     
%     x1=[0:1:length(av)-1];
%     x2=[0:1:length(av2)-1];
%     
%     subplot(4,3,i);
%     plot(x1,av,'b.');
%     hold on
%     plot(x2,av2,'r.');
%     
%     title(lab{i});
%     xlabel('num connections');
%     ylabel('firing freq (Hz)');
%     legend('CON CS-OFF','CON CS-ON')
%     clear av;
%     clear y;
%     %hold on;
%     %plot(Inputs_CeL(:,i),Inputs_CeL(:,12),'b.');
% end


%%%% Want to look at influence of cells on on/off
%OnOff=xlsread('OnOff.xlsx');
%Con_CeL_On=OnOff(:,1);
%Con_CeL_Off=OnOff(:,2);
Con_CeL_On=[];
Con_CeL_Off=[];
Con_CeL_On(:,1) = CeL_On;
Con_CeL_Off(:,1) = CeL_Off;
for i=1:length(CeL_On)
    for j=1:7
        Con_CeL_On(i,1+j)=Inputs_Ce{CeL_On(i,1)+1,2+j};
    end
end
for i=1:length(CeL_Off)
    for j=1:7
        Con_CeL_Off(i,1+j)=Inputs_Ce{CeL_Off(i,1)+1,2+j};
    end
end
  
% ON_grew = zeros(length(Con_CeL_On),6);
% ON_grew_av = zeros(length(Con_CeL_On),1);
% for i=1:length(Con_CeL_On)
%     M=find(allfinalwgtInp(:,2)==Con_CeL_On(i,1));
%     counter=1;
%     for j=1:length(M)
%         if allfinalwgtInp(M(j,1),4) > allfinalwgtInp(M(j,1),3)
%             ON_grew(i,counter)=allfinalwgtInp(M(j,1),4)-allfinalwgtInp(M(j,1),3);
%             counter = counter+1;
%         end
%     end
%     ON_grew(i,counter)=0;
%     ON_grew_av(i,1) = mean(ON_grew(i,:));
% end
% 
% OFF_grew = zeros(length(Con_CeL_Off),6);
% OFF_grew_av = zeros(length(Con_CeL_Off),1);
% 
% for i=1:length(Con_CeL_Off)
%     M=find(allfinalwgtInp(:,2)==Con_CeL_Off(i,1));
%     counter=1;
%     for j=1:length(M)
%         if allfinalwgtInp(M(j,1),4) > allfinalwgtInp(M(j,1),3)
%             OFF_grew(i,counter)=allfinalwgtInp(M(j,1),4)-allfinalwgtInp(M(j,1),3);
%             counter = counter+1;
%         end
%     end
%     OFF_grew(i,counter)=0;
%     OFF_grew_av(i,1) = mean(OFF_grew(i,:));
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Recreating Duvarci 2011 Figures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear bb;
% for i=1:size(ZScore_CeL_Hab_CS_off_Cells,2)
%     for j=1:size(ZScore_CeL_Hab_CS_off_Cells,1)
%         bb(j,i) = mean(ZScore_CeL_Hab_CS_off_Cells{j,i}(:,1));
%         bb2(j,i) = mean(ZScore_CeL_Hab_CS_on_Cells{j,i}(:,1));
%         bb3(j,i) = mean(ZScore_CeL_Con_CS_off_Cells{j,i}(:,1));
%         bb4(j,i) = mean(ZScore_CeL_Con_CS_on_Cells{j,i}(:,1));
%     end
% end
% 
% for i=1:size(bb,2)
%     dvCeL_Hab(1,i)=mean(bb(:,i));
%     dvCeL_Con(1,i)=mean(bb3(4:5,i));
%     dvCeL_Hab(1,i+4)=mean(bb2(:,i));
%     dvCeL_Con(1,i+4)=mean(bb4(4:5,i));
%     
% end
% clear bb bb2 bb3 bb4;
% 
% for i=1:size(ZScore_CeM_Hab_CS_off_Cells,2)
%     for j=1:size(ZScore_CeM_Hab_CS_off_Cells,1)
%         bb(j,i) = mean(ZScore_CeM_Hab_CS_off_Cells{j,i}(:,1));
%         bb2(j,i) = mean(ZScore_CeM_Hab_CS_on_Cells{j,i}(:,1));
%         bb3(j,i) = mean(ZScore_CeM_Con_CS_off_Cells{j,i}(:,1));
%         bb4(j,i) = mean(ZScore_CeM_Con_CS_on_Cells{j,i}(:,1));
%     end
% end
% 
% for i=1:size(bb,2)
%     dvCeM_Hab(1,i)=mean(bb(:,i));
%     dvCeM_Con(1,i)=mean(bb3(4:5,i));
%     dvCeM_Hab(1,i+4)=mean(bb2(:,i));
%     dvCeM_Con(1,i+4)=mean(bb4(4:5,i));
%     
% end
% 
% figure
% 
% plot([1:1:8],dvCeL_Hab,'k')
% ylim([-1 1]);
% hold on;
% plot([1:1:8],dvCeL_Con,'r')
% 
% figure
% 
% plot([1:1:8],dvCeM_Hab,'k')
% ylim([-1 1]);
% hold on;
% plot([1:1:8],dvCeM_Con,'r')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Plot individual capool over time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% InputCa={};
% 
% Files = dir('Ca_Inp/*_to_*_Ca_Inp');
% formout='Ca_Inp/%d_to_%d_Ca_Inp';
% 
% counter=1;
% counter2=1;
% for j=1:length(Files)
% str=Files(j).name;
% loc=sprintf('Ca_Inp/%s',str);
%    for i=261:380
%        cell=num2str(i);
%        if(~isempty(strfind(loc,cell)))
%            InputCa{1,counter}=dlmread(loc);
%            counter=counter+1;
%        end
%    end
%    for i=381:500
%        cell=num2str(i);
%         if(~isempty(strfind(loc,cell)))
%            InputCa{2,counter2}=dlmread(loc);
%            counter2=counter2+1;
%        end
%    end
% end
% 
% 
% 
% M=[InputCa{2,:}];
% M2=[InputCa{1,:}];
% 
% Ca_avg_over_time_PKCDP=mean(M,2);
% Ca_avg_over_time_PKCDM=mean(M2,2);
% 
% x_axis=[0:1:length(Ca_avg_over_time_PKCDP)-1]';
% figure(4);
% plot(x_axis,Ca_avg_over_time_PKCDP(:,1),'b');
% title('avg Ca conc. of LA to PKCDP over time');
% figure(5);
% plot(x_axis,Ca_avg_over_time_PKCDM(:,1),'b');
% title('avg Ca conc. of LA to PKCDM over time');
