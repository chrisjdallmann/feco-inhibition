# feco-inhibition
This repository contains code for recreating figures in:

Dallmann CJ, Luo Y, Agrawal S, Chou GM, Cook A, Brunton BW, Tuthill JC (2024): Presynaptic inhibition selectively suppresses leg proprioception in behaving Drosophila. bioRxiv 2023.10.20.563322. doi: https://doi.org/10.1101/2023.10.20.563322 

Data will be available for download on Dryad. 

## Usage
Instructions on how to recreate individual figure panels are given in `code/README.md`.

## Requirements 
This repository contains Python 3 code and MATLAB code. 

The Python code was tested on Windows 10 with the packages listed in `requirements.txt`. Currently, this code accesses the Drosophila connectomes via CAVEclient (FANC, FlyWire) or neuprint (MANC), which require an authentication token. 

The MATLAB code was tested on Windows 10 with MATLAB R2023a.  

## Installation
The code can be run on a standard computer. Installation of the Python packages should take 10 minutes. 

## Acknowledgements
This repository incorporates code for connectome-constrained modeling from https://github.com/philshiu/Drosophila_brain_model, which is licensed under the MIT license and accompanies the paper Shiu PK, Sterne GR, Spiller N et al. (2024): A Drosophila computational brain model reveals sensorimotor processing. Nature 634, 210–219. doi: https://doi.org/10.1038/s41586-024-07763-9.