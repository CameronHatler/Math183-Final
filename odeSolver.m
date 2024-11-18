%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% odeSolver.m code used for final project
%
% uses humanEnduranceModel.m to solve 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all % This erases the Workspace 
close all % This closes all previous plots

%% Solving Numerically ode45
x0=100;
y0=100;
z0 = 20;

initialvalues = [x0, y0, z0];

tspan = (0:0.1:10);

[t,y] = ode45(@(t,y) humanEnduranceModel(t,y),tspan,initialvalues);

x1 = y(:,1);

x2 = y(:,2);

figure(2)
plot(tspan, x1, tspan, x2,'linewidth',2)
legend('Alactic Energy', 'Lactic Energy','Location','best')
title('Small Amount of Work', 'FontSize', 24);         
set(gca,'FontSize',18)                                                    
xlabel('Time Step')                                                 
ylabel('Energy Left') 
ylim([99 100])

