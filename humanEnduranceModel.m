function deriv = humanEnduranceModel(t, y)

% constants used in the model
mO = 20;
mL = 20;
pThresh1 = 100;
pThresh2 = 50;
lMax = 0;
pC1 = 100;
pC2 = 100;
lC = 100;
alpha = 1;
epsilon = 0;

% set up
p = y(1);
l = y(2);
w = y(3);

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pChange = (mO*pOxygen(p))+(mL*pLactic(p, l))-(alpha*w);
lChange = epsilon - (mL * pLactic(p, l));
wChange = 0;

deriv = [ pChange, lChange, wChange]';


%% Helper functions used to simplify expresions

% the change in energy due to the oxydative system
function change = pOxygen(pLevels)
    change = (sigmoid(-pC1 * (pLevels - pThresh1)));
end

% the change in energy due to the lactic system
function change = pLactic(pLevels,lLevels)
    change = sigmoid(-pC2 * (pLevels - pThresh2)) * sigmoid(lC * (lLevels - lMax));
end

% a sigmoid function 1/(1+e^{-x})
function sig = sigmoid(x)
    sig = 1 / (1 + exp(-x));
end
end
