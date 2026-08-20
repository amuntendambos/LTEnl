clear;

% Predefine a structure.
R=struct('lat',[],'lon',[],'dep',[],'Zid',[],'Ss',[]);

% Populate the structure with relevant information on each earthquake scenario.
i=1;
R(i).lat=53.345; R(i).lon=6.672; R(i).dep=3.0; R(i).Zid=1; R(i).name='Huizinge'; i=i+1;
%%%
R(i).lat=52.832; R(i).lon=7.038; R(i).dep=2.0; R(i).Zid=2; R(i).name='Roswinkel'; 

% Set the interpolation type.
interp_type='linear';
Np=100000;

% Load in the data structure: S.
load('blanks/TLP_nl.mat');

% Perturb data structure and compute risk curves for a scenario.
for i=1:length(R)
    tic; Ss=runRISKdisag(S,Np,R(i).lat,R(i).lon,R(i).dep,R(i).Zid); toc;
    R(i).Ss=Ss;
    if(strcmpi(Ss.play_flag,'NL'))
        if(strcmpi(Ss.DNmetric_flag,'individual'))
            Nn3_f=0.1;
            Nd1_f=0.01;
            Nd2_f=0.01;
            Pf1_f=1e-5;
        elseif(strcmpi(Ss.DNmetric_flag,'aggregate'))
            Nn3_f=1;
            Nd1_f=1;
            Nd2_f=1;
            Pf1_f=1e-5;
        end
    end
    M=Ss.Mw;

    for k=1:length(Ss.dVAR.dM)
        Md_n=zeros(length(Ss.RISK),1);
        Md_d1=zeros(length(Ss.RISK),1);
        Md_d2=zeros(length(Ss.RISK),1);
        Md_r=zeros(length(Ss.RISK),1);

        for j=1:length(Ss.RISK)
            N_n=Ss.RISK(j).Nn3(k,:);
            N_d1=Ss.RISK(j).Nd1(k,:);
            N_d2=Ss.RISK(j).Nd2(k,:);
            N_r=Ss.RISK(j).Pf1(k,:);

            % Dealing with non-monotonic and non-unique inputs.
            dx=cumsum(ones(size(M)));
            N_n=N_n+dx.*N_n/(100*length(M))+dx*eps;
            N_d1=N_d1+dx.*N_d1/(100*length(M))+dx*eps;
            N_d2=N_d2+dx.*N_d2/(100*length(M))+dx*eps;
            N_r=N_r+dx.*N_r/(100*length(M))+dx*eps;

            Md_n(j)=interp1(N_n,M,Nn3_f,interp_type,'extrap');
            Md_d1(j)=interp1(N_d1,M,Nd1_f,interp_type,'extrap');
            Md_d2(j)=interp1(N_d2,M,Nd2_f,interp_type,'extrap');
            Md_r(j)=interp1(N_r,M,Pf1_f,interp_type,'extrap');

        end

        DIST(k).Md_n = Md_n;
        DIST(k).Md_d1 = Md_d1;
        DIST(k).Md_d2 = Md_d2;
        DIST(k).Md_r = Md_r;
    end

    R(i).DIST = DIST;

end


save('TLEnl_disaggregate.mat','R')

Pn = [2.5 25 75 97.5];

Base_N3(1)=R(1).DIST(1).Md_n;
Base_D1(1)=R(1).DIST(1).Md_d1;
Base_D2(1)=R(1).DIST(1).Md_d2;
Base_R(1)=R(1).DIST(1).Md_r;
for j=1:5
    for kk=1:length(Pn)
        k=(j-1)*length(Pn)+kk+1;
        y_n3(j,kk)=R(1).DIST(k).Md_n;
        y_d1(j,kk)=R(1).DIST(k).Md_d1;
        y_d2(j,kk)=R(1).DIST(k).Md_d2;
        y_r(j,kk)=R(1).DIST(k).Md_r;
    end
end
j=6; jj=8;
for kk=1:length(Pn)
    k=(jj-1)*length(Pn)+kk+1;
    y_n3(j,kk)=R(1).DIST(k).Md_n;
    y_d1(j,kk)=R(1).DIST(k).Md_d1;
    y_d2(j,kk)=R(1).DIST(k).Md_d2;
    y_r(j,kk)=R(1).DIST(k).Md_r;
end
y_n3=sort(y_n3,2);
y_d1=sort(y_d1,2);
y_d2=sort(y_d2,2);
y_r=sort(y_r,2);
for i=1:6
    dy_n3(i,1)=y_n3(i,1);
    dy_d1(i,1)=y_d1(i,1);
    dy_d2(i,1)=y_d2(i,1);
    dy_r(i,1)=y_r(i,1);
    for j=2:length(Pn)
        dy_n3(i,j)=y_n3(i,j)-y_n3(i,j-1);
        dy_d1(i,j)=y_d1(i,j)-y_d1(i,j-1);
        dy_d2(i,j)=y_d2(i,j)-y_d2(i,j-1);
        dy_r(i,j)=y_r(i,j)-y_r(i,j-1);
    end
end

figure;
subplot(2,4,1)
barh(dy_n3,'stacked','BaseValue',Base_N3(1))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([0.9 2.4])
title('Overlast (CDI3)')
subplot(2,4,2)
barh(dy_d1,'stacked','BaseValue',Base_D1(1))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([2.1 3.5])
title('DS1 schade')
subplot(2,4,3)
barh(dy_d2,'stacked','BaseValue',Base_D2(1))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([2.7 4.2])
title('DS2 schade')
subplot(2,4,4)
barh(dy_r,'stacked','BaseValue',Base_R(1))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([3.3 4.1])
title('Kans op overlijden')

clear y_* dy_*

Base_N3(2)=R(2).DIST(1).Md_n;
Base_D1(2)=R(2).DIST(1).Md_d1;
Base_D2(2)=R(2).DIST(1).Md_d2;
Base_R(2)=R(2).DIST(1).Md_r;
for j=1:5
    for kk=1:length(Pn)
        k=(j-1)*length(Pn)+kk+1;
        y_n3(j,kk)=R(2).DIST(k).Md_n;
        y_d1(j,kk)=R(2).DIST(k).Md_d1;
        y_d2(j,kk)=R(2).DIST(k).Md_d2;
        y_r(j,kk)=R(2).DIST(k).Md_r;
    end
end
j=6; jj=8;
for kk=1:length(Pn)
    k=(jj-1)*length(Pn)+kk+1;
    y_n3(j,kk)=R(2).DIST(k).Md_n;
    y_d1(j,kk)=R(2).DIST(k).Md_d1;
    y_d2(j,kk)=R(2).DIST(k).Md_d2;
    y_r(j,kk)=R(2).DIST(k).Md_r;
end
y_n3=sort(y_n3,2);
y_d1=sort(y_d1,2);
y_d2=sort(y_d2,2);
y_r=sort(y_r,2);
for i=1:6
    dy_n3(i,1)=y_n3(i,1);
    dy_d1(i,1)=y_d1(i,1);
    dy_d2(i,1)=y_d2(i,1);
    dy_r(i,1)=y_r(i,1);
    for j=2:length(Pn)
        dy_n3(i,j)=y_n3(i,j)-y_n3(i,j-1);
        dy_d1(i,j)=y_d1(i,j)-y_d1(i,j-1);
        dy_d2(i,j)=y_d2(i,j)-y_d2(i,j-1);
        dy_r(i,j)=y_r(i,j)-y_r(i,j-1);
    end
end

subplot(2,4,5)
barh(dy_n3,'stacked','BaseValue',Base_N3(2))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([0.9 2.4])
title('Overlast (CDI3)')
subplot(2,4,6)
barh(dy_d1,'stacked','BaseValue',Base_D1(2))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([2.1 3.5])
title('DS1 schade')
subplot(2,4,7)
barh(dy_d2,'stacked','BaseValue',Base_D2(2))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([2.7 4.2])
title('DS2 schade')
subplot(2,4,8)
barh(dy_r,'stacked','BaseValue',Base_R(2))
yticklabels({'dGM','dN1','dN2','\Psi_{0}','dLPR','dZ'})
xlim([3.3 4.1])
title('Kans op overlijden')
