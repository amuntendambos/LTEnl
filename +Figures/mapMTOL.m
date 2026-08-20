function mapMTOL(SPF,SPR,SGT,SSF,n,topo_wgs,TypeFlag)
% Function to map the outputs of MTOL

% set plot parameters
ML_c=[1.5 4.5];
XL=[3.25 7.25];
YL=[50.7207239083931 53.75];


% Create figure
figure(n); clf;
t=tiledlayout(2,2,'TileSpacing','compact');

% Create axes
nexttile; hold on
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.75 0.75 0.75],'LineWidth',1);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
if(strcmpi(TypeFlag,'DS1'))
    for i=1:max(SPF.MAP.Bid)
      p=fill(SPF.MAP.lonB(SPF.MAP.Bid==i),SPF.MAP.latB(SPF.MAP.Bid==i),SPF.SUM(i).M_d1);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'DS2'))
    for i=1:max(SPF.MAP.Bid)
      p=fill(SPF.MAP.lonB(SPF.MAP.Bid==i),SPF.MAP.latB(SPF.MAP.Bid==i),SPF.SUM(i).M_d2);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'FC'))
    for i=1:max(SPF.MAP.Bid)
      p=fill(SPF.MAP.lonB(SPF.MAP.Bid==i),SPF.MAP.latB(SPF.MAP.Bid==i),SPF.SUM(i).M_Pf);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
end
title('Producing fields');
xlabel('Longitude'); ylabel('Latitude');
colormap(gca,R_colormap('red-light')); caxis(ML_c);
xlim(XL); ylim(YL); box on
hold off
%
nexttile; hold on
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.75 0.75 0.75],'LineWidth',1);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
if(strcmpi(TypeFlag,'DS1'))
    for i=1:max(SPR.MAP.Bid)
      p=fill(SPR.MAP.lonB(SPR.MAP.Bid==i),SPR.MAP.latB(SPR.MAP.Bid==i),SPR.SUM(i).M_d1);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'DS2'))
    for i=1:max(SPR.MAP.Bid)
      p=fill(SPR.MAP.lonB(SPR.MAP.Bid==i),SPR.MAP.latB(SPR.MAP.Bid==i),SPR.SUM(i).M_d2);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'FC'))
    for i=1:max(SPR.MAP.Bid)
      p=fill(SPR.MAP.lonB(SPR.MAP.Bid==i),SPR.MAP.latB(SPR.MAP.Bid==i),SPR.SUM(i).M_Pf);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
end
title('Prospect fields'); xlabel('Longitude'); 
colormap(gca,R_colormap('red-light')); caxis(ML_c);
xlim(XL); ylim(YL); box on
hold off
%
nexttile; hold on
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.75 0.75 0.75],'LineWidth',1);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
if(strcmpi(TypeFlag,'DS1'))
    for i=1:max(SGT.MAP.Bid)
      p=fill(SGT.MAP.lonB(SGT.MAP.Bid==i),SGT.MAP.latB(SGT.MAP.Bid==i),SGT.SUM(i).M_d1);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'DS2'))
    for i=1:max(SGT.MAP.Bid)
      p=fill(SGT.MAP.lonB(SGT.MAP.Bid==i),SGT.MAP.latB(SGT.MAP.Bid==i),SGT.SUM(i).M_d2);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'FC'))
    for i=1:max(SGT.MAP.Bid)
      p=fill(SGT.MAP.lonB(SGT.MAP.Bid==i),SGT.MAP.latB(SGT.MAP.Bid==i),SGT.SUM(i).M_Pf);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
end
title('Geothermal heat licenses'); xlabel('Longitude'); ylabel('Latitude');
colormap(gca,R_colormap('red-light')); caxis(ML_c);
xlim(XL); ylim(YL); box on
hold off
%
nexttile; hold on
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.75 0.75 0.75],'LineWidth',1);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
if(strcmpi(TypeFlag,'DS1'))
    for i=1:max(SSF.MAP.Bid)
      p=fill(SSF.MAP.lonB(SSF.MAP.Bid==i),SSF.MAP.latB(SSF.MAP.Bid==i),SSF.SUM(i).M_d1);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'DS2'))
    for i=1:max(SSF.MAP.Bid)
      p=fill(SSF.MAP.lonB(SSF.MAP.Bid==i),SSF.MAP.latB(SSF.MAP.Bid==i),SSF.SUM(i).M_d2);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
elseif(strcmpi(TypeFlag,'FC'))
    for i=1:max(SSF.MAP.Bid)
      p=fill(SSF.MAP.lonB(SSF.MAP.Bid==i),SSF.MAP.latB(SSF.MAP.Bid==i),SSF.SUM(i).M_Pf);
      p.LineWidth=0.5; p.EdgeColor='k';
    end
end
title('Gas Storage Sites'); 
colormap(gca,R_colormap('red-light')); caxis(ML_c);
xlim(XL); ylim(YL); box on
hold off
xlabel('Longitude'); xlabel(t,'M_{TOL}');
cb=colorbar(); cb.Layout.Tile = 'south'; %cb.Label = 'M_{TOL}';
%ylabel(h, 'Red-Light Magnitude (M_L)');

end