% Set nominal cooling temperature of the refrigeration system
T_set = 20; % [degC] Thermostat set point
 
% Cooling capacity of the refrigeration system (this parameter defines the
% size of the system)
CoolingPower_kW = 3; % [kW]
 
% Thermodynamic design parameters
evap_inlet_enthalpy = 267; % [kJ/kg] (from p-H diagram)
evap_outlet_enthalpy = 430; % [kJ/kg] (from p-H diagram)
 
evap_inlet_p = 0.934; % [MPa]
evap_superheat_temp = 5; % [deltaK]
 
% Set the evaporating temperature, or the saturation temperature in the
% evaporator, to be lower than the desired cabin temperature to enable
% heat transfer from the indoor air to the refrigerant.
nominal_evap_temp = T_set - 15; % [degC]
 
% Calculate the refrigerant mass flow rate using enthalpy difference
refrigerant_massflowrate = CoolingPower_kW/(evap_outlet_enthalpy-evap_inlet_enthalpy); % [kg/s] 
 
% To calculate air massflow rate, divide the cooling capacity by the heat
% capacity of air at constant pressure, and divide that result by the
% desired temperature drop across the evaporator
Cp_air = 1.005; % [kg/kJ/K] Cp heat for air
evap_temperature_drop = 5; % [degC], temperature drop across the evaporator
evap_air_massflowrate = CoolingPower_kW/Cp_air/evap_temperature_drop; % [kg/s]
 
% Define refrigerant pipe and air duct diameters
tube_D = 0.01; % [m] Refrigerant tube diameter
duct_W = 0.2; % [m] Air duct width
 
% Set the condensing temperature, or the saturation temperature in the
% condenser, to be higher than the outdoor temperature to enable heat
% transfer from the refrigerant to the outdoor environment.
nominal_condens_temp = 45; % [degC]
% Set a subcooling temperature of 5 deg
condenser_subcooling_temp = 5; % [deltaK]
condenser_inlet_temp = 40; % [degC]
condenser_inlet_enthalpy = 457; % [kJ/kg (from p-H diagram)
condenser_inlet_p = 2.734; % [MPa] (from p-H diagram)
 
% Mass flow rate for the condenser fan (design parameter)
condenser_air_massflowrate = 0.5; % [kg/s]
 
% Compressor nominal speed
RPM_Compressor_nominal = 1000; % [rpm]

cabin_L = 2; % [m] cabin length
cabin_W = 2; % [m] cabin width
cabin_H = 1.5; % [m] cabin height
door_or_window_area = 0.5; % [m^2] Door or window area 
T_cabin_init = -10; % [degC] Initial cabin temperature
RH_cabin_init = 0.5; % [-] Initial cabin relative humidity

air_density = 1.225; % [kg/m^3] at standard conditions
VolFlowrate_CondenserFan = condenser_air_massflowrate/air_density;% [m^3/s]
RPM_CondFan = 3000; % [rpm]
VolFlowRate_EvapFan = evap_air_massflowrate/air_density;% [m^3/s]
RPM_EvapFan = 3000; % [rpm]
VolFlowRate_CoolantRadiatorFan = 0.5;% [m^3/s]

coolant_pipe_D = 0.02;  % [m] coolant pipe diameter
coolant_circuit_thermal_mass = 20; % [kg]
coolant_circuit_length = 5; % [m]

radiator_cooling_power = 3; % [kW] radiator cooling power
air_density = 1.225; % [kg/m^3]
radiator_coolant_mass_flow_rate = 1; % [kg/s]
radiator_air_mass_flow_rate = air_density*VolFlowRate_CoolantRadiatorFan; % [kg/s] 

pump_displacement = 0.02;   % [l/rev] coolant pump displacement
pump_speed_max = 3000;   % [rpm] coolant pump rpm
coolant_density = 1092; % [kg/m^3] Density of Ethylene Glycol in Solution for Mass Fraction of 0.5
pump_nominal_massflowrate   = pump_displacement*1e-3*(pump_speed_max/60)*coolant_density; % [kg/s] used to parametrize the chiller's thermal fluid nominal mass flow rate

coolant_tank_volume         = 5;  % [l] coolant tank capacity
coolant_tank_area           = 0.11^2; % [m^2] coolant tank area


% Environment
T_env = -10; % [degC] External environment temperature
RH_env = 0.5; % External environment relative humidity
 
moist_air_p_init = 0.101325; % [MPa]
moist_air_T_init = T_env; % [degC]
moist_air_RH_init = RH_env; 
 
coolant_p_init         = 0.101325;   % [MPa] initial ccolant pressure
coolant_T_init         = 30;         % [degC] initial coolant temperature
 
% Initial refrigerant condition is set up automatically in the block mask
% using nominal values, if not uncomment and use below values 
refrigerant_T_init     = -10; % [degC] initial
%refrigerant temperature
refrigerant_p_init     = 1.0; % [MPa] initial refrigerant pressure
refrigerant_alpha_init = 0.76;% initial refrigerant vapor quality

%%

battery_C1_LUT = ...
  [1913.6 12447 30609;
   4625.7 18872 32995;
   23306 40764 47535;
   10736 18721 26325;
   18036 33630 48274;
   12251 18360 26839;
   9022.9 23394 30606];

battery_Em_LUT = ...
  [3.4966 3.5057 3.5148;
   3.5519 3.566 3.5653;
   3.6183 3.6337 3.6402;
   3.7066 3.7127 3.7213;
   3.9131 3.9259 3.9376;
   4.0748 4.0777 4.0821;
   4.1923 4.1928 4.193];

battery_N_cells = 20;

battery_Qe_init = 0;

battery_R0_LUT = ...
  [0.0117 0.0085 0.009;
   0.011 0.0085 0.009;
   0.0114 0.0087 0.0092;
   0.0107 0.0082 0.0088;
   0.0107 0.0083 0.0091;
   0.0113 0.0085 0.0089;
   0.0116 0.0085 0.0089];

battery_R1_LUT = ...
  [0.0109 0.0029 0.0013;
   0.0069 0.0024 0.0012;
   0.0047 0.0026 0.0013;
   0.0034 0.0016 0.001;
   0.0033 0.0023 0.0014;
   0.0033 0.0018 0.0011;
   0.0028 0.0017 0.0011];

battery_SOC_LUT = [0; 0.1; 0.25; 0.5; 0.75; 0.9; 1];

battery_T_init = -10;

battery_capacity_LUT = [280.081 276.25 276.392];

battery_cell_cp = 795;

battery_cell_mass = 2.5;

battery_temperature_LUT = [-10 0 5 20 40];

%%

coolant_channel_D = 0.0092;

%%

radiator_H = 0.2;

radiator_L = 0.6;

radiator_N_fins = 7199.9999999999991;

radiator_N_tubes = 25;

radiator_W = 0.015;

radiator_air_area_fins = 1.4625;

radiator_air_area_flow = 0.097499999999999989;

radiator_air_area_primary = 0.43687499999999996;

radiator_fin_spacing = 0.002;

radiator_gap_H = 0.0067708333333333336;

radiator_tube_H = 0.0015;

radiator_tube_Leq = 1.9;

radiator_wall_conductivity = 240;

radiator_wall_thickness = 0.0001;

cabin_CO2_init = 0.0004;

cabin_RH_init = 0.5;

cabin_T_init = -10;

cabin_duct_area = 0.04;

cabin_p_init = 0.101325;


%%

cabin_glass_conductivity = 1;

cabin_doors_conductivity = 0.2;

cabin_roof_conductivity = 0.2;

%%

T_dcdc_init = -10;
T_motor_init = -10;
T_inverter_init = -10;
T_charger_init = -10;
 
%T_coolant = -10;

T_bat_target = 20;

%%
%hold on % hold on the axes of the opened p-H plot figure
%uncomment below line to plot the refrigeration loop points
%plot([430 457 267 267 430], [0.934 2.734 2.734 0.934 0.934], 'k-o', LineWidth = 2)