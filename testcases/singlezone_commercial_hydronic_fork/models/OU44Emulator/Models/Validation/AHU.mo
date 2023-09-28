within OU44Emulator.Models.Validation;



block AHU
  "Declaration of an FMU that exports a simple convective only HVAC system"
  final parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=2;
  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal=31;
  package Water = Buildings.Media.Water;
  package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"});
  extends Buildings.Fluid.FMI.ExportContainers.HVACZone(redeclare final package Medium = Air, hvacAda(nPorts = 2));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-180, -22}, {-140, 18}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-200, 104}, {-180, 124}}, rotation = 0)));
  Buildings.Utilities.IO.SignalExchange.Read reaTRetAir(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, description = "AHU return air temperature", y(unit = "K")) annotation(
    Placement(visible = true, transformation(origin = {-34, 50}, extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloEx(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-76, -22}, extent = {{48, 30}, {28, 50}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-80, 30}, {-100, 50}}, rotation = 0)));
  Buildings.Fluid.Sources.Outside outEx(redeclare package Medium = Air, nPorts = 1, use_C_in = true) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-140, 30}, {-120, 50}}, rotation = 0)));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{20, -50}, {40, -30}}, rotation = 0)));
  Buildings.Fluid.Sensors.Pressure senPreIn(redeclare package Medium = Air) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{132, -40}, {152, -20}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx1(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-18, 30}, {-38, 50}}, rotation = 0)));
  Buildings.Fluid.Movers.SpeedControlled_y fanEx(redeclare package Medium = Air, addPowerToMedium = false, allowFlowReversal = true, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, redeclare Data.AhuFanx4 per) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{20, 30}, {0, 50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput realInput annotation(
    Placement(visible = true, transformation(origin = {-138, 90}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Buildings.Utilities.IO.SignalExchange.Read reaPFanSup(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, description = "AHU supply fan electrical power consumption", y(unit = "W")) annotation(
    Placement(visible = true, transformation(origin = {-102, -100}, extent = {{-6, 6}, {6, -6}}, rotation = 180)));
  Buildings.Utilities.IO.SignalExchange.Read reaTHeaRec(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, description = "AHU air temperature exiting heat recovery in supply air stream", y(unit = "K")) annotation(
    Placement(visible = true, transformation(origin = {-56, -32}, extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Buildings.Utilities.IO.SignalExchange.Read reaFloExtAir(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, description = "'AHU extract air volume flowrate", y(unit = "kg/s")) annotation(
    Placement(visible = true, transformation(origin = {60, 62}, extent = {{12, 12}, {-12, -12}}, rotation = 180)));
  Buildings.Fluid.FixedResistances.PressureDrop resEx(redeclare package Medium = Air, allowFlowReversal = false, dp_nominal = 2500, m_flow_nominal = 46.7) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{90, 30}, {70, 50}}, rotation = 0)));
  Buildings.Fluid.Sensors.Pressure senPreEx(redeclare package Medium = Air) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{102, 40}, {122, 60}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Air) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{150, -50}, {170, -30}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{150, -50}, {170, -30}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{108, -50}, {128, -30}}, rotation = 0)));
  Buildings.Utilities.IO.SignalExchange.Read reaPFanRet(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, description = "AHU return fan electrical power consumption", y(unit = "W")) annotation(
    Placement(visible = true, transformation(origin = {-106, -38}, extent = {{-6, 6}, {6, -6}}, rotation = 180)));
  Buildings.Utilities.IO.SignalExchange.Read reaTSupAir(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, description = "AHU supply air temperature", y(unit = "K")) annotation(
    Placement(visible = true, transformation(origin = {53, -85}, extent = {{7, -7}, {-7, 7}}, rotation = 90)));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 = Air, redeclare package Medium2 = Air, allowFlowReversal1 = false, allowFlowReversal2 = false, dp1_nominal = 150, dp2_nominal = 150, eps = 0.75, linearizeFlowResistance1 = true, linearizeFlowResistance2 = true, m1_flow_nominal = m_flow_nominal, m2_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-46, -10}, {-66, 10}}, rotation = 0)));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveFanRet(description = "AHU return fan speed control signal", u(max = 1, min = 0, unit = "1")) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-46, 62}, {-26, 82}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-60, -84}, {-80, -64}}, rotation = 0)));
  Buildings.Fluid.Movers.SpeedControlled_y fanSu(redeclare package Medium = Air, addPowerToMedium = false, allowFlowReversal = true, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, redeclare Data.AhuFanx4 per) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-10, -50}, {10, -30}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium = Air) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{150, 30}, {170, 50}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{150, 30}, {170, 50}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-100, -50}, {-80, -30}}, rotation = 0)));
  Buildings.Fluid.Sources.Outside outSu(redeclare package Medium = Air, nPorts = 1, use_C_in = true) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-140, -50}, {-120, -30}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant cCO2(k = 0.00064) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-98, -10}, {-118, 10}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn2(redeclare package Medium = Air, allowFlowReversal = false, m_flow_nominal = m_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-36, -50}, {-16, -30}}, rotation = 0)));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSup(description = "AHU supply fan speed control signal", u(max = 1, min = 0, unit = "1")) annotation(
    Placement(visible = true, transformation(origin = {-138, 32}, extent = {{8, -8}, {-8, 8}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {-190, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-178, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-50, -120}, extent = {{-98, -10}, {-118, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant constant2(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-50, -120}, extent = {{-98, -10}, {-118, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant constant3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-56, -152}, extent = {{-98, -10}, {-118, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant constant4(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, -124}, extent = {{-98, -10}, {-118, 10}}, rotation = 180)));
  Buildings.Fluid.FixedResistances.PressureDrop pressureDrop(redeclare package Medium = Air, allowFlowReversal = false, dp_nominal = 2500, m_flow_nominal = 46.7) annotation(
    Placement(visible = true, transformation(origin = {-86, -98}, extent = {{90, 30}, {70, 50}}, rotation = 0)));
equation
  connect(senPreIn.port, port_b1) annotation(
    Line(points = {{64, -60}, {82, -60}}, color = {0, 127, 255}));
  connect(senTemEx2.port_b, outEx.ports[1]) annotation(
    Line(points = {{-178, 20}, {-198, 20}}, color = {0, 127, 255}));
  connect(fanEx.P, reaPFanRet.u) annotation(
    Line(points = {{-79, 29}, {-79, 30}, {-88, 30}, {-88, -38}, {-98.8, -38}}, color = {0, 0, 127}));
  connect(hex.port_b1, senTemEx2.port_a) annotation(
    Line(points = {{-144, -14}, {-150, -14}, {-150, 20}, {-158, 20}}, color = {0, 127, 255}));
  connect(cCO2.y, outSu.C_in[1]) annotation(
    Line(points = {{-197, -20}, {-224, -20}, {-224, -68}, {-220, -68}}, color = {0, 0, 127}));
  connect(weaBus, outSu.weaBus) annotation(
    Line(points = {{-238, -22}, {-228, -22}, {-228, -26}, {-218, -26}, {-218, -59.8}}, color = {255, 204, 51}, thickness = 0.5));
  connect(fanSu.P, reaPFanSup.u) annotation(
    Line(points = {{-67, -51}, {-62.5, -51}, {-62.5, -100}, {-94.8, -100}}, color = {0, 0, 127}));
  connect(realInput, oveFanSup.u) annotation(
    Line(points = {{-138, 90}, {-138, 41.6}}, color = {0, 0, 127}));
  connect(senVolFloEx.port_a, resEx.port_b) annotation(
    Line(points = {{-28, 18}, {-18, 18}, {-18, 20}, {-8, 20}}, color = {0, 127, 255}));
  connect(reaFloExtAir.u, senVolFloEx.V_flow) annotation(
    Line(points = {{45.6, 62}, {32, 62}, {32, 66}, {-4, 66}, {-4, 34}, {-38, 34}, {-38, 29}}, color = {0, 0, 127}));
  connect(reaPFanRet.y, add.u1) annotation(
    Line(points = {{-112.6, -38}, {-126, -38}, {-126, -88}, {-136, -88}}, color = {0, 0, 127}));
  connect(fanEx.port_b, senTemEx1.port_a) annotation(
    Line(points = {{-78, 20}, {-96, 20}}, color = {0, 127, 255}));
  connect(oveFanSup.y, fanSu.y) annotation(
    Line(points = {{-138, 23.2}, {-138, (-0 - 15)}, {-78, (-0 - 15)}, {-78, -48}}, color = {0, 0, 127}));
  connect(senPreIn.port, senTemIn3.port_b) annotation(
    Line(points = {{64, -60}, {50, -60}}, color = {0, 127, 255}));
  connect(senTemEx1.port_b, hex.port_a1) annotation(
    Line(points = {{-116, 20}, {-122, 20}, {-122, -14}, {-124, -14}}, color = {0, 127, 255}));
  connect(reaPFanSup.y, add.u2) annotation(
    Line(points = {{-108.6, -100}, {-136, -100}}, color = {0, 0, 127}));
  connect(senTemIn2.port_a, hex.port_b2) annotation(
    Line(points = {{-114, -60}, {-118, -60}, {-118, -26}, {-124, -26}}, color = {0, 127, 255}));
  connect(senVolFloEx.port_b, fanEx.port_a) annotation(
    Line(points = {{-48, 18}, {-54, 18}, {-54, 20}, {-58, 20}}, color = {0, 127, 255}));
  connect(senTemIn3.T, reaTSupAir.u) annotation(
    Line(points = {{40, -49}, {40, -40}, {53, -40}, {53, -76.6}}, color = {0, 0, 127}));
  connect(senTemIn1.port_a, outSu.ports[1]) annotation(
    Line(points = {{-178, -60}, {-198, -60}}, color = {0, 127, 255}));
  connect(senPreEx.port, port_a1) annotation(
    Line(points = {{34, 20}, {82, 20}}, color = {0, 127, 255}));
  connect(fanSu.port_b, senVolFloIn.port_a) annotation(
    Line(points = {{-68, -60}, {-58, -60}}, color = {0, 127, 255}));
  connect(weaBus, outEx.weaBus) annotation(
    Line(points = {{-238, -22}, {-228, -22}, {-228, -16}, {-218, -16}, {-218, 20.2}}, color = {255, 204, 51}, thickness = 0.5));
  connect(hex.port_a2, senTemIn1.port_b) annotation(
    Line(points = {{-144, -26}, {-150, -26}, {-150, -60}, {-158, -60}}, color = {0, 127, 255}));
  connect(senTemIn2.T, reaTHeaRec.u) annotation(
    Line(points = {{-104, -49}, {-104, -46}, {-84, -46}, {-84, -32}, {-65.6, -32}}, color = {0, 0, 127}));
  connect(cCO2.y, outEx.C_in[1]) annotation(
    Line(points = {{-197, -20}, {-224, -20}, {-224, 12}, {-220, 12}}, color = {0, 0, 127}));
  connect(oveFanRet.y, fanEx.y) annotation(
    Line(points = {{-103, 52}, {-68, 52}, {-68, 32}}, color = {0, 0, 127}));
  connect(oveFanRet.u, realInput) annotation(
    Line(points = {{-126, 52}, {-138, 52}, {-138, 90}}, color = {0, 0, 127}));
  connect(resEx.port_a, senPreEx.port) annotation(
    Line(points = {{12, 20}, {34, 20}}, color = {0, 127, 255}));
  connect(fanSu.port_a, senTemIn2.port_b) annotation(
    Line(points = {{-88, -60}, {-94, -60}}, color = {0, 127, 255}));
  connect(port_b1, port_b1) annotation(
    Line(points = {{82, -60}, {82, -60}}, color = {0, 127, 255}));
  connect(senTemEx1.T, reaTRetAir.u) annotation(
    Line(points = {{-106, 31}, {-106, 38}, {-62, 38}, {-62, 50}, {-43.6, 50}}, color = {0, 0, 127}));
  connect(port_a1, hvacAda.ports[1]) annotation(
    Line(points = {{82, 20}, {96, 20}, {96, 140}, {120, 140}}));
  connect(port_b1, hvacAda.ports[2]) annotation(
    Line(points = {{82, -60}, {86, -60}, {86, 140}, {120, 140}}));
  connect(add.y, y) annotation(
    Line(points = {{-158, -94}, {-158, -115}, {-190, -115}, {-190, -146}}, color = {0, 0, 127}));
  connect(constant2.y, QGaiRad_flow) annotation(
    Line(points = {{70, -120}, {112, -120}, {112, -40}, {180, -40}}, color = {0, 0, 127}));
  connect(constant3.y, QGaiSenCon_flow) annotation(
    Line(points = {{64, -152}, {130, -152}, {130, -90}, {180, -90}}, color = {0, 0, 127}));
  connect(constant4.y, QGaiLat_flow) annotation(
    Line(points = {{30, -124}, {38, -124}, {38, -140}, {180, -140}}, color = {0, 0, 127}));
  connect(senVolFloIn.port_b, pressureDrop.port_b) annotation(
    Line(points = {{-38, -60}, {-18, -60}, {-18, -58}, {-16, -58}}, color = {0, 127, 255}));
  connect(pressureDrop.port_a, senTemIn3.port_a) annotation(
    Line(points = {{4, -58}, {24, -58}, {24, -60}, {30, -60}}, color = {0, 127, 255}));
end AHU;