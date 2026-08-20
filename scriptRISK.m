clear;

% Define input parameters.
Nv=1;
Nt=1000;
rand_flag='random';
DNmetric_flag = 'individual'; % flag to opt between aggregate and individual 
                              % risk metrics for damage & nuissance

% Load in data, to continue iterations.
load('blanks/LTEnl_blank.mat','S')
% Choose output file as input to restart from last iteration
% load('TLEnl_temp.mat','S');

S.DNmetric_flag = DNmetric_flag;

if(strcmpi(S.DNmetric_flag,'aggregate'))
    % Iteratively add impact curves.
    while(length(S.dVAR.dM)<Nt)
        
        % Prompt for percent done.
        disp(['Percentage complete: ',num2str(100*length(S.dVAR.dM)/Nt),'%'])
        
        % Create a perturbed data structure.
        S=perturbVAR(S,Nv,rand_flag);
        
        % Compute risk curves for each spatial pixel and perturbed value.
        tic; S=runRISKagg(S,rand_flag); toc;
    
        % Save data structure.
        save('TLEnl_temp.mat','S');
    end
elseif(strcmpi(S.DNmetric_flag,'individual'))
    % Iteratively add impact curves.
    while(length(S.dVAR.dM)<Nt)
        
        % Prompt for percent done.
        disp(['Percentage complete: ',num2str(100*length(S.dVAR.dM)/Nt),'%'])
        
        % Create a perturbed data structure.
        S=perturbVAR(S,Nv,rand_flag);
        
        % Compute risk curves for each spatial pixel and perturbed value.
        tic; S=runRISKind(S,rand_flag); toc;
    
        % Save data structure.
        save('TLEnl_temp.mat','S');
    end
end






