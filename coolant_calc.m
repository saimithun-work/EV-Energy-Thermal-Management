% Given data
T_initial = -10; % Initial temperature of the coolant in Celsius
T_final = 20; % Final temperature of the coolant in Celsius
P = 101325; % Pressure in Pa
V = 5; % Total volume of coolant mixture in liters
Time = 1000; % Time duration in seconds
% Constants and properties
Cp_EG = 2420; % Specific heat capacity of ethylene glycol in J/(kg·K)
Cp_water = 4186; % Specific heat capacity of water in J/(kg·K)
w_EG = 0.5; % Mass fraction of ethylene glycol

% Convert volume to mass assuming density of water and ethylene glycol mixture
rho_water = 1000; % Density of water in kg/m^3
V_total = V / 1000; % Convert volume to cubic meters
m_total = V_total * rho_water; % Total mass of coolant mixture in kg

% Calculate the specific heat capacity of the coolant mixture
Cp_mix = w_EG * Cp_EG + (1 - w_EG) * Cp_water; % Specific heat capacity of the coolant mixture in J/(kg·K)

% Calculate the change in temperature
delta_T = T_final - T_initial; % Change in temperature in Celsius (corrected)

% Calculate the heat load
heat_load = m_total * Cp_mix * delta_T; % Heat load in J

% Convert heat load to kJ
heat_load_kJ = heat_load / 1000; % Total heat load in kJ

% Convert heat load to kW
heating_power_kW = heat_load / (1000 * Time); % Heating power in kW (renamed from cooling power)

% Display the results
fprintf('Total heat load: %.2f kJ\n', heat_load_kJ);
fprintf('Heating power: %.2f kW\n', heating_power_kW);
