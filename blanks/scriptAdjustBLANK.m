% Simple script to adjust the existing TLP blank data structure.
clear;

%% Definitions
% Define output file:
BlankFile = 'LTEnl_blank.mat';

% Define input parameters.
PLAYflag='NL';
PLAYtype = 'GF'; % GF - gas fields (including (gas/CO2-)storage); GT - geothermal heat; 
FIELDflag={'ONSHORE','GAS','Producing'}; % Field identifiers for gas fields
    % OPTIONS: 
    % First entry: ALL-all fields; ONSHORE-all onshore/near-shore fields; 
    % SPECIFIC-specific field(s) (specify field_CD's in next line)
    % (Note: second and third entry only for ALL and ONSHORE as first entry)
    % Second entry: ALL/OIL/GAS - select ALL or OIL or GAS fields only
    % Third entry: ALL, Producing, Prospect, Storage
field={'GRO','BGM','ELV','RSW','EMM','GAG'}; % Field-CD in case of specific field(s) analysis
GTflag='SPECIFIC'; % ALL - all plays, SPECIFIC - specific play(s) (specify 
	          % licence_cd's in next line)
licence={'CALIFORNIE IV-1', 'DELFT I','KLAZIENAVEEN I', 'KWINTSHEUL-1','LEEUWARDEN','LUTTELGEEST-2','MIDDENMEER-1'}; %{'CALIFORNIE IV-1','CALIFORNIE V'}; % Licence-cd in case of specific play(s) analysis

%% Load input
% Load input files & setup earthquake grid.
if(strcmpi(PLAYflag,'NL'))
    if strcmpi(PLAYtype,'GF')
        BOUNDfile='C:\Users\amuntendambos\OneDrive - Delft University of Technology\Documents\WORK\Projects\Current projects\LTEnl\NLOG_Velden_lon_lat_2';
        load('TLP_nl-highres.mat') % lOAD existing high resolution blank to adjust
        % Make the earthquake grid
        if(strcmpi(FIELDflag(3),'Storage'))
            Ne=1;
            dS=S.MAP.latG(2)-S.MAP.latG(1);
            latE=S.MAP.latG(1:Ne:end)+dS/Ne; 
            lonE=S.MAP.lonG(1:Ne:end)+dS/Ne; 
        else
            Ne=1;
            dL=0.0025;
            dS=S.MAP.latG(2)-S.MAP.latG(1);
            minlat = S.MAP.latG(1)+dS/Ne; maxlat = S.MAP.latG(end)+dS/Ne;
            minlon = S.MAP.lonG(1)+dS/Ne; maxlon = S.MAP.lonG(end)+dS/Ne;
            latE=minlat:dL:maxlat;
            lonE=minlon:dL:maxlon;
        end
    elseif strcmpi(PLAYtype,'GT')
        BOUNDfile='C:\Users\amuntendambos\OneDrive - Delft University of Technology\Documents\WORK\Projects\Current projects\LTEnl\NLOG_GT-Licenties_lon_lat';
        load('TLP_nl-highres.mat'); % lOAD existing high resolution blank to adjust
        % Make the earthquake grid.
        Ne=1;
        dS=S.MAP.latG(2)-S.MAP.latG(1);
        latE=S.MAP.latG(1:Ne:end)+dS/Ne; 
        lonE=S.MAP.lonG(1:Ne:end)+dS/Ne; 
    end
end

% load low resolution blank for shakefile.
load('TLP_nl.mat')
S.MAP.latE = latE;
S.MAP.lonE = lonE;
S.MAP.latCnl = S.MAP.latB;
S.MAP.lonCnl = S.MAP.lonB;
%clear S1

% Load in the play boundaries.
disp('Load play boundaries')
if strcmpi(PLAYtype,'GF')
    [latB,lonB,FieldName,StrUnit,F_id,B_id]=loadBOUND_GF(BOUNDfile,FIELDflag,field);
elseif strcmpi(PLAYtype,'GT')
    [latB,lonB,FieldName,StrUnit,F_id,B_id]=loadBOUND_GT(BOUNDfile,GTflag,licence);
else
    error('Invalid option for PLAYtype')
end

% adjust the data structure for TLP map.
disp('Adjusting structure')
S = adjustSTRUCT(S,latB,lonB,F_id,B_id,FieldName,StrUnit);

disp('Loading depths based on stratigraphy')
S=loadDEPfromSTRAT(S,StrUnit,B_id);

% Save the blank template data-structure.
save(BlankFile,'S');





