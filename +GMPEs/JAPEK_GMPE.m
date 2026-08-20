function [PGM,phi,tau] = JAPEK_GMPE(R,M,depth,Vs30,dE,GM_flag,dl,combi,ZE)
% With this function ground motions are modeled (peak ground velocity or
% peak ground acceleration) using an empirical GMPE for upper-crustal
% seismicity in the Netherlands. The GMPE has been derived using induced
% events. Only recordings on unconsolidated sediments (with a thickness of
% at least 200 m) were used.
% Four model versions exist. The first two models are for motions at the
% Earth's surface and for motions at 200 m depth, respectively. The models
% are based on 45,000 recorded motions. The third and fourth models have
% been obtained by mapping the second model to the surface (with Vs30=500
% m/s) and to reference rock condition (with Vs30=800 m/s).
% The empirical model at the surface is written as a scaled version of the
% one at depth, but with an aditional term that takes into account that
% there is additional distance-dependent attenuation in the top 200 of the
% soft sediments. The size of this term is controlled by parameters s1 and
% d7.
% An extra attenuation is implemented over the first few kilometers
% hypocentral distance when the source is below a high-velocity layer (e.g.
% salt) as controlled by the ZE input parameter.
% 
% USAGE: [PGM,phi,tau] = JAPEK_GMPE(R,depth,M,dovel,dl,combi,ZE)
% 
% INPUT:
% R         vector with epicentral distances [km]
% depth     depth of the hypocenter in km
% M         event local magnitude. For the study region, local magnitude is 
%           equal to moment magnitude for M>2. Otherwise, use the 
%           conversion relation from Dost et al. (2018) 
% GM_flag   if equals either 'PGV' or 'PGA'
% dl        Model variant. The models defined are for 
%           dl=0: for motions at the Earth's surface 
%               (Vs30=200 m/s, rho=1700 kg/m^3)
%           dl=200: for motions at 200 m depth 
%               (Vs=500 m/s, rho=2000 kg/m^3)
%           dl=500: previous model mapped to the surface
%               (Vs30=500 m/s, rho=2000 kg/m^3)
%           dl=800: previous model mapped to reference-rock conditions 
%               (Vs30=800 m/s, rho=2200 kg/m^3)
% combi:    if 1: geometric mean  
%              2: largest of the two
%              3: max rotated, resultant or Pythagoras
%           Models have been derived in max rotated. For other flavors of
%           PGM, conversion factors from Ruigrok and Dost (2020) are used
% ZE:       if 1: with Zechstein attenuation term (type Groningen)
%              2: no Zechstein attenuation term (type Roswinkel)           
%           Default is implementing the Zechstein term.
% 
% OUTPUT:
% PGM:      PGM values which are either PGV [cm/s] or PGA [cm/s^2] 
%           as function of R (or in fact Rstar)
% phi:      within-event uncertainty expressed in ln(PGM)
% tau:      between-event uncertainty expressed in ln(PGM)
%
% AUTHOR:
% elmer.ruigrok@knmi.nl, January 2025
% Aug. 2025: added dl=800 model for reference rock
% Modified Sept 2025 by Ryan: Vectorized the code, added vs30 correction term, added intra-event variability handling.

if nargin<7
    ZE=1;
end

e1=-1.7; 
e2=0.6720; 
if strcmpi(GM_flag,'PGV') % for PGV
    if dl==200
        c1=-2.0569;
    elseif dl==500
        c1=-2.0569+log(2); % factor 2 is FS effect. 
    elseif dl==800
        c1=-2.0569+log(2*0.72); % factor 0.72 is deamplification going from Vs=500 sediment to 800 m/s rock
    elseif dl==0
        c1=-0.6620;
    end
    c2=2.2813;
    g1=-2.94;
    g2=-1.29;
    d1=7.2;
    d2=13.1;
    g3=-1.88;
    d3=38;
    g4=-3.1;
    d4=54.5;
    g5=0.15;
    d5=86;
    g6=-3.0;
    % parameter and distance range for extra attenuation in salt setting
    d0=3.7;
    z1=1.22;  
    % DDS term
    d7=12;
    s1d=0.1221;
    % vs30 term
    s2v=0; %-0.4136;
elseif strcmpi(GM_flag,'PGA') % for PGA
    if dl==200
        c1=4.0471;
    elseif dl==500
        c1=4.0471+log(2); 
    elseif dl==800  
        c1=4.0471+log(2*0.72);    
    elseif dl==0
        c1=5.2938; 
    end
    c2=2.1381;
    g1=-3.95;
    d1=5.9;
    g2=-2.0;
    d2=13.1;
    g3=-2.33;
    d3=38;
    g4=-3.48;
    d4=52.5;
    g5=0.3;
    d5=83; 
    g6=-3.0;
    % parameter and distance range for extra attenuation in salt setting
    d0=3.9;
    z1=2.87;
    % DDS term
    d7=18;
    s1d=0.2480; 
    % vs30 term
    s2v=0;%0.6942;
end

% variability has been computed for the PGMrot database
if strcmpi(GM_flag,'PGV')
    if dl==200
        phi=0.4081;
        tau=0.1842;
    elseif dl==0
        phi=0.4548;
        tau=0.2026;
        sig=0.4979;
    end
elseif strcmpi(GM_flag,'PGA')
    if dl==200
        phi=0.4119;
        tau=0.2516;
    elseif dl==0
        phi=0.5331;
        tau=0.2731;
        sig=0.5990;
    end
end

% Distance attenuation.
Rstar=sqrt(R.^2 + depth.^2 + (exp(e1 + e2.*M)).^2);
gR=g1*log(d1) + g2*log(d2/d1) + g3*log(d3/d2) + g4*log(d4/d3) + g5*log(d5/d4) + g6*log(Rstar/d5);
I=Rstar<=d5; gR(I)=g1*log(d1) + g2*log(d2/d1) + g3*log(d3/d2) + g4*log(d4/d3) + g5*log(Rstar(I)/d4);
I=Rstar<=d4; gR(I)=g1*log(d1) + g2*log(d2/d1) + g3*log(d3/d2) + g4*log(Rstar(I)/d3);
I=Rstar<=d3; gR(I)=g1*log(d1) + g2*log(d2/d1) + g3*log(Rstar(I)/d2);
I=Rstar<=d2; gR(I)=g1*log(d1) + g2*log(Rstar(I)/d1);
I=Rstar<=d1; gR(I)=g1*log(Rstar(I));
I=Rstar<=d0 & ZE==1; gR(I)=gR(I)+z1*log(Rstar(I)/d0);

% Site effects.
I=dl==0 & Rstar<=d7; gR(I)=gR(I)+s1d*log(Rstar(I)/d7);
gR=gR+s2v*log(Vs30/200);

% Total ground motion.
PGM=exp(c1 + c2.*M + gR + sig.*dE)/10;

% conversion to PGVmax or PGVgeo if needed
%%%% Using 2020 Ruigrok and Dost conversion factors. Have not been computed
%%%% anew again. Would need to be derived for PGA as well ...
if combi==1
    PGM=PGM*0.6074;
elseif combi==2
    PGM=PGM*0.9218;
end



