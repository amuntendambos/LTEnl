function [STR] = getDEPTHgrid(STRfile,Dind,dZfile)
    % Simple function to read the depth grids

    % Setup basic structure for depth grids
    STR = struct('latD',[],'lonD',[],'A',[]);
    p = projcrs('ED50UTM31',"Authority",'IGNF');
    
    if strcmpi(Dind,'top')
        % read depthfile
        [A,R]=readgeoraster(STRfile,OutputType='double');
        [X,Y] = worldGrid(R);
        
        % get lon/lat coordinates form X,Y projection
        [latD,lonD] = projinv(p,X,Y);
    
        A(A==-99999)=nan;
    
        % Save to structure
        STR.A = A;
        STR.latD = latD;
        STR.lonD = lonD;
    elseif strcmpi(Dind,'base')
        % read depthfile
        [A,R]=readgeoraster(STRfile,OutputType='double');
        [X,Y] = worldGrid(R);
        
        % get lon/lat coordinates form X,Y projection
        [latD,lonD] = projinv(p,X,Y);
    
        A(A==-99999)=nan;

        % read thicknessfile
        [Z,~]=readgeoraster(dZfile,OutputType='double');

        Z(Z==-99999)=nan;
    
        % Save to structure
        STR.A = A+Z;
        STR.latD = latD;
        STR.lonD = lonD;

    end

end