within BESTESTAir.BaseClasses;
model SingleZone
  replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model";
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{38, 16}, {28, 26}}, rotation = 0)));
  Buildings.ThermalZones.ReducedOrder.RC.OneElement thermalZoneOneElement(AExt = {3.5, 8}, ATransparent = {7, 7}, AWin = {7, 7}, CExt = {5259932.23}, RExt = {0.00331421908725}, RExtRem = 0.1265217391, RWin = 0.01642857143,
    T_start=295.15,
    VAir=100,                                                                                                                                                                                                        energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, extWallRC(thermCapExt(der_T(fixed = true))), gWin = 1, hConExt = 2.7, hConWin = 2.7, hRad = 5, nExt = 1, nOrientations = 2, ratioWinConRad = 0.09, nPorts = 2, redeclare
      final package                                                                                                                                                                                                         Medium=MediumA) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{44, -2}, {92, 34}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant hConWall(k = 25*11.5) annotation (
    Placement(visible = true, transformation(origin = {30, -16}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Math.Add solRad[2] annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-38, 6}, {-28, 16}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{36, 6}, {26, -4}}, rotation = 0)));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{8, -6}, {20, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant hConWin(k = 20*14) annotation (
    Placement(visible = true, transformation(origin = {32, 38}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{48, -62}, {68, -42}}, rotation = 0)));
  Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(TGro = 285.15, aExt = 0.7, hConWallOut = 20, hConWinOut = 20, hRad = 5, n = 2, wfGro = 0, wfWall = {0.3043478260869566, 0.6956521739130435}, wfWin = {0.5, 0.5}, withLongwave = true) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-24, -14}, {-4, 6}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{48, -42}, {68, -22}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-100, -10}, {-66, 22}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-70, -12}, {-50, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const[2](k = 0) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, 14}, {-14, 20}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(calTSky = Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation, computeWetBulbTemperature = false, filNam = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-98, 52}, {-78, 72}}, rotation = 0)));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[2](azi = {3.1415926535898, 4.7123889803847}, lat = 0.87266462599716, til = 1.5707963267949) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-68, 52}, {-48, 72}}, rotation = 0)));
  Buildings.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane corGDouPan(UWin = 2.1, n = 2) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{6, 54}, {26, 74}}, rotation = 0)));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[2](azi = {3.1415926535898, 4.7123889803847}, lat = 0.87266462599716, outGroCon = true, outSkyCon = true, til = 1.5707963267949) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-68, 20}, {-48, 40}}, rotation = 0)));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem1 annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{8, 14}, {20, 26}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable intGai(columns = {2, 3, 4}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0]) annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{6, -60}, {22, -44}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{48, -84}, {68, -64}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package Medium=MediumA) annotation (
    Placement(visible = true, transformation(origin = {18, -50}, extent = {{-110, 10}, {-90, 30}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, 10}, {-90, 30}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package Medium=MediumA) annotation (
    Placement(visible = true, transformation(origin = {18, -50}, extent = {{-110, -30}, {-90, -10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, -30}, {-90, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation (
    Placement(visible = true, transformation(origin = {104, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(solRad.y, eqAirTemp.HSol) annotation (
    Line(points = {{-27.5, 11}, {-26, 11}, {-26, 2}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaDat.weaBus, HDifTil[1].weaBus) annotation (
    Line(points = {{-78, 62}, {-74, 62}, {-74, 30}, {-68, 30}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(corGDouPan.solarRadWinTrans, thermalZoneOneElement.solRad) annotation (
    Line(points = {{27, 64}, {34, 64}, {40, 64}, {40, 31}, {43, 31}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(intGai.y[2], perCon.Q_flow) annotation (
    Line(points = {{22.8, -52}, {36, -52}, {48, -52}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul) annotation (
    Line(points = {{-83, 6}, {-83, -2}, {-38, -2}, {-38, -10}, {-26, -10}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(preTem1.port, theConWin.fluid) annotation (
    Line(points = {{20, 20}, {28, 20}, {28, 21}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(perCon.port, thermalZoneOneElement.intGainsConv) annotation (
    Line(points = {{68, -52}, {96, -52}, {96, 20}, {92, 20}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(weaDat.weaBus, HDifTil[2].weaBus) annotation (
    Line(points = {{-78, 62}, {-74, 62}, {-74, 30}, {-68, 30}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(HDifTil.H, solRad.u2) annotation (
    Line(points = {{-47, 30}, {-44, 30}, {-44, 8}, {-39, 8}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaDat.weaBus, HDirTil[2].weaBus) annotation (
    Line(points = {{-78, 62}, {-73, 62}, {-68, 62}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(const.y, eqAirTemp.sunblind) annotation (
    Line(points = {{-13.7, 17}, {-12, 17}, {-12, 8}, {-14, 8}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(eqAirTemp.TEqAirWin, preTem1.T) annotation (
    Line(points = {{-3, -0.2}, {0, -0.2}, {0, 20}, {6.8, 20}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(theConWall.fluid, preTem.port) annotation (
    Line(points = {{26, 1}, {24, 1}, {24, 0}, {20, 0}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(HDirTil.H, corGDouPan.HDirTil) annotation (
    Line(points = {{-47, 62}, {-10, 62}, {-10, 70}, {4, 70}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaDat.weaBus, HDirTil[1].weaBus) annotation (
    Line(points = {{-78, 62}, {-73, 62}, {-68, 62}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky) annotation (
    Line(points = {{-83, 6}, {-58, 6}, {-58, 2}, {-32, 2}, {-32, -4}, {-26, -4}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(hConWall.y, theConWall.Gc) annotation (
    Line(points = {{30, -11.6}, {30, -4}, {31, -4}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(HDirTil.inc, corGDouPan.inc) annotation (
    Line(points = {{-47, 58}, {4, 58}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(theConWin.solid, thermalZoneOneElement.window) annotation (
    Line(points = {{38, 21}, {40, 21}, {40, 20}, {44, 20}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(HDifTil.HSkyDifTil, corGDouPan.HSkyDifTil) annotation (
    Line(points = {{-47, 36}, {-28, 36}, {-6, 36}, {-6, 66}, {4, 66}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(weaDat.weaBus, weaBus) annotation (
    Line(points = {{-78, 62}, {-74, 62}, {-74, 18}, {-84, 18}, {-84, 12}, {-83, 12}, {-83, 6}}, color = {255, 204, 51}, pattern = LinePattern.Solid, thickness = 0.5));
  connect(hConWin.y, theConWin.Gc) annotation (
    Line(points = {{32, 33.6}, {32, 26}, {33, 26}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(eqAirTemp.TEqAir, preTem.T) annotation (
    Line(points = {{-3, -4}, {4, -4}, {4, 0}, {6.8, 0}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(HDifTil.HGroDifTil, corGDouPan.HGroDifTil) annotation (
    Line(points = {{-47, 24}, {-4, 24}, {-4, 62}, {4, 62}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(HDirTil.H, solRad.u1) annotation (
    Line(points = {{-47, 62}, {-42, 62}, {-42, 14}, {-39, 14}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(intGai.y[3], macConv.Q_flow) annotation (
    Line(points = {{22.8, -52}, {28, -52}, {28, -74}, {48, -74}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(intGai.y[1], perRad.Q_flow) annotation (
    Line(points = {{22.8, -52}, {28, -52}, {28, -32}, {48, -32}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(thermalZoneOneElement.extWall, theConWall.solid) annotation (
    Line(points = {{44, 12}, {40, 12}, {40, 1}, {36, 1}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(perRad.port, thermalZoneOneElement.intGainsRad) annotation (
    Line(points = {{68, -32}, {84, -32}, {100, -32}, {100, 24}, {92, 24}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(macConv.port, thermalZoneOneElement.intGainsConv) annotation (
    Line(points = {{68, -74}, {82, -74}, {96, -74}, {96, 20}, {92, 20}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(thermalZoneOneElement.ports[1], supplyAir) annotation (
    Line(points={{82.2375,-1.95},{74,-1.95},{74,-30},{-82,-30}},
                                                               color = {0, 127, 255}, pattern = LinePattern.Solid));
  connect(thermalZoneOneElement.ports[2], returnAir) annotation (
    Line(points={{83.7625,-1.95},{83.7625,-70},{-82,-70}},
                                                     color = {0, 127, 255}, pattern = LinePattern.Solid));
  connect(thermalZoneOneElement.TAir, y) annotation (
    Line(points={{93,32},{96,32},{96,66},{104,66}},          color = {0, 0, 127}, pattern = LinePattern.Solid));
end SingleZone;
