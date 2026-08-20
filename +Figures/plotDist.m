function plotDist(S,n)
% function to plot the prior parameter distributions

Nv=length(S.dVAR.dZ);

% Create figure
figure1=figure(n); clf;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
subplot(2,3,1); histogram(S.dVAR.dZ, round(sqrt(Nv)) );
xlabel('Depth Perturbation, dZ (km)'); ylabel('Count');
subplot(2,3,2); histogram(S.dVAR.dGM, round(sqrt(Nv)) );
xlabel('GMPE Perturbation, dGM (-)'); ylabel('Count');
subplot(2,3,3); histogram(S.dVAR.dN1, round(sqrt(Nv)) );
xlabel('Nuisance Perturbation, dN1 (-)'); ylabel('Count');
subplot(2,3,4); histogram(S.dVAR.dN2, round(sqrt(Nv)) );
xlabel('Nuisance Perturbation, dN2 (-)'); ylabel('Count');
subplot(2,3,5); histogram(S.dVAR.Po, round(sqrt(Nv)) );
xlabel('Initial Damage State, \Psi_o (-)'); ylabel('Count');
subplot(2,3,6); histogram(S.dVAR.dLPR, round(sqrt(Nv)) );
xlabel('Vulnerability Perturbation, dV (-)'); ylabel('Count');
end