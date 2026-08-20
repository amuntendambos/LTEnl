function mapMTOL(MPF,MPR,MGT,MSF,n,topo_wgs,TypeFlag,FigType)
% Function to map the outputs of MTOL

% set plot parameters
ML_c=[1.5 4.5];
nc=(6*3)+1;

XL=[3.25 7.25];
YL=[50.7207239083931 53.75];

% Get appropriate iso-maps to plot
if(strcmpi(TypeFlag,'DS1'))
    MPF_pl = MPF.D1; MPR_pl = MPR.D1;
    MGT_pl = MGT.D1; MSF_pl = MSF.D1;
elseif(strcmpi(TypeFlag,'DS2'))
    MPF_pl = MPF.D2; MPR_pl = MPR.D2;
    MGT_pl = MGT.D2; MSF_pl = MSF.D2;
elseif(strcmpi(TypeFlag,'FC'))
    MPF_pl = MPF.R; MPR_pl = MPR.R;
    MGT_pl = MGT.R; MSF_pl = MSF.R;
end

if(strcmpi(FigType,'paper'))
    % Create figure
    figure(n); clf;
    t=tiledlayout(2,2,'TileSpacing','compact');
    
    % Create axes
    nexttile
    contourf(MPF.lon,MPF.lat,MPF_pl,linspace(ML_c(1),ML_c(2),12),'LineColor','none'); hold on;
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
    title('Producing fields');
    xlabel('Longitude'); ylabel('Latitude');
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    %
    nexttile
    contourf(MPR.lon,MPR.lat,MPR_pl,linspace(ML_c(1),ML_c(2),12),'LineColor','none'); hold on;
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
    title('Prospect fields'); xlabel('Longitude'); 
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    %
    nexttile
    contourf(MGT.lon,MGT.lat,MGT_pl,linspace(ML_c(1),ML_c(2),12),'LineColor','none'); hold on;
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
    title('Geothermal heat licenses'); xlabel('Longitude'); ylabel('Latitude');
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    %
    nexttile
    contourf(MSF.lon,MSF.lat,MSF_pl,linspace(ML_c(1),ML_c(2),12),'LineColor','none'); hold on;
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
    title('Gas Storage Sites'); 
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    xlabel('Longitude'); xlabel(t,'M_{TOL}');
    cb=colorbar(); cb.Layout.Tile = 'south'; %cb.Label = 'M_{TOL}';
    %ylabel(h, 'Red-Light Magnitude (M_L)');
elseif(strcmpi(FigType,'highres'))
    % Create figures
    n1=10*n+1; n2=10*n+2; n3=10*n+3; n4=10*n+4;

    figure(n1); clf;
    % Create axes
    contourf(MPF.lon,MPF.lat,MPF_pl,linspace(ML_c(1),ML_c(2),35),'LineColor','none'); hold on;
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
    colorbar(); %ylabel(h, 'Red-Light Magnitude (M_L)');
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    %
    figure(n2); clf;
    % Create axes
    contourf(MPR.lon,MPR.lat,MPR_pl,linspace(ML_c(1),ML_c(2),35),'LineColor','none'); hold on;
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
    colorbar(); %ylabel(h, 'Red-Light Magnitude (M_L)');
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    %
    figure(n3); clf;
    % Create axes
    contourf(MGT.lon,MGT.lat,MGT_pl,linspace(ML_c(1),ML_c(2),35),'LineColor','none'); hold on;
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
    colorbar(); %ylabel(h, 'Red-Light Magnitude (M_L)');
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
    %
    figure(n4); clf;
    % Create axes
    contourf(MSF.lon,MSF.lat,MSF_pl,linspace(ML_c(1),ML_c(2),35),'LineColor','none'); hold on;
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
    colorbar(); %ylabel(h, 'Red-Light Magnitude (M_L)');
    colormap(gca,R_colormap('red-light')); caxis(ML_c);
    xlim(XL); ylim(YL);
end

end