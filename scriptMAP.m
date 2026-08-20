clear;

% Load in the data structure: S.
disp('Loading results file')
%load('TLEnl_temp.mat','S');
load('Result_files/TLP_Results_STFields_1000it.mat')
S.DNmetric_flag = 'individual';

% Predefine some variables.
Pd=50;
Pn=50;
Pr=50;
Ni=3; % Set to 1 for highres solution! For combination set to 3/4; For lowres file 12
metric='mean'; % Get mean or median risk LTE estimate

% Get the play-specific thresholds to use.
if(strcmpi(S.play_flag,'NL'))
    if(strcmpi(S.DNmetric_flag,'individual'))
        Nn3_f=0.1;
        Nd1_f=0.01;
        Nd2_f=0.01;
        Pf1_f=1e-5;
    elseif(strcmpi(S.DNmetric_flag,'aggregate'))
        Nn3_f=1;
        Nd1_f=1;
        Nd2_f=1;
        Pf1_f=1e-5;
    end
end

% Make iso-nuisance maps.
% Note only CDI3. Other CDI's can be mapped similarly.
disp('Nuisance')
[Rn3,Mn3]=mapRISK(S,'nuisance',3,1,Nn3_f,Pn,Pd,Pr,Ni,metric);
for i=1:length(S.SUM)
    S.SUM(i).M_Nn3 = Mn3(i);
end

% Make iso-damage maps.
disp('Damage')
[Rd1,Md1]=mapRISK(S,'damage',3,1,Nd1_f,Pn,Pd,Pr,Ni,metric);
for i=1:length(S.SUM)
    S.SUM(i).M_d1 = Md1(i);
end
[Rd2,Md2]=mapRISK(S,'damage',3,2,Nd2_f,Pn,Pd,Pr,Ni,metric);
for i=1:length(S.SUM)
    S.SUM(i).M_d2 = Md2(i);
end

% Make iso-LPR map.
disp('Risk')
[Rr,Mpf]=mapRISK(S,'LPR',3,1,Pf1_f,Pr,Pd,Pr,Ni,metric);
for i=1:length(S.SUM)
    S.SUM(i).M_Pf = Mpf(i);
end
  
% Stuff everything into a structure.
% Nuisance maps.
M.N.T3=Nn3_f; 
M.N.N3=Rn3;
% Damage maps.
M.D.T1=Nd1_f; M.D.T2=Nd2_f;
M.D.D1=Rd1; M.D.D2=Rd2;
% LPR maps.
M.R.R1=Rr;
M.R.T1=Pf1_f;

% Save the structure.
disp('Saving output')
save('TLEnl_map.mat','M','-v7.3');
save('TLEnl_temp.mat','S');
