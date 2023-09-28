model Simple2R2C_PI_OM
  parameter Modelica.Units.SI.Time occSta = 8*3600 "Occupancy start time" annotation (
    Dialog(group = "Schedule"));
  parameter Modelica.Units.SI.Time occEnd = 18*3600 "Occupancy end time" annotation (
    Dialog(group = "Schedule"));
  parameter Modelica.Units.SI.DimensionlessRatio minSpe = 0.2 "Minimum fan speed" annotation (
    Dialog(group = "Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetCooUno = 273.15 + 30 "Unoccupied cooling setpoint" annotation (
    Dialog(group = "Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetCooOcc = 273.15 + 24 "Occupied cooling setpoint" annotation (
    Dialog(group = "Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetHeaUno = 273.15 + 15 "Unoccupied heating setpoint" annotation (
    Dialog(group = "Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetHeaOcc = 273.15 + 21 "Occupied heating setpoint" annotation (
    Dialog(group = "Setpoints"));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Ci(C = 1e6) "Thermal capacitance of room" annotation (
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{30, 0}, {50, 20}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZone "Room air temperature sensor" annotation (
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{60, -10}, {80, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut "Set the outside air temperature" annotation (
    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-40, -10}, {-20, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID con(Ti = 300, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 100, yMax = 100000, yMin = 0) "Feedback controller for the heater based on room temperature" annotation (
    Placement(transformation(extent = {{-68, -40}, {-48, -20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAct(u(unit = "W", min = -10000, max = 10000), description = "Heater thermal power") "Overwrite the heating power" annotation (
    Placement(transformation(extent = {{-36, -40}, {-16, -20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeat "Set the heating power to the room" annotation (
    Placement(visible = true, transformation(origin = {8, 0}, extent = {{0, -40}, {20, -20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain eff(k = 1/0.99) "Heater efficiency" annotation (
    Placement(transformation(extent = {{0, -90}, {20, -70}})));
  Buildings.Utilities.IO.SignalExchange.Read TRooAir(y(unit = "K"), KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature, description = "Zone air temperature") "Read the room air temperature" annotation (
    Placement(transformation(extent = {{80, -60}, {60, -40}})));
  Buildings.Utilities.IO.SignalExchange.Read PHea(y(unit = "W"), KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower, description = "Heater power") "Read the heater power" annotation (
    Placement(transformation(extent = {{80, -90}, {100, -70}})));
  Modelica.Blocks.Math.Abs abs annotation (
    Placement(transformation(extent = {{30, -90}, {50, -70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTset(description = "Heater setpoint", u(max = 313.15, min = 288.15, unit = "K")) annotation (
    Placement(visible = true, transformation(origin = {-66, 0}, extent = {{-40, -40}, {-20, -20}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(calTSky = Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation, computeWetBulbTemperature = false,
    filNam="USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
                                                                                                                                                                                                            annotation (
    Placement(visible = true, transformation(origin = {-22, 12}, extent = {{-98, 52}, {-78, 72}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (
    Placement(visible = true, transformation(origin = {34, 66}, extent = {{-100, -10}, {-66, 22}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-70, -12}, {-50, 8}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Ce(C = 5e6) annotation (
    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{30, 0}, {50, 20}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Ria(R = 0.01) annotation (
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{0, -10}, {20, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rea(R = 0.01) annotation (
    Placement(visible = true, transformation(origin = {-24, 0}, extent = {{0, -10}, {20, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, TSetHeaUno; occSta, TSetHeaOcc; occEnd, TSetHeaUno; 24*3600, TSetHeaUno]) annotation (
    Placement(visible = true, transformation(origin = {-48, -70}, extent = {{-100, 30}, {-80, 50}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preSol annotation (
    Placement(transformation(extent = {{40, 20}, {60, 40}})));
  Modelica.Blocks.Math.Gain Aw(k = 5) annotation (
    Placement(transformation(extent = {{-14, 20}, {6, 40}})));
equation
  connect(Ci.port, senTZone.port) annotation(
    Line(points = {{80, 0}, {120, 0}}, color = {191, 0, 0}));
  connect(con.y, oveAct.u) annotation(
    Line(points = {{-47, -30}, {-38, -30}}, color = {0, 0, 127}));
  connect(oveAct.y, preHeat.Q_flow) annotation(
    Line(points = {{-15, -30}, {8, -30}}, color = {0, 0, 127}));
  connect(preHeat.port, Ci.port) annotation(
    Line(points = {{28, -30}, {80, -30}, {80, -26}, {81, -26}, {81, -8}, {82.5, -8}, {82.5, 0}, {80, 0}}, color = {191, 0, 0}));
  connect(oveAct.y, eff.u) annotation(
    Line(points = {{-15, -30}, {-10, -30}, {-10, -80}, {-2, -80}}, color = {0, 0, 127}));
  connect(senTZone.T, TRooAir.u) annotation(
    Line(points = {{140, 0}, {140, -50}, {82, -50}}, color = {0, 0, 127}));
  connect(TRooAir.y, con.u_m) annotation(
    Line(points = {{59, -50}, {-58, -50}, {-58, -42}}, color = {0, 0, 127}));
  connect(eff.y, abs.u) annotation(
    Line(points = {{21, -80}, {28, -80}}, color = {0, 0, 127}));
  connect(abs.y, PHea.u) annotation(
    Line(points = {{51, -80}, {78, -80}}, color = {0, 0, 127}));
  connect(oveTset.y, con.u_s) annotation(
    Line(points = {{-85, -30}, {-70, -30}}, color = {0, 0, 127}));
  connect(weaBus, weaDat.weaBus) annotation(
    Line(points = {{-49, 72}, {-100, 72}, {-100, 74}}, color = {255, 204, 51}, thickness = 0.5));
  connect(preTOut.T, weaBus.TDryBul) annotation(
    Line(points = {{-60, 0}, {-60, 50}, {-28, 50}, {-28, 72}, {-49, 72}}, color = {0, 0, 127}));
  connect(Ria.port_b, Ci.port) annotation(
    Line(points = {{60, 0}, {80, 0}}, color = {191, 0, 0}));
  connect(Ce.port, Rea.port_b) annotation(
    Line(points = {{22, 0}, {-4, 0}}, color = {191, 0, 0}));
  connect(Ria.port_a, Ce.port) annotation(
    Line(points = {{40, 0}, {22, 0}}, color = {191, 0, 0}));
  connect(Rea.port_a, preTOut.port) annotation(
    Line(points = {{-24, 0}, {-38, 0}}, color = {191, 0, 0}));
  connect(TSetHea.y[1], oveTset.u) annotation(
    Line(points = {{-127, -30}, {-108, -30}}, color = {0, 0, 127}));
  connect(Aw.y, preSol.Q_flow) annotation(
    Line(points = {{7, 30}, {40, 30}}, color = {0, 0, 127}));
  connect(Aw.u, weaBus.HGloHor) annotation(
    Line(points = {{-16, 30}, {-20, 30}, {-20, 72}, {-49, 72}}, color = {0, 0, 127}),
    Text(string = "%second", index = 1, extent = {{-6, 3}, {-6, 3}}, horizontalAlignment = TextAlignment.Right));
  connect(preSol.port, Ci.port) annotation(
    Line(points = {{60, 30}, {70, 30}, {70, 0}, {80, 0}}, color = {191, 0, 0}));
end Simple2R2C_PI_OM;