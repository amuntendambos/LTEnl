function [R]=mapRISKspecial(S,TypeFlag,CDI,DS,N_c,ML_c,Pn,Pd,Pr,Ni)
  % Compute the risk maps.
  
  % Set the interpolation type.
  interp_type='linear';
  
  % Check that we're up to date.
  if(strcmpi(S.dVAR.UPDATEflag,'yes'))
      return;
  end
  
  % Define structure and preallocate space for output maps.
  R=struct('MAPs',[]);
  MAPs=struct('N',[],'Nn',[]);
  
  % Predefine some important varaibles.
  J=find(S.MAP.Ir);
  M=S.Mw;
  
  % Loop over all of the map realizations.
  for i=1:length(S.dVAR.dM)
      
      N=NaN*zeros(size(S.MAP.Ir));
      Nn=zeros(length(S.RISK),1);
      
      % Loop over all of the (in-bounds) EQ grid.
      for j=1:length(S.RISK)
          
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
          
          %figure(10); plot(M,N_n);
          
          % Find intersecting values.
          if(strcmpi(TypeFlag,'nuisance'))
              N(J(j))=interp1(M,N_n,ML_c(j,1),interp_type,'extrap');
              Nn(j)=interp1(M,N_n,ML_c(j,1),interp_type,'extrap');
              N(N<0)=0; % Error handling
              Nn(Nn<0)=0; % Error handling
          elseif(strcmpi(TypeFlag,'damage'))
              if (DS==1)
                  N(J(j))=interp1(M,N_d,ML_c(j,2),interp_type,'extrap');
                  Nn(j)=interp1(M,N_d,ML_c(j,2),interp_type,'extrap');
              elseif (DS==2)
                  N(J(j))=interp1(M,N_d,ML_c(j,3),interp_type,'extrap');
                  Nn(j)=interp1(M,N_d,ML_c(j,3),interp_type,'extrap');
              end
              N(N<0)=0; % Error handling
              Nn(Nn<0)=0; % Error handling
          elseif(strcmpi(TypeFlag,'LPR'))
              N(J(j))=interp1(M,N_r,ML_c(j,4),interp_type,'extrap');
          end
      end
      
      % Stuff map into the output structure.
      MAPs(i).N=N;
      MAPs(i).Nn=Nn;
  end
  
  % Compute the averaged maps.
  if(strcmpi(TypeFlag,'nuisance'))
      N=prctile(cat(3,MAPs.N),Pn,3);
      Nn=prctile(cat(3,MAPs.Nn),Pn,3);
  elseif(strcmpi(TypeFlag,'damage'))
      Nn=prctile(cat(3,MAPs.Nn),Pd,3);
      N=prctile(cat(3,MAPs.N),Pd,3);
  elseif(strcmpi(TypeFlag,'LPR'))
      N=prctile(cat(3,MAPs.N),Pr,3);
      Nn=prctile(cat(3,MAPs.Nn),Pr,3);
  end
  
  % Upsample the averaged maps.
  lon=linspace(min(S.MAP.lonE),max(S.MAP.lonE),Ni*length(S.MAP.lonE));
  lat=linspace(min(S.MAP.latE),max(S.MAP.latE),Ni*length(S.MAP.latE));
  [LON,LAT]=meshgrid(lon,lat);
  [LONe,LATe]=meshgrid(S.MAP.lonE,S.MAP.latE);
  N=scatteredInterpolant(LONe(J),LATe(J),N(J),'natural','linear'); N=N(LON,LAT);
  for kk=1:max(S.MAP.Bid)
      inb = inpolygon(LON,LAT,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
      if kk==1 
          I = inb;
      else
          I(I == 0) = inb(I == 0); 
      end
  end
  N(~I)=NaN;
    
  % Error handling.
  N(N<0)=0;
    
  % Stuff results into the output structure.
  R.MAPs=MAPs;
  R.Nn=Nn;
  R.N=N;
  R.lat=lat;
  R.lon=lon;
  R.lat = LAT;
  R.lon = LON;
  
return