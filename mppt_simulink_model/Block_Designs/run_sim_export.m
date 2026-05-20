% run_sim_export.m
% 1. Load parameters first
run('../matlab_code/parameters.m'); 
model = 'mppt'; 

% 2. Load model
if ~bdIsLoaded(model)
    load_system(model);
end

% 3. Set the basic Sim Time
set_param(model, 'StopTime', num2str(Sim_Time));

fprintf('Starting Simulation: %s for %0.2f seconds...\n', model, Sim_Time);

try
    % Run simulation - this creates the 'out' variable
    out = sim(model);
    
    % Save results
    save('sim_results.mat', 'out');
    fprintf('Success! Results saved to sim_results.mat\n');
    
    % Check if data is there
    if isprop(out, 'logsout')
        fprintf('Found %d logged signals.\n', out.logsout.numElements);
    end
catch ME
    fprintf('Simulation failed: %s\n', ME.message);
end
