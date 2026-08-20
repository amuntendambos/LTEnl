function [SU_id]=getMainStrat(str_un)
    % Simple function to derive main stratigraphy unit from detailed field info
    
    [NU,NL,CK,KN,NS,AT,RN,RB,ZE,RO,DC,DI,DF] = setMainStratUnits;

    for j=1:length(NU) % main unit 1
        if strcmpi(cellstr(NU(j)),cellstr(str_un))
            SU_id = 'NU';
            return
        end
    end
    for j=1:length(NL) % main unit 2
        if strcmpi(cellstr(NL(j)),cellstr(str_un))
            SU_id = 'NL';
            return
        end
    end
    for j=1:length(CK) % main unit 3
        if strcmpi(cellstr(CK(j)),cellstr(str_un))
            SU_id = 'CK';
            return
        end
    end
    for j=1:length(KN) % main unit 4
        if strcmpi(cellstr(KN(j)),cellstr(str_un))
            SU_id = 'KN';
            return
        end
    end
    for j=1:length(NS) % main unit 5
        if strcmpi(cellstr(NS(j)),cellstr(str_un))
            SU_id = 'NS';
            return
        end
    end
    for j=1:length(AT) % main unit 6
        if strcmpi(cellstr(AT(j)),cellstr(str_un))
            SU_id = 'AT';
            return
        end
    end
    for j=1:length(RN) % main unit 7
        if strcmpi(cellstr(RN(j)),cellstr(str_un))
            SU_id = 'RN';
            return
        end
    end
    for j=1:length(RB) % main unit 8
        if strcmpi(cellstr(RB(j)),cellstr(str_un))
            SU_id = 'RB';
            return
        end
    end
    for j=1:length(ZE) % main unit 9
        if strcmpi(cellstr(ZE(j)),cellstr(str_un))
            SU_id = 'ZE';
            return
        end
    end
    for j=1:length(RO) % main unit 10
        if strcmpi(cellstr(RO(j)),cellstr(str_un))
            SU_id = 'RO';
            return
        end
    end
    for j=1:length(DC) % main unit 11
        if strcmpi(cellstr(DC(j)),cellstr(str_un))
            SU_id = 'DC';
            return
        end
    end
    for j=1:length(DI) % main default unit 
        if strcmpi(cellstr(DI(j)),cellstr(str_un))
            SU_id = 'DI';
            return
        end
    end
    for j=1:length(DF) % main default unit 
        if strcmpi(cellstr(DF(j)),cellstr(str_un))
            SU_id = 'DF';
            return
        end
    end


return