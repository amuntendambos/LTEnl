clear;

ERiskFlag = 'equivalent'; % threshold - number of housholds affected for 
                         % specific threshold; equivalent - number of
                         % housholds affected at red-light threshold (DS2)
RMetric = 'DS1'; % Risk metric to use: CDI3, DS1, DS2, Pf
% Load reference magnitude and prepare for use
disp('Get reference magnitudes')
load('TLEnl_temp.mat','S'); % Reference risk output

for j=1:length(S.RISK)     
    latT(j) = S.RISK(j).lat;
    lonT(j) = S.RISK(j).lon;
end
ML_f=zeros(length(latT),4);
for kk=1:max(S.MAP.Bid)
    inb = inpolygon(lonT,latT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
    if(strcmpi(ERiskFlag,'threshold'))
        ML_f(inb==1,1) = S.SUM(kk).M_Nn3;
        ML_f(inb==1,2) = S.SUM(kk).M_d1;
        ML_f(inb==1,3) = S.SUM(kk).M_d2;
        ML_f(inb==1,4) = S.SUM(kk).M_Pf;
    elseif(strcmpi(ERiskFlag,'equivalent'))
        if(strcmpi(RMetric,'CDI3'))
            ML_f(inb==1,:) = S.SUM(kk).M_Nn3;
        elseif(strcmpi(RMetric,'DS1'))
            ML_f(inb==1,:) = S.SUM(kk).M_d1;
        elseif(strcmpi(RMetric,'DS2'))
            ML_f(inb==1,:) = S.SUM(kk).M_d2;
        elseif(strcmpi(RMetric,'Pf'))
            ML_f(inb==1,:) = S.SUM(kk).M_Pf;
        end
    end
end
          
clear S inb j kk

% Load in the impacted household data structure: S.
disp('Loading structure')
load('TLEnl_temp_agg.mat','S'); % Aggregate risk output

% Predefine some variables.
%ML_f=3.0;
Pd=50;
Pn=50;
Pr=50;
Ni=4; % Set to 1 for highres solution! For combination set to 3/4; For lowres file 12

% Get the play-specific thresholds to use.
if(strcmpi(S.play_flag,'NL'))
    Nn2_f=0.5;
    Nn3_f=0.1;
    Nn4_f=0.05;
    Nd1_f=0.01;
    Nd2_f=0.01;
    Pf1_f=1e-5;
end

% Make iso-nuisance maps.
disp('Nuisance')
Rn3=mapRISKspecial(S,'nuisance',3,1,Nn3_f,ML_f,Pn,Pd,Pr,Ni);

% Make iso-damage maps.
disp('Damage')
Rd1=mapRISKspecial(S,'damage',3,1,Nd1_f,ML_f,Pn,Pd,Pr,Ni);
Rd2=mapRISKspecial(S,'damage',3,2,Nd2_f,ML_f,Pn,Pd,Pr,Ni);

% Make iso-LPR map.
disp('Probability of fatality')
Rr=mapRISKspecial(S,'LPR',3,1,Pf1_f,ML_f,Pr,Pd,Pr,Ni);

% Stuff everything into a structure.
% Nuisance maps.
M.N.T3=Nn3_f; 
M.N.N3=Rn3; 
for kk=1:max(S.MAP.Bid)
    inb = inpolygon(lonT,latT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
    Nn_max(kk) = max(M.N.N3.Nn(inb==1));
end
M.N.N3.Nn_max=Nn_max;
% Damage maps.
M.D.T1=Nd1_f; M.D.T2=Nd2_f;
M.D.D1=Rd1; M.D.D2=Rd2;
for kk=1:max(S.MAP.Bid)
    inb = inpolygon(lonT,latT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
    Nd1_max(kk) = max(M.D.D1.Nn(inb==1));
    Nd2_max(kk) = max(M.D.D2.Nn(inb==1));
end
M.D.D1.Nd_max=Nd1_max;
M.D.D2.Nd_max=Nd2_max;
% LPR maps.
M.R.R1=Rr;
M.R.T1=Pf1_f;
for kk=1:max(S.MAP.Bid)
    inb = inpolygon(lonT,latT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
    NR_max(kk) = max(M.R.R1.Nn(inb==1));
end
M.R.R1.NR_max=NR_max;

% Save the structure.
disp('Saving results')
save('TLPmap_eq.mat','M','-v7.3');





