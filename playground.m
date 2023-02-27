%% Instructions
% Follow section guide to go between planar and the full DOF model
% Change the following function parameters to accomidate dimension change
    % Import Robot URDF         --> urdf
    % Generate Collision Data   --> num_dim, filename
    % Train SVM Model           --> trained filename
    % Model Evaluation          --> method

%% Import Robot URDF

robot = importrobot('urdf/bravo7.urdf', DataFormat='column');


%% Generate Collision Data

filename = "data/collision_data.mat";
collision_data_gen(robot, 6, 10, filename)


%% Train SVM Model

data = load(filename);
thetas = data.thetas;
ee_points = data.ee_points;
ground_truth = data.label;

trained_model = "data/trained_model.mat";
collision_check_training(thetas, ground_truth, trained_model)


%% Model Evaluation

model = loadLearnerForCoder(trained_model);
[accuracy, svm_avg_runtime, gt_avg_runtime, runtime_ratio, model_type] = model_eval(2, model, robot, 1000);