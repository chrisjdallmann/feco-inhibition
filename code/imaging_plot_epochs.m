% IMAGING_PLOT_EPOCHS.m calculates and plots median values of calcium imaging and behavior data recorded in Dallmann et al. (2024)
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
% Last revision: 03-March-2025

% ------------- BEGIN CODE -------------

clear
clc

% Settings 
settings.parquet_file = 'claw_treadmill';
settings.ball = 1;
settings.platform = 0;
settings.epoch_type = 'L1_rest'; 
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
settings.plot_trials = true;
settings.parameters_to_plot = {'analyze','L1_move','ball',...
    'L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};

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

% Select frames
if contains(settings.parquet_file,'magnet')
    frames = true(1,size(data,1));
else
    frames = data.ball==settings.ball ...
        & data.platform==settings.platform;
end

% Select trials
trials = unique(data.trial(frames))';

% Calculate normalization factor
calcium_norm_factor = max(data.calcium(data.analyze==1));
predicted_calcium_norm_factor = max(data.predicted_calcium(data.analyze==1));

% Initialize figure
if settings.plot_trials
    h = figure;
end

% Loop over trials
epochs = [];
n_epoch = 0; 
for iTrial = 1:numel(trials)  
    % Select trial data
    frames_trial = strcmp(data.trial,trials{iTrial});
    data_trial = data(frames_trial,:);
       
    % Predict calcium signals (optional)
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
    
    % Find epochs
    idx_epochs = imaging_find_epochs( ...
        data_trial.(settings.epoch_type), ...
        settings.min_epoch_win*settings.sampling_rate);
    
    % Loop over epochs
    idx_epochs_included = [];
    for iEpoch = 1:size(idx_epochs,1)
        epoch_win = idx_epochs(iEpoch,1):idx_epochs(iEpoch,2);
        % Exclude frames where analyze=0
        epoch_win(data_trial.analyze(epoch_win)==0) = []; 
        % Include epoch only if there are enough frames to analyze and
        % epoch occurred during right condition (relevant for
        % *treadmill_removal.parquet)
        if numel(epoch_win)>=settings.min_epoch_win*settings.sampling_rate && all(data_trial.ball(epoch_win) == settings.ball)
            idx_epochs_included = [idx_epochs_included; [epoch_win(1),epoch_win(end)]];
            n_epoch = n_epoch+1;
            epochs.animal_id(n_epoch) = data_trial.animal_id(1);
            epochs.duration(n_epoch) = epoch_win(end)-epoch_win(1)+1;
            
            % Loop over parameters
            for iParam = 1:numel(settings.parameters)
                % Calculate median value for epoch 
                epochs.([settings.parameters{iParam},'_',settings.epoch_type])(:,n_epoch) = ...
                        median(data_trial.(settings.parameters{iParam})(epoch_win));
            end
            clearvars iParam
        end
        clearvars epoch_win 
    end
    clearvars iEpoch

    % Plot epochs 
    if settings.plot_trials
       disp(data_trial.trial(1))

       figure(h), clf
       imaging_plot_trial_figure(data_trial,settings.parameters_to_plot,config)
       h_subplots = get(h,'children');
       % Add medians 
       for iParam = 1:numel(settings.parameters)
           iPlot = find(strcmp(settings.parameters_to_plot,settings.parameters{iParam}));
           if ~isempty(iPlot)
               for iEpoch = 1:size(idx_epochs_included,1)
                   x1 = data_trial.time(idx_epochs_included(iEpoch,1));
                   x2 = data_trial.time(idx_epochs_included(iEpoch,2));
                   y = epochs.([settings.parameters_to_plot{iPlot},'_',settings.epoch_type])(end-(size(idx_epochs_included,1)-iEpoch));
                   hold(h_subplots(end-iPlot+1), 'on')
                   plot(h_subplots(end-iPlot+1), [x1,x2], [y,y], 'color', 'm')
               end
               clearvars iEpoch
           end
       end
       clearvars iParam
    end

    clearvars frames_trial data_trial idx_epochs idx_epochs_included x1 x2 y
end
clearvars iTrial 
if settings.plot_trials
    close(h)
end

% Get number of trials per animal
[~,~,ix] = unique(epochs.animal_id);
n_epochs_per_animal = accumarray(ix,1).';
clearvars ix

disp(['Number of epochs total: ', num2str(sum(n_epochs_per_animal))])
disp(['Number of animals: ', num2str(length(n_epochs_per_animal))])
disp(['Number of epochs per animal: ', num2str(n_epochs_per_animal)])

% Plot boxplot of specific epoch type with kernel density estimation
% Boxplot
y = epochs.(['predicted_calcium_norm_',settings.epoch_type]); 
h = figure;
h.Position(3) = 300;
hold on
boxplot(y)
a = get(get(gca,'children'),'children');   
set(a(1),'Marker','.','MarkerEdgeColor',[0,0,0])
for iProp = 1:numel(a)
    set(a(iProp),'Color',[0,0,0])
end
clearvars iProp
set(a(4),'linestyle','none')
set(a(5),'linestyle','none')
set(a(6),'linestyle','-')
set(a(7),'linestyle','-')
set(gca,'Color','none')
% Kernel density estimation  
[f,xi] = ksdensity(y);
hold on
plot(1-normalize(f,'range')*0.2,xi,'color',[0,0,0])
hold off
set(gca,'Color','none')

% Plot epochs against epochs with binned mean
y = epochs.predicted_calcium_norm_L1_rest; 
x = epochs.L1C_flex_L1_rest; 
figure
hold on
scatter(x,y,[],[0,0,0],'filled')
set(gca,'Color','none')
bins = 30:10:140;
val = [];
for iBin = 1:numel(bins)-1
    idx_trial = find(x>=bins(iBin) & x<bins(iBin+1));
    val = [val, nanmean(y(idx_trial))];
end
x = 35:10:135;
y = val; 
plot(x,y)