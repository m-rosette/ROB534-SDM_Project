function [accuracy, svm_avg_runtime, gt_avg_runtime, runtime_ratio, model_type] = model_eval(method, model, robot, tests)

% Initialize comparison variable storage
false_prediction_count = 0;
time_ratios = zeros(tests, 1);
svm_time = zeros(tests, 1);
gt_time = zeros(tests, 1);

if method == 1
    model_type = "Planar";

    % Initialize config storage
    configurations = zeros(tests, 3);
end

if method == 2
    model_type = "Full";

    % Initialize config storage
    configurations = zeros(tests, 6);
end

for i = 1:tests
    j1 = rand*(2*pi);
    j2 = rand*(pi);
    j3 = rand*(pi);
    j4 = rand*(2*pi);
    j5 = rand*(pi);
    j6 = rand*(2*pi);

    % Generate random configuration within joint limits
    if method == 1
        current_config = [j2, j3, j5];
    end
    if method == 2
        current_config = [j1, j2, j3, j4, j5, j6];
    end

    configurations(i, :) = current_config;
    
    % Ground truth collision check
    tic
    collision_check = checkCollision(robot, current_config', 'Exhaustive', 'on', 'SkippedSelfCollisions','parent');
    gt_time(i) = toc;
    
    % Predicted collision check
    tic
    [label, score] = predict(model, current_config);
    svm_time(i) = toc;
    
    time_ratios(i) = gt_time(i)/svm_time(i);
    
    if collision_check ~= label
        false_prediction_count = false_prediction_count + 1;
%         disp("Predicted not equal to ground truth")
    end
end

accuracy = 1 - false_prediction_count / tests;
svm_avg_runtime = sum(svm_time, "all") / tests;
gt_avg_runtime = sum(gt_time, "all") / tests;
runtime_ratio = sum(time_ratios, "all") / tests;