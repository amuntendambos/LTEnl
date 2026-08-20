function [lat,lon,Fldname,SUnit,F_id,B_id]=loadBOUND_GF(filename,FIELDflag,field)
  % Simple function that loads in the play-bounded area for Dutch gas fields.
  
  % Load in datafile.
  data=readtable(filename);
  D = struct('lat',[],'lon',[],'Fname',[],'SUnit',[],'FCD',[],'VP',[],'Status',[],'OG',[]);
  
  if strcmpi(FIELDflag(1),'ALL')
      if (strcmpi(FIELDflag(2),'ALL') && strcmpi(FIELDflag(3),'ALL'))
          lon = data.lon_DD;
          lat = data.lat_DD;
    
          str_un = data.STRAT_UNIT;
          F_CD = data.FIELD_CD;
          Fname = data.FIELD_NAME;
          Cid = data.vertex_part;
      else
          D.lon = data.lon_DD; D.lat = data.lat_DD;
          D.SUnit = data.STRAT_UNIT; D.FCD = data.FIELD_CD;
          D.VP = data.vertex_part; D.Fname = data.FIELD_NAME;
          D.Status = data.STATUS; D.OG = data.OILGAS;

          [lon,lat,Fname,str_un,F_CD,Cid]=extractFields(D,FIELDflag);
      end
  elseif strcmpi(FIELDflag(1),'ONSHORE')
      if (strcmpi(FIELDflag(2),'ALL') && strcmpi(FIELDflag(3),'ALL'))
          lon = data.lon_DD(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          lat = data.lat_DD(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
    
          str_un = data.STRAT_UNIT(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          F_CD = data.FIELD_CD(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          Cid = data.vertex_part(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          Fname = data.FIELD_NAME(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
      else
          D.lon = data.lon_DD(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          D.lat = data.lat_DD(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
    
          D.SUnit = data.STRAT_UNIT(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          D.FCD = data.FIELD_CD(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          D.VP = data.vertex_part(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          D.Status = data.STATUS(strcmpi(cellstr(data.LANDSEA(:)),'Land')); 
          D.OG = data.OILGAS(strcmpi(cellstr(data.LANDSEA(:)),'Land'));
          D.Fname = data.FIELD_NAME(strcmpi(cellstr(data.LANDSEA(:)),'Land'));

          [lon,lat,Fname,str_un,F_CD,Cid]=extractFields(D,FIELDflag);
      end
  elseif strcmpi(FIELDflag(1),'SPECIFIC')
      lon = [];
      lat = [];
      str_un = [];
      F_CD = [];
      Cid = [];
      Fname = [];
      for i = 1: length(field)
          lonT = data.lon_DD(strcmpi(field(i),cellstr(data.FIELD_CD(:))));
          latT = data.lat_DD(strcmpi(field(i),cellstr(data.FIELD_CD(:))));
          str_unT = data.STRAT_UNIT(strcmpi(field(i),cellstr(data.FIELD_CD(:))));
          F_CDT = data.FIELD_CD(strcmpi(field(i),cellstr(data.FIELD_CD(:))));
          CidT = data.vertex_part(strcmpi(field(i),cellstr(data.FIELD_CD(:))));
          FnameT = data.FIELD_NAME(strcmpi(field(i),cellstr(data.FIELD_CD(:))));

          lon = [lon; lonT];
          lat = [lat; latT];
          str_un = [str_un; str_unT];
          F_CD = [F_CD; F_CDT];
          Cid = [Cid; CidT];
          Fname = [Fname; FnameT];
      end
  else
      error('Invalid option for FIELDflag.AREA')
  end

  % Assign the boundary nodes to specific fields by B_id and optain each 
  % fields characteristic main stratigraphy SUnit
  k=1; l=1;
  B_id = zeros(length(F_CD),1); B_id(1) = 1;
  F_id = zeros(length(F_CD),1); F_id(1) = 1;
  Fldname(1) = Fname(1);
  [sun]=getMainStrat(str_un(1)); toc
  SUnit(1) = cellstr(sun);
  for i=2:length(F_CD)
      if strcmpi(cellstr(F_CD(i)),cellstr(F_CD(i-1)))
          F_id (i) = k;
          if (Cid(i) == Cid(i-1))
              B_id (i) = l;
              continue
          end
          l=l+1;
          B_id (i) = l;
          Fldname(l) = Fname(i);
          tic
          [sun]=getMainStrat(str_un(i)); toc
          SUnit(l) = cellstr(sun);
          continue
      end
      k=k+1;
      l=l+1;
      B_id (i) = l;
      F_id (i) = k;
      Fldname(l) = Fname(i);
      tic
      [sun]=getMainStrat(str_un(i)); toc
      SUnit(l) = cellstr(sun);
  end
  
return