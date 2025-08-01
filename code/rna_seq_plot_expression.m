% RNA_SEQ_PLOT_EXPRESSION.m plots RNA-seq data in Dallmann et al. (2025)
% 
% Files required: 
%    rna-seq.xlsx

% Author: Chris J. Dallmann 
% Affiliation: University of Wuerzburg
% Last revision: 08-March-2025

% ------------- BEGIN CODE -------------

clear, clc

% Load RNA-seq data 
table_claw = readtable('../data/rna-seq.xlsx','Sheet','claw');
table_hook = readtable('../data/rna-seq.xlsx','Sheet','hook');
table_club = readtable('../data/rna-seq.xlsx','Sheet','club');

data_claw = table_claw{1:end,2:end};
data_hook = table_hook{1:end,2:end};
data_club = table_club{1:end,2:end};

% Calculate mean expression and fraction of cells with expression
expression_claw = mean(data_claw);
fraction_claw = sum(data_claw>0)./size(data_claw,1); 

expression_hook = mean(data_hook);
fraction_hook = sum(data_hook>0)./size(data_hook,1); 

expression_club = mean(data_club);
fraction_club = sum(data_club>0)./size(data_club,1); 

% Set grayscale
expression_max = max([expression_hook, expression_claw, expression_club]); 
color_claw = 1-ones(length(expression_claw),3).*expression_claw'./expression_max;
color_hook = 1-ones(length(expression_hook),3).*expression_hook'./expression_max;
color_club = 1-ones(length(expression_club),3).*expression_club'./expression_max;

% Plot 
figure
hold on
for i = 1:length(expression_hook)
    if fraction_claw(i) > 0
        plot(i, 3, 'o', 'MarkerSize', fraction_claw(i)*10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_claw(i,:))
    end
    if fraction_hook(i) > 0
        plot(i, 2, 'o', 'MarkerSize', fraction_hook(i)*10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_hook(i,:))
    end
    if fraction_club(i) > 0
        plot(i, 1, 'o', 'MarkerSize', fraction_club(i)*10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_club(i,:))
    end
end
hold off
xlim([0,28])
ylim([0.5,3.5])
set(gca, ...
    'Color', 'none', ...
    'XTick', 1:length(expression_hook), ...
    'XtickLabel', table_hook.Properties.VariableNames(2:end), ...
    'TickLabelInterpreter', 'none', ...
    'YTick', [1,2,3], ...
    'YTickLabel', {'Club','Hook','Claw'})
cb = colorbar;
clim([0,expression_max])
colormap(flipud(gray))
ylabel(cb,'Mean expression in group')