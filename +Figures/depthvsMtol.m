function depthvsMtol(SPF,R_PF,SPR,R_PR,SGT,R_GT,SSF,R_SF,n)
% Function to show the dependence of Mtol on depth and distance to shore
XL = [1 5];
YL = [1 5];

Z = [0 0 0; 0.5 0.5 0.5];

% Extract the magnitudes, depth and presence of Zechstein
for i=1:length(SPF)
    dep_PF(i)=-SPF(i).DEPTH;
    PFM_d1(i)=SPF(i).M_d1;
    PFM_d2(i)=SPF(i).M_d2;
    PFM_Pf(i)=SPF(i).M_Pf;
    if (strcmpi(SPF(i).STRAT_UN,'ZE')) || (strcmpi(SPF(i).STRAT_UN,'RO')) || ...
            (strcmpi(SPF(i).STRAT_UN,'DC')) || (strcmpi(SPF(i).STRAT_UN,'DI'))
        PF_Ze(i)=1;
    else
        PF_Ze(i)=0;
    end
end
for i=1:length(SPR)
    dep_PR(i)=-SPR(i).DEPTH;
    PRM_d1(i)=SPR(i).M_d1;
    PRM_d2(i)=SPR(i).M_d2;
    PRM_Pf(i)=SPR(i).M_Pf;
    if (strcmpi(SPR(i).STRAT_UN,'ZE')) || (strcmpi(SPR(i).STRAT_UN,'RO')) || ...
            (strcmpi(SPR(i).STRAT_UN,'DC')) || (strcmpi(SPR(i).STRAT_UN,'DI'))
        PR_Ze(i)=1;
    else
        PR_Ze(i)=0;
    end
end
for i=1:length(SGT)
    dep_GT(i)=-SGT(i).DEPTH;
    GTM_d1(i)=SGT(i).M_d1;
    GTM_d2(i)=SGT(i).M_d2;
    GTM_Pf(i)=SGT(i).M_Pf;
    if (strcmpi(SGT(i).STRAT_UN,'ZE')) || (strcmpi(SGT(i).STRAT_UN,'RO')) || ...
            (strcmpi(SGT(i).STRAT_UN,'DC')) || (strcmpi(SGT(i).STRAT_UN,'DI'))
        GT_Ze(i)=1;
    else
        GT_Ze(i)=0;
    end
end
for i=1:length(SSF)
    dep_SF(i)=-SSF(i).DEPTH;
    SFM_d1(i)=SSF(i).M_d1;
    SFM_d2(i)=SSF(i).M_d2;
    SFM_Pf(i)=SSF(i).M_Pf;
    if (strcmpi(SSF(i).STRAT_UN,'ZE')) || (strcmpi(SSF(i).STRAT_UN,'RO')) || ...
            (strcmpi(SSF(i).STRAT_UN,'DC')) || (strcmpi(SSF(i).STRAT_UN,'DI'))
        SF_Ze(i)=1;
    else
        SF_Ze(i)=0;
    end
end
%
% Plot the figure:
% D1-damage
figure(n),clf;
subplot(3,1,1), hold on
scatter(dep_PF(R_PF<=2),PFM_d1(R_PF<=2),25,PF_Ze(R_PF<=2),"Marker",'^')
scatter(dep_PR(R_PR<=2),PRM_d1(R_PR<=2),25,PR_Ze(R_PR<=2),"Marker",'v')
scatter(dep_GT(R_GT<=2),GTM_d1(R_GT<=2),25,GT_Ze(R_GT<=2),"Marker",'s')
scatter(dep_SF(R_SF<=2),SFM_d1(R_SF<=2),25,SF_Ze(R_SF<=2),"Marker",'d')
h2=scatter(dep_PF(R_PF>2),PFM_d1(R_PF>2),25,PF_Ze(R_PF>2),'Filled','Marker','^');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_PR(R_PR>2),PRM_d1(R_PR>2),25,PR_Ze(R_PR>2),'Filled','Marker','v');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_GT(R_GT>2),GTM_d1(R_GT>2),25,GT_Ze(R_GT>2),'Filled','Marker','s');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_SF(R_SF>2),SFM_d1(R_SF>2),25,SF_Ze(R_SF>2),'Filled','Marker','d');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
xlabel('Depth (km)'); ylabel('M_{TOL}(DS1)');
legend('PF','PP', 'GT', 'SF','Location','southeast')
grid on; box on; axis equal
text(0.3,5.15,'(a)','FontSize',12,'FontWeight','bold')
xlim(XL); ylim(YL);
colormap(Z)
%
% D2-damage
subplot(3,1,2), hold on
scatter(dep_PF(R_PF<=2),PFM_d2(R_PF<=2),25,PF_Ze(R_PF<=2),"Marker",'^')
scatter(dep_PR(R_PR<=2),PRM_d2(R_PR<=2),25,PR_Ze(R_PR<=2),"Marker",'v')
scatter(dep_GT(R_GT<=2),GTM_d2(R_GT<=2),25,GT_Ze(R_GT<=2),"Marker",'s')
scatter(dep_SF(R_SF<=2),SFM_d2(R_SF<=2),25,SF_Ze(R_SF<=2),"Marker",'d')
h2=scatter(dep_PF(R_PF>2),PFM_d2(R_PF>2),25,PF_Ze(R_PF>2),'Filled','Marker','^');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_PR(R_PR>2),PRM_d2(R_PR>2),25,PR_Ze(R_PR>2),'Filled','Marker','v');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_GT(R_GT>2),GTM_d2(R_GT>2),25,GT_Ze(R_GT>2),'Filled','Marker','s');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_SF(R_SF>2),SFM_d2(R_SF>2),25,SF_Ze(R_SF>2),'Filled','Marker','d');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
xlabel('Depth (km)'); ylabel('M_{TOL}(DS2)');
legend('PF','PP', 'GT', 'SF','Location','southeast')
grid on; box on; axis equal
text(0.3,5.15,'(b)','FontSize',12,'FontWeight','bold')
xlim(XL); ylim(YL);
colormap(Z)
%
subplot(3,1,3), hold on
scatter(dep_PF(R_PF<=2),PFM_Pf(R_PF<=2),25,PF_Ze(R_PF<=2),"Marker",'^')
scatter(dep_PR(R_PR<=2),PRM_Pf(R_PR<=2),25,PR_Ze(R_PR<=2),"Marker",'v')
scatter(dep_GT(R_GT<=2),GTM_Pf(R_GT<=2),25,GT_Ze(R_GT<=2),"Marker",'s')
scatter(dep_SF(R_SF<=2),SFM_Pf(R_SF<=2),25,SF_Ze(R_SF<=2),"Marker",'d')
h2=scatter(dep_PF(R_PF>2),PFM_Pf(R_PF>2),25,PF_Ze(R_PF>2),'Filled','Marker','^');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_PR(R_PR>2),PRM_Pf(R_PR>2),25,PR_Ze(R_PR>2),'Filled','Marker','v');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_GT(R_GT>2),GTM_Pf(R_GT>2),25,GT_Ze(R_GT>2),'Filled','Marker','s');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
h2=scatter(dep_SF(R_SF>2),SFM_Pf(R_SF>2),25,SF_Ze(R_SF>2),'Filled','Marker','d');
set(get(get(h2,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
xlabel('Depth (km)'); ylabel('M_{TOL}(FC)');
legend('PF','PP', 'GT', 'SF','Location','southeast')
grid on; box on; axis equal
text(0.3,5.15,'(c)','FontSize',12,'FontWeight','bold')
xlim(XL); ylim(YL);
colormap(Z)

% Plot the Supplement figure MTOL versus hypocentral distance:
HD_PF=sqrt(dep_PF.*dep_PF+R_PF'.*R_PF');
HD_PR=sqrt(dep_PR.*dep_PR+R_PR'.*R_PR');
HD_GT=sqrt(dep_GT.*dep_GT+R_GT'.*R_GT');
HD_SF=sqrt(dep_SF.*dep_SF+R_SF'.*R_SF');
% D1-damage
figure(n+10),clf;
subplot(3,1,1), hold on
scatter(HD_PF,PFM_d1,25,PF_Ze,"Marker",'^')
scatter(HD_PR,PRM_d1,25,PR_Ze,"Marker",'v')
scatter(HD_GT,GTM_d1,25,GT_Ze,"Marker",'s')
scatter(HD_SF,SFM_d1,25,SF_Ze,"Marker",'d')
xlabel('Hypocentral distance (km)'); ylabel('M_{TOL}(DS1)');
legend('PF','PP', 'GT', 'SF','Location','southeast')
grid on; box on; axis equal
text(0.25,5.15,'(a)','FontSize',12,'FontWeight','bold')
xlim(XL); ylim(YL);
colormap(Z)
%
% D2-damage
subplot(3,1,2), hold on
scatter(HD_PF,PFM_d2,25,PF_Ze,"Marker",'^')
scatter(HD_PR,PRM_d2,25,PR_Ze,"Marker",'v')
scatter(HD_GT,GTM_d2,25,GT_Ze,"Marker",'s')
scatter(HD_SF,SFM_d2,25,SF_Ze,"Marker",'d')
xlabel('Hypocentral distance (km)'); ylabel('M_{TOL}(DS2)');
legend('PF','PP', 'GT', 'SF','Location','southeast')
grid on; box on; axis equal
text(0.25,5.15,'(b)','FontSize',12,'FontWeight','bold')
xlim(XL); ylim(YL);
colormap(Z)
%
subplot(3,1,3), hold on
scatter(HD_PF,PFM_Pf,25,PF_Ze,"Marker",'^')
scatter(HD_PR,PRM_Pf,25,PR_Ze,"Marker",'v')
scatter(HD_GT,GTM_Pf,25,GT_Ze,"Marker",'s')
scatter(HD_SF,SFM_Pf,25,SF_Ze,"Marker",'d')
xlabel('Hypocentral distance (km)'); ylabel('M_{TOL}(FC)');
legend('PF','PP', 'GT', 'SF','Location','southeast')
grid on; box on; axis equal
text(0.25,5.15,'(c)','FontSize',12,'FontWeight','bold')
xlim(XL); ylim(YL);
colormap(Z)
end