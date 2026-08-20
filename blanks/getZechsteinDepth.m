function [ZE]=getZechsteinDepth(S)
% function getZechsteinDepth 
% Function to obtain the depthmap of the Zechstein for identification of
% the presence of the layer for the GMPE application in JAPEK

ZE_Dfile = 'C:\Users\amuntendambos\OneDrive - Delft University of Technology\Documents\WORK\Projects\Current projects\LTEnl\DGM-diep_v5\Top_ZE_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc'; 

[ZE] = getDEPTHgrid(ZE_Dfile,'top');

figure;
contourf(ZE.lonD,ZE.latD,ZE.A./1000,'LineColor','none'); hold on
plot(S.MAP.lonCnl,S.MAP.latCnl,'-k');

end