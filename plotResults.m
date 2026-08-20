clear;

load('topo_NL_WGS84.mat')

% Load in the data structure: S.
disp('Loading results file')
load('TLEnl_temp.mat');
% load('Result_files/TLP_Results_ProdFields_1000it.mat');
% load('Result_files/TLP_Results_ProsFields_1000it.mat');
% load('Result_files/TLP_Results_GT_1000it.mat');
load('Result_files/TLP_Results_STFields_1000it.mat');

% Displaying depth map (Figures S1-S4)
disp('Displaying depth map')
n=1;
Figures.mapDepth(S,n,topo_wgs)

% Displaying prior parameter distributions (Figure 2)
disp('Displaying prior parameter distributions')
n=2;
Figures.plotDist(S,n)

% Load output files containing maps
load('Result_files/TLEnl_Results_ProdFields_map.mat','M')
MPF.lon = M.D.D1.lon; MPF.lat = M.D.D1.lat;
MPF.D1 = M.D.D1.Mr; MPF.D2 = M.D.D2.Mr; MPF.R = M.R.R1.Mr;
clear M
load('Result_files/TLEnl_Results_ProsFields_map.mat','M')
MPR.lon = M.D.D1.lon; MPR.lat = M.D.D1.lat;
MPR.D1 = M.D.D1.Mr; MPR.D2 = M.D.D2.Mr; MPR.R = M.R.R1.Mr;
clear M
load('Result_files/TLP_Results_GT_1000it_map.mat','M')
MGT.lon = M.D.D1.lon; MGT.lat = M.D.D1.lat;
MGT.D1 = M.D.D1.Mr; MGT.D2 = M.D.D2.Mr; MGT.R = M.R.R1.Mr;
clear M
load('Result_files/TLP_Results_STfields_1000it_map.mat','M')
MSF.lon = M.D.D1.lon; MSF.lat = M.D.D1.lat;
MSF.D1 = M.D.D1.Mr; MSF.D2 = M.D.D2.Mr; MSF.R = M.R.R1.Mr;
clear M

% Displaying Mtol maps (Figures 3-5):
n=3;
Figures.mapMTOL(MPF,MPR,MGT,MSF,n,topo_wgs,'DS1','paper')
n=4;
Figures.mapMTOL(MPF,MPR,MGT,MSF,n,topo_wgs,'DS2','paper')
n=5;
Figures.mapMTOL(MPF,MPR,MGT,MSF,n,topo_wgs,'FC','paper')

% Figure 6 & S7: Mtol (individual risk metric) versus depth and hypocentral
% distance
clear
load('Result_files/TLP_Results_ProdFields_1000it.mat');
[R_PF] = Figures.dis2pop(S);
SPF = S.SUM; clear S
load('Result_files/TLP_Results_ProsFields_1000it.mat');
[R_PR] = Figures.dis2pop(S);
SPR = S.SUM; clear S
load('Result_files/TLP_Results_GT_1000it.mat');
[R_GT] = Figures.dis2pop(S);
SGT = S.SUM; clear S
load('Result_files/TLP_Results_STFields_1000it.mat');
[R_SF] = Figures.dis2pop(S);
SSF = S.SUM; clear S

n=6;
Figures.depthvsMtol(SPF,R_PF,SPR,R_PR,SGT,R_GT,SSF,R_SF,n)

% Figure 7: Individual risk derived Mtol versus aggregate based Mtol
load('Result_files/TLP_Results_ProdFields_Agg_1000it.mat');
ASPF = S.SUM; clear S
load('Result_files/TLP_Results_ProsFields_Agg_1000it.mat');
ASPR = S.SUM; clear S
load('Result_files/TLP_Results_GT_Agg_1000it.mat');
ASGT = S.SUM; clear S
load('Result_files/TLP_Results_STFields_Agg_1000it.mat');
ASSF = S.SUM; clear S

n=7;
Figures.IMvsAM(SPF,R_PF,SPR,R_PR,SGT,R_GT,SSF,R_SF,...
    ASPF,ASPR,ASGT,ASSF,n)

% Figure 8 + S8: DS1 damage estimates earthquake scenarios
clear
load('Result_files/Scenarios.mat')
load('Result_files/TLP_Results_STFields_1000it.mat');
n=8;
Figures.plotScenarios(R,S,n)

% Figure S6: Population density with field/license outlines
clear
load('topo_NL_WGS84.mat')
load('Result_files/TLP_Results_SelFields_1000it.mat')
S1 = S; clear S
load('Result_files/TLP_Results_SelGT_1000it.mat')
S2 = S; clear S 
load('blanks/TLP_nl-highres.mat')

n=61;
Figures.mapPop(S,S1,S2,n,topo_wgs)

% Figure S9: iso-Risk combination map
clear
load('topo_NL_WGS84.mat')
load('Result_files/TLP_Results_ProdFields_1000it.mat');
SPF = S; clear S
load('Result_files/TLP_Results_ProsFields_1000it.mat');
SPR = S; clear S
load('Result_files/TLP_Results_GT_1000it.mat');
SGT = S; clear S
load('Result_files/TLP_Results_STFields_1000it.mat');
SSF = S; clear S
load('Result_files/TLP_Results_ProdFields_Agg_1000it.mat');
ASPF = S.SUM; clear S
load('Result_files/TLP_Results_ProsFields_Agg_1000it.mat');
ASPR = S.SUM; clear S
load('Result_files/TLP_Results_GT_Agg_1000it.mat');
ASGT = S.SUM; clear S
load('Result_files/TLP_Results_STFields_Agg_1000it.mat');
ASSF = S.SUM; clear S

n=91;
Figures.mapISORiskComb(SPF,SPR,SGT,SSF,ASPF,ASPR,ASGT,ASSF,topo_wgs,n)