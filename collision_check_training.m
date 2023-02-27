function collision_check_training(data, ground_truth, filename)

% Train self collision model 
% Marcus Rosette
% 02/21/2023

% Setup file storage method
if isfile(filename)
    error("File '" + filename + "' already exists. Choose new file name")
end

disp("Training SVM Model...")

% Call machine learning function
tic
Mdl = fitcsvm(data, ground_truth, "KernelFunction","rbf", "Solver", 'SMO');
toc

% Save the trained data (default = .mat)
saveLearnerForCoder(Mdl, filename)

disp(toc)
disp("Training Complete")