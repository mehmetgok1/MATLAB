%%
% Create a new fuzzy inference system
fis = mamfis('Name', 'mpptfuzzy');

% Define the input variable with the range [0.1 0.9]
fis = addInput(fis, [0.1 0.9], 'Name', 'D');

% Define the membership functions
fis = addMF(fis, 'D', 'zmf', [0.1167 0.25], 'Name', 'NL');
fis = addMF(fis, 'D', 'trimf', [0.133333 0.3 0.466667], 'Name', 'NS');
fis = addMF(fis, 'D', 'trimf', [0.333333 0.5 0.666667], 'Name', 'Z');
fis = addMF(fis, 'D', 'trimf', [0.533333 0.7 0.866667], 'Name', 'PS');
fis = addMF(fis, 'D', 'smf', [0.751372 0.884672], 'Name', 'PL');

% Plot the membership functions
figure;
plotmf(fis, 'input', 1);
title('Membership Function Plot',"FontWeight","normal");
xlabel('Output Variable "D" ');
ylabel('Degree of Membership');
set(gca, 'FontSize', 12); % Adjust font size
h = findobj(gca, 'Type', 'line'); % Find all line objects in the current axes
set(h, 'LineWidth', 2.2); % Set line width to 2 (or any other value you prefer)
grid on;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fis = mamfis('Name', 'mpptfuzzy');

% Define the input variable with the range [0.1 0.9]
fis = addInput(fis, [-0.5 0.5], 'Name', 'DP');

% Define the membership functions
fis = addMF(fis, 'DP', 'zmf', [-0.09583 -0.0625], 'Name', 'NL');
fis = addMF(fis, 'DP', 'trimf', [-0.0916667 -0.05 -0.00833333], 'Name', 'NS');
fis = addMF(fis, 'DP', 'trimf', [-0.0416667 0 0.0416667], 'Name', 'ZE');
fis = addMF(fis, 'DP', 'trimf', [0.00833333 0.05 0.0916667], 'Name', 'PS');
fis = addMF(fis, 'DP', 'smf', [0.0625 0.09583], 'Name', 'PL');

% Plot the membership functions
figure;
plotmf(fis, 'input', 1);
title('Membership Function Plot',"FontWeight","normal");
xlabel('Input Variable "DP" (W)');
ylabel('Degree of Membership');
set(gca, 'FontSize', 12); % Adjust font size
h = findobj(gca, 'Type', 'line'); % Find all line objects in the current axes
set(h, 'LineWidth', 2.2); % Set line width
xlim([-0.5 0.5]); % Ensure x-axis range is correct
grid on;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fis = mamfis('Name', 'mpptfuzzy');

% Define the input variable with the range [0.1 0.9]
fis = addInput(fis, [-0.3 0.3], 'Name', 'DV');

% Define the membership functions
fis = addMF(fis, 'DV', 'zmf', [-0.09583 -0.0625], 'Name', 'NL');
fis = addMF(fis, 'DV', 'trimf', [-0.0916667 -0.05 -0.00833333], 'Name', 'NS');
fis = addMF(fis, 'DV', 'trimf', [-0.0416667 0 0.0416667], 'Name', 'ZE');
fis = addMF(fis, 'DV', 'trimf', [0.00833333 0.05 0.0916667], 'Name', 'PS');
fis = addMF(fis, 'DV', 'smf', [0.0625 0.09583], 'Name', 'PL');

% Plot the membership functions
figure;
plotmf(fis, 'input', 1);
title('Membership Function Plot',"FontWeight","normal");
xlabel('Input Variable "DV" (V) ');
ylabel('Degree of Membership');
set(gca, 'FontSize', 12); % Adjust font size
h = findobj(gca, 'Type', 'line'); % Find all line objects in the current axes
set(h, 'LineWidth', 2.2); % Set line width to 2 (or any other value you prefer)
grid on;