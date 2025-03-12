% IMAGING_HOOK_MODEL_EXAMPLE.m plot the response of the hook flexion model to an artifical joint angle time course 
% 
% Functions/toolboxes required:
%    imaging_predict_gcamp.m
% 
% See also imaging_predict_gcamp.m

% Author: Chris J. Dallmann 
% Affiliation: University of Wuerzburg
% Last revision: 11-March-2025

% ------------- BEGIN CODE -------------

clear, clc

dt = 0.003; % s

% Initial rest phase
t_all = 0:dt:10; 
idx = find(t_all<2); 
stim(idx) = 90; 

% Walking bout
f = 10; % Hz
a = 30; % deg
idx = find(t_all>=1 & t_all<4); 
stim(idx) = sin(2*pi*dt/(1/f*dt).*idx.*dt).*a+90; 

% Slow flexion after walking bout 
tau = 1;
idx = find(t_all>=4 & t_all<5.5); 
t = t_all(1:numel(idx));
decay = (exp(-t./tau));
decay = decay-decay(1);
decay = decay./max(abs(decay));
a = 30; % deg
decay = decay.*a;
stim(idx) = stim(end)+decay; 

idx = find(t_all>=5.5 & t_all<6); 
stim(idx) = stim(end);

% Single slow flexion
idx = find(t_all>=6 & t_all<=8);
stim(end) = 90;
t = t_all(1:numel(idx));
tau = 1;
decay = (exp(-t./tau));
decay = decay-decay(1);
decay = decay./max(abs(decay));
a = 30; % deg
decay = decay.*a;
stim(idx) = stim(end)+decay; 

idx = find(t_all>8 & t_all<10); 
stim(idx) = stim(end);

% Predict GCaMP for three different velocity thresholds
model_1 = imaging_predict_gcamp(stim,1/dt,'hook_flex',-50);
model_2 = imaging_predict_gcamp(stim,1/dt,'hook_flex',-25);
model_3 = imaging_predict_gcamp(stim,1/dt,'hook_flex',0);

% Plot example
figure
s(1) = subplot(211);
    plot(t_all, stim)
    ylabel('Angle (deg)')
    set(gca,'Color','none','XTickLabel','')
    ylim([0,180])
    box off
s(2) = subplot(313);
    hold on
    model_max = max([model_1; model_2; model_3]);
    plot(t_all, model_1./model_max)
    plot(t_all, model_2./model_max)
    plot(t_all, model_3./model_max)
    hold off
    l = legend({'-50 deg/s', '-10 deg/s', '0 deg/s'});
    set(l,'color','none');
    xlabel('Time (s)')
    ylabel('Predicted calcium')
    set(gca,'Color','none')
    ylim([-0.05,1.05])
linkaxes([s(1) s(2)],'x')
