# Instructions for recreating figures 
The following sections show how to recreate the figures in Dallmann et al. (2024) from data that will be available for download on Dryad. 

Connectome figures can be recreated with the Jupyter Notebooks `fanc_*`, `manc_*`, and `flywire_*`. 

Calcium imaging and behavior figures can be recreated with the Matlab files `imaging_*.m`. The datasets already contain the predicted calcium signals, but the signals can also be predicted from scratch within the m-files (see instructions below).  

The RNA-seq figures can be recreated with the Matlab file `rna-seq_plot_expression.m`.

# Datasets
`claw_treadmill.parquet`: Calcium imaging data from claw axons during behavior on and off the treadmill.  

`claw_magnet_Mamiya2018.parquet`: Calcium imaging data from claw axons during passive leg movements with the magnet (from Mamiya et al. 2018). 

`hook_flexion_01_treadmill_platform.parquet`: Calcium imaging data from hook flexion axons (driver line 1) during behavior on and off the treadmill and passive leg movements with the platform.

`hook_flexion_01_magnet.parquet`: Calcium imaging data from hook flexion axons (driver line 1) during passive leg movements with the magnet. 

`hook_flexion_01_magnet_Mamiya2018.parquet`: Calcium imaging data from hook flexion axons (driver line 1) during passive leg movements with the magnet (from Mamiya et al. 2018). 

`hook_flexion_02_treadmill.parquet`: Calcium imaging data from hook flexion axons (driver line 2) during behavior on and off the treadmill.

`hook_extension_treadmill_platform.parquet`: Calcium imaging data from hook extension axons during behavior on and off the treadmill and passive leg movements with the platform.

`hook_extension_magnet.parquet`: Calcium imaging data from hook extension axons during passive leg movements with the magnet.

`club_treadmill.parquet`: Calcium imaging data from club axons during behavior on and off the treadmill.

`club_treadmill_removal.parquet`: Calcium imaging data from club axons when the treadmill was removed during the recording. 

`club_magnet_Mamiya2018.parquet`: Calcium imaging data from club axons during passive leg movements with the magnet (from Mamiya et al. 2018). 

`9A_treadmill_platform.parquet`: Calcium imaging data from 9A axons during behavior on and off the treadmill and passive leg movements with the platform.

`9A_CsChrimson.parquet`: Behavioral data for optogenetic activation of 9A neurons in tethered flies on the treadmill. 

`9A_GtACR1.parquet`: Behavioral data for optogenetic silencing of 9A neurons in tethered flies on the treadmill. 

`web_treadmill.parquet`: Calcium imaging data from web axons during behavior on the treadmill.

`rna-seq.xls`: RNA-seq data for hook, claw, and club neurons.  

## Figure 1  
Figure 1D: Run `fanc_synapse_locations.ipynb`.

Figure 1E: Run `fanc_synapse_transmitters.ipynb`.

Figure 1F: Run `rna-seq_plot_expression.m`. 

## Figure 2
Figure 2D: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trials = "20200630_A01_00003";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 2E: Run `imaging_plot_xcorr.m` with these settings: 
```
settings.parquet_file = 'claw_treadmill';
settings.trial_to_highlight = "20200630_A01_00003";
settings.ball = 1;
settings.platform = 0;
```

Figure 2F: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
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


To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
```

## Figure 3
Figure 3B: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210720_A01_00019";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 3C: `imaging_plot_xcorr.m` with these settings for the treadmill data: 
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trial_to_highlight = "20210720_A01_00019";
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
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_rest'`, `'L1_walk'`, or `'L1_groom'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 3E: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
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
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 3H: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
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

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
```

## Figure 4
Figure 4A: Run `fanc_feco_connectivity.ipynb`.

Figure 4C, top: Run `fanc_feco_connectivity.ipynb`. In connectivity matrix, sum hook input synapses from 9A neurons.

Figure 4C, bottom: Run `fanc_9A_connectivity.ipynb`.

Figure 4E: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00006";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 4F: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
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
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 4I: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.ball = 0;
settings.platform = 1;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
```

## Figure 5
Figure 5A: Run `fanc_9A_connectivity.ipynb`.

Figure 5C: Sum values of Figure S9E (see below).

Figure 5D: Run `flywire_plot_neuron.ipynb`.

Figure 5F: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trials = "240122_A01_00026";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 5G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
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

Figure 5H: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trial_to_highlight = "240122_A01_00026"; 
settings.ball = 1;
settings.platform = 0;
```

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'web';
settings.model_parameters = [];  
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
settings.parquet_file = 'hook_flexion_01_magnet_Mamiya2018';
settings.model_activation_function = 'hook_flex';
settings.roi = {'L1_medial'};
```

Figure S2A and S2F-G: Run `imaging_fit_activation_function.m` with these settings:
```
settings.parquet_file = 'club_magnet_Mamiya2018';
settings.model_activation_function = 'club';
settings.roi = {'L1_x'};
```

Figure S2H: Run `imaging_hook_model_example.m`.


## Figure S3
Figure S3A: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.model_parameters = [];  
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_rest'`, `'L1_walk'`, or `'L1_groom'`. Plot `calcium_norm` or `predicted_calcium_norm`. 


Figure S3B: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = .5; 
settings.baseline_type = 'mean_pre';
```
Set `settings.transition_parameter` to `'L1_walk'` or `'L1_groom'`. For each transition parameter, run the m-file with `settings.transition_type` set to `'onset'`, manually save `mean_post_calcium_norm - mean_post_predicted_calcium`, run the m-file again with `settings.transition_type` set to `'offset'`, combine `mean_post_calcium_norm - mean_post_predicted_calcium` with the previously saved values, then plot the combined values (see end of m-file).  


Figure S3C: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trials = "20191209_A01_00012";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
``` 

Figure S3D: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trial_to_highlight = "20191209_A01_00012";
settings.ball = 0;
settings.platform = 0;
```

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'claw';
settings.model_parameters = [];  
```

## Figure S4
Figure S4A: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210707_A01_00020";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S4B: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.ball = 0;
settings.platform = 1;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = .5; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 


Figure S4C: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210712_A01_00002";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S4D: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trial_to_highlight = "20210712_A01_00002";
settings.ball = 0;
settings.platform = 0;
```

Figure S4E: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
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

Figure S4F: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trials = "20200219_A01_00010"; 
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure S4G: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trial_to_highlight = "20200219_A01_00010";
settings.ball = 1;
settings.platform = 0;
```

Figure S4H: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
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

Figure S4I: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trials = "20200224_A01_00029";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S4J: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trial_to_highlight = "20200224_A01_00029";
settings.ball = 0;
settings.platform = 0;
```

Figure S4K: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
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


To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
```

## Figure S5
Figure S5B: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20211122_A01_00003";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure S5C: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211122_A01_00003";
settings.ball = 1;
settings.platform = 0;
```

Figure S5D: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
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


Figure S5E: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20211201_A01_00026";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S5F: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211201_A01_00026";
settings.ball = 0;
settings.platform = 0;
```

Figure S5G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
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


Figure S5H: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20230213_A01_00003";
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S5I: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20230213_A01_00003";
settings.ball = 0;
settings.platform = 1;
```

Figure S5J: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
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

Figure S5K: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.ball = 0;
settings.platform = 1;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = .5; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
```

## Figure S6
Figure S6C: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.trials = "R21D12_09_walkingreplay01_L1_medial";
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```
For the right panel, change:
```
settings.trials = "R21D12_09_groomingreplay01_L1_medial";
```

Figure S6D: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.transition_type = 'onset'; 
settings.transition_parameter = 'stimulus';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = 1; 
settings.baseline_type = 'mean_pre';
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S6E: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.trial_to_highlight = [];
```

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'hook_flex';
settings.model_parameters = -50;  
```

Figure S6F: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_extension_magnet';
settings.trials = "JR476_04_walkingreplay01_L1_medial";
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```
For the right panel, replace:
```
settings.trials = "JR476_03_groomingreplay01_L1_medial";
```

Figure S6G: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'hook_extension_magnet'; 
settings.transition_type = 'onset'; 
settings.transition_parameter = 'stimulus';
settings.parameters = {'calcium_norm','predicted_calcium_norm'};
settings.L1C_flex_thresholds = [0,360]; 
settings.win_pre_transition = .5; 
settings.win_post_transition = 1; 
settings.baseline_type = 'mean_pre'; 
```
Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure S6H: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_magnet';
settings.trial_to_highlight = [];
```

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'hook_ext';
settings.model_parameters = 50;  
```

## Figure S7
Figure S7A: Run `rna-seq_plot_expression.m`. 

Figure S7C: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trials = "20210609_A01_00002";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure S7D: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trial_to_highlight = "20210609_A01_00002";
settings.ball = 1;
settings.platform = 0;
```

Figure S7E: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
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

Figure S7F: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trials = "20210608_A01_00029";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S7G: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trial_to_highlight = "20210608_A01_00029";
settings.ball = 0;
settings.platform = 0;
```

Figure S7H: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
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


Figure S7I: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill_removal';
settings.trials = "20210608_A01_00027";
settings.parameters_to_plot = {'analyze','L1_move','ball','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S7JI: Run `imaging_plot_epochs.m` with these settings for the left panel:
```
settings.parquet_file = 'club_treadmill_removal';
settings.platform = 0;
settings.epoch_type = 'L1_rest'; 
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.ball` to `1` or `0`.

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'club';
settings.model_parameters = 50;  
```

## Figure S8
Figure S8A: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00023";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure S8B: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trial_to_highlight = "20221118_A01_00023";
settings.ball = 0;
settings.platform = 0;
```

Figure S8C: Run `imaging_plot_transitions.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
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

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
```

## Figure S9
Figure S9C: Run `manc_9A_web_connectivity.ipynb`. Set `source_name` to `chief_9A` and run script with `source_index` set to `0`, `1`, `2`, `3`, `4`, and `5`.

Figure S9D and S9E: Run `fanc_DN_IN_connectivity.ipynb`.

## Figure S10
Figure S10A: Run `manc_9A_web_connectivity.ipynb`. Set `source_name` to `web` and run script with `source_index` set to `0`.

Figure S10B: Run `flywire_web_connectivity.ipynb`.

Figure S10C: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trials = "240131_A01_00018";
settings.model_activation_function = 'web';
settings.model_parameters = [];  
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'web';
settings.model_parameters = [];  
```