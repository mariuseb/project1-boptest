within BESTESTAir.BaseClasses;
model SingleZone4RC
    replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames = {"CO2"}) "Medium model";
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3
                                            weaDat(
    calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-88,52},{-68,72}})));

  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez
                                                   HDifTil[2](
    each outSkyCon=true,
    each outGroCon=true,
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
                                                          HDirTil[2](
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-60,52},{-40,72}})));
  Buildings.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
                                  corGDouPan(UWin=2.1, n=2)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{14,46},{34,66}})));
  Buildings.ThermalZones.ReducedOrder.RC.FourElements
                  thermalZoneFourElements(
    VAir=200,
    hConExt=2.7,
    hConWin=2.7,
    gWin=1,
    ratioWinConRad=0.09,
    nExt=1,
    RExt={0.00331421908725},
    CExt={525993200.23},
    hRad=5,
    AInt=100,
    hConInt=2.12,
    nInt=1,
    RInt={0.000668895639141},
    CInt={12391363.86},
    RWin=0.01642857143,
    RExtRem=0.1265217391,
    AFloor=100,
    hConFloor=2.7,
    nFloor=1,
    RFloor={0.00331421908725},
    RFloorRem=0.1265217391,
    CFloor={52599320.23},
    ARoof=100,
    hConRoof=2.7,
    nRoof=1,
    RRoof={0.00331421908725},
    RRoofRem=0.1265217391,
    CRoof={52599320.23},
    nOrientations=2,
    AWin={7,7},
    ATransparent={7,7},
    AExt={20,8},
    redeclare replaceable package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    floorRC(thermCapExt(each der_T(fixed=true))),
    T_start=295.15,
    roofRC(thermCapExt(each der_T(fixed=true))),
    nPorts=2)                                    "Thermal zone"
    annotation (Placement(transformation(extent={{52,-2},{100,34}})));
  Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow
                                             eqAirTemp(
    wfGro=0,
    withLongwave=true,
    aExt=0.7,
    hConWallOut=20,
    hRad=5,
    hConWinOut=20,
    n=2,
    wfWall={0.3043478260869566,0.6956521739130435},
    wfWin={0.5,0.5},
    TGro=285.15) "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-16,-14},{4,6}})));
  Modelica.Blocks.Math.Add solRad[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-30,6},{-20,16}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{16,-6},{28,6}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{16,14},{28,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{46,16},{36,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{44,6},{34,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{56,-42},{76,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{56,-62},{76,-42}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
        50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
        0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
        86400,0,0,0],
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{14,-60},{30,-44}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-12,14},{-6,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{56,-84},{76,-64}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*11.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90,
    origin={38,-16})));
  Modelica.Blocks.Sources.Constant hConWin(k=20*14)
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=90,origin={40,38})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={75,-12})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=180,origin={92,-22})));
  Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007
                                   eqAirTempVDI(
    aExt=0.7,
    n=1,
    wfWall={1},
    wfWin={0},
    wfGro=0,
    hConWallOut=20,
    hRad=5,
    TGro=285.15) "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{38,74},{58,94}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={75,64})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={75,47})));
  Modelica.Blocks.Sources.Constant hConRoof(k=25*11.5)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},origin={94,47})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{76,90},{70,96}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-92,-10},{-58,22}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA)                                                                   annotation (
    Placement(visible = true, transformation(origin={24,-54},    extent = {{-110, 10}, {-90, 30}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, 10}, {-90, 30}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA)                                                                   annotation (
    Placement(visible = true, transformation(origin={24,-54},    extent = {{-110, -30}, {-90, -10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-110, -30}, {-90, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput TAir1 "Indoor air temperature"
    annotation (Placement(transformation(extent={{118,78},{138,98}})));
equation
  connect(eqAirTemp.TEqAirWin,preTem1. T)
    annotation (Line(points={{5,-0.2},{8,-0.2},{8,20},{14.8,20}},
    color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{5,-4},{12,-4},{12,0},{14.8,0}},
    color={0,0,127}));
  connect(weaDat.weaBus,weaBus)
    annotation (Line(points={{-68,62},{-66,62},{-66,18},{-76,18},{-76,12},{-75,12},
          {-75,6}},   color={255,204,51},
    thickness=0.5), Text(textString="%second",index=1,extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul,eqAirTemp. TDryBul)
    annotation (Line(points={{-75,6},{-75,-2},{-30,-2},{-30,-10},{-18,-10}},
    color={255,204,51},
    thickness=0.5), Text(textString="%first",index=-1,extent={{-6,3},{-6,3}}));
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{30.8,-52},{36,-52},{36,-32},{56,-32}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{30.8,-52},{56,-52}},          color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{30.8,-52},{36,-52},{36,-74},{56,-74}},
    color={0,0,127}));
  connect(const.y,eqAirTemp. sunblind)
    annotation (Line(points={{-5.7,17},{-4,17},{-4,8},{-6,8}},
    color={0,0,127}));
  connect(HDifTil.HSkyDifTil,corGDouPan. HSkyDifTil)
    annotation (Line(points={{-39,36},{2,36},{2,58},{8,58},{8,57.8},{12,57.8},{12,
          58}},
    color={0,0,127}));
  connect(HDirTil.H,corGDouPan. HDirTil)
    annotation (Line(points={{-39,62},{12,62}},        color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-39,62},{-34,62},{-34,14},{-31,14}},
    color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-39,30},{-36,30},{-36,8},{-31,8}},
    color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDouPan. HGroDifTil)
    annotation (Line(points={{-39,24},{4,24},{4,54},{12,54}},
    color={0,0,127}));
  connect(solRad.y,eqAirTemp. HSol)
    annotation (Line(points={{-19.5,11},{-18,11},{-18,2}},
    color={0,0,127}));
  connect(weaDat.weaBus,HDifTil [1].weaBus)
    annotation (Line(points={{-68,62},{-66,62},{-66,30},{-60,30}},
    color={255,204,51},thickness=0.5));
  connect(weaDat.weaBus,HDifTil [2].weaBus)
    annotation (Line(points={{-68,62},{-66,62},{-66,30},{-60,30}},
    color={255,204,51},thickness=0.5));
  connect(weaDat.weaBus,HDirTil [1].weaBus)
    annotation (Line(
    points={{-68,62},{-60,62}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [2].weaBus)
    annotation (Line(
    points={{-68,62},{-60,62}},
    color={255,204,51},
    thickness=0.5));
  connect(perRad.port,thermalZoneFourElements. intGainsRad)
    annotation (
    Line(points={{76,-32},{108,-32},{108,24},{100,24}},
    color={191,0,0}));
  connect(theConWin.solid,thermalZoneFourElements. window)
    annotation (Line(points={{46,21},{48,21},{48,20},{52,20}},   color=
    {191,0,0}));
  connect(preTem1.port,theConWin. fluid)
    annotation (Line(points={{28,20},{36,20},{36,21}}, color={191,0,0}));
  connect(thermalZoneFourElements.extWall,theConWall. solid)
    annotation (Line(points={{52,12},{48,12},{48,1},{44,1}},
    color={191,0,0}));
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{34,1},{32,1},{32,0},{28,0}}, color={191,0,0}));
  connect(hConWall.y,theConWall. Gc)
    annotation (Line(points={{38,-11.6},{38,-4},{39,-4}}, color={0,0,127}));
  connect(hConWin.y,theConWin. Gc)
    annotation (Line(points={{40,33.6},{40,26},{41,26}}, color={0,0,127}));
  connect(weaBus.TBlaSky,eqAirTemp. TBlaSky)
    annotation (Line(
    points={{-75,6},{-50,6},{-50,2},{-24,2},{-24,-4},{-18,-4}},
    color={255,204,51},
    thickness=0.5), Text(
    textString="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(macConv.port,thermalZoneFourElements. intGainsConv)
    annotation (
    Line(points={{76,-74},{104,-74},{104,20},{100,20}},       color={191,
    0,0}));
  connect(perCon.port,thermalZoneFourElements. intGainsConv)
    annotation (
    Line(points={{76,-52},{104,-52},{104,20},{100,20}},
                                                     color={191,0,0}));
  connect(preTemFloor.port,thermalZoneFourElements. floor)
    annotation (Line(points={{75,-6},{76,-6},{76,-2}}, color={191,0,0}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{87.6,-22},{75,-22},{75,-19.2}}, color={0,0,127}));
  connect(preTemRoof.port,theConRoof. fluid)
    annotation (Line(points={{75,58},{75,52}},         color={191,0,0}));
  connect(theConRoof.solid,thermalZoneFourElements. roof)
    annotation (Line(points={{75,42},{74.9,42},{74.9,34}}, color={191,0,0}));
  connect(eqAirTempVDI.TEqAir,preTemRoof. T)
    annotation (Line(
    points={{59,84},{75,84},{75,71.2}}, color={0,0,127}));
  connect(theConRoof.Gc,hConRoof. y)
    annotation (Line(points={{80,47},{89.6,47}},          color={0,0,127}));
  connect(eqAirTempVDI.TDryBul,eqAirTemp. TDryBul)
    annotation (Line(points={{36,78},{-88,78},{-88,-2},{-30,-2},{-30,-10},{-18,-10}},
    color={0,0,127}));
  connect(eqAirTempVDI.TBlaSky,eqAirTemp. TBlaSky)
    annotation (Line(points={{36,84},{-90,84},{-90,-8},{-50,-8},{-50,2},{-24,2},
          {-24,-4},{-18,-4}},
    color={0,0,127}));
  connect(eqAirTempVDI.HSol[1],weaBus. HGloHor)
    annotation (Line(points={{36,90},{-92,90},{-92,6},{-75,6}},
    color={0,0,127}),Text(
    textString="%second",
    index=1,
    extent={{6,3},{6,3}}));
  connect(HDirTil.inc,corGDouPan. inc)
    annotation (Line(points={{-39,58},{-2,58},{-2,50},{12,50}},
    color={0,0,127}));
  connect(const1.y,eqAirTempVDI. sunblind[1])
    annotation (Line(points={{69.7,93},{64,93},{64,98},{48,98},{48,96}},
                                      color={0,0,127}));
  connect(corGDouPan.solarRadWinTrans,thermalZoneFourElements. solRad)
    annotation (Line(points={{35,56},{48,56},{48,31},{51,31}}, color={0,0,127}));
  connect(supplyAir, thermalZoneFourElements.ports[1]) annotation (Line(points={
          {-76,-34},{90.2375,-34},{90.2375,-1.95}}, color={0,127,255}));
  connect(returnAir, thermalZoneFourElements.ports[2]) annotation (Line(points={
          {-76,-74},{-22,-74},{-22,-68},{91.7625,-68},{91.7625,-1.95}}, color={0,
          127,255}));
  connect(thermalZoneFourElements.TAir, TAir1) annotation (Line(points={{101,32},
          {116,32},{116,88},{128,88}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SingleZone4RC;
