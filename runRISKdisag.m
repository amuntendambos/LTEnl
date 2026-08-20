function S=runRISKdisag(S,Np,lat,lon,dep,Zid)
  % Compute the risk curves for one scenario.

  % Predefine a flag.
  rand_flag='disaggregate';
  S.DNmetric_flag = 'individual';

  % Overwrite values in risk structure to just the ones of interest.
  S.RISK(1).lat=lat;
  S.RISK(1).lon=lon;
  S.RISK(1).Zid=Zid;
  S.MAP.DEP=dep*ones(size(S.MAP.DEP));
  S.MAP.Ir=true;
  S.RISK(2:end)=[];
  
  % Perturb data structure and compute risk curves.
  S=perturbVAR(S,Np,rand_flag);
  if(strcmpi(S.DNmetric_flag,'aggregate'))
      S=runRISKagg(S,rand_flag);
  elseif(strcmpi(S.DNmetric_flag,'individual'))
      S=runRISKind(S,rand_flag);
  end
   
return
