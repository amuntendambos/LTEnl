function PSA=PGA2PSA(PGA,M,R,vs30,T)
  % Computes the PSA given the PGA & inputs.  Units for input are M (Mw), 
  % R (km), vs30 (m/s), T (s), and PSA (PGA).  Code is vectorized.
  %
  % Reference:
  % Graizer, V., & Kalkan, E. (2009). Prediction of spectral acceleration response ordinates based on PGA attenuation. Earthquake Spectra, 25(1), 39-69, doi: 10.1193/1.3043904.
  %
  % Written by Ryan Schultz.
  
  % Coefficients (Figure 9).
  m1=-0.0012;
  m2=-0.4087;
  m3=0.0006;
  m4=3.63;
  a1=0.017;
  a2=1.27;
  a3=0.0001;
  Dsp=0.75;
  t1=0.0022;
  t2=0.63;
  t3=-0.0005;
  t4=-2.1;
  s1=0.001;
  s2=0.077;
  s3=0.3251;
  zeta=1.5;
  %SIGlnsa=
  
  % Compute sub-functions (Figure 9).
  mu=m1*R+m2*M+m3*vs30+m4; % Eqn 7.
  I=(a1*M+a2).*exp(a3*R); % Eqn 6.
  S=s1*R-(s2*M+s3); % Eqn 9.
  Tspeco=t1*R+t2*M+t3*vs30+t4; % Eqn 8.
  
  % Compute functions (Figure 9).
  F1=I.*exp(-((log(T)+mu)./S).^2/2); % Eqn 2.
  F2=1./sqrt((1-(T./Tspeco).^zeta).^2+(4*Dsp.^2).*(T/Tspeco).^zeta); % Eqn 3.
  
  % Compute normalized spectral frequency (Figure 9).
  SAnorm=F1+F2; % Eqn 4.
  
  % Compute the spectral frequency (Figure 10).
  PSA=log(PGA)+log(SAnorm); % Eqn 10.
  PSA=exp(PSA);
  
return