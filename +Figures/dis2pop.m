function [R_min] = dis2pop(S)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Get lengths of map edges.
  Nx=length(S.MAP.lonG);
  Ny=length(S.MAP.latG);
    
  % Get lists of all of the lat/long coords of interest.
  latG=repmat(S.MAP.latG',1,Nx); latG=latG(:);
  lonG=repmat(S.MAP.lonG,Ny,1); lonG=lonG(:);
  latE=[S.RISK.lat];
  lonE=[S.RISK.lon];
  pop=S.MAP.POP(:);
  Ne=length(latE);
  Nm=length(S.ML);

  pop=repmat(pop,1,Nm);
  rgd=zeros(Ne,1);
  R_min=zeros(max(S.MAP.Bid),1);

  for j=1:Ne
      % Get distances and reshape into matrix (km).
      Re=Geoid_Distance(latE(j),lonE(j),latG,lonG,'elliptical')*6371*pi()/180; % [Ng 1]
      Re=repmat(Re,1,Nm); % [Ng Nm]
             
      % Truncate to the closest grid point that's populated.
      Ii=find((pop(:,1)>0));
      [~,Im]=min(Re(Ii,1));
      Ii=Ii(Im);
      rgd(j) = Re(Ii,1);
  end

  for kk=1:max(S.MAP.Bid)
      inb = inpolygon(lonE,latE,S.MAP.lonB(S.MAP.Bid==kk)',S.MAP.latB(S.MAP.Bid==kk)');
      R_min(kk) = min(rgd(inb==1));
  end
end