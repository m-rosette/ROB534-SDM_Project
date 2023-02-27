robot = importrobot('urdf/bravo7.urdf', DataFormat='column');

model = loadLearnerForCoder("data\trained_model_opt.mat");
[accuracy, svm_avg_runtime, gt_avg_runtime, runtime_ratio, model_type] = model_eval(2, model, robot, 1000);