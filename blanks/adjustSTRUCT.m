function S=adjustSTRUCT(S,latBOUN,lonBOUN,F_id,B_id,Fname,SUn)
  % Simple function that adjusts the existing TLP risk-map data structure.
  
  % Put information in the MAP structure.
  S.MAP.latB=latBOUN;
  S.MAP.lonB=lonBOUN;
  S.MAP.Bid=B_id;
  S.MAP.Fid=F_id;
  S.Mw=[0.0:0.2:5.0,5.5];
  S.ML=S.Mw;
  
  latEQ = S.MAP.latE;
  lonEQ = S.MAP.lonE;

  RISK=struct('lat',[],'lon',[],'DEP',[],'Zid',[],'Nn2',[],'Nn3',[],'Nn4',[],'Nn5',[],'Nn6',[],'Nd1',[],'Nd2',[],'Pf1',[]);
  S.RISK = RISK;
  S.MAP.Ir = [];
  SUM=struct('FieldName',[],'STRAT_UN',[],'DEPTH',[],'M_Nn3',[],'M_d1',[],'M_d2',[],'M_Pf',[]);
  S.SUM = SUM;
  for i=1:length(Fname)
    S.SUM(i).FieldName=Fname(i);
    S.SUM(i).STRAT_UN=SUn(i);
  end
  
  % Find the map lats/longs that are within the play boundaries.
  LAT=repmat(latEQ',1,length(lonEQ));
  LON=repmat(lonEQ,length(latEQ),1);
  [n,m]=size(LAT);
  ZE = zeros(n,m);

  % Get Zechstein depth for identification of presence of the layer (for
  % GMPE).
  [DZE]=getZechsteinDepth(S);
  
  for kk=1:max(B_id)
      inb = inpolygon(LON,LAT,lonBOUN(B_id==kk)',latBOUN(B_id==kk)');
      inb2 = inpolygon(DZE.lonD,DZE.latD,lonBOUN(B_id==kk)',latBOUN(B_id==kk)');
      if kk==1 
          if (length(inb(inb==1))>10)
              Ne=2;
              inb(2:Ne:end,:)=0;
              inb(:,2:Ne:end)=0;
          end
          if (length(inb(inb==1))>15)
              Ne=4;
              inb(3:Ne:end,:)=0;
              inb(:,3:Ne:end)=0;
          end
          if (length(inb(inb==1))>20)
              Ne=8;
              inb(5:Ne:end,:)=0;
              inb(:,5:Ne:end)=0;
          end
          if (length(inb(inb==1))>20)
              Ne=16;
              inb(9:Ne:end,:)=0;
              inb(:,9:Ne:end)=0;
          end
          S.MAP.Ir=inb;
          if strcmpi(cellstr(SUn(kk)),'ZE') || strcmpi(cellstr(SUn(kk)),'RO')...
                  || strcmpi(cellstr(SUn(kk)),'DC')|| strcmpi(cellstr(SUn(kk)),'DF')
              AT = DZE.A(inb2==1);
              AT(isnan(AT)) = mean(AT,'omitnan');
              if ~isnan(AT)
                  ZE(inb==1) = 1;
              else
                  ZE(inb==1) = 2;
              end
          else
              ZE(inb==1) = 2;
          end
      else
          if (length(inb(inb==1))>10)
              Ne=2;
              inb(2:Ne:end,:)=0;
              inb(:,2:Ne:end)=0;
          end
          if (length(inb(inb==1))>15)
              Ne=4;
              inb(3:Ne:end,:)=0;
              inb(:,3:Ne:end)=0;
          end
          if (length(inb(inb==1))>20)
              Ne=8;
              inb(5:Ne:end,:)=0;
              inb(:,5:Ne:end)=0;
          end
          S.MAP.Ir(S.MAP.Ir == 0) = inb(S.MAP.Ir == 0);
          if strcmpi(cellstr(SUn(kk)),'ZE') || strcmpi(cellstr(SUn(kk)),'RO')...
                  || strcmpi(cellstr(SUn(kk)),'DC')|| strcmpi(cellstr(SUn(kk)),'DF')
              AT = DZE.A(inb2==1);
              AT(isnan(AT)) = mean(AT,'omitnan');
              if ~isnan(AT)
                  ZE(inb==1) = 1;
              else
                  ZE(inb==1) = 2;
              end
          else
              ZE(inb==1) = 2;
          end
      end
  end
      
  % Make a list of those lat/longs
  lat=LAT(S.MAP.Ir); lat=lat(:);
  lon=LON(S.MAP.Ir); lon=lon(:);
  Zid=ZE(S.MAP.Ir); Zid=Zid(:);

  figure; scatter(lon,lat,15,Zid,"filled"),hold on
  for i=1:max(S.MAP.Bid)
    plot(S.MAP.lonB(S.MAP.Bid==i),S.MAP.latB(S.MAP.Bid==i),'-k');
  end
  plot(S.MAP.lonCnl,S.MAP.latCnl,'-k');
  
  % Loop over all in-play coords, and stuff into risk structure.
  for i=1:length(lat)
      S.RISK(i).lat=lat(i);
      S.RISK(i).lon=lon(i);
      S.RISK(i).Zid=Zid(i);
  end
  
return