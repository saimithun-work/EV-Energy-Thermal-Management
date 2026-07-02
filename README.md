# Efficient Thermal & Energy Management in EVs at Low Temperatures

A MATLAB/Simulink/Simscape model of an **Electric Vehicle Thermal Management System (EVTMS)** designed to maintain cabin comfort and battery temperature in cold-climate conditions. Developed as my MSc Automotive Engineering thesis at **Cranfield University** (2023–2024).

---

## Overview

Electric vehicles lose significant range in cold weather because cabin and battery heating draw directly on the traction battery. This project builds a physics-based test bench to study **where that energy goes** — component by component — so heating strategies can be evaluated before committing to hardware.

The model simulates warming a vehicle's cabin **and** battery from **−10 °C to a 20 °C target**, and reports the heat flow rates and power consumption of every major component along the way.

**Tools:** MATLAB / Simulink / Simscape (Simscape Fluids — two-phase refrigerant & moist-air domains)
**Model version:** R2024a

---

## System architecture

The model is built around three coupled loops:

**1. Refrigeration loop (vapour-compression cycle, R-1234yf refrigerant)**
Drives heat into the cabin and, via a chiller, into the coolant. Components: compressor (with first-order speed control), condenser + fan, evaporator + blower, thermostatic expansion valves, and a chiller heat exchanger.

**2. Coolant loop (50/50 water–ethylene glycol)**
Circulates heat to the battery, motor, inverter, DC-DC converter and charger. Components: coolant pump, coolant tank, radiator + fan, and component cooling jackets.

**3. Cabin / HVAC loop**
A detailed cabin thermal model accounting for external conditions, air leakage, occupant heat/moisture/CO₂ gains, and solar radiation, supplemented by a **PTC heater** (2.5 kW max) for direct cabin heating.

A control layer manages it all: a PI controller regulates the blower, and bang-bang / relay logic drives the PTC heater and coolant pumps based on cabin, battery, motor and environmental temperatures.

**Input:** FTP75 drive cycle (reference speed and current).

---

## System sizing

Heat loads were sized analytically before modelling (see the calculation scripts):

| Load | Result |
|------|--------|
| Cabin heating power (−10 °C → 20 °C) | **2.71 kW** |
| Coolant-loop heating power | **0.50 kW** |

---

## Key results

- **Cabin heating:** cabin rises from −10 °C to the 20 °C setpoint and holds steady with only minor oscillation, confirming the control strategy is stable.
- **Battery heating:** the battery reaches its 20 °C target in ~1000 s (one FTP75 cycle) with a controlled approach that avoids overshoot.
- **Heat flow:** the evaporator carries the highest heat flow (peaks ~2.5 kW) as the primary cabin heat source; the coolant radiator holds steady near 0.6 kW.
- **Power consumption:** the compressor dominates, peaking near 6 kW at cold start before settling into a lower steady state. The analysis flags compressor cycling and negative fan-power readings as clear targets for control optimisation.

Result plots are in the thesis (Chapter 4).

---

## Repository contents

| File | Description |
|------|-------------|
| `EV_TMS_MODEL.slx` | The complete Simulink/Simscape model |
| `model_script.m` | Master parameter script — **run this first** to load all parameters into the workspace |
| `load_calc.m` | Cabin air heat-load calculation (Magnus equation, enthalpy method) |
| `coolant_calc.m` | Coolant-loop heat-load / sizing calculation |
| `docs/` | MSc thesis (full methodology, literature review, results) |

---

## Running the model

1. Open MATLAB R2024a (with Simulink and Simscape Fluids).
2. Run `model_script.m` to populate the workspace parameters.
3. Open and run `EV_TMS_MODEL.slx`.

**Note on dependencies:** the model takes an FTP75 drive-cycle input and draws on standard reference datasets (e.g. MathWorks' EV battery cooling example data). These third-party datasets aren't redistributed here — obtain them from their original sources if you want to reproduce the run end-to-end.

---

## Scope & limitations

This is a **thermodynamic test bench**, not a production controller. The battery is modelled at a simplified system level, and several environmental parameters are assumed for study purposes. Planned extensions (discussed in the thesis) include full energy/exergy modelling to quantify losses per component, an improved PTC control scheme, and waste-heat-recovery strategies.

---

## Author

**Sai Mithun Sureshkumar**
MSc Automotive Engineering, Cranfield University (2024)
Supervisors: Dr Abbas Fotouhi (Cranfield) · Dr Abbas Tourani (Jaguar Land Rover)

---

*Thesis © Cranfield University 2024. Model and scripts shared for portfolio and educational purposes.*
