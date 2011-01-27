function [results]=cmb_outliers(results)
%CMB_OUTLIERS    Outlier analysis of core-diffracted data
%
%    Usage:    results=cmb_outliers(results)
%
%    Description:
%     RESULTS=CMB_OUTLIERS(RESULTS) provides an interface for graphically
%     removing arrival time and amplitude outliers from the core-diffracted
%     wave analysis RESULTS struct generated by either CMB_1ST_PASS,
%     CMB_CLUSTERING or CMB_2ND_PASS.  Plots and info are saved during the
%     analysis by the user.
%
%    Notes:
%     - Outliers are reset each time CMB_OUTLIERS is ran on a RESULTS
%       struct.
%
%    Examples:
%     % Typical alignment and refinement workflow:
%     results=cmb_1st_pass;
%     results=cmb_clustering(results);
%     results=cmb_outliers(results);
%
%    See also: PREP_CMB_DATA, CMB_1ST_PASS, CMB_2ND_PASS, SLOWDECAYPAIRS,
%              SLOWDECAYPROFILES, MAP_CMB_PROFILES

%     Version History:
%        Dec. 12, 2010 - added docs
%        Jan.  6, 2011 - catch empty axis handle breakage
%        Jan. 13, 2011 - output ground units in .adjustclusters field
%        Jan. 16, 2011 - split off clustering to cmb_clustering, menu
%                        rather than forcing user to cycle through
%        Jan. 18, 2011 - .time field, no setting groups as bad
%        Jan. 26, 2011 - no travel time corrections for synthetics, use 2
%                        digit cluster numbers, update for 2 plot arrcut
%
%     Written by Garrett Euler (ggeuler at wustl dot edu)
%     Last Updated Jan. 26, 2011 at 13:35 GMT

% todo:
% - coloring of outlier plots

% check nargin
error(nargchk(1,1,nargin));

% check results
error(check_cmb_results(results));

% loop over each event
for i=1:numel(results)
    % display name
    disp(results(i).runname);
    
    % abandon events we skipped
    if(isempty(results(i).useralign)); continue; end
    
    % arrival & amplitude info
    dd=getheader(results(i).useralign.data,'gcarc');
    arr=results(i).useralign.solution.arr;
    if(results(i).synthetics)
        carr=arr;
    else
        carr=arr-results(i).corrections.ellcor...
            -results(i).corrections.crucor.prem...
            -results(i).corrections.mancor.hmsl06p.upswing;
    end
    arrerr=results(i).useralign.solution.arrerr;
    amp=results(i).useralign.solution.amp;
    camp=amp./results(i).corrections.geomsprcor;
    amperr=results(i).useralign.solution.amperr;
    
    % default to all non-outliers
    results(i).outliers.bad=false(numel(results(i).useralign.data),1);
    
    % loop over good clusters
    for j=find(results(i).usercluster.good(:)')
        % current cluster index as a string
        sj=num2str(j,'%02d');
        
        % preallocate struct
        results(i).outliers.cluster(j).arrcut=...
            struct('bad',[],'cutoff',[]);
        results(i).outliers.cluster(j).ampcut=...
            struct('bad',[],'cutoff',[]);
        results(i).outliers.cluster(j).errcut=...
            struct('bad',[],'cutoff',[]);
        
        % loop until user is happy overall
        % with outlier analysis of this cluster
        happyoverall=false;
        arrcnt=0; ampcnt=0; errcnt=0;
        while(~happyoverall)
            % get current cluster population
            good=find(results(i).usercluster.T==j ...
                & ~results(i).outliers.bad);
            pop=numel(good);
            
            % require at least 2 members in good standing
            % - otherwise set remaining as outliers and skip
            if(pop<2)
                warning('seizmo:cmb_outliers:tooFewGood',...
                    ['Cluster ' sj ' has <2 good members. Skipping!']);
                results(i).outliers.bad(good)=true;
                happyoverall=true;
                continue;
            end
            
            % ask user what to do
            choice=menu(...
                ['CLUSTER ' sj ': Remove what outliers?'],...
                'Arrival Time',...
                'Arrival Time Error',...
                'Amplitude',...
                'Continue');
            
            % action based on choice
            switch choice
                case 1 % arr
                    arrcnt=arrcnt+1;
                    [bad,cutoff,ax]=...
                        arrcut(dd(good),carr(good),[],1,arrerr(good));
                    results(i).outliers.bad(good(bad))=true;
                    results(i).outliers.cluster(j).arrcut.bad{arrcnt}=good(bad);
                    results(i).outliers.cluster(j).arrcut.cutoff(arrcnt)=cutoff;
                    if(ishandle(ax(1)))
                        saveas(get(ax(1),'parent'),...
                            [results(i).runname '_cluster_' ...
                            sj '_arrcut_' num2str(arrcnt) '.fig']);
                        close(get(ax(1),'parent'));
                    end
                case 2 % arrerr
                    errcnt=errcnt+1;
                    [bad,cutoff,ax]=errcut(dd(good),arrerr(good));
                    results(i).outliers.bad(good(bad))=true;
                    results(i).outliers.cluster(j).errcut.bad{errcnt}=good(bad);
                    results(i).outliers.cluster(j).errcut.cutoff(errcnt)=cutoff;
                    if(ishandle(ax))
                        saveas(get(ax,'parent'),...
                            [results(i).runname '_cluster_' ...
                            sj '_errcut_' num2str(errcnt) '.fig']);
                        close(get(ax,'parent'));
                    end
                case 3 % amp
                    ampcnt=ampcnt+1;
                    [bad,cutoff,ax]=ampcut(dd(good),camp(good),[],1,amperr(good));
                    results(i).outliers.bad(good(bad))=true;
                    results(i).outliers.cluster(j).ampcut.bad{ampcnt}=good(bad);
                    results(i).outliers.cluster(j).ampcut.cutoff(ampcnt)=cutoff;
                    if(ishandle(ax))
                        saveas(get(ax,'parent'),...
                            [results(i).runname '_cluster_' ...
                            sj '_ampcut_' num2str(ampcnt) '.fig']);
                        close(get(ax,'parent'));
                    end
                case 4 % continue
                    happyoverall=true;
                    continue;
            end
        end
    end
    
    % time
    results(i).time=datestr(now);
    
    % save results
    tmp=results(i);
    save([results(i).runname '_outliers_results.mat'],'-struct','tmp');
end

end