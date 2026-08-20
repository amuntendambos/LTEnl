function plotScenarios(R,S,n)
% Simple function to plot the event scenario DS1 damage distributions
dam_rep1=[1800 204 141 275];
dam_rep2=[1800 6100 7389 10001 3300];
Np=1000;

figure(n); clf;
ax1 = subplot(211);
newcolor = orderedcolors("gem");
colororder(ax1,"gem");
for i=1:length(dam_rep1)
    histogram(log10(R(i).Ss.RISK.Nd1),round(2*sqrt(Np)),'DisplayName',R(i).name); hold on;
end
for i=1:length(dam_rep1)
    h1=plot(log10(dam_rep1(i))*[1 1],ylim,'--');
    h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
    h1.Color=newcolor(i,:);
end
xlabel('log_{10} Damage Impacts (DS1)'); ylabel('Counts');
text(-2.5,101,'(a)',Fontsize=11,FontWeight='bold')
lgd = legend();
lgd.NumColumns = 2;
lgd.Location = 'northoutside';
%
ax2 = subplot(212);
colororder(ax1,"gem")
histogram(log10(R(1).Ss.RISK.Nd1),round(2*sqrt(Np)),'DisplayName',R(1).name); hold on;
for i=length(dam_rep1)+1:length(R)
    histogram(log10(R(i).Ss.RISK.Nd1),round(2*sqrt(Np)),'DisplayName',R(i).name); hold on;
end
for i=1:length(dam_rep2)
    h1=plot(log10(dam_rep2(i))*[1 1],ylim,'--');
    h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
    h1.Color=newcolor(i,:);
end
colororder(ax2,"gem")
xlabel('log_{10} Damage Impacts (DS1)'); ylabel('Counts');
text(-3.65,101,'(b)',Fontsize=11,FontWeight='bold')
lgd = legend();
lgd.NumColumns = 3;
lgd.Location = 'northoutside';

% Figure S8
n=n*10+1;
Nv=length(S.dVAR.dZ);
figure(n); clf;
hold on
h1=histogram(S.dVAR.dGM, round(sqrt(Nv)) );
h1.Annotation.LegendInformation.IconDisplayStyle = 'off';
for i=1:length(R)
    if i<=length(newcolor)
        h2=plot(R(i).dGM*[1 1],ylim,'--','DisplayName',R(i).name);
        h2.Color=newcolor(i,:);
    else
        h2=plot(R(i).dGM*[1 1],ylim,':','DisplayName',R(i).name);
        h2.Color=[0.1 0.1 0.1];
    end
end
xlabel('GMPE Perturbation, dGM (-)'); ylabel('Count');
lgd = legend();
lgd.NumColumns = 3;
lgd.Location = 'northoutside';
box on

end