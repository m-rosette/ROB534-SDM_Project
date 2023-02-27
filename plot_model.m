raw_data = load("data/collision_data.mat");
collision_free_ee_points = raw_data.ee_points(raw_data.label == 0, :);
collision_ee_points = raw_data.ee_points(raw_data.label == 1, :);

% scatter3(collision_free_ee_points(:, 1), collision_free_ee_points(:, 2), collision_free_ee_points(:, 3), "filled")
% hold on
% scatter3(collision_ee_points(:, 1), collision_ee_points(:, 2), collision_ee_points(:, 3), "filled")

scatter(collision_free_ee_points(:, 1), collision_free_ee_points(:, 3), "filled")
% hold on
% scatter(collision_ee_points(:, 1), collision_ee_points(:, 3), "filled")
















% model = loadLearnerForCoder(trained_model);
% 
% [accuracy, svm_avg_runtime, gt_avg_runtime, runtime_ratio, model_type, configurations, ee_points] = model_eval(2, model, robot, 1000);
% 
% % Predict scores over the grid
% d = 0.02;
% [x1Grid, x2Grid, x3Grid] = meshgrid(min(ee_points(:,1)):d:max(ee_points(:,1)), min(ee_points(:,2)):d:max(ee_points(:,2)), min(ee_points(:,3)):d:max(ee_points(:,3)));
% xGrid = [x1Grid(:), x2Grid(:), x3Grid(:)];
% [~, scores] = predict(model, xGrid);
% 
% % Plot the data and the decision boundary
% figure;
% h(1:3) = gscatter(ee_points(:,1), ee_points(:,2), ee_points(:,3), theclass,'rb','.');
% hold on
% ezpolar(@(x)1);
% h(4) = plot(ee_points(model.IsSupportVector, 1), ee_points(model.IsSupportVector, 2), ee_points(model.IsSupportVector, 3), 'ko');
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% legend(h,{'-1','+1','Support Vectors'});
% axis equal
% hold off








