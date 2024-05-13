function idx = imaging_find_epochs(binary_signal,win_size)
%FIND_EPOCHS returns beginning and end indices of epochs of ones in binary signal that are at least win_size long 
%
%   idx = IMAGING_FIND_EPOCHS(binary_signal,win_size) returns beginning and end 
%   indices of epochs of ones in binary signal that are at least win_size 
%   long.
%   
%   binary_signal = vector containing zeros and ones 
%   win_size      = window size in samples

% Author: Chris J. Dallmann 
% Affiliation: University of Wuerzburg
% Last revision: 13-May-2024

% ------------- BEGIN CODE -------------

if nargin<2
    win_size = 1;
else
    win_size = round(win_size);
end

% % Example
% binary_signal = [1,1,1,0,1,0]; 
% win_size = 2;

% Identify frames of transitions
d = diff(binary_signal);

idx_01 = (find(d>0)+1)';
idx_10 = find(d<0)'; 

if any(d~=0) 
    % Deal with incomplete epochs at beginning and end of signal
    if isempty(idx_01) || isempty(idx_10) % If only one transition  
        if isempty(idx_01) 
            idx_01 = 1; 
        else
            idx_10 = numel(binary_signal);
        end
    else % If multiple transitions 
        if idx_10(1)<idx_01(1) % If signal starts with ongoing epoch of ones
            idx_01 = [1, idx_01];
        end
        if idx_01(end)>idx_10(end) % If signal ends with ongoing epoch of ones 
            idx_10 = [idx_10, numel(binary_signal)];
        end
    end
    % Include only epochs that are at least win_size long
    epochs = (idx_10-idx_01+1)>=win_size; % +1 because idx_10 marks last of ones, not first of zeros (see above) 
    if any(epochs==false)
        disp([num2str(numel(epochs)-sum(epochs)),' epoch(s) too short and discarded']);
    end
    idx_01 = idx_01(epochs);
    idx_10 = idx_10(epochs);

    idx = [idx_01', idx_10'];
else
    idx = [];
end

