data = load("data\collision_data.mat");
thetas = data.thetas;
ee_points = data.ee_points;
ground_truth = data.label;

trained_model = "data/trained_model_opt.mat";
collision_check_training(thetas, ground_truth, trained_model)
