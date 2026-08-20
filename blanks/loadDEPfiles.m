function [DM] = loadDEPfiles(C)
    % Simple function to load all relevant depthgrids

    % Set-up stucture for depthmaps
    DM = struct('R',[],'NU',[],'NL',[],'CK',[],'KN',[],'NS',[],'AT',[],'RN',[],'RB',[],'ZE',[],'RO',[],'DC',[],'DI',[]);
    
    % Define the depth and thickness files for the different stratigraphies
    NU_Dfile = 'DGM-diep_v5\NU_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    NU_dZfile = 'DGM-diep_v5\NU_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    NL_Dfile = 'DGM-diep_v5\NLNM_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    NL_dZfile = 'DGM-diep_v5\NLNM_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    CK_Dfile = 'DGM-diep_v5\CK_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    CK_dZfile = 'DGM-diep_v5\CK_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    KN_Dfile = 'DGM-diep_v5\KN_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc' ;
    KN_dZfile = 'DGM-diep_v5\KN_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    NS_Dfile = 'DGM-diep_v5\S_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc' ;
    NS_dZfile = 'DGM-diep_v5\S_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    AT_Dfile = 'DGM-diep_v5\AT_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc' ;
    AT_dZfile = 'DGM-diep_v5\AT_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    RN_Dfile = 'DGM-diep_v5\RN_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    RN_dZfile = 'DGM-diep_v5\RN_dZ_on_offshore_merge_DGM50_ED50_UTM31.asc';
    RB_Dfile = 'DGM-diep_v5\RB_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    RB_dZfile = 'DGM-diep_v5\RB_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    ZE_Dfile = 'DGM-diep_v5\Top_ZE_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc'; 
    RO_Dfile = 'DGM-diep_v5\RO_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    RO_dZfile = 'DGM-diep_v5\RO_dZ_on_offshore_DGM50_ED50_UTM31.asc';
    DC_Dfile = 'DGM-diep_v5\RO_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';
    DC_Dfile2 = 'DGM-diep_v5\ZE_tvd_on_offshore_clipped_DGM50_ED50_UTM31.asc';

    [R] = getDEPTHgrid(NU_Dfile,'base',NU_dZfile);
    %R.A(~isnan(R.A))=0;
    DM.R = R;

    % Load the depthmaps of the relevant unique stratigraphies (defined in C)
    for i = 1: length(C)
        if strcmpi(cellstr(C(i)),'NU') 
            [NU] = getDEPTHgrid(NU_Dfile,'base',NU_dZfile);
            NU.A (NU.A>-50) = -50;
            DM.NU = NU;
        elseif strcmpi(cellstr(C(i)),'NL')
            [NL] = getDEPTHgrid(NL_Dfile,'base',NL_dZfile); 
            DM.NL = NL;
        elseif strcmpi(cellstr(C(i)),'CK')
            [CK] = getDEPTHgrid(CK_Dfile,'base',CK_dZfile); 
            DM.CK = CK;
        elseif strcmpi(cellstr(C(i)),'KN')
            [KN] = getDEPTHgrid(KN_Dfile,'base',KN_dZfile); 
            DM.KN = KN;
        elseif strcmpi(cellstr(C(i)),'NS')
            [NS] = getDEPTHgrid(NS_Dfile,'base',NS_dZfile); 
            DM.NS = NS;
        elseif strcmpi(cellstr(C(i)),'AT')
            [AT] = getDEPTHgrid(AT_Dfile,'base',AT_dZfile); 
            DM.AT = AT;
        elseif strcmpi(cellstr(C(i)),'RN')
            [RN] = getDEPTHgrid(RN_Dfile,'base',RN_dZfile); 
            DM.RN = RN;
        elseif strcmpi(cellstr(C(i)),'RB')
            [RB] = getDEPTHgrid(RB_Dfile,'base',RB_dZfile); 
            DM.RB = RB;
        elseif strcmpi(cellstr(C(i)),'ZE')
            [ZE] = getDEPTHgrid(ZE_Dfile,'top'); 
            DM.ZE = ZE;
        elseif strcmpi(cellstr(C(i)),'RO')
            [RO] = getDEPTHgrid(RO_Dfile,'base',RO_dZfile); 
            DM.RO = RO;
        elseif strcmpi(cellstr(C(i)),'DC')
            [DC] = getDEPTHgrid(DC_Dfile,'top'); 
            [DC2] = getDEPTHgrid(DC_Dfile2,'top');
            DC.A(isnan(DC.A)) = DC2.A(isnan(DC.A));
            DM.DC = DC;
        elseif strcmpi(cellstr(C(i)),'DI')
            [DI] = getDEPTHgrid(DC_Dfile,'top'); 
            DI.A = DI.A-750;
            DM.DI = DI;
        end
    end

end