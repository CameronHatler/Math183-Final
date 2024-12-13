% Define the humanEnduranceModel function handle
model = @(t, y) humanEnduranceModel(t, y);

% Define the point where you want to compute the Jacobian and eigenvalues
p_val = 0.8;  % Example value for p
l_val = 0.5;  % Example value for l
w_val = 0.1;  % Example value for w

% State vector at which to evaluate
y_val = [p_val; l_val; w_val];

% Small perturbation for numerical differentiation
epsilon = 1e-6;

% Preallocate Jacobian matrix
n = length(y_val);
Jacobian = zeros(n);

% Compute Jacobian using finite differences
for i = 1:n
    % Perturb the i-th state variable
    y_perturbed = y_val;
    y_perturbed(i) = y_perturbed(i) + epsilon;
    
    % Evaluate the model at the perturbed state
    f_perturbed = model(0, y_perturbed);
    
    % Evaluate the model at the original state
    f_original = model(0, y_val);
    
    % Approximate derivative (finite difference)
    Jacobian(:, i) = (f_perturbed - f_original) / epsilon;
end

% Compute eigenvalues of the Jacobian
eigenvalues = eig(Jacobian);

% Display results
disp('Jacobian matrix at the specified point:');
disp(Jacobian);

disp('Eigenvalues of the Jacobian:');
disp(eigenvalues);