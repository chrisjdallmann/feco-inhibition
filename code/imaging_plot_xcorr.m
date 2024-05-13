% IMAGING_PLOT_XCORR.m calculates and plots cross-correlation data in Dallmann et al. (2024)
% The code assumes that the data are stored in the parallel folder ../data/. 
% 
% Files required: 
%    *.parquet
%    imaging_config.toml
%
% Functions/packages required:
%    imaging_predict_gcamp.m
%    imaging_plot_trial_figure.m
%    matlab-toml
% 
% See also imaging_predict_gcamp.m, imaging_plot_trial_figure.m 

% Author: Chris J. Dallmann 
% Affiliation: University of Wuerzburg
% Last revision: 13-May-2024

% ------------- BEGIN CODE -------------

clear
clc

% Settings 
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211201_A01_00026";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
settings.plot_trials = false;
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom',...
    'L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};

% Load parquet file 
[parent_folder, ~] = fileparts(cd);
data = parquetread([parent_folder,'\data\',settings.parquet_file,'.parquet']);

settings.sampling_rate = ceil(1/data.time(2));

% Load config file
config = toml.read('imaging_config.toml');
config = toml.map_to_struct(config);

% Select frames
if contains(settings.parquet_file,'magnet')
    frames = true(1,size(data,1));
else
    frames = data.ball==settings.ball ...
        & data.platform==settings.platform;
end

% Select trials
trials = unique(data.trial(frames))';

% Set normalization
if contains(settings.parquet_file,'magnet')
    calcium_norm_factor = config.calcium_norm_factor.([data.driver{1},'_magnet']);
    predicted_calcium_norm_factor = config.predicted_calcium_norm_factor.([data.driver{1},'_magnet']);
else
    calcium_norm_factor = config.calcium_norm_factor.(data.driver{1});
    predicted_calcium_norm_factor = config.predicted_calcium_norm_factor.(data.driver{1});
end

if settings.plot_trials
    h = figure;
end

% Loop through trials
correlations = [];
correlations.r0 = [];
correlations.animal_id = [];
correlations.win = 5; % Seconds
correlations.t_all = linspace(-correlations.win,correlations.win,correlations.win*2*settings.sampling_rate+1);
for iTrial = 1:numel(trials)

    % Select trial data
    frames_trial = strcmp(data.trial,trials{iTrial});
    data_trial = data(frames_trial,:);
    
    % Predict calcium signals 
    model_input = [];
    model_input(:,1) = data_trial.L1C_flex;
    if contains(settings.parquet_file,'9A')
        model_input(:,2) = data_trial.annotation;
    end
    if contains(settings.parquet_file,'web')
        model_input(:,1) = data_trial.L1_rest; 
        model_input(data_trial.annotation==1) = 0;
    end
    model_input = [repmat(model_input(1,:),1000,1); model_input]; 
    predicted_calcium = imaging_predict_gcamp(...
        model_input, ...
        settings.sampling_rate, ...
        settings.model_activation_function, ...
        settings.model_parameters);
    predicted_calcium(1:1000,:) = [];
    predicted_calcium = predicted_calcium-min(predicted_calcium(data_trial.analyze==1));
    
    data_trial.predicted_calcium = predicted_calcium;
    clearvars model_input predicted_calcium

    % Normalize calcium signals 
    data_trial.calcium_norm = data_trial.calcium./calcium_norm_factor;
    data_trial.predicted_calcium_norm = data_trial.predicted_calcium./predicted_calcium_norm_factor;
    
    % Specify which frames to include for cross-correlation
    if contains(settings.parquet_file,'hook') && contains(settings.parquet_file,'platform')
        frames_to_include = data_trial.analyze==1 & data_trial.L1_rest==1; 
    else
        frames_to_include = data_trial.analyze==1;
    end
                      
    % Calculate cross-correlation 
    [r_temp,lags_temp] = xcorr( ...
        data_trial.predicted_calcium(frames_to_include), ... 
        data_trial.calcium(frames_to_include), ...
        'coeff');
    % Get correlation coefficient at a time lag of 0 s
    correlations.r0 = [correlations.r0; r_temp(lags_temp==0)];
    
    % Get animal ID
    correlations.animal_id(iTrial,1) = data_trial.animal_id(1); 

    % Plot trial   
    if settings.plot_trials
        disp([data_trial.trial{1},'; r0=',num2str(correlations.r0(end))])
        
        figure(h), clf
        imaging_plot_trial_figure(data_trial,settings.parameters_to_plot,config)
    end
        
    clearvars frames_trial frames_to_include data_trial r_temp lags_temp
end
clearvars iTrial

disp(['Median r0=', num2str(median(correlations.r0))])

% Get number of trials per animal
[~,~,ix] = unique(correlations.animal_id);
n_trials_per_animal = accumarray(ix,1).';
clearvars ix

disp(['Number of trials total: ', num2str(sum(n_trials_per_animal))])
disp(['Number of animals: ', num2str(length(n_trials_per_animal))])
disp(['Number of trials per animal: ', num2str(n_trials_per_animal)])

figure
hold on
% Plot cross-correlation values
h = scatter(ones(numel(correlations.r0),1),correlations.r0, ...
    'k','filled', ...
    'jitter','on','jitteramount',.2, ...
    'MarkerEdgeColor','none','MarkerFaceAlpha',.5);
line([.8,1.2],[median(correlations.r0),median(correlations.r0)],'Color','k')
% Highlight specific trial
if ~isempty(settings.trial_to_highlight)
    c = h.CData;
    c = repmat(c,[numel(correlations.r0) 1]);
    c(strcmp(trials,settings.trial_to_highlight),:) = [0,153/255,153/255];
    h.CData = c;
    clearvars c
end
ylim([-.1,1.1])
xlim([0,2])
hold off
ylabel('Cross-correlation (r)')
set(gca,'XTick',[],'Color','none')
