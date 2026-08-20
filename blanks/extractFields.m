function [lon,lat,Fname,str_un,F_CD,Cid]=extractFields(D,FIELDflag)
% Simple function that further constraints the boundfile input

T = struct('lat',[],'lon',[],'Fname',[],'SUnit',[],'FCD',[],'VP',[],'Status',[]);

if strcmpi(FIELDflag(2),'ALL')
    T.lon = D.lon; T.lat = D.lat;
    T.SUnit = D.SUnit; T.FCD = D.FCD;
    T.VP = D.VP; T.Status = D.Status;
    T.Fname = D.Fname;
elseif strcmpi(FIELDflag(2),'GAS')
    T.lon = D.lon(strcmpi(cellstr(D.OG(:)),'GAS'));
    T.lat = D.lat(strcmpi(cellstr(D.OG(:)),'GAS'));
    
    T.SUnit = D.SUnit(strcmpi(cellstr(D.OG(:)),'GAS'));
    T.FCD = D.FCD(strcmpi(cellstr(D.OG(:)),'GAS'));
    T.VP = D.VP(strcmpi(cellstr(D.OG(:)),'GAS'));
    T.Status = D.Status(strcmpi(cellstr(D.OG(:)),'GAS'));
    T.Fname = D.Fname(strcmpi(cellstr(D.OG(:)),'GAS'));
elseif strcmpi(FIELDflag(2),'OIL')
    T.lon = D.lon(strcmpi(cellstr(D.OG(:)),'OIL'));
    T.lat = D.lat(strcmpi(cellstr(D.OG(:)),'OIL'));
    
    T.SUnit = D.SUnit(strcmpi(cellstr(D.OG(:)),'OIL'));
    T.FCD = D.FCD(strcmpi(cellstr(D.OG(:)),'OIL'));
    T.VP = D.VP(strcmpi(cellstr(D.OG(:)),'OIL'));
    T.Status = D.Status(strcmpi(cellstr(D.OG(:)),'OIL'));
    T.Fname = D.Fname(strcmpi(cellstr(D.OG(:)),'OIL'));
else
    error('Invalid option for FIELDflag.OILGAS')
end

if strcmpi(FIELDflag(3),'ALL')
    lon = T.lon; lat = T.lat;
    str_un = T.SUnit; F_CD = T.FCD;
    Cid = T.VP; Fname = T.Fname;
elseif strcmpi(FIELDflag(3),'Producing')
    lon = T.lon(strcmpi(cellstr(T.Status(:)),'Producing'));
    lat = T.lat(strcmpi(cellstr(T.Status(:)),'Producing'));
    
    str_un = T.SUnit(strcmpi(cellstr(T.Status(:)),'Producing'));
    F_CD = T.FCD(strcmpi(cellstr(T.Status(:)),'Producing'));
    Cid = T.VP(strcmpi(cellstr(T.Status(:)),'Producing'));
    Fname = T.Fname(strcmpi(cellstr(T.Status(:)),'Producing'));
elseif strcmpi(FIELDflag(3),'Prospect')
    lon = T.lon(strcmpi(cellstr(T.Status(:)),'Prospect'));
    lat = T.lat(strcmpi(cellstr(T.Status(:)),'Prospect'));
    
    str_un = T.SUnit(strcmpi(cellstr(T.Status(:)),'Prospect'));
    F_CD = T.FCD(strcmpi(cellstr(T.Status(:)),'Prospect'));
    Cid = T.VP(strcmpi(cellstr(T.Status(:)),'Prospect'));
    Fname = T.Fname(strcmpi(cellstr(T.Status(:)),'Prospect'));
elseif strcmpi(FIELDflag(3),'Storage')
    lon = T.lon(strcmpi(cellstr(T.Status(:)),'Storage'));
    lat = T.lat(strcmpi(cellstr(T.Status(:)),'Storage'));
    
    str_un = T.SUnit(strcmpi(cellstr(T.Status(:)),'Storage'));
    F_CD = T.FCD(strcmpi(cellstr(T.Status(:)),'Storage'));
    Cid = T.VP(strcmpi(cellstr(T.Status(:)),'Storage'));
    Fname = T.Fname(strcmpi(cellstr(T.Status(:)),'Storage'));
else
    error('Invalid option for FIELDflag.Status')
end

return