% IMAGING_PLOT_TRIAL.m plots data of a specified trial recorded in Dallmann et al. (2024)
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
% Last revision: 11-March-2025

% ------------- BEGIN CODE -------------

clear
clc

% Settings 
settings.parquet_file = 'web_treadmill';
settings.trials = "240131_A01_00018";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};

settings.predict_calcium_signals = false;
settings.model_activation_function = '';
settings.model_parameters = [];  

% Load parquet file 
[parent_folder, ~] = fileparts(cd);
data = parquetread([parent_folder,'\data\',settings.parquet_file,'.parquet']);

settings.sampling_rate = ceil(1/data.time(2));

% Load config file
config = toml.read('imaging_config.toml');
config = toml.map_to_struct(config);

% Calculate normalization factor
calcium_norm_factor = max(data.calcium(data.analyze==1));
predicted_calcium_norm_factor = max(data.predicted_calcium(data.analyze==1));

% Initialize figure
h = figure;

% Loop through trials
for iTrial = 1:numel(settings.trials)  

    % Select trial data
    frames_trial = strcmp(data.trial,settings.trials{iTrial});
    data_trial = data(frames_trial,:);
    
    % Predict calcium signals 
    if settings.predict_calcium_signals  
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
        data_trial.predicted_calcium = predicted_calcium-min(predicted_calcium(data_trial.analyze==1));
    end
    clearvars model_input predicted_calcium

    % Normalize calcium signals 
    data_trial.calcium_norm = data_trial.calcium./calcium_norm_factor;
    data_trial.predicted_calcium_norm = data_trial.predicted_calcium./predicted_calcium_norm_factor;

    % Plot trial
    figure(h), clf
    imaging_plot_trial_figure(data_trial,settings.parameters_to_plot,config)

end
clearvars iTrial

