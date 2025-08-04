# Overview of datasets
## Calcium imaging data from behaving animals
`claw_treadmill.parquet`: Calcium imaging data from claw axons during behavior on and off the treadmill.  

`hook_flexion_01_treadmill_platform.parquet`: Calcium imaging data from hook flexion axons (driver line 1) during behavior on and off the treadmill and passive leg movements with the platform.

`hook_flexion_02_treadmill.parquet`: Calcium imaging data from hook flexion axons (driver line 2) during behavior on and off the treadmill.

`hook_extension_treadmill_platform.parquet`: Calcium imaging data from hook extension axons during behavior on and off the treadmill and passive leg movements with the platform.

`club_treadmill.parquet`: Calcium imaging data from club axons during behavior on and off the treadmill.

`club_treadmill_removal.parquet`: Calcium imaging data from club axons when the treadmill was removed during the recording. 

`9A_treadmill_platform.parquet`: Calcium imaging data from 9A axons during behavior on and off the treadmill and passive leg movements with the platform.

`web_treadmill.parquet`: Calcium imaging data from DNg74 (web) axons during behavior on the treadmill.

## Calcium imaging data from fully restrained animals
`hook_flexion_01_magnet.parquet`: Calcium imaging data from hook flexion axons (driver line 1) during passive leg movements with the magnet. 

`hook_extension_magnet.parquet`: Calcium imaging data from hook extension axons during passive leg movements with the magnet.

`claw_magnet_Mamiya2018.parquet`: Calcium imaging data from claw axons during passive leg movements with the magnet (Mamiya et al. 2018). Used to tune the computational model. 

`hook_flexion_01_magnet_Mamiya2018.parquet`: Calcium imaging data from hook flexion axons (driver line 1) during passive leg movements with the magnet (Mamiya et al. 2018). Used to tune the computational model. 

`club_magnet_Mamiya2018.parquet`: Calcium imaging data from club axons during passive leg movements with the magnet (Mamiya et al. 2018). Used to tune the computational model. 

`hook_flexion_03_bdn2.parquet`: Calcium imaging data from hook flexion axons with and without activation of descending neuron DNg100 (BDN2).

`pmt_control.parquet`: GFP fluorescence from FeCO axons following the start-up of the microscope PMT. 

## Optogenetic activation and silencing data from behaving animals 
`9A_activation.parquet`: Behavioral data for optogenetic activation of 9A neurons in tethered walking flies. 

`9A_silencing.parquet`: Behavioral data for optogenetic silencing of 9A neurons in tethered walking flies. 

`control_activation.parquet`: Behavioral data for optogenetic activation of tethered walking control flies. 

`control_silencing.parquet`: Behavioral data for optogenetic silencing of tethered walking control flies. 

## RNA-seq data
`rna-seq.xlsx`: RNA-seq data for hook, claw, and club neurons. 

## Connectome data 
`fanc_dn_information.xlsx`: Connectome identifiers, predicted neurotransmitters, and community names for descending neurons of interest in the FANC connectome. 

`manc_v1_classifications.csv`: Connectome identifiers, names, and predicted neurotransmitter for neurons of the MANC connectome. 

`manc_v1_completeness.csv`: Connectome identifiers for neurons of the MANC connectome that can be included in the simulation.  

`manc_v1_connectivity.parquet`: Weighted synaptic connectivity between neurons of the MANC connectome.