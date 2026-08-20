function [R,Md_min]=mapRISK(S,TypeFlag,CDI,DS,N_c,Pn,Pd,Pr,Ni,metric)
  % Compute the risk maps.
  
  % Set the interpolation type.
  interp_type='linear';
  
  % Check that we're up to date.
  if(strcmpi(S.dVAR.UPDATEflag,'yes'))
      return;
  end
  
  % Define structure and preallocate space for output maps.
  R=struct('Mr',[],'Md',[],'DIST',[],'lat',[],'lon',[]);
  DIST=struct('Md',[]);
    
  % Predefine some important varaibles.
  J=find(S.MAP.Ir);
  M=S.Mw;
  Mr=NaN*zeros(size(S.MAP.Ir));
  
  % Loop over all of the map realizations.
  for i=1:length(S.dVAR.dM)
      
      Md=zeros(length(S.RISK),1);
      
      % Loop over all of the (in-bounds) EQ grid.
      for j=1:length(S.RISK)
          if i==1
              latT(j) = S.RISK(j).lat;
              lonT(j) = S.RISK(j).lon;
          end
          
          % Get the nuisance level of interest.
          if(CDI==2)
              N_n=S.RISK(j).Nn2(i,:);
          elseif(CDI==3)
              N_n=S.RISK(j).Nn3(i,:);
          elseif(CDI==4)
              N_n=S.RISK(j).Nn4(i,:);
          elseif(CDI==5)
              N_n=S.RISK(j).Nn5(i,:);
          elseif(CDI==6)
              N_n=S.RISK(j).Nn6(i,:);
          end
          
          % Get the damage level of interest.
          if(DS==1)
              N_d=S.RISK(j).Nd1(i,:);
          elseif(DS==2)
              N_d=S.RISK(j).Nd2(i,:);
          elseif(DS==3)
              N_d=S.RISK(j).Nd3(i,:);
          elseif(DS==4)
              N_d=S.RISK(j).Nd4(i,:);
          end
          
          % Get the LPR.
          N_r=S.RISK(j).Pf1(i,:);

          % Dealing with non-monotonic and non-unique inputs.
          dx=cumsum(ones(size(M)));
          N_n=N_n+dx.*N_n/(100*length(M))+dx*eps;
          N_d=N_d+dx.*N_d/(100*length(M))+dx*eps;
          N_r=N_r+dx.*N_r/(100*length(M))+dx*eps;
                  
          % Find intersecting values.
          if(strcmpi(TypeFlag,'nuisance'))
              Md(j)=interp1(N_n,M,N_c,interp_type,'extrap');
              % Md(j)=min([4.0 Md(j)]);
          elseif(strcmpi(TypeFlag,'damage'))
              Md(j)=interp1(N_d,M,N_c,interp_type,'extrap');
              % Md(j)=min([4.0 Md(j)]);
          elseif(strcmpi(TypeFlag,'LPR'))
              Md(j)=interp1(N_r,M,N_c,interp_type,'extrap');
              % Md(j)=min([4.0 Md(j)]);
          end
      end
      
      % Stuff map into the output structure.
      DIST(i).Md=Md;

  end
  
  if(strcmpi(metric,'median'))
      % Compute the median maps.
      if(strcmpi(TypeFlag,'nuisance'))
          Md=prctile(cat(3,DIST.Md),Pn,3);
      elseif(strcmpi(TypeFlag,'damage'))
          Md=prctile(cat(3,DIST.Md),Pn,3);
      elseif(strcmpi(TypeFlag,'LPR'))
          Md=prctile(cat(3,DIST.Md),Pn,3);
      end
  elseif(strcmpi(metric,'mean'))
      % Compute the mean maps.
      if(strcmpi(TypeFlag,'nuisance'))
          Md=mean(cat(3,DIST.Md),3);
      elseif(strcmpi(TypeFlag,'damage'))
          Md=mean(cat(3,DIST.Md),3);
      elseif(strcmpi(TypeFlag,'LPR'))
          Md=mean(cat(3,DIST.Md),3);
      end
  end

  for j=1:length(S.RISK)
      Mr(J(j))=Md(j);
  end

  % Compute minimum LTE-magnitude per field/block
  for kk=1:max(S.MAP.Bid)
      inb = inpolygon(lonT,latT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
      Md_min(kk) = min(Md(inb==1));
  end
  
  % Upsample the averaged maps.
  lon=linspace(min(S.MAP.lonE),max(S.MAP.lonE),Ni*length(S.MAP.lonE));
  lat=linspace(min(S.MAP.latE),max(S.MAP.latE),Ni*length(S.MAP.latE));
  [LON,LAT]=meshgrid(lon,lat);
  [LONe,LATe]=meshgrid(S.MAP.lonE,S.MAP.latE);
  Mr=scatteredInterpolant(LONe(J),LATe(J),Mr(J),'natural','linear'); Mr=Mr(LON,LAT);
  for kk=1:max(S.MAP.Bid)
      inb = inpolygon(LON,LAT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
      if kk==1 
          I = inb;
      else
          I(I == 0) = inb(I == 0); 
      end
  end
  Mr(~I)=NaN;
   
  % Stuff results into the output structure.
  R.Mr=Mr; 
  R.Md=Md;
  R.DIST=DIST;
  R.lat = LAT;
  R.lon = LON;
  
return