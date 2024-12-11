%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Model for human endurance. Uses three variables to model endurance 
% energy systems, 
% 
% p: the energy in the alactic system
% l: the energy in the lactic system
% w: the work done
% 
% Written by: Cameron Hatler
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function deriv = humanEnduranceModel(t, y)

%% constants used in the model
mO = .002;  % maximal amount oxidative system contributes
mL = .2;  % maximal amount lactic system contributes
poThresh = 1;  % when oxidative system activates
plThresh = .8;  % when lactic system activates
lMax = 1;  % largest amount lactic levels can be
lMin = 0.065;  % smallest amount lactic levels can be

%% 'Steepness' of activation function
pC1 = 100;  % oxidative system activation
pC2 = 100;  % lactic system activation
lC = 100;  % lactic system deactivation
eC = 100;  % lactic extra energy activation

%% Hyperparameters
alpha = 1;  % energy consumed to work done ratio ratio
epsilon = 0;  % energy trickled back into lactic system

% set up
p = y(1);
l = y(2);
w = y(3);

%   finds change in lactic, alactic, and work
pChange = (mO*pOxygen(p)) + (mL*pLactic(p, l)) - (alpha*w);
lChange = (epsilon * sigmoid(-eC * (l - lMax))) - (mL * pLactic(p, l));
wChange = 0;

%   returns the derivative of these
deriv = [ pChange, lChange, wChange]';


%% Helper functions used to simplify expresions

% the change in energy due to the oxydative system
function change = pOxygen(pLevels)
    change = (sigmoid(-pC1 * (pLevels - poThresh)));
end

% the change in energy due to the lactic system
function change = pLactic(pLevels,lLevels)
    change = sigmoid(-pC2 * (pLevels - plThresh)) * sigmoid(lC * (lLevels - lMin));
end

% a sigmoid function 1/(1+e^{-x})
function sig = sigmoid(x)
    sig = 1 / (1 + exp(-x));
end
end
