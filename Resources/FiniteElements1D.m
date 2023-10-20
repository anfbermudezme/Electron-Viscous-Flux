% Parameters
number_of_elements = 200;  % number of elements
L = 1;  % length of domain
nu = 0.01;  % viscosity
f = 1.0;  % force
u0 = 0;  % BC at x=0
uL = 0;  % BC at x=L
dx = L / number_of_elements;  % size of each element

% Initialize matrices
K = zeros(number_of_elements+1, number_of_elements+1);
F = zeros(number_of_elements+1, 1);

% Assembly
for i = 1:number_of_elements
    k_local = [
        nu/dx - 0.5*(u0 + uL)/2, -nu/dx + 0.5*(u0 + uL)/2;
        -nu/dx - 0.5*(u0 + uL)/2, nu/dx + 0.5*(u0 + uL)/2;
    ];
    % Local load vector
    f_local = [f*dx/2; f*dx/2];
    
    % Assembly to global matrix
    K(i:i+1, i:i+1) = K(i:i+1, i:i+1) + k_local;
    F(i:i+1) = F(i:i+1) + f_local;
end

% Apply Dirichlet boundary conditions
K(1, :) = 0;
K(:, 1) = 0;
K(1, 1) = 1;
F(1) = u0;

K(end, :) = 0;
K(:, end) = 0;
K(end, end) = 1;
F(end) = uL;

% Solve
u = K\F;
x = linspace(0, L, number_of_elements+1);

% Plot
figure('Color', 'w');
plot(x, u, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'Color', 'k');
xlabel('Position (x)', 'FontSize', 10);
ylabel('Velocity (u)', 'FontSize', 10);
title('1D Navier-Stokes Velocity-Position', 'FontSize', 10);
grid on;
legend('Velocity', 'FontSize', 9);

