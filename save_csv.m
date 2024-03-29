clear all
clc
close all
%%
load('468_sttc.mat')

for n=1:length(FOV_coeff)
    FirstCell = FOV_coeff(n).first_cell';
    SecndCell = FOV_coeff(n).secnd_cell';
    STTC_plusminus1 = FOV_coeff(n).STTC_plusminus1';
    STTC_plusminus5 = FOV_coeff(n).STTC_plusminus5';
    STTC_plusminus10 = FOV_coeff(n).STTC_plusminus10';
    tab = table(FirstCell,SecndCell,STTC_plusminus1,STTC_plusminus5,STTC_plusminus10);
    writetable(tab, ['/Users/treviyek/Documents/cancer_data/MatlabAlgorithms/468_sttc/',FOV_coeff(n).filename])
    disp(['FOV ',num2str(n)])
end


