model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveAct_u(unit="W", min=-10000.0, max=10000.0) "Heater thermal power";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for Heater thermal power";
	Modelica.Blocks.Interfaces.RealInput oveTset_u(unit="K", min=288.15, max=313.15) "Heater setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveTset_activate "Activation for Heater setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput CO2RooAir_y(unit="ppm") = mod.CO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput PHea_y(unit="W") = mod.PHea.y "Heater power";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y(unit="K") = mod.TRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput oveAct_y(unit="W") = mod.oveAct.y "Heater thermal power";
	Modelica.Blocks.Interfaces.RealOutput oveTset_y(unit="K") = mod.oveTset.y "Heater setpoint";
	// Original model
	Simple2R2C_PI mod(
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate)),
		oveTset(uExt(y=oveTset_u),activate(y=oveTset_activate))) "Original model with overwrites";
end wrapped;
