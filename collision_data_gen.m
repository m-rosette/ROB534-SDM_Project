function collision_data_gen(robot, num_dim, num_samples, filename)
% Self Collision Data Generation Function
% Full DOF Bravo Arm
% Marcus Rosette
% 02/21/2023

% Setup .mat file storage method
if isfile(filename)
    error("File '" + filename + "' already exists. Choose new file name")
end
file = matfile(filename, 'Writable', true); % Create new file instance

disp("Starting Collision Data Generation...")

% Joint Limits
joint_lim1 = linspace(0, pi, num_samples);
joint_lim2 = linspace(0, 2*pi, num_samples); 

% Iteratively sample and test joint space for collisions
range = 1:num_samples; % loop range for each joint
iterations = 1; % Start the counter

if num_dim == 3
    tic
    for joint2 = range
        for joint3 = range
            for joint5 = range
                if ~mod(iterations, 1000)
                    elapsedTime = toc;
                    estimatedTime = (num_samples ^ num_dim) / (iterations / elapsedTime);
                    ETA = estimatedTime - elapsedTime;
                    disp(['ETA: ', num2str(ETA/60),' minutes']);
                end
    
                current_config = [joint_lim1(joint2); joint_lim1(joint3); joint_lim1(joint5)];
                collision_check = checkCollision(robot, current_config, 'Exhaustive', 'on', 'SkippedSelfCollisions','parent');

                % Save theta combination
                file.thetas(iterations, 1:3) = current_config';
                
                % Calculate and save end effector point
                transform = getTransform(robot, current_config, "end_effector_tip", "world");
                file.ee_points(iterations, 1:3) = transform(1:3, 4)';
                
                % Save the collision label
                file.label(iterations, 1) = collision_check;

                % Increment count
                iterations = iterations + 1;
            end
        end
    end
    toc
end

if num_dim == 6
    tic
    for joint1 = range
        for joint2 = range
            for joint3 = range
                for joint4 = range
                    for joint5 = range
                        for joint6 = range
                            % Calculate ETA of program runtime
                            if ~mod(iterations, 1000)
                                elapsedTime = toc;
                                estimatedTime = (num_samples ^ num_dim) / (iterations / elapsedTime);
                                ETA = estimatedTime - elapsedTime;
                                disp(['ETA: ', num2str(ETA/60),' minutes']);
                            end

                            current_config = [joint_lim2(joint1); joint_lim1(joint2); joint_lim1(joint3); joint_lim2(joint4); joint_lim1(joint5); joint_lim2(joint6)];
                            collision_check = checkCollision(robot, current_config, 'Exhaustive', 'on', 'SkippedSelfCollisions','parent');
                            
                            % Save theta combination
                            file.thetas(iterations, 1:6) = current_config';
                            
                            % Calculate and save end effector point
                            transform = getTransform(robot, current_config, "end_effector_tip", "world");
                            file.ee_points(iterations, 1:3) = transform(1:3, 4)';
                            
                            % Save the collision label
                            file.label(iterations, 1) = collision_check;

                            % Increment count
                            iterations = iterations + 1;
                        end
                    end
                end
            end
        end 
    end
    toc
end
file.ElapsedTime = toc;  
disp("Collision Data Generation Complete")                                                                                                                                                                                                                                                                                                                                                                                                                                