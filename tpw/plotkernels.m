function [ax]=plotkernels(Kph,Kam,x,y,ax)
%PLOTKERNELS  Plots Rayleigh wave sensitivity kernels
%
%    Usage:    plotkernels(Kph,Kam,x,y)
%              plotkernels(Kph,Kam,x,y,ax)
%              ax=plotkernel(...)
%
%    Description: PLOTKERNELS(Kph,Kam,X,Y) plots sensitivity kernels made
%     with RAYLEIGH_2D_PLANE_WAVE_KERNELS or read in with READKERNELS.  The
%     kernels are plotted as images (previously they were plotted as
%     surfaces but this was really slow).
%
%     PLOTKERNELS(Kph,Kam,X,Y,AX) sets the axes to draw in.  This is useful
%     for subplots, guis, etc.  Note that AX must be a 2 element vector!
%
%     AX=PLOTKERNELS(...) returns the handles to the axes that the kernels
%     are plotted in.  AX is a 2 element vector.
%
%    Notes:
%     - Unfortunately this does not include the velocity & period in the
%       title of the figures as this info is not saved in the Yang &
%       Forsyth kernel format.
%
%    Examples:
%     Read in kernels and plot them up:
%      [Kph,Kam,x,y]=readkernels();
%      plotkernels(Kph,Kam,x,y);
%
%    See also: READKERNELS, RAYLEIGH_2D_PLANE_WAVE_KERNELS, GETMAINLOBE,
%              SMOOTH2D, MAKEKERNELS, WRITEKERNELS

%     Version History:
%        July  9, 2010 - initial version
%
%     Written by Garrett Euler (ggeuler at wustl dot edu)
%     Last Updated July  9, 2010 at 16:30 GMT

% todo:

% check nargin
error(nargchk(4,5,nargin));

% check handle
if(nargin<5 || isempty(ax) || numel(ax)~=2 || ~isreal(ax) ...
        || ~all(ishandle(ax)) || ~all(strcmp('axes',get(ax,'type'))))
    badax=true;
else
    badax=false;
end

% check inputs
if(ndims(Kph)~=2 || ~isnumeric(Kph))
    error('seizmo:plotkernels:badInput',...
        'Kph must be a 2D array of numeric values!');
elseif(ndims(Kam)~=2 || ~isnumeric(Kam) || ~isequal(size(Kam),size(Kph)))
    error('seizmo:plotkernels:badInput',...
        'Kam must be a numeric array equal in size to Kph!');
elseif(ndims(x)~=2 || ~isnumeric(x) || ~isequal(size(x),size(Kph)))
    error('seizmo:plotkernels:badInput',...
        'X must be a numeric array equal in size to Kph!');
elseif(ndims(y)~=2 || ~isnumeric(y) || ~isequal(size(y),size(Kph)))
    error('seizmo:plotkernels:badInput',...
        'Y must be a numeric array equal in size to Kph!');
end
dx=unique(diff(x,1,2));
dy=unique(diff(y,1,1));
if(~isscalar(dx) || dx<=0)
    error('seizmo:plotkernels:badInput',...
        'X step size is not uniform or is <=0!');
elseif(~isscalar(dy) || dy<=0)
    error('seizmo:plotkernels:badInput',...
        'Y step size is not uniform or is <=0!');
end

% get x0
x0=unique(x(:));

% first plot the phase kernel
if(badax)
    figure;
    ax(1)=gca;
end
axes(ax(1));
imagesc(x0,x0,Kph);
colormap(jet);
xlabel('RADIAL POSITION (KM)');
ylabel('TRANSVERSE POSITION (KM)');
zlabel('SENSITIVITY (S/KM^2)');
title({'2D PLANE-WAVE PHASE DELAY KERNEL' ...
    'FOR RAYLEIGH WAVE PHASE VELOCITIES'});
box on
grid on
colorbar

% now plot the amplitude kernel
if(badax)
    figure;
    ax(2)=gca;
end
axes(ax(2));
imagesc(x0,x0,Kam);
colormap(jet);
xlabel('RADIAL POSITION (KM)');
ylabel('TRANSVERSE POSITION (KM)');
zlabel('SENSITIVITY (S/KM^2)');
title({'2D PLANE-WAVE AMPLITUDE DEVIATION KERNEL' ...
    'FOR RAYLEIGH WAVE PHASE VELOCITIES'});
box on
grid on
colorbar

end