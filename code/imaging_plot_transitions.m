% IMAGING_PLOT_TRANSITIONS.m finds and plots transitions in calcium imaging and behavior data recorded in Dallmann et al. (2024)
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
settings.parquet_file = '9A_treadmill_platform';
settings.ball = 0;
settings.platform = 0;
settings.transition_type = 'offset'; % 'onset' 'offset'
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre'; % 'mean_pre' 'mean_post' 'min'
settings.plot_trials = false;
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom',...
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

% Loop through trials
transitions = [];
n_trans = 0;
for iTrial = 1:numel(trials)  
    
    % Select trial data
    frames_trial = strcmp(data.trial,trials{iTrial});
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
       
    % Find transitions 
    if strcmp(settings.transition_type,'onset')
       idx_trans = find(diff(data_trial.(settings.transition_parameter))>0)+1;
    else
       idx_trans = find(diff(data_trial.(settings.transition_parameter))<0)+1;
    end

    idx_trans_included = [];
    for iTrans = 1:numel(idx_trans)
        % Set window around transition
        idx_win = idx_trans(iTrans) - settings.win_pre_transition*settings.sampling_rate : ...
            idx_trans(iTrans) + settings.win_post_transition*settings.sampling_rate-1;
        
        % Check if window is in bounds
        if idx_win(1) > 0 && ...
            idx_win(end) < size(data_trial,1) 
            
            % Check if other parameters match
            include_trans = false;
            if strcmp(settings.transition_parameter,'annotation')
                if ~any(data_trial.analyze(idx_win)==0) ...
                        && ~any(data_trial.L1_move(idx_win)==1)
                    include_trans = true;
                end
            elseif strcmp(settings.transition_parameter,'stimulus') || strcmp(settings.transition_parameter,'stimulus_core')
                if ~any(data_trial.analyze(idx_win)==0) 
                    include_trans = true;
                end
            else
                if strcmp(settings.transition_type,'onset')
                    if ~any(data_trial.analyze(idx_win)==0) ...
                            && ~any(data_trial.L1_other(idx_win)==1) ...
                            && ~any(data_trial.manipulation(idx_win)==1) ...
                            && ~any(data_trial.annotation(idx_win)==1) ... % To do: Check if line-specific
                            && ~any(data_trial.L1_move(idx_win(1:settings.win_pre_transition*settings.sampling_rate))==1) ...
                            && ~any(data_trial.L1_rest(idx_win(end-settings.win_pre_transition*settings.sampling_rate+1:end))==1) ...
                            && mean(data_trial.L1C_flex(idx_win(1:settings.win_pre_transition*settings.sampling_rate)))>=settings.L1C_flex_thresholds(1) ...
                                && mean(data_trial.L1C_flex(idx_win(1:settings.win_pre_transition*settings.sampling_rate)))<=settings.L1C_flex_thresholds(2)
                        include_trans = true;
                    end
                elseif strcmp(settings.transition_type,'offset')
                    if ~any(data_trial.analyze(idx_win)==0) ...
                            && ~any(data_trial.L1_other(idx_win)==1) ...
                            && ~any(data_trial.manipulation(idx_win)==1) ...
                            && ~any(data_trial.annotation(idx_win)==1) ... % To do: Check if line-specific
                            && ~any(data_trial.L1_rest(idx_win(1:settings.win_pre_transition*settings.sampling_rate))==1) ...
                            && ~any(data_trial.L1_move(idx_win(end-settings.win_pre_transition*settings.sampling_rate+1:end))==1) ...
                            && mean(data_trial.L1C_flex(idx_win(end-settings.win_pre_transition*settings.sampling_rate+1:end)))>=settings.L1C_flex_thresholds(1) ...
                                && mean(data_trial.L1C_flex(idx_win(end-settings.win_pre_transition*settings.sampling_rate+1:end)))<=settings.L1C_flex_thresholds(2)
                        include_trans = true;
                    end
                end
            end

            if include_trans
                idx_trans_included = [idx_trans_included, idx_trans(iTrans)];
                n_trans = n_trans+1;
                % Get values of parameters for window
                for iParam = 1:numel(settings.parameters)
                    % Calculate baseline 
                    if strcmp(settings.baseline_type,'min')
                        baseline = min(data_trial.(settings.parameters{iParam})(idx_win));
                    elseif strcmp(settings.baseline_type,'mean_pre')
                        baseline = mean(data_trial.(settings.parameters{iParam})(...
                            idx_trans(iTrans)-settings.win_pre_transition*settings.sampling_rate : idx_trans(iTrans)));
                    elseif strcmp(settings.baseline_type,'mean_post')
                        baseline = mean(data_trial.(settings.parameters{iParam})(...
                            idx_trans(iTrans) : idx_trans(iTrans)+settings.win_post_transition*settings.sampling_rate));
                    end
                    
                    if contains(settings.parameters{iParam},'L1C_flex')
                       transitions.(settings.parameters{iParam})(:,n_trans) = ...
                            data_trial.(settings.parameters{iParam})(idx_win);
                    else
                       % Subtract baseline
                       transitions.(settings.parameters{iParam})(:,n_trans) = ...
                           data_trial.(settings.parameters{iParam})(idx_win) ...
                           - baseline;
                    end
                end
                clearvars iParam
                
                transitions.animal_id(n_trans) = data_trial.animal_id(1);               
            end
            clearvars include_trans
        end      
    end
    clearvars iTrans
    
    % Plot transitions 
    if settings.plot_trials
       figure(h), clf
       imaging_plot_trial_figure(data_trial,settings.parameters_to_plot,config)
       h_subplots = get(h,'children');
       % Overlay transition windows
       for iPlot = 1:numel(h_subplots)
           for iTrans = 1:numel(idx_trans_included)
               x = data_trial.time(idx_trans_included(iTrans));
               hold(h_subplots(iPlot), 'on')
               plot(h_subplots(iPlot), ...
                   [x,x]-settings.win_pre_transition, ...
                   h_subplots(iPlot).YLim, 'color','m')
               plot(h_subplots(iPlot), ...
                   [x,x]+settings.win_pre_transition, ...
                   h_subplots(iPlot).YLim, 'color','m')
               plot(h_subplots(iPlot), ...
                   [x,x], ...
                   h_subplots(iPlot).YLim, 'color','m')
           end
           clearvars iTrans
       end
       clearvars iPlot
    end

    clearvars frames_trial data_trial idx_trans idx_win iTrans idx_trans_included
end
clearvars iTrial 


% Calculate animal means
animal_id = unique(transitions.animal_id);
n_mean = 0;
for iAnimal = 1:numel(animal_id)
    n_mean = n_mean+1;
    for iParam = 1:numel(settings.parameters)
        transitions.(['mean_',settings.parameters{iParam}])(:,n_mean) = ...
            mean(transitions.(settings.parameters{iParam})(:,transitions.animal_id==animal_id(iAnimal)),2);
    end
    clearvars iParam
end
clearvars iAnimal 

% Calculate grand mean and sem
for iParam = 1:numel(settings.parameters)
    transitions.(['grand_mean_',settings.parameters{iParam}])(:,1) = ...
        mean(transitions.(['mean_',settings.parameters{iParam}]),2);
    transitions.(['sem_',settings.parameters{iParam}])(:,1) = ...
        std(transitions.(['mean_',settings.parameters{iParam}]),0,2) ...
        / sqrt(size(transitions.(['mean_',settings.parameters{iParam}]),2));
end
clearvars iParam

% Get number of transitions per animal
[~,~,ix] = unique(transitions.animal_id);
n_trans_per_animal = accumarray(ix,1).';
clearvars ix

disp(['Number of transitions total: ', num2str(sum(n_trans_per_animal))])
disp(['Number of animals: ', num2str(length(n_trans_per_animal))])
disp(['Number of transitions per animal: ', num2str(n_trans_per_animal)])

% Plot mean transitions
parameter_to_plot = 'calcium_norm';
y1 = transitions.(['mean_',parameter_to_plot]);
y2 = transitions.(['grand_mean_',parameter_to_plot]);
y3 = transitions.(['sem_',parameter_to_plot]);
transitions.time = -settings.win_pre_transition : 1/settings.sampling_rate : ...
    settings.win_post_transition-1/settings.sampling_rate;
figure
hold on
plot(transitions.time, y1, 'color', [0,0,0], 'linewidth', .25)
plot(transitions.time, y2, 'color', [0,0,0], 'linewidth', 2)
plot(transitions.time, y2+y3, 'color', [0,0,0], 'linewidth', 2)
plot(transitions.time, y2-y3, 'color', [0,0,0], 'linewidth',2)
hold off
set(gca,'Color','none')


% Calculate predicted delta calcium and measured delta calcium  
animal_id = unique(transitions.animal_id);
n_mean = 0;
idx_trans = settings.win_pre_transition*settings.sampling_rate;
for iParam = 1:numel(settings.parameters) 
        transitions.(['mean_pre_',settings.parameters{iParam}]) = nan(100,numel(animal_id));
        transitions.(['mean_post_',settings.parameters{iParam}]) = nan(100,numel(animal_id));
end
for iAnimal = 1:numel(animal_id)
    n_mean = n_mean+1;
    for iParam = 1:numel(settings.parameters) 
        n_trans = sum(transitions.animal_id==animal_id(iAnimal));
        transitions.(['mean_pre_',settings.parameters{iParam}])(1:n_trans,n_mean) = ...
            mean(transitions.(settings.parameters{iParam})(1:idx_trans, transitions.animal_id==animal_id(iAnimal)));
        transitions.(['mean_post_',settings.parameters{iParam}])(1:n_trans,n_mean) = ...
            mean(transitions.(settings.parameters{iParam})(idx_trans:end, transitions.animal_id==animal_id(iAnimal)));
    end
    clearvars iParam
end
clearvars iAnimal idx_trans
 
% % Plot difference in measured and predicted delta calcium 
% y1 = transitions.mean_post_predicted_calcium_norm;
% y2 = transitions.mean_post_calcium_norm;
% y1 = reshape(y1,[],1);
% y2 = reshape(y2,[],1);
% y1 = abs(y1);
% y2 = abs(y2);
% y = y2-y1;
% y(isnan(y)) = [];
% 
% figure
% boxplot(y)
% a = get(get(gca,'children'),'children');   
% set(a(1),'Marker','.','MarkerEdgeColor',[0,0,0])
% for iProp = 1:numel(a)
%     set(a(iProp),'Color',[0,0,0])
% end
% clearvars iProp
% set(a(4),'linestyle','none')
% set(a(5),'linestyle','none')
% set(a(6),'linestyle','-')
% set(a(7),'linestyle','-')
% % Kernel density estimation  
% [f,xi] = ksdensity(y);
% hold on
% plot(1-normalize(f,'range')*0.2,xi,'color',[0,0,0])
% hold off
% set(gca,'Color','none','XTickLabel','')
% ylabel('Measured - predicted calcium')
% ylim([-0.5,0.5])
