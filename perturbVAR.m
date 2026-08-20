function S=perturbVAR(S,N,rand_flag,varargin)
  % Simple function that creates a list of perturbed variables.
  
  % Define the b-value statistics.
  if(strcmpi(S.play_flag,'NL'))
      bm=0.95;
      db=0.09;
      Rs=0.9; 
  end
  
  % Flag for random or average behaviour.
  if(strcmpi(rand_flag,'random'))
      % Create a vector of perturbation values.
      b=bm*ones([1 N]);
      dM=zeros([1 N]);
      dGM=normrnd(0.0,1.0,[1 N]);
      dN1=normrnd(0.0,1.0,[1 N]);
      dN2=normrnd(0.0,1.0,[1 N]);
      Po=abs(normrnd(0.0,0.15,[1 N]));
      dLPR=normrnd(0.0,1.0,[1 N]);
      dSA=lognrnd(0.0,0.05,[1 N]);
      dPOP=abs(normrnd(mean(S.MAP.POP(:)), sqrt(mean(S.MAP.POP(:))), [1 N])/mean(S.MAP.POP(:)));
      dZ=pearsrnd(0+0.05,0.05,0.8,4,[1 N]);
  elseif(strcmpi(rand_flag,'none'))
      % Create a vector of perturbation values.
      b=bm*ones([1 N]);
      dM=zeros([1 N]);
      dGM=zeros([1 N]);
      dN1=zeros([1 N]);
      dN2=zeros([1 N]);
      Po=zeros([1 N]);
      dLPR=zeros([1 N]);
      dSA=ones([1 N]);
      dPOP=ones([1 N]);
      dZ=zeros([1 N]);
  elseif(strcmpi(rand_flag,'scenario'))
      % Create a vector of perturbation values.
      gm=varargin{1};

      b=bm*ones([1 N]);
      dM=normrnd(0.0,0.2,[1 N]);
      dGM=normrnd(gm,0.1,[1 N]);
      dN1=normrnd(0.0,1.0,[1 N]);
      dN2=normrnd(0.0,1.0,[1 N]);
      Po=abs(normrnd(0.0,0.15,[1 N]));
      dLPR=normrnd(0.0,1.0,[1 N]);
      dSA=lognrnd(0,0.01,[1 N]);
      dPOP=ones([1 N]);
      dZ=pearsrnd(0+0.05,0.05,0.8,4,[1 N]);
  elseif(strcmpi(rand_flag,'disaggregate'))
      Pn = [2.5 25 75 97.5];
      dGM=normrnd(0.0,1.0,[1 N]);
      dN1=normrnd(0.0,1.0,[1 N]);
      dN2=normrnd(0.0,1.0,[1 N]);
      Po=abs(normrnd(0.0,0.15,[1 N]));
      dLPR=normrnd(0.0,1.0,[1 N]);
      dSA=lognrnd(0.0,0.05,[1 N]);
      dPOP=abs(normrnd(mean(S.MAP.POP(:)), sqrt(mean(S.MAP.POP(:))), [1 N])/mean(S.MAP.POP(:)));
      dZ=pearsrnd(0+0.05,0.05,0.8,4,[1 N]);

      dGMm=0.0; dN1m=0.0; dN2m=0.0; Pom=mean(Po); 
      dLPRm=0.0; dSAm=mean(dSA); dPOPm=mean(dPOP);dZm=mean(dZ);

      PdGM=prctile(dGM,Pn);
      PdN1=prctile(dN1,Pn);
      PdN2=prctile(dN2,Pn);
      PPo=prctile(Po,Pn);
      PdLPR=prctile(dLPR,Pn);
      PdSA=prctile(dSA,Pn);
      PdPOP=prctile(dPOP,Pn);
      PdZ=prctile(dZ,Pn);

      clear dGM dN1 dN2 Po dLPR dSA dPOP dZ
      dGM = [dGMm PdGM dGMm*ones(1,length(Pn)*7)];
      dN1 = [dN1m dN1m*ones(1,length(Pn)) PdN1 dN1m*ones(1,length(Pn)*6)];
      dN2 = [dN2m dN2m*ones(1,length(Pn)*2) PdN2 dN2m*ones(1,length(Pn)*5)];
      Po = [Pom Pom*ones(1,length(Pn)*3) PPo Pom*ones(1,length(Pn)*4)];
      dLPR = [dLPRm dLPRm*ones(1,length(Pn)*4) PdLPR dLPRm*ones(1,length(Pn)*3)];
      dSA = [dSAm dSAm*ones(1,length(Pn)*5) PdSA dSAm*ones(1,length(Pn)*2)];
      dPOP = [dPOPm dPOPm*ones(1,length(Pn)*6) PdPOP dPOPm*ones(1,length(Pn))];
      dZ = [dZm dZm*ones(1,length(Pn)*7) PdZ];
      b=bm*ones(1,length(dGM));
      dM=zeros(1,length(dGM));

  end
  
  % Append new values to the structure.
  S.dVAR.b=[S.dVAR.b,b];
  S.dVAR.dM=[S.dVAR.dM,dM];
  S.dVAR.dGM=[S.dVAR.dGM,dGM];
  S.dVAR.dN1=[S.dVAR.dN1,dN1];
  S.dVAR.dN2=[S.dVAR.dN2,dN2];
  S.dVAR.Po=[S.dVAR.Po,Po];
  S.dVAR.dLPR=[S.dVAR.dLPR,dLPR];
  S.dVAR.dSA=[S.dVAR.dSA,dSA];
  S.dVAR.dPOP=[S.dVAR.dPOP,dPOP];
  S.dVAR.dZ=[S.dVAR.dZ,dZ];
  
  % Flag that the risk routine needs to be (re)run now.
  S.dVAR.UPDATEflag='yes';
  
return