%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PhasePlane.m
% Written by: Prof. Edholm 
%
% For creating phase planes
%
% Edited by: Cameron Hater
%
% For application to Human Endurance Model
%
% Last Edited: December 11, 2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all % This erases the Workspace 
close all % This closes all previous plots


%% Define the system
f = @humanEnduranceModel; 
work = 0.2;

%define the grid on which to plot the phase plane
y1 = linspace(0,1,40);%x direction
y2 = linspace(0,1,20);%y direction

% creates two matrices one for all the x-values on the grid, and one for
% all the y-values on the grid. Note that x and y are matrices of the same
% size and shape, in this case 20 rows and 20 columns
[x,y] = meshgrid(y1,y2);
size(x)
size(y)


% compute the vector field
u = zeros(size(x));
v = zeros(size(x));

%% We can use a single loop over each element to compute the derivatives at
% each point (y1, y2)
t=0; % we want the derivatives at each point at t=0, i.e. the starting time
for i = 1:numel(x)
    Yprime = f(t,[x(i); y(i); work]);
    u(i) = Yprime(1);
    v(i) = Yprime(2);
end


%the following makes all arrows a larger size
%to make them more visible. Remove if you want arrows
% to represent the level of flow at the given point (will be small near
%nullclines)

for i = 1:numel(x)
Vmod = sqrt(u(i)^2 + v(i)^2);
u(i) = u(i)/Vmod;
v(i) = v(i)/Vmod;
end

%% Plot the vector field using quiver
quiver(x,y,u,v,'r'); figure(gcf)
title('Phase Plane', 'FontSize', 24); 
set(gca,'FontSize',18)   
xlabel('Alactic Levels')
ylabel('Lactic Levels')
ylim([0, 1])
xlim([0, 1])


