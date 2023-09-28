within BESTESTAir.BaseClasses;
model SingleZone2R2C
  replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames = {"CO2"}) "Medium model";
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium =                                                                     MediumA) annotation (
    Placement(visible = true, transformation(origin = {-24, -30}, extent = {{-110, 10}, {-90, 30}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, 10}, {-90, 30}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium =                                                                     MediumA) annotation (
    Placement(visible = true, transformation(origin = {0, -34}, extent = {{-110, -30}, {-90, -10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, -30}, {-90, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation (
    Placement(visible = true, transformation(origin={186,-46},  extent={{-18,-18},
            {18,18}},                                                                            rotation = 0), iconTransformation(origin = {104, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare final package Medium = MediumA,
    V=100,                                                                                         m_flow_nominal = 0.55, nPorts = 2) annotation (
    Placement(visible = true, transformation(origin = {-14, 3}, extent = {{-14, -13}, {14, 13}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Ci(C=1E6)   annotation (
    Placement(visible = true, transformation(origin = {42, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Ti annotation (
    Placement(visible = true, transformation(origin={72,-46},  extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Ta annotation (
    Placement(visible = true, transformation(origin = {26, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rea(R = 0.01)  annotation (
    Placement(visible = true, transformation(origin={74,46},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(calTSky = Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation, computeWetBulbTemperature = false,
    filNam=Modelica.Utilities.Files.loadResource(
  "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
                                                                                                                                                                                                        annotation (Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-98, 52}, {-78, 72}}, rotation = 0)));
Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (
    Placement(visible = true, transformation(origin = {42, 74}, extent = {{-100, -10}, {-66, 22}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-70, -12}, {-50, 8}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Ce(C=5E6) annotation (
      Placement(visible=true, transformation(
        origin={144,16},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rie(R=0.001)
    annotation (Placement(visible=true, transformation(
        origin={72,4},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{10,26},{30,46}})));
  Modelica.Blocks.Math.Gain Aw(k=0)
    annotation (Placement(transformation(extent={{-36,32},{-16,52}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTRooAir(KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature, y(unit="K"))
    annotation (Placement(transformation(extent={{106,-56},{126,-36}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Te annotation(
    Placement(visible = true, transformation(origin = {136, -18}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Buildings.Utilities.IO.SignalExchange.Read reaTEnv(KPIs = Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature, y(unit = "K")) annotation(
    Placement(visible = true, transformation(origin = {48, 28}, extent = {{106, -56}, {126, -36}}, rotation = 0)));
equation
  connect(vol.ports[1], supplyAir) annotation(
    Line(points = {{-15.4, -10}, {-124, -10}}, color = {0, 127, 255}));
  connect(vol.ports[2], returnAir) annotation(
    Line(points = {{-12.6, -10}, {-12, -10}, {-12, -54}, {-100, -54}}, color = {0, 127, 255}, pattern = LinePattern.Solid));
  connect(Ci.port, Ti.port) annotation(
    Line(points = {{42, 4}, {42, 2}, {58, 2}, {58, -46}, {64, -46}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Rea.port_a, Ta.port) annotation(
    Line(points = {{74, 56}, {74, 60}, {36, 60}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Ta.T, weaBus.TDryBul) annotation(
    Line(points = {{14, 60}, {-18, 60}, {-18, 80}, {-41, 80}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaBus, weaDat.weaBus) annotation(
    Line(points = {{-41, 80}, {-92, 80}, {-92, 82}}, color = {255, 204, 51}, thickness = 0.5),
    Text(string = "%first", index = -1, extent = {{-3, -6}, {-3, -6}}, horizontalAlignment = TextAlignment.Right));
  connect(Ci.port, Rie.port_a) annotation(
    Line(points = {{42, 4}, {62, 4}}, color = {191, 0, 0}));
  connect(Rie.port_b, Ce.port) annotation(
    Line(points = {{82, 4}, {84, 4}, {84, 6}, {144, 6}}, color = {191, 0, 0}));
  connect(Rea.port_b, Ce.port) annotation(
    Line(points = {{74, 36}, {74, 18}, {118, 18}, {118, 6}, {144, 6}}, color = {191, 0, 0}));
  connect(Aw.y, prescribedHeatFlow.Q_flow) annotation(
    Line(points = {{-15, 42}, {-8, 42}, {-8, 44}, {0, 44}, {0, 36}, {10, 36}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow.port, Ci.port) annotation(
    Line(points = {{30, 36}, {44, 36}, {44, 42}, {56, 42}, {56, 4}, {42, 4}}, color = {191, 0, 0}));
  connect(Aw.u, weaBus.HGloHor) annotation(
    Line(points = {{-38, 42}, {-50, 42}, {-50, 80}, {-41, 80}}, color = {0, 0, 127}),
    Text(string = "%second", index = 1, extent = {{-6, 3}, {-6, 3}}, horizontalAlignment = TextAlignment.Right));
  connect(Ti.T, reaTRooAir.u) annotation(
    Line(points = {{80, -46}, {104, -46}}, color = {0, 0, 127}));
  connect(reaTRooAir.y, y) annotation(
    Line(points = {{127, -46}, {186, -46}}, color = {0, 0, 127}));
  connect(Ci.port, vol.heatPort) annotation(
    Line(points = {{42, 4}, {10, 4}, {10, 20}, {-48, 20}, {-48, 4}, {-28, 4}}, color = {191, 0, 0}));
  connect(Ce.port, Te.port) annotation(
    Line(points = {{144, 6}, {122, 6}, {122, -18}, {128, -18}}, color = {191, 0, 0}));
  connect(Te.T, reaTEnv.u) annotation(
    Line(points = {{144, -18}, {152, -18}}, color = {0, 0, 127}));
  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end SingleZone2R2C;