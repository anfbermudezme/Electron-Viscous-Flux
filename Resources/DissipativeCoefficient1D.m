% Main plotting area
figure;
xlabel('Position (x)');
ylabel('Velocity (u)');
title('1D Navier-Stokes Velocity-Position with Different Damping Coefficients');
grid on;

% Run simulations with different damping coefficients
simulationWithDamping(0);
simulationWithDamping(0.1);
simulationWithDamping(0.5);
simulationWithDamping(1.0);

legend('Damping 0', 'Damping 0.1', 'Damping 0.5', 'Damping 1.0');
hold off;