function S = loadDEPfromSTRAT(S,SUn,B_id)
    % Simple function that loads the play depths based on the stratigraphy 
    % it is located in.
        
    C = unique(SUn);
    %
    [DM] = loadDEPfiles(C);

    A = DM.R.A; latD = DM.R.latD; lonD = DM.R.lonD;
    %[n,m]=size(A);
    for kk=1:max(B_id)
        inb = inpolygon(lonD,latD,S.MAP.lonB(B_id==kk)',S.MAP.latB(B_id==kk)');
        if strcmpi(cellstr(SUn(kk)),'NU'), AT = DM.NU.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'NL'), AT = DM.NL.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'CK'), AT = DM.CK.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'KN'), AT = DM.KN.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'NS'), AT = DM.NS.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'AT'), AT = DM.AT.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'RN'), AT = DM.RN.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'RB'), AT = DM.RB.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'ZE'), AT = DM.ZE.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'RO'), AT = DM.RO.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'DC'), AT = DM.DC.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'DI'), AT = DM.DI.A(inb == 1);
        elseif strcmpi(cellstr(SUn(kk)),'DF'), AT = -2500;
        end
        AT(isnan(AT)) = mean(AT,'omitnan');
        if isnan(AT)
            A(inb == 1) = -250;
        else
            A(inb == 1) = AT;
        end
        S.SUM(kk).DEPTH = mean(A(inb==1),'omitnan')/1000;
    end
    
    % Inpterpolate isothermal depths to a regular grid.
    [LON,LAT]=meshgrid(S.MAP.lonE,S.MAP.latE);
    F_TVD=griddata(lonD,latD,A,LON,LAT,'nearest');
    
    figure; 
    contourf(lonD,latD,A./1000,35,'LineColor','none'); hold on;
    for i=1:max(S.MAP.Bid)
        plot(S.MAP.lonB(S.MAP.Bid==i),S.MAP.latB(S.MAP.Bid==i),'-k');
    end
    plot(S.MAP.lonCnl,S.MAP.latCnl,'-k');
    % figure; 
    % contourf(lonD,latD,DM.RO.A./1000,'LineColor','none'); hold on;
    % plot(S.MAP.lonB,S.MAP.latB,'-k'); hold off
    %figure;
    %contourf(S.MAP.lonE,S.MAP.latE,F_TVD./1000,'LineColor','none'); hold on;
    %plot(S.MAP.lonB,S.MAP.latB,'-k');
    
    % Fill in the edges a bit to make sure the area is completely covered.
    F_TVD=fillmissing(F_TVD,'nearest',1);
    F_TVD=fillmissing(F_TVD,'nearest',2);
    
    % Stuff data into output structure.
    S.MAP.DEP=F_TVD./1000;
      
    latE=[S.RISK.lat];
    lonE=[S.RISK.lon];
    Zid=[S.RISK.Zid];

    DEP=interp2(S.MAP.lonE,S.MAP.latE,S.MAP.DEP,lonE,latE,'linear');
    latE = latE(DEP<-0.1);
    lonE = lonE(DEP<-0.1);
    Zid = Zid(DEP<-0.1);

    RISK=struct('lat',[],'lon',[],'DEP',[],'Zid',[],'Nn2',[],'Nn3',[],'Nn4',[],'Nn5',[],'Nn6',[],'Nd1',[],'Nd2',[],'Pf1',[]);
    S.RISK = RISK;
    % Loop over all in-play coords, and stuff into risk structure.
    for i=1:length(latE)
        S.RISK(i).lat=latE(i);
        S.RISK(i).lon=lonE(i);
        S.RISK(i).Zid=Zid(i);
    end

    figure; 
    for i=1:length(S.RISK)
        plot(S.RISK(i).lon,S.RISK(i).lat,'.k'); hold on;
    end
    for i=1:max(S.MAP.Bid)
        plot(S.MAP.lonB(S.MAP.Bid==i),S.MAP.latB(S.MAP.Bid==i),'-k');
    end
    plot(S.MAP.lonCnl,S.MAP.latCnl,'-k');
return
