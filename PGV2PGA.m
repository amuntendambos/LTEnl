function PGA=PGV2PGA(PGV)
  % Computes the PGA given the PGV inputs.  Units for input are PGV (cm/s) and PGA (cm/s²).
  % Based on emprical regression for data from the Netherlands.
  % Code is vectorized.
  % 
  % Written by Ryan Schultz.
  
  % Conversion of PGV into PGA.
  PGA=0.9788*log10(PGV)+1.5519; % Linear regression.
  %PGA=1.3060*log10(PGV)+1.6250; % Orthogonal regression.
  PGA=10.^PGA;
  
return
