function mapISORiskComb(SPF,SPR,SGT,SSF,ASPF,ASPR,ASGT,ASSF,topo_wgs,n)
% Function to map the iso-Risk Combination map: aggregate versus individual
% risk metric

XL=[3.25 7.25];
YL=[50.7207239083931 53.75];
CC=colormap(gca,R_colormap('indicies'));
Z=CC(1:round(length(CC)/2),:);

CombPF = ones(length(SPF.SUM),1);
CombPR = ones(length(SPR.SUM),1);
CombGT = ones(length(SGT.SUM),1);
CombSF = ones(length(SSF.SUM),1);
for i=1:length(SPF.SUM)
    PFM_d1(i)=SPF.SUM(i).M_d1; APFM_d1(i)=ASPF(i).M_d1;
end
for i=1:length(SPR.SUM)
    PRM_d1(i)=SPR.SUM(i).M_d1; APRM_d1(i)=ASPR(i).M_d1;
end
for i=1:length(SGT.SUM)
    GTM_d1(i)=SGT.SUM(i).M_d1; AGTM_d1(i)=ASGT(i).M_d1;
end
for i=1:length(SSF.SUM)
    SFM_d1(i)=SSF.SUM(i).M_d1; ASFM_d1(i)=ASSF(i).M_d1;
end

CombPF(PFM_d1<APFM_d1)=length(Z);
CombPR(PRM_d1<APRM_d1)=length(Z);
CombGT(GTM_d1<AGTM_d1)=length(Z);
CombSF(SFM_d1<ASFM_d1)=length(Z);

% Create figure
figure(n); clf;

% Create axes
subplot(2,2,1), hold on
for j=1:length(SPF.RISK)
    latT(j) = SPF.RISK(j).lat;
    lonT(j) = SPF.RISK(j).lon;
end
for i=1:max(SPF.MAP.Bid)
      p=fill(SPF.MAP.lonB(SPF.MAP.Bid==i),SPF.MAP.latB(SPF.MAP.Bid==i),Z(CombPF(i),:));
      p.LineWidth=0.5; p.EdgeColor='k';
end
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.5 0.5 0.5]);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
xlabel('Longitude'); ylabel('Latitude'); title('Producing fields');
c1=colorbar('Ticks',clim,'TickLabels',{'Aggregate','Individual'},FontSize=10); 
c1.Label.String='Controling risk acceptance criteria'; c1.Label.FontSize=12; c1.Ruler.TickLabelRotation=90;
colormap(Z); 
xlim(XL); ylim(YL); box on
%
subplot(2,2,2), hold on
for j=1:length(SPR.RISK)
    latT(j) = SPR.RISK(j).lat;
    lonT(j) = SPR.RISK(j).lon;
end
for i=1:max(SPR.MAP.Bid)
      p=fill(SPR.MAP.lonB(SPR.MAP.Bid==i),SPR.MAP.latB(SPR.MAP.Bid==i),Z(CombPR(i),:));
      p.LineWidth=0.5; p.EdgeColor='k';
end
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.5 0.5 0.5]);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
xlabel('Longitude'); ylabel('Latitude'); title('Prospect fields');
c1=colorbar('Ticks',clim,'TickLabels',{'Aggregate','Individual'},FontSize=10); 
c1.Label.String='Controling risk acceptance criteria'; c1.Label.FontSize=12; c1.Ruler.TickLabelRotation=90;
colormap(Z); 
xlim(XL); ylim(YL); box on
% %
subplot(2,2,3), hold on
for j=1:length(SGT.RISK)
    latT(j) = SGT.RISK(j).lat;
    lonT(j) = SGT.RISK(j).lon;
end
for i=1:max(SGT.MAP.Bid)
      p=fill(SGT.MAP.lonB(SGT.MAP.Bid==i),SGT.MAP.latB(SGT.MAP.Bid==i),Z(CombGT(i),:));
      p.LineWidth=0.5; p.EdgeColor='k';
end
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.5 0.5 0.5]);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
xlabel('Longitude'); ylabel('Latitude'); title('Geothermal heat licenses');
c1=colorbar('Ticks',clim,'TickLabels',{'Aggregate','Individual'},FontSize=10); 
c1.Label.String='Controling risk acceptance criteria'; c1.Label.FontSize=12; c1.Ruler.TickLabelRotation=90;
colormap(Z); 
xlim(XL); ylim(YL); box on
% %
subplot(2,2,4), hold on
for j=1:length(SSF.RISK)
    latT(j) = SSF.RISK(j).lat;
    lonT(j) = SSF.RISK(j).lon;
end
for i=1:max(SSF.MAP.Bid)
      p=fill(SSF.MAP.lonB(SSF.MAP.Bid==i),SSF.MAP.latB(SSF.MAP.Bid==i),Z(CombSF(i),:));
      p.LineWidth=0.5; p.EdgeColor='k';
end
for i=3:max(topo_wgs(:,1))-1
    II=find(topo_wgs(:,1)==i);
    hline2=plot(topo_wgs(II,2),topo_wgs(II,3),'Color',[0.5 0.5 0.5]);
    if i==1
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','on');
    else
        set(get(get(hline2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
    end
end
xlabel('Longitude'); ylabel('Latitude'); title('Gas Storage Sites');
c1=colorbar('Ticks',clim,'TickLabels',{'Aggregate','Individual'},FontSize=10); 
c1.Label.String='Controling risk acceptance criteria'; c1.Label.FontSize=12; c1.Ruler.TickLabelRotation=90;
colormap(Z); 
xlim(XL); ylim(YL); box on
end