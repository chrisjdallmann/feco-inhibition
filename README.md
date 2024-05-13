# Dallmann-2024
 Code for recreating figures in Dallmann et al . (2024)

This repository contains code for recreating figures in:

Dallmann CJ, Luo Y, Agrawal S, Chou GM, Cook A, Brunton BW, Tuthill JC (2024): Presynaptic inhibition selectively suppresses leg proprioception in behaving Drosophila. bioRxiv 2023.10.20.563322. doi: https://doi.org/10.1101/2023.10.20.563322 

Data will be available for download on Dryad. 

## Usage
Instructions on how to recreate individual figure panels are given in `code/README.md`.

## Requirements 
This repository contains Python 3 code and MATLAB code. 

The Python code was tested with the packages listed in `requirements.txt`. Currently, this code accesses the Drosophila connectomes via CAVEclient (FANC, FlyWire) or neuprint (MANC), which require an authentication token.

The MATLAB code was tested with MATLAB R2023a.  