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

% Displaying prior parameter distributions (Figure 3)
disp('Displaying prior parameter distributions')
n=3;
Figures.plotDist(S,n)

% Figures 4-6
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

% Displaying Mtol maps (Figures 4-6):
n=4;
Figures.mapMTOL(SPF,SPR,SGT,SSF,n,topo_wgs,'DS1')
n=5;
Figures.mapMTOL(SPF,SPR,SGT,SSF,n,topo_wgs,'DS2')
n=6;
Figures.mapMTOL(SPF,SPR,SGT,SSF,n,topo_wgs,'FC')

% Figure 7 & S7: Mtol (individual risk metric) versus depth and hypocentral
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

n=7;
Figures.depthvsMtol(SPF,R_PF,SPR,R_PR,SGT,R_GT,SSF,R_SF,n)

% Figure 8: Individual risk derived Mtol versus aggregate based Mtol
load('Result_files/TLP_Results_ProdFields_Agg_1000it.mat');
ASPF = S.SUM; clear S
load('Result_files/TLP_Results_ProsFields_Agg_1000it.mat');
ASPR = S.SUM; clear S
load('Result_files/TLP_Results_GT_Agg_1000it.mat');
ASGT = S.SUM; clear S
load('Result_files/TLP_Results_STFields_Agg_1000it.mat');
ASSF = S.SUM; clear S

n=8;
Figures.IMvsAM(SPF,R_PF,SPR,R_PR,SGT,R_GT,SSF,R_SF,...
    ASPF,ASPR,ASGT,ASSF,n)

% Figure 9 + S6: DS1 damage estimates earthquake scenarios
clear
load('Result_files/Scenarios.mat')
load('Result_files/TLP_Results_STFields_1000it.mat');
n=9;
Figures.plotScenarios(R,S,n)

% Figure S5: Population density with field/license outlines
clear
load('topo_NL_WGS84.mat')
load('Result_files/TLP_Results_SelFields_1000it.mat')
S1 = S; clear S
load('Result_files/TLP_Results_SelGT_1000it.mat')
S2 = S; clear S 
load('blanks/TLP_nl-highres.mat')

n=51;
Figures.mapPop(S,S1,S2,n,topo_wgs)

% Figure S8: iso-Risk combination map
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

n=81;
Figures.mapISORiskComb(SPF,SPR,SGT,SSF,ASPF,ASPR,ASGT,ASSF,topo_wgs,n)