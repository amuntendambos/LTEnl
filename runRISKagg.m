function S=runRISKagg(S,rand_flag)
  % Compute the risk curves.
  
  % Check that we're not already up to date.
  if(strcmpi(S.dVAR.UPDATEflag,'no'))
      return;
  end
  
  % Minimum magntiude to consider when converting PGA to PSA.
  Msa=3.5;

  % Get lengths of map edges.
  Nx=length(S.MAP.lonG);
  Ny=length(S.MAP.latG);
  
  % Get lists of all of the lat/long coords of interest.
  latG=repmat(S.MAP.latG',1,Nx); latG=latG(:);
  lonG=repmat(S.MAP.lonG,Ny,1); lonG=lonG(:);
  latE=[S.RISK.lat];
  lonE=[S.RISK.lon];
  Zid=[S.RISK.Zid];
  
  % Get the map properties of interest.
  DEP=interp2(S.MAP.lonE,S.MAP.latE,S.MAP.DEP,lonE,latE,'linear');
  for i=1:length(S.RISK)
      S.RISK(i).DEP = DEP(i);
  end
  VS30=S.MAP.Vs30(:);
  DVS30=S.MAP.dVs30(:);
  POP=S.MAP.POP(:);
  
  % Find the number of iterations needed.
  Ne=length(latE);
  Ng=length(latG);
  Nv=length(S.dVAR.dM);
  Nm=length(S.ML);
  
  % Get the flag for the GMPE to use.
  if(strcmpi(S.play_flag,'NL'))
      % GMPEflag='bg21';
      GMPEflag='jap';
  end
  
  % Loop over all of the (new) perturbed values.
  ns=size(S.RISK(1).Nn2,1)+1;
  for i=ns:Nv
      
      % Get this iteration's perturbation values, depending on user flag.
      if(strcmpi(rand_flag,'none'))
          % Get all information and perturb it.
          M=S.Mw;                  % [1 Nm]
          dGM=S.dVAR.dGM(i);       % [1 1]
          dSA=S.dVAR.dSA(i);       % [1 1]
          dep=DEP;                 % [Ne 1]
          vs30=VS30;               % [Ng 1]
          pop=POP;                 % [Ng 1]
          dN=[S.dVAR.dN1(i) S.dVAR.dN2(i)];
          Po=S.dVAR.Po(i);
          dLPR=S.dVAR.dLPR(i);
      else
          % Get all information and perturb it.
          M=S.Mw+S.dVAR.dM(i);     % [1 Nm]
          dGM=S.dVAR.dGM(i);       % [1 1]
          dSA=S.dVAR.dSA(i);       % [1 1]
          dep=abs(DEP+S.dVAR.dZ(i));    % [Ne 1]
          vs30=VS30.*lognrnd(0.0,log10(exp(DVS30)));       % [Ng 1]
          pop=abs(normrnd(POP,sqrt(POP)))*S.dVAR.dPOP(i);  % [Ng 1]
          dN=[S.dVAR.dN1(i) S.dVAR.dN2(i)];
          Po=S.dVAR.Po(i);
          dLPR=S.dVAR.dLPR(i);
      end
      
      % Reshape information into matrices [Ng Nm].
      M=repmat(M,Ng,1);
      vs30=repmat(vs30,1,Nm);
      pop=repmat(pop,1,Nm);
      
      % Loop over all of the map pixels.
      for j=1:Ne

          if strcmpi(GMPEflag,'jap')
              ZE = Zid(j);
          else
              ZE = 0;
          end

          % Get distances and reshape into matrix (km).
          Re=Geoid_Distance(latE(j),lonE(j),latG,lonG,'elliptical')*6371*pi()/180; % [Ng 1]
          Re=repmat(Re,1,Nm); % [Ng Nm]
          
          % Truncate based on maximum distance.
          In=(Re(:,1)<=S.MAP.ReN_max);
          Id=(Re(:,1)<=S.MAP.ReD_max);
          
          % Truncate to the closest grid point that's populated.
          Ii=find((pop(:,1)>0));
          [~,Im]=min(Re(Ii,1));
          Ii=Ii(Im);

          % Compute the ground motion matrices (PGVn:m/s & PGVd:mm/s).
          pgv_n=GMPE(Re(In,:),M(In,:),dep(j),vs30(In,:),dGM,   -1,GMPEflag,ZE)*dSA*0.01;     % [Ng(In) Nm]
          pgv_d=GMPE(Re(Id,:),M(Id,:),dep(j),vs30(Id,:),dGM,   -1,GMPEflag,ZE)*dSA*10;       % [Ng(Id) Nm]

          % Compute chance of nuisance observation [Ng(In) Nm].
          On2=NUISfxn(pgv_n,dN,2);
          On3=NUISfxn(pgv_n,dN,3);
          On4=NUISfxn(pgv_n,dN,4);
          On5=NUISfxn(pgv_n,dN,5);
          On6=NUISfxn(pgv_n,dN,6);
          
          % Compute chance of damage observation [Ng(Id) Nm].
          Od1=FRAGfxn_cosmetic(pgv_d,Po,1);
          Od2=FRAGfxn_cosmetic(pgv_d,Po,2);
          
          % Compute expected number of impacted households (3 people/house) [1 Nm].
          Nn2=sum(On2.*pop(In,:),1)/3; Nn3=sum(On3.*pop(In,:),1)/3; Nn4=sum(On4.*pop(In,:),1)/3; Nn5=sum(On5.*pop(In,:),1)/3; Nn6=sum(On6.*pop(In,:),1)/3;
          Nd1=sum(Od1.*pop(Id,:),1)/3; Nd2=sum(Od2.*pop(Id,:),1)/3;
              
          % Compute the average spectral acceleration (PSAi:g).
          if strcmpi(GMPEflag,'jap')
              psa_i=GMPE(Re(Ii,:),M(Ii,:),dep(j),vs30(Ii,:),dGM,   0,GMPEflag,ZE)*dSA/980.665;          % [Ng(Ii) Nm] i.e., [1 Nm]
          elseif strcmpi(GMPEflag,'bg21')
              psa_i=GMPE(Re(Ii,:),M(Ii,:),dep(j),vs30(Ii,:),dGM,   -1,'bg21',ZE)*dSA;
              psa_i=PGV2PGA(psa_i)/980.665;
          end
         
          for k=1:length(psa_i)
              psa_k=PGA2PSA(psa_i(k),max(M(Ii,k),Msa),Re(Ii,k),vs30(Ii,k)-50,S.T);
              psa_i(k)=AvgSA(S.T,real(psa_k),0.2,'NL');
          end
          
          % Compute the Local Personal Risk (probability of loss of life).
          Pf1=VULNfxn_fatality(psa_i,dLPR)*0.95;

          % Stash results into the output data structure.
          S.RISK(j).Nn2=[S.RISK(j).Nn2;Nn2]; S.RISK(j).Nn3=[S.RISK(j).Nn3;Nn3]; S.RISK(j).Nn4=[S.RISK(j).Nn4;Nn4]; S.RISK(j).Nn5=[S.RISK(j).Nn5;Nn5]; S.RISK(j).Nn6=[S.RISK(j).Nn6;Nn6];
          S.RISK(j).Nd1=[S.RISK(j).Nd1;Nd1]; S.RISK(j).Nd2=[S.RISK(j).Nd2;Nd2]; 
          S.RISK(j).Pf1=[S.RISK(j).Pf1;Pf1];
          
      end
  end

  % Flip the risk routine run flag.
  S.dVAR.UPDATEflag='no';
  
return
