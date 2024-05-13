function imaging_plot_trial_figure(data_trial, parameters_to_plot, config)
%IMAGING_PLOT_TRIAL_FIGURE plots parameters_to_plot of data_trial  
%
%   idx = IMAGING_PLOT_TRIAL_FIGURE(data_trial, parameters_to_plot, config)
%   plots parameters_to_plot of data_trial.
%   
%   data_trial         = table containing data  
%   parameters_to_plot = cell array with names of table columns to plot 
%   config             = structure array containing configuration parameters 

% Author: Chris J. Dallmann 
% Affiliation: University of Wuerzburg
% Last revision: 13-May-2024

% ------------- BEGIN CODE -------------

n_subplots = numel(parameters_to_plot);
for iPlot = 1:n_subplots
    subplot(n_subplots,1,iPlot)
    plot(data_trial.time, data_trial.(parameters_to_plot{iPlot}), 'k');
    ylabel(parameters_to_plot{iPlot},'Interpreter','none','Rotation',0)
    if isfield(config.ylim,parameters_to_plot{iPlot})
        set(gca, ...
            'ylim', config.ylim.(parameters_to_plot{iPlot}), ...
            'ytick', config.ytick.(parameters_to_plot{iPlot}), ...
            'Color', 'none')
    end
    if iPlot < n_subplots
        set(gca,'xticklabels','')
    else
        xlabel('Time (s)')
    end
end
clearvars iParam
set(gca,'Color','none')
linkaxes(findall(gcf,'type','axes'),'x')

end