# feco-inhibition
This repository contains code for recreating figures in:

Dallmann CJ, Luo Y, Agrawal S, Mamiya A, Chou GM, Cook A, Sustar A, Brunton BW, Tuthill JC (2025): Selective inhibition of leg proprioception in behaving *Drosophila*. Nature. 

Data is available for download from Dryad: 

## Usage
Instructions on how to recreate individual figure panels are given in `code/README.md`. Information on the datasets is given on Dryad and in `data/README.md`.

## Requirements 
This repository contains Python 3 code and MATLAB code. 

The Python code was tested on Windows 10 with the packages listed in `requirements.txt`. The code accesses the *Drosophila* connectomes via CAVEclient (FANC, FlyWire) or neuprint (MANC), which require an authentication token. A token for FANC can be obtained by joining the [FANC community](https://github.com/htem/FANC_auto_recon/wiki#collaborative-community). A token for MANC can be obtained from [neuprint.janelia.org](https://neuprint.janelia.org/account).  

The MATLAB code was tested on Windows 10 with MATLAB R2023a. The `code` folder, its subfolders, and [matlab-toml](https://www.mathworks.com/matlabcentral/fileexchange/67858-matlab-toml) must be added to the Matlab path.  

## Installation
The code can be run on a standard computer. Installation of the Python packages should take 10 minutes. 

## Acknowledgements
This repository incorporates code for connectome-constrained modeling from [github.com/philshiu](https://github.com/philshiu/Drosophila_brain_model), which is licensed under the MIT license and accompanies the paper Shiu PK, Sterne GR, Spiller N et al. (2024): A *Drosophila* computational brain model reveals sensorimotor processing. Nature 634, 210–219. doi: https://doi.org/10.1038/s41586-024-07763-9.