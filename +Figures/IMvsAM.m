function IMvsAM(SPF,R_PF,SPR,R_PR,SGT,R_GT,SSF,R_SF,...
    ASPF,ASPR,ASGT,ASSF,n)
% Function to show the Mtol(IM) versus Mtol(AM) 
XL = [1 5];
YL = [1 5];
CL = [0 7];
Z=colormap(cool);

% Extract the magnitudes and depth
for i=1:length(SPF)
    dep_PF(i)=-SPF(i).DEPTH;
    PFM_d1(i)=SPF(i).M_d1;
    PFM_d2(i)=SPF(i).M_d2;
    APFM_d1(i)=ASPF(i).M_d1;
    APFM_d2(i)=ASPF(i).M_d2;
end
for i=1:length(SPR)
    dep_PR(i)=-SPR(i).DEPTH;
    PRM_d1(i)=SPR(i).M_d1;
    PRM_d2(i)=SPR(i).M_d2;
    PRM_Pf(i)=SPR(i).M_Pf;
    APRM_d1(i)=ASPR(i).M_d1;
    APRM_d2(i)=ASPR(i).M_d2;
    APRM_Pf(i)=ASPR(i).M_Pf;
end
for i=1:length(SGT)
    dep_GT(i)=-SGT(i).DEPTH;
    GTM_d1(i)=SGT(i).M_d1;
    GTM_d2(i)=SGT(i).M_d2;
    AGTM_d1(i)=ASGT(i).M_d1;
    AGTM_d2(i)=ASGT(i).M_d2;
end
for i=1:length(SSF)
    dep_SF(i)=-SSF(i).DEPTH;
    SFM_d1(i)=SSF(i).M_d1;
    SFM_d2(i)=SSF(i).M_d2;
    ASFM_d1(i)=ASSF(i).M_d1;
    ASFM_d2(i)=ASSF(i).M_d2;
end
% 
% Compute hypocentral distances:
HD_PF=sqrt(dep_PF.*dep_PF+R_PF'.*R_PF');
HD_PR=sqrt(dep_PR.*dep_PR+R_PR'.*R_PR');
HD_GT=sqrt(dep_GT.*dep_GT+R_GT'.*R_GT');
HD_SF=sqrt(dep_SF.*dep_SF+R_SF'.*R_SF');
%
figure(n),clf;
tiledlayout(1,2)
nexttile; hold on
scatter(APFM_d1,PFM_d1,35,HD_PF,"Marker",'^')
scatter(APRM_d1,PRM_d1,35,HD_PR,"Marker",'v')
scatter(AGTM_d1,GTM_d1,35,HD_GT,"Marker",'s')
scatter(ASFM_d1,SFM_d1,35,HD_SF,"Marker",'d')
h = plot([0 5],[0 5],'-k')';
set(get(get(h,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
ylabel('M_{TOL}(DS1)','FontSize',12); xlabel('M_{TOL}[N(DS1)≥1]','FontSize',12);
legend('PF','PP', 'GT', 'SF','Location','southeast','FontSize',12)
grid on; box on; axis equal
text(0.25,5.15,'(a)','FontSize',14,'FontWeight','bold')
xlim(XL); ylim(YL); clim(CL); hold off
colormap(Z)
%
nexttile; hold on
scatter(APFM_d2,PFM_d2,35,HD_PF,"Marker",'^')
scatter(APRM_d2,PRM_d2,35,HD_PR,"Marker",'v')
scatter(AGTM_d2,GTM_d2,35,HD_GT,"Marker",'s')
scatter(ASFM_d2,SFM_d2,35,HD_SF,"Marker",'d')
h = plot([0 5],[0 5],'-k')';
set(get(get(h,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off');
ylabel('M_{TOL}(DS2)','FontSize',12); xlabel('M_{TOL}[N(DS2)≥1]','FontSize',12);
legend('PF','PP', 'GT', 'SF','Location','southeast','FontSize',12)
grid on; box on; axis equal
text(0.25,5.15,'(b)','FontSize',14,'FontWeight','bold')
xlim(XL); ylim(YL); clim(CL);
colormap(Z)
cb = colorbar; cb.Layout.Tile = 'east';
cb.Label.String='Hypocentral distance (km)';
cb.FontSize=16;
end