clear;

% Predefine a structure.
R=struct('M',[],'lat',[],'lon',[],'dep',[],'dGM',[],'year',[],'Zid',[],'name',[],'Ss',[]);

% Populate the structure with relevant information on each earthquake scenario.
i=1;
R(i).M=3.6; R(i).lat=53.345; R(i).lon=6.672; R(i).dep=3.0; R(i).dGM=+0.85; R(i).year=2012; R(i).Zid=1; R(i).name='Huizinge 2012-08-16'; i=i+1;
%%%
R(i).M=3.4; R(i).lat=52.832; R(i).lon=7.038; R(i).dep=2.0; R(i).dGM=-0.51; R(i).year=1997; R(i).Zid=2; R(i).name='Roswinkel 1997-02-19'; i=i+1;
R(i).M=3.3; R(i).lat=52.833; R(i).lon=7.053; R(i).dep=2.0; R(i).dGM=+0.36; R(i).year=1998; R(i).Zid=2; R(i).name='Roswinkel 1998-07-14'; i=i+1;
R(i).M=3.5; R(i).lat=53.350; R(i).lon=6.697; R(i).dep=3.0; R(i).dGM=-0.59; R(i).year=2006; R(i).Zid=1; R(i).name='Westeremden 2006-08-08'; i=i+1;
%%%
R(i).M=3.1; R(i).lat=53.234; R(i).lon=6.834; R(i).dep=3.0; R(i).dGM=-1.9; R(i).year=2015; R(i).Zid=1; R(i).name='Hellum 2015-09-30'; i=i+1;
R(i).M=3.4; R(i).lat=53.363; R(i).lon=6.751; R(i).dep=3.0; R(i).dGM=0.09; R(i).year=2018; R(i).Zid=1; R(i).name='Zeerijp 2018-01-08'; i=i+1;
R(i).M=3.4; R(i).lat=53.328; R(i).lon=6.652; R(i).dep=3.0; R(i).dGM=-0.95; R(i).year=2019; R(i).Zid=1; R(i).name='Westerwijtwerd 2019-05-22'; i=i+1;
R(i).M=3.4; R(i).lat=53.348; R(i).lon=6.774; R(i).dep=3.0; R(i).dGM=+0.85; R(i).year=2025; R(i).Zid=1; R(i).name='Zeerijp 2025-11-14'; i=i+1;
%
Yls=2018;
Np=1000;
Nn2_f=10.^4.75;
Nn3_f=10.^4.50;
Nn4_f=10.^4.25;
Nd1_f=10.^2.40;
Nd2_f=10.^0.25;
p=10;

% Load in the data structure: S.
load('blanks/TLP_nl.mat');

% Perturb data structure and compute risk curves for a scenario.
for i=1:length(R)
    tic; Ss=runRISKscenario(S,R(i).lat,R(i).lon,R(i).dep,R(i).M,R(i).dGM,Np,R(i).Zid); toc;
    R(i).Ss=Ss;
end

save('TLEnl_Scenarios.mat','R')
