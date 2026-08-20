function [lat,lon,Fldname,SUnit,F_id,B_id]=loadBOUND_GT(filename,GTflag,licence)
  % Simple function that loads in the play-bounded area for Dutch 
  % geothermal licenses.
  
  % Load in datafile.
  data=readtable(filename);
  
  if strcmpi(GTflag,'ALL')
      lon = data.lon_DD;
      lat = data.lat_DD;

      str_un = data.STRAT_UNIT;
      F_CD = data.licence_cd;
      Fname = data.licence_nm;
      Cid = data.vertex_part;
  elseif strcmpi(GTflag,'SPECIFIC')
      lon = [];
      lat = [];
      str_un = [];
      F_CD = [];
      Cid = [];
      Fname = [];
      for i = 1: length(licence)
          lonT = data.lon_DD(strcmpi(licence(i),cellstr(data.licence_cd(:))));
          latT = data.lat_DD(strcmpi(licence(i),cellstr(data.licence_cd(:))));
          str_unT = data.STRAT_UNIT(strcmpi(licence(i),cellstr(data.licence_cd(:))));
          F_CDT = data.licence_cd(strcmpi(licence(i),cellstr(data.licence_cd(:))));
          CidT = data.vertex_part(strcmpi(licence(i),cellstr(data.licence_cd(:))));
          FnameT = data.licence_nm(strcmpi(licence(i),cellstr(data.licence_cd(:))));

          lon = [lon; lonT];
          lat = [lat; latT];
          str_un = [str_un; str_unT];
          F_CD = [F_CD; F_CDT];
          Cid = [Cid; CidT];
          Fname = [Fname; FnameT];
      end
  else
      error('Invalid option for GTflag')
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