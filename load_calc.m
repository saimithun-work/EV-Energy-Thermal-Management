% Given data
T_initial = -10; % Initial temperature in Celsius
RH_initial = 50; % Initial relative humidity in percentage
T_final = 20; % Final temperature in Celsius
RH_final = 50; % Final relative humidity in percentage
P = 101325; % Pressure in Pa
V = 4; % Volume of humid air in cubic meters
Time = 60; % Time duration in seconds
% Constants and properties
R = 287.05; % Specific gas constant for dry air in J/(kg·K)
Cp = 1005; % Specific heat capacity of dry air at constant pressure in J/(kg·K)

% Calculate saturation vapor pressure using Magnus equation
e_sat_initial = 6.112 * exp((17.67 * T_initial) / (T_initial + 243.5)); % in Pa
e_sat_final = 6.112 * exp((17.67 * T_final) / (T_final + 243.5)); % in Pa

% Calculate specific humidity at initial and final conditions
omega_initial = 0.622 * (RH_initial / 100) * e_sat_initial / (P - (1 - (RH_initial / 100)) * e_sat_initial); % in kg/kg dry air
omega_final = 0.622 * (RH_final / 100) * e_sat_final / (P - (1 - (RH_final / 100)) * e_sat_final); % in kg/kg dry air

% Calculate latent heat of vaporization at initial and final temperatures (converted to J/kg)
h_fg_initial = 2501000 - 4184 * T_initial; % Latent heat of vaporization at initial temperature in J/kg
h_fg_final = 2501000 - 4184 * T_final; % Latent heat of vaporization at final temperature in J/kg

% Calculate enthalpies at initial and final conditions
h_initial = Cp * (T_initial + 273.15) + omega_initial * h_fg_initial; % Initial enthalpy in J/kg dry air
h_final = Cp * (T_final + 273.15) + omega_final * h_fg_final; % Final enthalpy in J/kg dry air

% Calculate change in enthalpy
delta_h = h_final - h_initial; % Change in enthalpy in J/kg dry air

% Mass flow rate of air assuming standard conditions
rho_air_initial = P / (R * (T_initial + 273.15)); % Density of air at initial condition in kg/m^3
m_air = rho_air_initial * V; % Mass of air in kg

% Total heat load
heat_load = delta_h * m_air; % Total heat load in J
% Convert heat load to kJ
heat_load_kJ = heat_load / 1000; % Total heat load in kJ

% Heating power
heating_power = heat_load / Time; % Heating power in W
% Convert heating power to kW
heating_power_kW = heating_power / 1000; % Heating power in kW

% Display the results
fprintf('Total heat load: %.2f kJ\n', heat_load_kJ);
fprintf('Heating Power: %.2f kW\n', heating_power_kW);
