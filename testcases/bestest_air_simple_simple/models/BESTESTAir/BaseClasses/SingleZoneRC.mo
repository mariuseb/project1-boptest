within BESTESTAir.BaseClasses;
model SingleZoneRC
  replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames = {"CO2"}) "Medium model";
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium =                                                                     MediumA) annotation (
    Placement(visible = true, transformation(origin = {2, 30}, extent = {{-110, 10}, {-90, 30}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, 10}, {-90, 30}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium =                                                                     MediumA) annotation (
    Placement(visible = true, transformation(origin = {0, -34}, extent = {{-110, -30}, {-90, -10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, -30}, {-90, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation (
    Placement(visible = true, transformation(origin = {109, 5}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {104, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare final package Medium = MediumA, V = 45, m_flow_nominal = 0.55, nPorts = 2) annotation (
    Placement(visible = true, transformation(origin = {-14, 3}, extent = {{-14, -13}, {14, 13}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Ci(C=1E6)   annotation (
    Placement(visible = true, transformation(origin = {42, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Ris(R=0.002)   annotation (
    Placement(visible = true, transformation(origin = {20, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Ti annotation (
    Placement(visible = true, transformation(origin = {78, 4}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Ta annotation (
    Placement(visible = true, transformation(origin = {26, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rea(R = 0.01)  annotation (
    Placement(visible = true, transformation(origin = {64, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(calTSky = Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation, computeWetBulbTemperature = false,
    filNam=
        "/home/marius/Desktop/modelica/modelica-buildings/Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")                                                                    annotation (
    Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-98, 52}, {-78, 72}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (
    Placement(visible = true, transformation(origin = {42, 74}, extent = {{-100, -10}, {-66, 22}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-70, -12}, {-50, 8}}, rotation = 0)));
equation
  connect(vol.ports[1], supplyAir) annotation (
    Line(points={{-15.4,-10},{-72,-10},{-72,50},{-98,50}},        color = {0, 127, 255}, pattern = LinePattern.Solid));
  connect(vol.ports[2], returnAir) annotation (
    Line(points={{-12.6,-10},{-12,-10},{-12,-54},{-100,-54}},        color = {0, 127, 255}, pattern = LinePattern.Solid));
  connect(vol.heatPort, Ris.port_a) annotation (
    Line(points={{-28,3},{-36,3},{-36,26},{10,26},{10,4}},            color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Ris.port_b, Ci.port) annotation (
    Line(points = {{30, 4}, {42, 4}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Ci.port, Ti.port) annotation (
    Line(points = {{42, 4}, {70, 4}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Ti.T, y) annotation (
    Line(points = {{86, 4}, {97, 4}, {97, 5}, {109, 5}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(Ci.port, Rea.port_b) annotation (
    Line(points = {{42, 4}, {64, 4}, {64, 26}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Rea.port_a, Ta.port) annotation (
    Line(points = {{64, 46}, {64, 60}, {36, 60}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(Ta.T, weaBus.TDryBul) annotation (
    Line(points={{14,60},{-18,60},{-18,80},{-41,80}},          color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaBus, weaDat.weaBus) annotation (Line(
      points={{-41,80},{-92,80},{-92,82}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end SingleZoneRC;
