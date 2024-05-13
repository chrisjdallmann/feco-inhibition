# Instructions for recreating figures 
The following sections show how to recreate the figures in Dallmann et al. (2024) from data that will be available for download on Dryad. 

Connectome figures can be recreated with the Jupyter Notebooks `fanc_*`, `manc_*`, and `flywire_*`. 

Calcium imaging and behavior figures can be recreated with the Matlab files `imaging_*`.

## Figure 1  
Figure 1D: Run `fanc_synapse_locations.ipynb`.

Figure 1E: Run `fanc_synapse_transmitters.ipynb`.

Figure 1F: Run `rna-seq_plot_expression.m`. 

## Figure 2
Figure 2D: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trials = "20200630_A01_00003";
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 2E: Run `imaging_plot_xcorr.m` with these settings: 
```
settings.parquet_file = 'claw_treadmill';
settings.trial_to_highlight = "20200630_A01_00003";
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
```

Figure 2F: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
settings.epoch_type = 'L1_rest'; 
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Plot `epochs.calcium_norm_L1_rest` or `epochs.predicted_calcium_norm_L1_rest` versus `epochs.L1C_flex_L1_rest`.

Figure 2G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [70,90]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre'; 
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

## Figure 3
Figure 3B: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill';
settings.trials = "20210720_A01_00019";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 3C: `imaging_plot_xcorr.m` with these settings for the treadmill data: 
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trial_to_highlight = "20210720_A01_00019";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 1;
settings.platform = 0;
```
For the platform data, change:
```
settings.trial_to_highlight = "20230209_A01_00004";
settings.ball = 0;
settings.platform = 1;	
```

Figure 3D: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_rest'`, `'L1_walk'`, or `'L1_groom'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 3E: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre'; 
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 3G: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20230209_A01_00004";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 3H: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 0;
settings.platform = 1;
settings.transition_type = 'onset'; 
settings.transition_parameter = 'annotation';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre'; 
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

## Figure 4
Figure 4A: Run `fanc_feco_connectivity.ipynb`.

Figure 4C, top: Run `fanc_feco_connectivity.ipynb`. In connectivity matrix, sum hook input synapses from 9A neurons.

Figure 4C, bottom: Run `fanc_9A_connectivity.ipynb`.

Figure 4E: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00006";
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 4F: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 4G: Run `imaging_plot_xcorr.m` with these settings for the treadmill data: 
```
settings.parquet_file = '9A_treadmill_platform';
settings.trial_to_highlight = "20221118_A01_00006";
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.ball = 1;
settings.platform = 0;
```
For the platform data, change:
```
settings.trial_to_highlight = "20221118_A01_00039";
settings.ball = 0;
settings.platform = 1;	
```

Figure 4H: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00039";
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 4I: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 1;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

## Figure 5
Figure 5A: Run `fanc_9A_connectivity.ipynb`.

Figure 5B: Run `fanc_DN_9A_connectivity.ipynb` and sum synapsee connections of interest.

Figure 5D: Run `manc_web_connectivity.ipynb`.

Figure 5F: Run `flywire_web_connectivity.ipynb`.

Figure 5H: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trials = "240122_A01_00026";
settings.model_activation_function = 'web';
settings.model_parameters = [];  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 5I: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.model_activation_function = 'web';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`.  

Figure 5J: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trial_to_highlight = "240122_A01_00026";
settings.model_activation_function = 'web';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
```

## Figure S2
Figure S2A-C: Run `imaging_fit_activation_function.m` with these settings:
```
settings.parquet_file = 'claw_magnet_Mamiya2018';
settings.model_activation_function = 'claw';
settings.roi = {'L1_x','L1_y','L1_z'};
```

Figure S2A and S2D-E: Run `imaging_fit_activation_function.m` with these settings:
```
settings.parquet_file = 'claw_magnet_Mamiya2018';
settings.model_activation_function = 'claw';
settings.roi = {'L1_x','L1_y','L1_z'};
```

Figure S2F: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_rest'`, `'L1_walk'`, or `'L1_groom'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S2G: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trials = "20191209_A01_00012";
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
``` 

Figure S2H: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trial_to_highlight = "20191209_A01_00012";
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
settings.ball = 0;
settings.platform = 0;
```

## Figure S3
Figure S3A: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210712_A01_00002";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S3B: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trial_to_highlight = "20210712_A01_00002";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 0;
settings.platform = 0;
```

Figure S3C: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 0;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre'; 
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S3D: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trials = "20200219_A01_00010";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure S3E: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trial_to_highlight = "20200219_A01_00010";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 1;
settings.platform = 0;
```

Figure S3F: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S3G: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trials = "20200224_A01_00029";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S3H: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trial_to_highlight = "20200224_A01_00029";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 0;
settings.platform = 0;
```

Figure S3I: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 0;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S3J: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.ball = 0;
settings.platform = 1;
settings.epoch_type = 'L1_move'; 
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = .5; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

## Figure S4
Figure S4B: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20211122_A01_00003";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure S4C: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211122_A01_00003";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 1;
settings.platform = 0;
```

Figure S4D: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 


Figure S4E: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20211201_A01_00026";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S4F: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211201_A01_00026";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
```

Figure S4G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 


Figure S4H: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20230213_A01_00003";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S4I: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20230213_A01_00003";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 1;
```

Figure S4J: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 1;
settings.transition_type = 'onset';
settings.transition_parameter = 'annotation';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S4K: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 1;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = .5; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 



## Figure S5
Figure S5B: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 1;
settings.transition_type = 'onset';
settings.transition_parameter = 'annotation';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S5C: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.trials = "R21D12_09_walkingreplay01_L1_medial";
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```
For the right panel, replace:
```
settings.trials = "R21D12_09_groomingreplay01_L1_medial";
```

Figure S5D: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
settings.transition_type = 'onset'; 
settings.transition_parameter = 'stimulus';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = 1; 
settings.baseline_type = 'mean_pre';
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S5E: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.trial_to_highlight = [];
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
```

Figure S5F: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_extension_magnet';
settings.trials = "JR476_04_walkingreplay01_L1_medial";
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```
For the right panel, replace:
```
settings.trials = "JR476_03_groomingreplay01_L1_medial";
```

Figure S5G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_magnet';
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
settings.transition_type = 'onset'; 
settings.transition_parameter = 'stimulus';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = 1; 
settings.baseline_type = 'mean_pre'; 
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S5H: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_magnet';
settings.trial_to_highlight = [];
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
```

## Figure S6
Figure S6B: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trials = "20210609_A01_00002";
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure S6C: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trial_to_highlight = "20210609_A01_00002";
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.ball = 1;
settings.platform = 0;
```

Figure S6D: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.ball = 1;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S6E: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trials = "20210608_A01_00029";
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S6F: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trial_to_highlight = "20210608_A01_00029";
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
```

Figure S6G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S6H: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill_removal';
settings.trials = "20210608_A01_00027";
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','ball','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S6I: Run `imaging_plot_epochs.m` with these settings for the left panel:
```
settings.parquet_file = 'club_treadmill_removal';
settings.model_activation_function = 'club';
settings.model_parameters = 50; 
settings.platform = 0;
settings.epoch_type = 'L1_rest'; 
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.ball` to `1` or `0`.

## Figure S7
Figure S7A: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00023";
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S7B: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trial_to_highlight = "20221118_A01_00023";
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
```

Figure S7C: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
settings.ball = 0;
settings.platform = 0;
settings.transition_parameter = 'L1_move';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre'; 
```
Set `settings.transition_type` to `'onset'` or `'offset'`. Plot `calcium_norm` or `predicted_calcium_norm`. 



## Figure S8
Figure S8A: Run `fanc_DN_IN_connectivity.ipynb`.

Figure S8D: Run `manc_9A_connectivity.ipynb`.

Figure S8E: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trials = "240131_A01_00018";
settings.model_activation_function = 'web';
settings.model_parameters = [];  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```