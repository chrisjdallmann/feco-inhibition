# Instructions for recreating figures 
The following sections show how to recreate the figures in Dallmann et al. (2025) from data that will be available for download on Dryad. 

The RNA-seq figures can be recreated with the Matlab file `rna-seq_plot_expression.m`.

Calcium imaging and behavior figures can be recreated with the Matlab scripts `imaging_*.m`. The datasets already contain the predicted calcium signals, but the signals can be predicted from scratch within the m-files (see instructions below).   

Connectome figures can be recreated with the Jupyter notebooks `fanc_*`, `manc_*`, and `flywire_*`. 

The connectome simulation figure can be recreated with the Jupyter notebooks `simulation_*`. 

# Datasets
`rna-seq.xls`: RNA-seq data for hook, claw, and club neurons. 

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

`hook_flexion_03_bdn2.parquet`: Calcium imaging data from hook flexion axons with and without activation of descending neuron BDN2.

`pmt_control.parquet`: GFP fluorescence from FeCO axons following the start-up of the microscope PMT. 

The connectome simulation runs on data from the MANC connectome, which can be found in the subfolder `simulation`. 
`classifications_manc_v1.csv` contains information about each neuron's name, type, and predicted neurotransmitter. 
`completeness_manc_v1` contains all neurons that can be included in the simulation.  
`connectivity_manc_v1.parquet` contains information about the weighted connectivity between neurons. 
For more information on the data structure, see the original repository for the simulation: https://github.com/philshiu/Drosophila_brain_model. 


## Figure 1  
Figure 1d: Run `fanc_synapse_locations.ipynb`. Select `['claw_flx','claw_ext']` or `['hook_flx','hook_ext']` as cell type. To plot postsynaptic sites, set `query_input_syn = True`. To plot presynaptic sites, set `query_input_syn = False`. 

Figure 1e: Run `fanc_synapse_transmitters.ipynb`. Select `['claw_flx','claw_ext']` or `['hook_flx','hook_ext']` as cell type.

Figure 1f: Run `rna-seq_plot_expression.m`. 


## Figure 2
Figure 2d: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trials = "20200630_A01_00003";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 2e: Run `imaging_plot_xcorr.m` with these settings: 
```
settings.parquet_file = 'claw_treadmill';
settings.trial_to_highlight = "20200630_A01_00003";
settings.ball = 1;
settings.platform = 0;
```

Figure 2f: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.ball = 1;
settings.platform = 0;
settings.epoch_type = 'L1_rest'; 
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Plot `epochs.calcium_norm_L1_rest` or `epochs.predicted_calcium_norm_L1_rest` versus `epochs.L1C_flex_L1_rest` (see end of m-file).

Figure 2g: Run `imaging_plot_transitions.m` with these settings:
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
Figure 3b: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210720_A01_00019";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 3c: `imaging_plot_xcorr.m` with these settings for the treadmill data: 
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

Figure 3d: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_rest'`, `'L1_walk'`, or `'L1_groom'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 3e: Run `imaging_plot_transitions.m` with these settings:
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

Figure 3g: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20230209_A01_00004";
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 3h: Run `imaging_plot_transitions.m` with these settings:
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
Figure 4a: Run `fanc_feco_connectivity.ipynb`.

Figure 4c, top: Run `fanc_feco_connectivity.ipynb`. 

Figure 4c, bottom: Run `fanc_9A_connectivity.ipynb`, cells `9A outputs onto hook`.

Figure 4e: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00006";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 4f: Run `imaging_plot_transitions.m` with these settings:
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

Figure 4g: Run `imaging_plot_xcorr.m` with these settings for the treadmill data: 
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

Figure 4h: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00039";
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 4i: Run `imaging_plot_epochs.m` with these settings:
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
Figure 5a, top: Run `fanc_9A_connectivity.ipynb`, cells `9A input from sensory or descending neurons`. Set `tag = 'sensory neuron'`.

Figure 5a, middle: Run `fanc_9A_connectivity.ipynb`, cells `9A input from premotor neurons`. Set `tag = 'descending'`.

Figure 5a, bottom: Run `fanc_9A_connectivity.ipynb`, cells `9A input from sensory or descending neurons`. Set `tag = 'descending'`.

Figure 5c, bottom: Sum values of Extended Data Fig.9e (see below).

Figure 5d: Run `flywire_plot_neuron.ipynb`. For top view, set `view = ('-x','-z')`. For posterior view, set `view = ('-x','-y')`. 

Figure 5f: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trials = "240122_A01_00026";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 5g: Run `imaging_plot_transitions.m` with these settings:
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

Figure 5h: Run `imaging_plot_xcorr.m` with these settings:
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

Figure 5i: First, run `simulation_run_model.ipynb`. For activating BDN2, set `experiment_name = "BDN2"` and `neurons_to_excite = [10093]`. For activating DNg12, set `experiment_name = "DNg12"` and `neurons_to_excite = [32815, 31635, 32742, 31078]`. For co-activating the web neuron, append `10107` to list of neurons to excite. 

Then, after running the simulations, run `simulation_parquet_to_csv.ipynb` for each simulation. Set `experiment_name` and `neurons_excited` accordingly. 

Finally, run `simulation_plot_results.ipynb` to read out and plot the simulated spike rates for chief 9A neurons in T1L (`100513`), T2L (`13157`), and T3L (`14517`). 


## Extended Data Figure 2
Figure 2a and 2b,c: Run `imaging_fit_activation_function.m` with these settings:
```
settings.parquet_file = 'claw_magnet_Mamiya2018';
settings.model_activation_function = 'claw';
settings.roi = {'L1_x','L1_y','L1_z'};
```

Figure 2a and 2d,e: Run `imaging_fit_activation_function.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_magnet_Mamiya2018';
settings.model_activation_function = 'hook_flex';
settings.roi = {'L1_medial'};
```

Figure 2a and 2f,g: Run `imaging_fit_activation_function.m` with these settings:
```
settings.parquet_file = 'club_magnet_Mamiya2018';
settings.model_activation_function = 'club';
settings.roi = {'L1_x'};
```

In `Plot time courses for a specific stimulus`, set `stimulus_to_plot = 'ramp_hold_flex_first'` or `stimulus_to_plot = 'ramp_hold_ext_first'`. 

Figure 2h: Run `imaging_hook_model_example.m`.


## Extended Data Figure 3
Figure 3a: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.ball = 1;
settings.platform = 0;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = 1; 
```
Set `settings.epoch_type` to `'L1_rest'`, `'L1_walk'`, or `'L1_groom'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 3b: Run `imaging_plot_transitions.m` with these settings:
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
Set `settings.transition_parameter` to `'L1_walk'` or `'L1_groom'`. For each transition parameter, run the m-file with `settings.transition_type` set to `'onset'`, manually save `mean_post_calcium_norm - mean_post_predicted_calcium`, run the m-file again with `settings.transition_type` set to `'offset'`, combine `mean_post_calcium_norm - mean_post_predicted_calcium` with the previously saved values, and then plot the combined values (see end of m-file).  

Figure 3c: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'claw_treadmill';
settings.trials = "20191209_A01_00012";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
``` 

Figure 3d: Run `imaging_plot_xcorr.m` with these settings:
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


## Extended Data Figure 4
Figure 4a: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210707_A01_00020";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 4b: Run `imaging_plot_epochs.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.ball = 0;
settings.platform = 1;
settings.parameters = {'calcium_norm','predicted_calcium_norm','L1C_flex'};
settings.min_epoch_win = .5; 
```
Set `settings.epoch_type` to `'L1_move'` or `'annotation'`. Plot `calcium_norm` or `predicted_calcium_norm`. 

Figure 4c: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trials = "20210712_A01_00002";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 4d: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_01_treadmill_platform';
settings.trial_to_highlight = "20210712_A01_00002";
settings.ball = 0;
settings.platform = 0;
```

Figure 4e: Run `imaging_plot_transitions.m` with these settings:
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

Figure 4f: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trials = "20200219_A01_00010"; 
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 4g: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trial_to_highlight = "20200219_A01_00010";
settings.ball = 1;
settings.platform = 0;
```

Figure 4h: Run `imaging_plot_transitions.m` with these settings:
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

Figure 4i: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trials = "20200224_A01_00029";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 4j: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_flexion_02_treadmill';
settings.trial_to_highlight = "20200224_A01_00029";
settings.ball = 0;
settings.platform = 0;
```

Figure 4k: Run `imaging_plot_transitions.m` with these settings:
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


## Extended Data Figure 5
Figure 5b: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20211122_A01_00003";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 5c: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211122_A01_00003";
settings.ball = 1;
settings.platform = 0;
```

Figure 5d: Run `imaging_plot_transitions.m` with these settings:
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

Figure 5e: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20211201_A01_00026";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 5f: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20211201_A01_00026";
settings.ball = 0;
settings.platform = 0;
```

Figure 5g: Run `imaging_plot_transitions.m` with these settings:
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

Figure 5h: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trials = "20230213_A01_00003";
settings.parameters_to_plot = {'analyze','L1_move','annotation','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 5i: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'hook_extension_treadmill_platform';
settings.trial_to_highlight = "20230213_A01_00003";
settings.ball = 0;
settings.platform = 1;
```

Figure 5j: Run `imaging_plot_transitions.m` with these settings:
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

Figure 5k: Run `imaging_plot_epochs.m` with these settings:
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


## Extended Data Figure 6
Figure 6c, left: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.trials = "R21D12_09_walkingreplay01_L1_medial";
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 6c, right: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_flexion_01_magnet';
settings.trials = "R21D12_09_groomingreplay01_L1_medial";
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 6d: Run `imaging_plot_transitions.m` with these settings:
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

Figure 6e: Run `imaging_plot_xcorr.m` with these settings:
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

Figure 6f, left: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_extension_magnet';
settings.trials = "JR476_04_walkingreplay01_L1_medial";
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 6f, right: Run `imaging_plot_trial.m` with these settings for the left panel:
```
settings.parquet_file = 'hook_extension_magnet';
settings.trials = "JR476_03_groomingreplay01_L1_medial";
settings.parameters_to_plot = {'analyze','stimulus','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 6g: Run `imaging_plot_transitions.m` with these settings:
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

Figure 6h: Run `imaging_plot_xcorr.m` with these settings:
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


## Extended Data Figure 7
Figure 7a: Run `rna-seq_plot_expression.m`. 

Figure 7c: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trials = "20210609_A01_00002";
settings.parameters_to_plot = {'analyze','L1_move','L1_walk','L1_groom','L1C_flex','predicted_calcium_norm','calcium_norm','vel_forward'};
```

Figure 7d: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trial_to_highlight = "20210609_A01_00002";
settings.ball = 1;
settings.platform = 0;
```

Figure 7e: Run `imaging_plot_transitions.m` with these settings:
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

Figure 7f: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trials = "20210608_A01_00029";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 7g: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = 'club_treadmill';
settings.trial_to_highlight = "20210608_A01_00029";
settings.ball = 0;
settings.platform = 0;
```

Figure 7h: Run `imaging_plot_transitions.m` with these settings:
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

Figure 7i: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'club_treadmill_removal';
settings.trials = "20210608_A01_00027";
settings.parameters_to_plot = {'analyze','L1_move','ball','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 7j: Run `imaging_plot_epochs.m` with these settings for the left panel:
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


## Extended Data Figure 8
Figure 8a: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trials = "20221118_A01_00023";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

Figure 8b: Run `imaging_plot_xcorr.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.trial_to_highlight = "20221118_A01_00023";
settings.ball = 0;
settings.platform = 0;
```

Figure 8c: Run `imaging_plot_transitions.m` with these settings:
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

Figure 8d: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = '9A_treadmill_platform';
settings.parameters_to_plot = {'L1_rest','L1_move','L1C_flex','calcium_norm'};
```
Set `settings.trials` to either `"20221118_A01_00002"`, `"20221118_A01_00003"`, or `"20221118_A01_00006"`.

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = '9A';
settings.model_parameters = 50;  
```

Figure 8f-i: Run `behavior_9A_activation_silencing.ipynb`. 


## Extended Data Figure 9
Figure 9c: Run `manc_9A_web_connectivity.ipynb`. Set `source_name = 'chief_9A'` and run script with `source_index` set to `0`, `1`, `2`, `3`, `4`, and `5`.

Figure 9d,e: Run `fanc_DN_IN_connectivity.ipynb`.

Figure 9f: Run `manc_9A_web_connectivity.ipynb`. Set `source_name = 'web'` and run script with `source_index` set to `0`.

Figure 9g: Run `flywire_web_connectivity.ipynb`.


## Extended Data Figure 10
Figure 10b: Run `imaging_BDN2_activation.ipynb`. Set `file_name`to `hook_flexion_03_bdn2.parquet`. Run section `Plot data of specific trial`. For Figure 10b left, set `animal_id = 2` and `trial = 2`. For Figure 10b right, set `animal_id = 2` and `trial = 3`.

Figure 10c, left: Run `imaging_BDN2_activation.ipynb`. Set `file_name`to `hook_flexion_03_bdn2.parquet`. Run section `Align data to stimulus offset`. Set `animal_ids = [1,2,3,4,5]`, `trials = [2,4,6,8,10]`, and `stimulus_trials = [2,4,6,8,10]`. 

Figure 10c, right: Run same code as for 10c, left, but set `trials = [3,5,7,9,11]`.

Figure 10d: Run the same code as for Figure 10c, but compute `delta_calcium_exp` and `delta_calcium_control` in between. Then plot the change in calcium.  

Figure 10e: Run `imaging_BDN2_activation.ipynb`. Set `file_name`to `pmt_control.parquet`. Run section `Align data to stimulus offset `. Set `animal_ids = [1,2,3]`, `trials = [1,2,3,4,5,6,7,8,9,10,11,12]`, and `stimulus_trials = trials`.

Figure 10f: Run `imaging_plot_trial.m` with these settings:
```
settings.parquet_file = 'web_treadmill';
settings.trials = "240131_A01_00018";
settings.parameters_to_plot = {'analyze','L1_move','L1C_flex','predicted_calcium_norm','calcium_norm'};
```

To predict the calcium signals from scratch, run the above m-file(s) with the following settings:
```
settings.predict_calcium_signals = true;
settings.model_activation_function = 'web';
settings.model_parameters = [];  
```