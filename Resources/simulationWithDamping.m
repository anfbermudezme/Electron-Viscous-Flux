% Parameters
number_of_elements = 50;  % number of elements
L = 1;  % length of domain
nu = 0.01;  % viscosity
f = 1.0;  % force
u0 = 0;
uL = 0;
dx = L / number_of_elements;  % size of each element
beta_values = [0.05, 0.1, 0.15]; % Array of beta values

% Create a figure
figure;
hold on;

for b = 1:length(beta_values)
    beta = beta_values(b);

    K = zeros(number_of_elements + 1, number_of_elements + 1);
    F = zeros(number_of_elements + 1, 1);

    % Assembly
    for i = 1:number_of_elements
        k_local = [nu/dx - 0.5*(u0 + uL)/2 + beta, -nu/dx + 0.5*(u0 + uL)/2;
                   -nu/dx - 0.5*(u0 + uL)/2, nu/dx + 0.5*(u0 + uL)/2 + beta];

        % Local load vector
        f_local = [f * dx / 2; f * dx / 2];

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

    u = K \ F;
    x = linspace(0, L, number_of_elements + 1);

    plot(x, u, 'o-', 'LineWidth', 2, 'DisplayName', ['\beta = ' num2str(beta)]);
end

% Set plot details
xlabel('Position (x)');
ylabel('Velocity (u)');
title('1D Navier-Stokes Velocity-Position for Different \beta Values');
grid on;
legend;
hold off;
