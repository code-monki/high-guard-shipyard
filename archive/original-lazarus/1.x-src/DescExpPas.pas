unit DescExpPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, Math, AnalysisPas, DataPas, CompExpPas, ShipModulePas;

type

   { TDescExp }

   TDescExp = class(TShipExporter)
   private
      function Book2Crew : String;
      function Book5Crew : String;
      function Book5CrewBreakdown: String;
      function RoundUp(TheNum : Extended) : Integer;
      function GunCrew : Integer;
      function MixTurretWpns (var Anal : TAnalysis) : String;
      function TurretType (TurretStyle : Integer) : String;
      function EngDetails : String;
      function EngBackups : String;
      function AviDetails (CompModel: String): String;
      function FlagDetails(TheFlagComp: String): String;
      function AviBackups (BakComp: String): String;
      function HardPointDetails : String;
      function ArmDetails (var Anal : TAnalysis) : String;
      function BigBayWpnDetails (var Anal : TAnalysis) : String;
      function LittleBayWpnDetails (var Anal : TAnalysis; EngyType : String) : String;
      function TurretWpnDetails (var Anal : TAnalysis; LasType, EngyType, PAType : String) : String;
      function DefDetails (var Anal : TAnalysis) : String;
      function ScreenDetails : String;
      function ScreenBackups : String;
      function CraftDetails : String;
      function IndCraft (Num, Crew : Integer; Size, Price : Extended; Desc : String) : String;
      function FuelTreatmentDetails : String;
      function GetConfig : String;
      function ConstructTime : Extended;
      function AccomDetails : String;
      function Range : String;
      function SmallCraftBridge: Boolean;
      function HullDetails : String;
      function CostDetails : String;
      function UserDefDetails : String;
      function GetCommType : String;
      function CalcStructure(ShipSize, ExtraTons : Extended) : Integer;
      function EngineeringIsRefitted: Boolean;
   public
      //
   //published
      procedure ExportShip (ExportFile : String);
   protected

   end;

var
   DescExp : TDescExp;
   iTest: Integer;
   eTest: Extended;
   sTest: String;
   bTest: Boolean;

implementation

uses
   ShipPas;

{ TDescExp }

function TDescExp.AccomDetails: String;
//generate details of accommodations and suchlike

var
   ReturnString : String;
   TonsCargo : Extended;
   Couch : Integer;
begin
   ReturnString := '';
   //staterooms
   if (Ship.Accom.StRoom > 0) then begin
      if (Frac(Ship.Accom.StRoom) <> 0) then begin
         ReturnString := FloatToStrF(Ship.Accom.StRoom, ffNumber, 18, 1)
               + ' Stateroom';
      end
      else begin
         ReturnString := FloatToStrF(Ship.Accom.StRoom, ffNumber, 18, 0)
               + ' Stateroom';
      end;
   end;
   if (Ship.Accom.StRoom > 1) then begin
      ReturnString := MakePlural(ReturnString);
   end;
   //small staterooms
   if (Ship.Accom.SmStRoom > 0) then begin
      if (ReturnString = '') then begin
         if (Frac(Ship.Accom.SmStRoom) <> 0) then begin
            ReturnString := FloatToStrF(Ship.Accom.SmStRoom, ffNumber, 18, 1)
                  + ' Small Craft Stateroom';
         end
         else begin
            ReturnString := FloatToStrF(Ship.Accom.SmStRoom, ffNumber, 18, 0)
                  + ' Small Craft Stateroom';
         end;
      end
      else begin
         if (Frac(Ship.Accom.SmStRoom) <> 0) then begin
            ReturnString := ReturnString + ', '
                  + FloatToStrF(Ship.Accom.SmStRoom, ffNumber, 18, 1)
                  + ' Small Craft Stateroom';
         end
         else begin
            ReturnString := ReturnString + ', '
                  + FloatToStrF(Ship.Accom.SmStRoom, ffNumber, 18, 0)
                  + ' Small Craft Stateroom';
         end;
      end;
      if (Ship.Accom.SmStRoom > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
   end;
   //couches
   if (SmallCraftBridge) then begin
      Couch := 2 + Ship.Accom.Couches;
   end
   else begin
      Couch := Ship.Accom.Couches;
   end;
   if (Couch > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Couch) + ' Acceleration Couch';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Couch)
               + ' Acceleration Couch';
      end;
      if (Couch > 1) then begin
         ReturnString := ReturnString + 'es';
      end;
   end;
   //low berths
   if (Ship.Accom.LowBerth > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Accom.LowBerth) + ' Low Berth';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.LowBerth)
               + ' Low Berth';
      end;
      if (Ship.Accom.LowBerth > 1) then begin
         ReturnString := ReturnString + 's';
      end;
   end;
   //emergency low berths
   if (Ship.Accom.EmLowBerth > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Accom.EmLowBerth) + ' Emergency Low Berth';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.EmLowBerth)
               + ' Emergency Low Berth';
      end;
      if (Ship.Accom.EmLowBerth > 1) then begin
         ReturnString := ReturnString + 's';
      end;
   end;
   //drop capsules, go into this branch if any caps of any type
   if (Ship.Accom.DropCaps > 0)
         or (Ship.Accom.ReadyDropCaps > 0)
         or (Ship.Accom.StoredDropCaps > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Accom.DropCaps) + ' Drop Capsule Launcher';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.DropCaps)
               + ' Drop Capsule Launcher';
      end;
      if (Ship.Accom.DropCaps > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      //ready caps
      if (Ship.Accom.ReadyDropCaps > 0) then begin
         ReturnString := ReturnString + ' with ' + IntToStr(Ship.Accom.ReadyDropCaps)
               + ' Ready Capsule';
         if (Ship.Accom.ReadyDropCaps > 1) then begin
             ReturnString := MakePlural(ReturnString);
         end;
      end;
      //stored caps
      if (Ship.Accom.StoredDropCaps > 0) then begin
         ReturnString := ReturnString + ' and ' + IntToStr(Ship.Accom.StoredDropCaps)
               + ' Stored Capsule';
         if (Ship.Accom.StoredDropCaps > 1) then begin
             ReturnString := MakePlural(ReturnString);
         end;
      end;
   end;

   //T20 components
   if (Ship.DesignRules = 0) then begin
      //engineering shops
      if (Ship.Accom.EngShop > 0) then begin
         if (ReturnString = '') then begin
            ReturnString := IntToStr(Ship.Accom.EngShop) + ' Engineering Shop';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.EngShop)
                  + ' Engineering Shop';
         end;
         if (Ship.Accom.EngShop > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
      end;
      //vehicle shops
      if (Ship.Accom.VehicleShop > 0) then begin
         if (ReturnString = '') then begin
            ReturnString := IntToStr(Ship.Accom.VehicleShop) + ' Vehicle Shop';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.VehicleShop)
                  + ' Vehicle Shop';
         end;
         if (Ship.Accom.VehicleShop > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
      end;
      //labs
      if (Ship.Accom.Labs > 0) then begin
         if (ReturnString = '') then begin
            ReturnString := IntToStr(Ship.Accom.Labs) + ' Laborator';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.Labs)
                  + ' Laborator';
         end;
         if (Ship.Accom.VehicleShop > 1) then begin
            ReturnString := ReturnString + 'ies';
         end
         else begin
            ReturnString := ReturnString + 'y';
         end;
      end;
      //sick bays
      if (Ship.Accom.SickBay > 0) then begin
         if (ReturnString = '') then begin
            ReturnString := IntToStr(Ship.Accom.SickBay) + ' Sick Bay';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.SickBay)
                  + ' Sick Bay';
         end;
         if (Ship.Accom.SickBay > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
      end;
      //autodocs
      if (Ship.Accom.AutoDoc > 0) then begin
         if (ReturnString = '') then begin
            ReturnString := IntToStr(Ship.Accom.AutoDoc) + ' Autodoc';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.AutoDoc)
                  + ' Autodoc';
         end;
         if (Ship.Accom.AutoDoc > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
      end;
      //Airlocks
      if (Ship.Accom.Airlock > 0) then begin
         if (ReturnString = '') then begin
           ReturnString := IntToStr(Ship.Accom.Airlock) + ' Additional Airlock';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.Airlock)
                  + ' Additional Airlock';
         end;
         if (Ship.Accom.Airlock > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
      end;
      //freshers
      if (Ship.Accom.Fresher > 0) then begin
         if (ReturnString = '') then begin
           ReturnString := IntToStr(Ship.Accom.Fresher) + ' Fresher';
         end
         else begin
            ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.Fresher)
                  + ' Fresher';
         end;
         if (Ship.Accom.Fresher > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
      end;
      //missile magazines
      if (Ship.Accom.MissileMag > 0) then begin
         if (ReturnString = '') then begin
            if (Frac(Ship.Accom.MissileMag) <> 0) then begin
               ReturnString := FloatToStrF(Ship.Accom.MissileMag, ffNumber, 18, 2)
                     + ' Ton';
            end
            else begin
               ReturnString := FloatToStrF(Ship.Accom.MissileMag, ffNumber, 18, 0)
                     + ' Ton';
            end;
         end
         else begin
            if (Frac(Ship.Accom.MissileMag) <> 0) then begin
               ReturnString := ReturnString + ', ' +
                     FloatToStrF(Ship.Accom.MissileMag, ffNumber, 18, 2) + ' Ton';
            end
            else begin
               ReturnString := ReturnString + ', ' +
                     FloatToStrF(Ship.Accom.MissileMag, ffNumber, 18, 0) + ' Ton';
            end;
         end;
         if (Ship.Accom.MissileMag > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' of Missile Magazines (holding '
               + IntToStr(Trunc(Ship.Accom.MissileMag * 20)) + ' missiles)';
      end;
   end;

   //passengers
   if (Ship.Accom.HighPass > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Accom.HighPass) + ' High Passenger';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.HighPass)
               + ' High Passenger';
      end;
      if (Ship.Accom.HighPass > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
   end;
   if (Ship.Accom.MidPass > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Accom.MidPass) + ' Middle Passenger';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.MidPass)
               + ' Middle Passenger';
      end;
      if (Ship.Accom.MidPass > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
   end;
   if (Ship.Accom.LowPass > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Accom.LowPass) + ' Low Passenger';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Accom.LowPass)
               + ' Low Passenger';
      end;
      if (Ship.Accom.LowPass > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
   end;
   //cargo
   if (Ship.Accom.AutoCargoMark = 0) then begin
      TonsCargo := Ship.Accom.Cargo;
   end
   else begin
      TonsCargo := Ship.GetRemTonnage + Ship.Eng.UpgradeSpaceAvailable;
   end;
   if (ReturnString = '') then begin
      if (Frac(TonsCargo) <> 0) then begin
         ReturnString := FloatToStrF(TonsCargo, ffNumber, 18, 3) + ' Ton';
      end
      else begin
         ReturnString := FloatToStrF(TonsCargo, ffNumber, 18, 0) + ' Ton';
      end;
   end
   else begin
      if (Frac(TonsCargo) <> 0) then begin
         ReturnString := ReturnString + ', ' + FloatToStrF(TonsCargo, ffNumber, 18, 3)
               + ' Ton';
      end
      else begin
         ReturnString := ReturnString + ', ' + FloatToStrF(TonsCargo, ffNumber, 18, 0)
               + ' Ton';
      end;
   end;
   if (TonsCargo > 1) then begin
      ReturnString := MakePlural(ReturnString);
   end;
   ReturnString := ReturnString + ' Cargo';

   //engineering upgrade space
   if (Ship.Eng.UpgradeSpaceAvailable > 0) then begin
      ReturnString := ReturnString + ' (Including '
            + FloatToStrF(Ship.Eng.UpgradeSpaceAvailable, ffNumber, 18, 3)
            + ' Ton';
      if (Ship.Eng.UpgradeSpaceAvailable <> 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      ReturnString := ReturnString + ' of Engineering upgrade space)';
   end;
   //waste space
   if (Ship.Accom.AutoCargoMark = 0) and (Ship.GetRemTonnage > 0) then begin
      if (ReturnString <> '') then begin
         ReturnString := ReturnString + ', ';
      end;
      if (Frac(Ship.GetRemTonnage) <> 0) then begin
         ReturnString := ReturnString + FloatToStrF(Ship.GetRemTonnage, ffNumber, 18, 3)
               + ' Ton';
      end
      else begin
         ReturnString := ReturnString + FloatToStrF(Ship.GetRemTonnage, ffNumber, 18, 0)
               + ' Ton';
      end;
      if (Ship.GetRemTonnage > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      ReturnString := ReturnString + ' of Waste Space';
   end;

   Result := ReturnString;
end;

function TDescExp.ArmDetails(var Anal: TAnalysis): String;
//Armament details

var
  WpnsString : String;
  LaserType, EnergyType, PAType : String;
begin
  //get wpns type
  //energy weapons
  if (Ship.LittleBays.EnergyBays > 0) then
  begin
    if (Ship.LittleBays.EnergyType = 1) then
    begin
      EnergyType := 'Fusion';
    end
    else begin
      EnergyType := 'Plasma';
    end;
  end
  else
  begin
    if (Ship.Turrets.EnergyType = 1) then
    begin
      EnergyType := 'Fusion';
    end
    else
    begin
      EnergyType := 'Plasma';
    end;
  end;
  //lasers
  if (Ship.Turrets.MixedTurrets = 0) then
  begin
    //if (Ship.Turrets.MixLaserType = 1) then begin
    if (Ship.Turrets.LaserType = 1) then
    begin
      LaserType := 'Pulse';
    end
    else
    begin
      LaserType := 'Beam';
    end;
  end
  else begin
    if (Ship.Turrets.LaserType = 1) then
    begin
      LaserType := 'Pulse';
    end
    else
    begin
      LaserType := 'Beam';
    end;
  end;
  //PA turret or barbette
  if (Ship.TechLevel < 15) then
  begin
    PAType := 'Barbette';
  end
  else
  begin
    PAType := 'Turret';
  end;

  //spinal mount
  if ((Ship.SpinalMount.SpinalMount > 0) and (not Ship.SpinalMount.RefitSpinalMount))
      or ((Ship.SpinalMount.NewSpinalMount > 0)and (Ship.SpinalMount.RefitSpinalMount)) then
  begin
    if (Ship.SpinalMount.RefitSpinalMount) then
    begin
      case (Ship.SpinalMount.NewSpinalType) of
         0: WpnsString := '';
         1: WpnsString := 'Meson Gun Spinal Mount (Factor-' +
               Ship.SpinalMount.SpinalMesonFactor + ', TL '
               + IntToStr(Ship.SpinalMount.SpinalMountRefitTech) + ' Refit)';
         2: WpnsString := 'Particle Accelerator Spinal Mount (Factor-' +
               Ship.SpinalMount.SpinalPAFactor + ', TL '
               + IntToStr(Ship.SpinalMount.SpinalMountRefitTech) + ' Refit)';
      end;
    end
    else
    begin
      case (Ship.SpinalMount.SpinalType) of
         0: WpnsString := '';
         1: WpnsString := 'Meson Gun Spinal Mount (Factor-' +
               Ship.SpinalMount.SpinalMesonFactor + ')';
         2: WpnsString := 'Particle Accelerator Spinal Mount (Factor-' +
               Ship.SpinalMount.SpinalPAFactor + ')';
      end;
   end;
  end;

  //100tbays
  if (BigBayWpnDetails(Anal) <> '') then
  begin
    if (WpnsString = '') then
    begin
      WpnsString := BigBayWpnDetails(Anal);
    end
    else if (BigBayWpnDetails(Anal) <> '') then
    begin
      WpnsString := WpnsString + ', ' + BigBayWpnDetails(Anal);
    end;
  end;
  //50t bays
  if (LittleBayWpnDetails(Anal, EnergyType) <> '') then
  begin
    if (WpnsString = '') then
    begin
      WpnsString := LittleBayWpnDetails(Anal, EnergyType);
    end
    else
    begin
      WpnsString := WpnsString + ', ' + LittleBayWpnDetails(Anal, EnergyType);
    end;
  end;
  //turrets
  if (TurretWpnDetails(Anal, LaserType, EnergyType, PAType) <> '') then
  begin
    if (WpnsString = '') then
    begin
      WpnsString := TurretWpnDetails(Anal, LaserType, EnergyType, PAType);
    end
    else
    begin
      WpnsString := WpnsString + ', '
          + TurretWpnDetails(Anal, LaserType, EnergyType, PAType);
    end;
  end;

  if (WpnsString = '') then
  begin
    WpnsString := 'None';
  end;
  Result := WpnsString;
end;

function TDescExp.AviBackups(BakComp: String): String;
//backup avionics details

var
  AviBak : String;
  iBakBridgeNum: Integer;
begin
  AviBak := '';
  if (Ship.Avionics.RefitBakBridge) then iBakBridgeNum := Ship.Avionics.NewBakBridgeNum
      else iBakBridgeNum := Ship.Avionics.BakBridgeNum;
  //bridge
  if (Ship.Avionics.BakBridge = 0) then
  begin
    AviBak := IntToStr(iBakBridgeNum) + ' Backup Bridge';
    if (iBakBridgeNum > 1) then
    begin
      AviBak := MakePlural(AviBak);
    end;
  end;
  //computer
  if (Ship.Avionics.RefitBakComp) then
  begin
    if (Ship.Avionics.NewBakCompNum > 0) then
    begin
      if (AviBak <> '') then
      begin
        AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.NewBakCompNum)
            + ' ' + BakComp + ' Backup Computer';
        if (Ship.Avionics.NewBakCompNum > 1) then
        begin
          AviBak := MakePlural(AviBak);
        end;
      end
      else
      begin
        AviBak := IntToStr(Ship.Avionics.NewBakCompNum)
            + ' ' + BakComp + ' Backup Computer';
        if (Ship.Avionics.NewBakCompNum > 1) then
        begin
          AviBak := MakePlural(AviBak);
        end;
      end;
      AviBak := AviBak + ' (TL ' + IntToStr(Ship.Avionics.BakCompRefitTech) + ' Refit)';
    end;
  end
  else
  begin
    if (Ship.Avionics.BakCompNum > 0) then
    begin
      if (AviBak <> '') then
      begin
        AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.BakCompNum)
            + ' ' + BakComp + ' Backup Computer';
        if (Ship.Avionics.BakCompNum > 1) then
        begin
          AviBak := MakePlural(AviBak);
        end;
      end
      else
      begin
        AviBak := IntToStr(Ship.Avionics.BakCompNum)
            + ' ' + BakComp + ' Backup Computer';
        if (Ship.Avionics.BakCompNum > 1) then
        begin
          AviBak := MakePlural(AviBak);
        end;
      end;
    end;
  end;

  //T20
  if (Ship.DesignRules = 0) then
  begin
    //Flight avionics
    if (Ship.Avionics.RefitBakFltAvionics) then
    begin
      if (Ship.Avionics.NewBakFltAvionics > 0) then
      begin
        if (AviBak <> '') then
        begin
          AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.NewBakFltAvionicsNum)
              + ' Model/' + IntToStr(Ship.Avionics.NewBakFltAvionics)
              + ' Backup Flight Avionics';
        end
        else
        begin
          AviBak := IntToStr(Ship.Avionics.NewBakFltAvionicsNum) + ' Model/'
              + IntToStr(Ship.Avionics.NewBakFltAvionics)
              + ' Backup Flight Avionics';
        end;
        AviBak := AviBak + ' (TL ' + IntToStr(Ship.Avionics.BakFltAvionicsRefitTech) + ' Refit)';
      end;
    end
    else
    begin
      if (Ship.Avionics.BakFltAvionics > 0) then
      begin
        if (AviBak <> '') then
        begin
          AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.BakFltAvionicsNum)
              + ' Model/' + IntToStr(Ship.Avionics.BakFltAvionics)
              + ' Backup Flight Avionics';
        end
        else
        begin
          AviBak := IntToStr(Ship.Avionics.BakFltAvionicsNum) + ' Model/'
              + IntToStr(Ship.Avionics.BakFltAvionics)
              + ' Backup Flight Avionics';
        end;
      end;
    end;
    //sensors
    if (Ship.Avionics.RefitBakSensors) then
    begin
      if (Ship.Avionics.NewBakSensors > 0) then
      begin
        if (AviBak <> '') then
        begin
          AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.NewBakSensorsNum)
              + ' Model/' + IntToStr(Ship.Avionics.NewBakSensors)
              + ' Backup Sensors';
        end
        else
        begin
          AviBak := IntToStr(Ship.Avionics.NewBakSensorsNum) + ' Model/'
              + IntToStr(Ship.Avionics.NewBakSensors) + ' Backup Sensors';
        end;
        AviBak := AviBak + ' (TL ' + IntToStr(Ship.Avionics.BakSensorsRefitTech) + ' Refit)';
      end;
    end
    else
    begin
      if (Ship.Avionics.BakSensors > 0) then
      begin
        if (AviBak <> '') then
        begin
          AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.BakSensorsNum)
              + ' Model/' + IntToStr(Ship.Avionics.BakSensors)
              + ' Backup Sensors';
        end
        else
        begin
          AviBak := IntToStr(Ship.Avionics.BakSensorsNum) + ' Model/'
              + IntToStr(Ship.Avionics.BakSensors) + ' Backup Sensors';
        end;
      end;
    end;
    //communications
    if (Ship.Avionics.RefitBakComms) then
    begin
      if (Ship.Avionics.NewBakComms > 0) then
      begin
        if (AviBak <> '') then
        begin
          AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.NewBakCommsNum)
              + ' Model/' + IntToStr(Ship.Avionics.NewBakComms)
              + ' Backup ' + GetCommType + 'Communications';
        end
        else
        begin
          AviBak := IntToStr(Ship.Avionics.NewBakCommsNum) + ' Model/'
              + IntToStr(Ship.Avionics.NewBakComms) + ' Backup '
              + GetCommType + 'Communications';
        end;
        AviBak := AviBak + ' (TL ' + IntToStr(Ship.Avionics.BakCommsRefitTech) + ' Refit)';
      end;
    end
    else
    begin
      if (Ship.Avionics.BakComms > 0) then
      begin
        if (AviBak <> '') then
        begin
          AviBak := AviBak + ', ' + IntToStr(Ship.Avionics.BakCommsNum)
              + ' Model/' + IntToStr(Ship.Avionics.BakComms)
              + ' Backup ' + GetCommType + 'Communications';
        end
        else
        begin
          AviBak := IntToStr(Ship.Avionics.BakCommsNum) + ' Model/'
              + IntToStr(Ship.Avionics.BakComms) + ' Backup '
              + GetCommType + 'Communications';
        end;
      end;
    end;

  end;
  Result := AviBak;
end;

function TDescExp.AviDetails(CompModel: String): String;
//avionics details

var
  AviString : String;
begin
  if (Ship.Avionics.RefitComp) then
  begin
    //no computer
    if (Ship.Avionics.NewComp = 0) then
    begin
      AviString := 'Bridge, No Computer Installed';
    end
    //no bridge
    else if (Ship.Avionics.Bridge = 1) then
    begin
      AviString := 'No Bridge Installed, ' + CompModel + ' Computer (TL '
          + IntToStr(Ship.Avionics.CompRefitTech) + ' Refit)';
    end
    //bridge and computer
    else
    begin
      AviString := 'Bridge, ' + CompModel + ' Computer (TL '
          + IntToStr(Ship.Avionics.CompRefitTech) + ' Refit)';
    end;
  end
  else
  begin
    //no computer
    if (Ship.Avionics.MainComp = 0) then
    begin
      AviString := 'Bridge, No Computer Installed';
    end
    //no bridge
    else if (Ship.Avionics.Bridge = 1) then
    begin
      AviString := 'No Bridge Installed, ' + CompModel + ' Computer';
    end
    //bridge and computer
    else
    begin
      AviString := 'Bridge, ' + CompModel + ' Computer';
    end;
  end;
  //T20 components
  if (Ship.DesignRules = 0) then
  begin
    //Flight avionics
    if (Ship.Avionics.RefitFltAvionics) then
    begin
      if (Ship.Avionics.NewFltAvionics > 0) then
      begin
        AviString := AviString + ', Model/' + IntToStr(Ship.Avionics.NewFltAvionics)
            + ' Flight Avionics (TL ' + IntToStr(Ship.Avionics.FltAvionicsRefitTech)
            + ' Refit)';
      end;
    end
    else
    begin
      if (Ship.Avionics.FltAvionics > 0) then
      begin
        AviString := AviString + ', Model/' + IntToStr(Ship.Avionics.FltAvionics)
            + ' Flight Avionics';
      end;
    end;
    //sensors
    if (Ship.Avionics.RefitSensors) then
    begin
      if (Ship.Avionics.NewSensors > 0) then
      begin
        AviString := AviString + ', Model/' + IntToStr(Ship.Avionics.NewSensors)
            + ' Sensors (TL ' + IntToStr(Ship.Avionics.SensorsRefitTech)
            + ' Refit)';
      end;
    end
    else
    begin
      if (Ship.Avionics.Sensors > 0) then
      begin
        AviString := AviString + ', Model/' + IntToStr(Ship.Avionics.Sensors)
            + ' Sensors';
      end;
    end;
    //communications
    if (Ship.Avionics.RefitComms) then
    begin
      if (Ship.Avionics.NewComms > 0) then
      begin
        AviString := AviString + ', Model/' + IntToStr(Ship.Avionics.NewComms)
            + ' ' + GetCommType + 'Communications (TL '
            + IntToStr(Ship.Avionics.CommsRefitTech) + ' Refit)';
      end;
    end
    else
    begin
      if (Ship.Avionics.Comms > 0) then
      begin
        AviString := AviString + ', Model/' + IntToStr(Ship.Avionics.Comms)
            + ' ' + GetCommType + 'Communications';
      end;
    end;
  end;
  Result := AviString;
end;

function TDescExp.FlagDetails(TheFlagComp: String): String;
begin
  Result := 'Fitted as Flagship: Includes accomodation for Admiral and ten staff';
  with (Ship.Avionics) do
  begin
    if (FlagBridge) then
    begin
      Result := Result + ' with Flag Bridge';
    end;
    if (FlagComp > 0) or (NewFlagComp > 0) then
    begin
      if (FlagBridge) then
      begin
        if (RefitFlagComp) then
        begin
          Result := Result + ' and ' + TheFlagComp + ' Flag Computer (TL '
              + IntToStr(FlagCompRefitTech) + ' Refit)';
        end
        else
        begin
          Result := Result + ' and ' + TheFlagComp + ' Flag Computer';
        end;
      end
      else
      begin
        if (RefitFlagComp) then
        begin
          Result := Result + ' with ' + TheFlagComp + ' Flag Computer (TL '
              + IntToStr(FlagCompRefitTech) + ' Refit)';
        end
        else
        begin
          Result := Result + ' with ' + TheFlagComp + ' Flag Computer';
        end;
      end;
    end;
  end;
end;

function TDescExp.BigBayWpnDetails(var Anal: TAnalysis): String;
//100t bay weapon details

var
  ReturnString : String;
  BigWpnsBays, iMeson, iPa, iMissile, iTech: Integer;
begin
  ReturnString := '';
  BigWpnsBays := 0;
  with (Ship.BigBays) do
  begin
    if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
    if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
    if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  end;

  BigWpnsBays := iMeson + iPa + iMissile;
  if (BigWpnsBays > 0) then
  begin
    //meson guns
    if (iMeson > 0) then
    begin
      ReturnString := IntToStr(iMeson) + ' 100-ton Meson Bay';
    end;
    if (iMeson > 1) then
    begin
       ReturnString := MakePlural(ReturnString);
    end;
    if (iMeson > 0) then
    begin
      if (Ship.BigBays.RefitMesonBays) then iTech := Ship.BigBays.MesonBaysRefitTech
          else iTech := Ship.TechLevel;
      ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.BigBays.MesonFactor(iTech));
      if (Ship.BigBays.RefitMesonBays) then
      begin
        ReturnString := ReturnString + ' TL ' + IntToStr(iTech) + ' Refit)';
      end
      else
      begin
        ReturnString := ReturnString + ')';
      end;
    end;

    //PA bays
    if (iPa > 0) then
    begin
      if (ReturnString = '') then
      begin
        ReturnString := IntToStr(iPa) + ' 100-ton Particle Accelerator Bay';
       end
       else
       begin
         ReturnString := ReturnString + ', ' + IntToStr(iPa) + ' 100-ton Particle Accelerator Bay';
       end;
       if (iPa > 1) then
       begin
         ReturnString := MakePlural(ReturnString);
       end;
       if (iPa > 0) then
       begin
         if (Ship.BigBays.RefitPaBays) then iTech := Ship.BigBays.PaBaysRefitTech
             else iTech := Ship.TechLevel;
         ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.BigBays.PaFactor(iTech));
         if (Ship.BigBays.RefitPaBays) then
         begin
           ReturnString := ReturnString + ' TL ' + IntToStr(iTech) + ' Refit)';
         end
         else
         begin
           ReturnString := ReturnString + ')';
         end;
       end;
     end;

     //missile bays
     if (iMissile > 0) then
     begin
       if (ReturnString = '') then
       begin
         ReturnString := IntToStr(iMissile) + ' 100-ton Missile Bay';
       end
       else
       begin
         ReturnString := ReturnString + ', ' + IntToStr(iMissile) + ' 100-ton Missile Bay';
       end;
       if (iMissile > 1) then
       begin
         ReturnString := MakePlural(ReturnString);
       end;
       if (iMissile > 0) then
       begin
         if (Ship.BigBays.RefitMissileBays) then iTech := Ship.BigBays.MissileBaysRefitTech
             else iTech := Ship.TechLevel;
         ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.BigBays.MissileFactor(iTech));
         if (Ship.BigBays.RefitMissileBays) then
         begin
           ReturnString := ReturnString + ' TL ' + IntToStr(iTech) + ' Refit)';
         end
         else
         begin
           ReturnString := ReturnString + ')';
         end;
       end;
     end;
   end;
   Result := ReturnString;
end;

function TDescExp.Book2Crew: String;
//create a list of book two crew

var
   CrewString : String;
   Passengers, Gunners : Integer;
begin
   //all ships need a pilot
   CrewString := 'Pilot';

   //does it have a navigator
   if (Ship.Tonnage > 200) and (Ship.Eng.JDrive <> 0) then begin
      CrewString := CrewString + ', Navigator';
   end;

   //engineers
   if not (Ship.Tonnage < 200) then begin
      if (Ship.Eng.Crew = 1) then begin
         CrewString := CrewString + ', Engineer';
      end
      else begin
         CrewString := CrewString + ', ' + IntToStr(Ship.Eng.Crew)
               + ' Engineers';
      end;
   end;

   //stewards
   if (Ship.Accom.HighPass > 0) then begin
      if (Ship.Accom.HighPass < 9) then begin
         CrewString := CrewString + ', Steward';
      end
      else begin
         CrewString := CrewString + ', ' + IntToStr(RoundUp(Ship.Accom.HighPass / 8))
               + ' Stewards';
      end;
   end;

   //medics
   Passengers := Ship.Accom.HighPass + Ship.Accom.MidPass + Ship.Accom.LowPass;
   if ((Ship.Tonnage >= 200) or (Passengers > 0)) and (Ship.Eng.JDrive <> 0) then begin
      if (Passengers < 120) then begin
         CrewString := CrewString + ', Medic';
      end
      else begin
         CrewString := CrewString + ', ' + IntToStr(RoundUp(Passengers / 120))
               + ' Medics';
      end;
   end;

   //gunners
   Gunners := Ship.BigBays.Crew + Ship.LittleBays.Crew
         + Ship.Turrets.Crew + Ship.Screens.Crew;
   if (Gunners > 0) then begin
      if (Gunners < 2) then begin
         CrewString := CrewString + ', Gunner';
      end
      else begin
         CrewString := CrewString + ', ' + IntToStr(Gunners) + ' Gunners';
      end;
   end;

   //craft
   if (Ship.Craft.Crew > 0) then begin
      CrewString := CrewString + ', ' + IntToStr(Ship.Craft.Crew) + ' Flight Crew';
   end;

   //troops
   if (Ship.Accom.Marines > 0) then begin
      if (Ship.Accom.Marines < 2) then begin
         CrewString := CrewString + ', Marine';
      end
      else begin
         CrewString := CrewString + ', ' + IntToStr(Ship.Accom.Marines)
               + ' Marines';
      end;
   end;

   //others
   if (Ship.Accom.OtherCrew > 0) then begin
      CrewString := CrewString + ', ' + IntToStr(Ship.Accom.OtherCrew)
               + ' Other Crew';
   end;

   //user defined
   if (Ship.UserDef.Crew > 0) then begin
      CrewString := CrewString + ', ' + IntToStr(Ship.UserDef.Crew)
            + ' Additional Crew (User Defined)';
   end;

   Result := CrewString;
end;

function TDescExp.Book5Crew: String;
//create a book five crew list

var
   Off, Rat, Trps, Plts : Integer;
   CrewString : String;
begin
   //initialise the variables
   Off := 0;
   Rat := 0;
   Trps := 0;
   Plts := 0;
   CrewString := '';

   //get the number of marines
   Trps := Ship.Accom.Marines;

   //get the number of fighter pilots. Look for craft called fighters and
   //allocate one pilot per
   if (Ship.Craft.FtrSqd > 0) then begin
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr1Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr1Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr2Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr2Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr3Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr3Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr4Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr4Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr5Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr5Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr6Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr6Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr7Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr7Num;
      end;
      if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr8Desc)) <> 0) then begin
         Plts := Plts + Ship.Craft.Cr8Num;
      end;
   end;

   //work out how many of the crew are officers
   Off := Max(7, RoundUp((Ship.Avionics.CmdCrew + Ship.Avionics.Crew) / 10))
         + RoundUp((Ship.Eng.CmdCrew + Ship.Eng.Crew) / 10)
         + RoundUp(GunCrew / 10)
         + (Ship.Craft.CmdCrew + Ship.Craft.LF1Num + Ship.Craft.LF2Num)
         + RoundUp((Ship.Accom.CmdCrew + Ship.Accom.Crew) / 10)
         + RoundUp(((Ship.MedicalCmdCrew + Ship.MedicalCrew) / 10) * 3);

   //calulate the number of ratings (not officers, marines or pilots)
   Rat := (Ship.GetTotalCmdCrew + Ship.GetTotalCrew) - (Off + Trps + Plts);

   //generate the crew list
   CrewString := IntToStr(Off) + ' Officers, ' + IntToStr(Rat) + ' Ratings';
   if (Plts > 0) then begin
      CrewString := CrewString + ', ' + IntToStr(Plts) + ' Pilots';
   end;
   if (Trps > 0) then begin
      CrewString := CrewString + ', ' + IntToStr(Trps) + ' Marines';
   end;
   Result := CrewString;
end;

function TDescExp.Book5CrewBreakdown: String;
var
  CrewString: String;
  iOfficers, iPilots: Integer;
begin
  //get the number of fighter pilots. Look for craft called fighters and
  //allocate one pilot per
  if (Ship.Craft.FtrSqd > 0) then begin
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr1Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr1Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr2Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr2Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr3Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr3Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr4Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr4Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr5Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr5Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr6Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr6Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr7Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr7Num;
    end;
    if (Pos('FIGHTER', UpperCase(Ship.Craft.Cr8Desc)) <> 0) then begin
      iPilots := iPilots + Ship.Craft.Cr8Num;
    end;
  end;

  //command
   iOfficers := Max(7, RoundUp((Ship.Avionics.CmdCrew + Ship.Avionics.Crew) / 10));
   CrewString := 'Command section: ' + IntToStr(iOfficers) + ' officers and '
       + IntToStr((Ship.Avionics.CmdCrew + Ship.Avionics.Crew) - iOfficers)
       + ' ratings';
   iOfficers := 0;
   //Engineering
   iOfficers := RoundUp((Ship.Eng.CmdCrew + Ship.Eng.Crew) / 10);
   CrewString := CrewString + '; Engineering section: ' + IntToStr(iOfficers)
       + ' officers and ' + IntToStr((Ship.Eng.CmdCrew + Ship.Eng.Crew) - iOfficers)
       + ' ratings';
   iOfficers := 0;
   //gunnery
   if (GunCrew > 0) then
   begin
     iOfficers := RoundUp(GunCrew / 10);
     CrewString := CrewString + '; Gunnery section: ' + IntToStr(iOfficers)
         + ' officers and ' + IntToStr(GunCrew - iOfficers) + ' ratings';
     iOfficers := 0;
   end;
   if ((ship.Craft.CmdCrew + Ship.Craft.Crew) > 0) then
   begin
     iOfficers := (Ship.Craft.CmdCrew + Ship.Craft.LF1Num + Ship.Craft.LF2Num);
     CrewString := CrewString + '; Flight section: ' + IntToStr(iOfficers)
         + ' officers';
     if (iPilots > 0) then
     begin
       CrewString := CrewString + ', ' + IntToStr(iPilots) + ' pilots and '
           + IntToStr((Ship.Craft.CmdCrew + Ship.Craft.Crew) - (iOfficers + iPilots))
           + ' ratings';
     end
     else
     begin
       CrewString := CrewString + ' and '
           + IntToStr((Ship.Craft.CmdCrew + Ship.Craft.Crew) - (iOfficers))
           + ' ratings';
     end;
     iOfficers := 0;
   end;
   //accomodations
   iOfficers := RoundUp((Ship.Accom.CmdCrew + Ship.Accom.Crew) / 10);
   CrewString := CrewString + '; Service section: ' + IntToStr(iOfficers)
       + ' officers and ' + IntToStr((Ship.Accom.CmdCrew + Ship.Accom.Crew) - iOfficers)
       + ' ratings';
   iOfficers := 0;
   //medical
   iOfficers := RoundUp(((Ship.MedicalCmdCrew + Ship.MedicalCrew) / 10) * 3);
   CrewString := CrewString + '; Medical Section: ' + IntToStr(iOfficers)
       + ' officers and ' + IntToStr((Ship.MedicalCmdCrew + Ship.MedicalCrew) - iOfficers)
       + ' ratings';
   if (Ship.Accom.Marines > 0) then
   begin
     CrewString := CrewString + '; Marines: ' + IntToStr(Ship.Accom.Marines);
   end;
   Result := CrewString;
end;

function TDescExp.CalcStructure(ShipSize, ExtraTons: Extended): Integer;
//T20 METHOD
//calculate the ships structural value

begin
  Result := 0;
  if (ShipSize <= 10) then
  begin
    Result := Trunc(50 + (2.5 * (Trunc(ExtraTons / 1))));
  end
  else if (ShipSize <= 100) then
  begin
    Result := Trunc(75 + (2.5 * (Trunc(ExtraTons / 10))));
  end
  else if (ShipSize <= 1000) then
  begin
    Result := 100 + (15 * (Trunc(ExtraTons / 100)));
  end
  else if (ShipSize <= 10000) then
  begin
    Result := 250 + (25 * (Trunc(ExtraTons / 1000)));
  end
  else if (ShipSize <= 100000) then
  begin
    Result := 500 + (25 * (Trunc(ExtraTons / 10000)));
  end
  else if (ShipSize <= 1000000) then
  begin
    Result := 750 + (25 * (Trunc(ExtraTons / 100000)));
  end
  else
  begin
    Result := 1000 + (100 * (Trunc(ExtraTons / 1000000)));
  end;
end;

function TDescExp.EngineeringIsRefitted: Boolean;
begin
  Result := False;
  if (Ship.Eng.MDriveIsRefitted) then Result := True;
  if (Ship.Eng.JDriveIsRefitted) then Result := True;
  if (Ship.Eng.PPlantIsRefitted) then Result := True;
  if (Ship.Eng.PowerTonsIsRefitted) then Result := True;
  if (Ship.Eng.BakMDriveIsRefitted) then Result := True;
  if (Ship.Eng.BakJDriveIsRefitted) then Result := True;
  if (Ship.Eng.BakPPlantIsRefitted) then Result := True;
  if (Ship.Eng.BakPowerTonsIsRefitted) then Result := True;
end;

function TDescExp.ConstructTime: Extended;
//this **ROUGHLY** calculates the ships construction time.
//The formula are imperfect, but work within acceptable limits

begin
  if (Ship.Tonnage < 1000) then
  begin
    Result := Power(Log10(Ship.Tonnage), 2.9) * 5.1;
  end
  else
  begin
    Result := Log10(Ship.Tonnage) * 40;
  end;
end;

function TDescExp.CostDetails: String;
//details of costs

var
  ReturnString : String;
  StdPrice, ArchFee, TotCost, RftPrice, RftArch, RefitCost: Extended;
begin
  StdPrice := Ship.Price;
  ArchFee := StdPrice * 0.01;
  TotCost := StdPrice + ArchFee;
  RftPrice := Ship.RefitPrice;
  RftArch := RftPrice * 0.01;
  RefitCost := RftPrice + RftArch;
  ReturnString := 'MCr ' + FloatToStrF(TotCost, ffNumber, 18, 3)
      + ' Singly (incl. Architects fees of MCr '
      + FloatToStrF(ArchFee, ffNumber, 18, 3) + '), MCr '
      + FloatToStrF((StdPrice * 0.8), ffNumber, 18, 3)  + ' in Quantity';
  if (Ship.CraftCost > 0) then
  begin
    ReturnString := ReturnString + ', plus MCr '
        + FloatToStrF(Ship.CraftCost, ffNumber, 18, 3) + ' of Carried Craft';
  end;
  if (Ship.Options.ChargeForHardpoints = 1) then
  begin
    ReturnString := ReturnString + ' (Hardpoints and Turrets charged)';
  end;
  if (Ship.IsRefitted) then
  begin
    ReturnString := ReturnString + ', Refit Cost MCr ' + FloatToStrF(RefitCost, ffNumber, 18, 3)
        + ' Singly (Incl. Architects fees of MCr ' + FloatToStrF(RftArch, ffNumber, 18, 3)
        + '), MCr ' + FloatToStrF(RefitCost * 0.8, ffNumber, 18, 3) + ' in Quantity';
  end;
  Result := ReturnString;
end;

function TDescExp.CraftDetails: String;
//details of craft and launch facilities

var
   ReturnString : String;
begin
   ReturnString := '';

   //craft
   if (Ship.Craft.Cr1Num > 0) then begin
      ReturnString := IndCraft(Ship.Craft.Cr1Num, Ship.Craft.Cr1Crew,
            Ship.Craft.Cr1Tonnage, Ship.Craft.Cr1Price, Ship.Craft.Cr1Desc);
   end;
   if (Ship.Craft.Cr2Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr2Num, Ship.Craft.Cr2Crew,
               Ship.Craft.Cr2Tonnage, Ship.Craft.Cr2Price, Ship.Craft.Cr2Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr2Num, Ship.Craft.Cr2Crew,
                  Ship.Craft.Cr2Tonnage, Ship.Craft.Cr2Price, Ship.Craft.Cr2Desc);
      end;
   end;
   if (Ship.Craft.Cr3Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr3Num, Ship.Craft.Cr3Crew,
               Ship.Craft.Cr3Tonnage, Ship.Craft.Cr3Price, Ship.Craft.Cr3Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr3Num, Ship.Craft.Cr3Crew,
                  Ship.Craft.Cr3Tonnage, Ship.Craft.Cr3Price, Ship.Craft.Cr3Desc);
      end;
   end;
   if (Ship.Craft.Cr4Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr4Num, Ship.Craft.Cr4Crew,
               Ship.Craft.Cr4Tonnage, Ship.Craft.Cr4Price, Ship.Craft.Cr4Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr4Num, Ship.Craft.Cr4Crew,
                  Ship.Craft.Cr4Tonnage, Ship.Craft.Cr4Price, Ship.Craft.Cr4Desc);
      end;
   end;
   if (Ship.Craft.Cr5Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr5Num, Ship.Craft.Cr5Crew,
               Ship.Craft.Cr5Tonnage, Ship.Craft.Cr5Price, Ship.Craft.Cr5Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr5Num, Ship.Craft.Cr5Crew,
                  Ship.Craft.Cr5Tonnage, Ship.Craft.Cr5Price, Ship.Craft.Cr5Desc);
      end;
   end;
   if (Ship.Craft.Cr6Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr6Num, Ship.Craft.Cr6Crew,
               Ship.Craft.Cr6Tonnage, Ship.Craft.Cr6Price, Ship.Craft.Cr6Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr6Num, Ship.Craft.Cr6Crew,
                  Ship.Craft.Cr6Tonnage, Ship.Craft.Cr6Price, Ship.Craft.Cr6Desc);
      end;
   end;
   if (Ship.Craft.Cr7Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr7Num, Ship.Craft.Cr7Crew,
               Ship.Craft.Cr7Tonnage, Ship.Craft.Cr7Price, Ship.Craft.Cr7Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr7Num, Ship.Craft.Cr7Crew,
                  Ship.Craft.Cr7Tonnage, Ship.Craft.Cr7Price, Ship.Craft.Cr7Desc);
      end;
   end;
   if (Ship.Craft.Cr8Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IndCraft(Ship.Craft.Cr8Num, Ship.Craft.Cr8Crew,
               Ship.Craft.Cr8Tonnage, Ship.Craft.Cr8Price, Ship.Craft.Cr8Desc);
      end
      else begin
         ReturnString := ReturnString + ', '
               + IndCraft(Ship.Craft.Cr8Num, Ship.Craft.Cr8Crew,
                  Ship.Craft.Cr8Tonnage, Ship.Craft.Cr8Price, Ship.Craft.Cr8Desc);
      end;
   end;

   //launch facilities
   if (Ship.Craft.LF1Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Craft.LF1Num)
               + ' ' + FloatToStrF(Ship.Craft.LF1Size, ffNumber, 18, 3)
               + ' ton Launch Tube';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Craft.LF1Num)
               + ' ' + FloatToStrF(Ship.Craft.LF1Size, ffNumber, 18, 3)
               + ' ton Launch Tube';
      end;
      if (Ship.Craft.LF1Num > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
   end;
   if (Ship.Craft.LF2Num > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Craft.LF2Num)
               + ' ' + FloatToStrF(Ship.Craft.LF2Size, ffNumber, 18, 3)
               + ' ton Launch Tube';
      end
      else begin
         ReturnString := ReturnString + ', ' + IntToStr(Ship.Craft.LF2Num)
               + ' ' + FloatToStrF(Ship.Craft.LF2Size, ffNumber, 18, 3)
               + ' ton Launch Tube';
      end;
      if (Ship.Craft.LF2Num > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
   end;

   if (ReturnString = '') then begin
      ReturnString := 'None';
   end;
   Result := ReturnString;
end;

function TDescExp.DefDetails(var Anal: TAnalysis): String;
//defence details

var
  ReturnString : String;
  UsedMixTurrets, ArmFact, iBigRepulsor, iLittleRepulsor, iBigRepTech, iLittleRepTech: Integer;
begin
  ReturnString := '';
  UsedMixTurrets := Ship.Turrets.NumMixTurrets - Ship.Turrets.EmptyMixTurrets;
  if (Ship.BigBays.RefitRepulsorBays) then
  begin
    iBigRepulsor := Ship.BigBays.NewRepulsorBays;
    iBigRepTech := Ship.BigBays.RepulsorBaysRefitTech;
  end
  else
  begin
    iBigRepulsor := Ship.BigBays.RepulsorBays;
    iBigRepTech := Ship.TechLevel;
  end;
  if (Ship.LittleBays.RefitRepulsorBays) then
  begin
    iLittleRepulsor := Ship.LittleBays.NewRepulsorBays;
    iLittleRepTech := Ship.LittleBays.RepulsorBaysRefitTech;
  end
  else
  begin
    iLittleRepulsor := Ship.LittleBays.RepulsorBays;
    iLittleRepTech := Ship.TechLevel;
  end;

  //repulsors
  if (iBigRepulsor > 0) then
  begin
    ReturnString := IntToStr(iBigRepulsor) + ' 100-ton Repulsor Bay';
    if (iBigRepulsor > 1) then
    begin
      ReturnString := MakePlural(ReturnString);
    end;
    ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.BigBays.RepulsorFactor(iBigRepTech));
    if (Ship.BigBays.RefitRepulsorBays) then
    begin
      ReturnString := ReturnString + ', TL ' + IntToStr(iBigRepTech) + ' Refit)';
    end
    else
    begin
      ReturnString := ReturnString + ')';
    end;
  end
  else
  if (iLittleRepulsor > 0) then
  begin
    ReturnString := IntToStr(iLittleRepulsor) + ' 50-ton Repulsor Bay';
    if (iLittleRepulsor > 1) then
    begin
      ReturnString := MakePlural(ReturnString);
    end;
    ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.LittleBays.RepulsorFactor(iLittleRepTech));
    if (Ship.LittleBays.RefitRepulsorBays) then
    begin
      ReturnString := ReturnString + ', TL ' + IntToStr(iLittleRepTech) + ' Refit)';
    end
    else
    begin
      ReturnString := ReturnString + ')';
    end;
  end;

  //Sandcasters
  if (Ship.Turrets.MixedTurrets = 0)
      and (Ship.Turrets.MixTurretSand > 0)
      and (UsedMixTurrets > 0) then
  begin
    if (ReturnString = '') then begin
      ReturnString := IntToStr(Ship.Turrets.MixTurretSand) + ' Sandcaster';
    end
    else begin
      ReturnString := ReturnString + ', '
          + IntToStr(Ship.Turrets.MixTurretSand) + ' Sandcaster';;
    end;
    if (Ship.Turrets.MixTurretSand > 1) then begin
      ReturnString := MakePlural(ReturnString);
    end;
    ReturnString := ReturnString + ' in ';
    if (UsedMixTurrets > 1) then begin
      ReturnString := ReturnString + 'each';
    end
    else begin
      ReturnString := ReturnString + 'the';
    end;
    ReturnString := ReturnString + ' Mixed Turret, organised into '
       + IntToStr(UsedMixTurrets) + ' Batter';
    if (UsedMixTurrets > 1) then begin
      ReturnString := ReturnString + 'ies';
    end
    else begin
      ReturnString := ReturnString + 'y';
    end;
    ReturnString := ReturnString + ' (Factor-'
        + IntToStr(Ship.Turrets.SandFact(Ship.TechLevel))+ ')';
  end
  else if (Ship.Turrets.SandTurrets > 0) then begin
    if (ReturnString = '') then begin
      ReturnString := IntToStr(Ship.Turrets.SandTurrets) + ' '
          + TurretType(Ship.Turrets.SandTurretStyle)
          + ' Sandcaster Turret';
    end
    else begin
      ReturnString := ReturnString + ', ' + IntToStr(Ship.Turrets.SandTurrets)
          + ' ' + TurretType(Ship.Turrets.SandTurretStyle)
          + ' Sandcaster Turret';
    end;
    if (Ship.Turrets.SandTurrets > 1) then begin
      ReturnString := MakePlural(ReturnString);
    end;
    ReturnString := ReturnString + ' organised into '
        + IntToStr(Ship.Turrets.SandBatteries) + ' Batter';
    if (Ship.Turrets.SandBatteries > 1) then begin
      ReturnString := ReturnString + 'ies';
    end
    else begin
      ReturnString := ReturnString + 'y';
    end;
    ReturnString := ReturnString + ' (Factor-'
        + IntToStr(Ship.Turrets.SandFact(Ship.TechLevel)) + ')';
  end;

  //screens
  if (ScreenDetails <> '') then begin
    if (ReturnString = '') then begin
      ReturnString := ScreenDetails;
    end
    else begin
      ReturnString := ReturnString + ', ' + ScreenDetails;
    end;
  end;

  //armour
  ArmFact := Ship.Hull.Armour;
  if (Ship.Hull.Config = 8) then ArmFact := ArmFact + 3;
  if (Ship.Hull.Config = 9) then ArmFact := ArmFact + 6;
  if (ArmFact > 0) then begin
    if (ReturnString = '') then begin
      ReturnString := 'Armoured Hull (Factor-'
          + IntToStr(ArmFact) + ')';
    end
    else begin
      ReturnString := ReturnString + ', ' + 'Armoured Hull (Factor-'
          + IntToStr(ArmFact) + ')';
    end;
  end;

  if (ReturnString = '') then begin
    ReturnString := 'None';
  end;

  Result := ReturnString;
end;

function TDescExp.EngBackups: String;
//String covering engineering backups

var
   EngBak : String;
   sBakMDrive, sNumBakMDrive, sBakJDrive, sNumBakJDrive,
   sBakPPlant, sNumBakPPlant, sBakPowerTons, sNumBakPowerTons: String;
begin
  EngBak := '';
  if (Ship.Eng.BakMDriveIsRefitted) then sBakMDrive := IntToStr(Ship.Eng.BakNewMDrive)
      else sBakMDrive := IntToStr(Ship.Eng.BakMDrive);
  if (Ship.Eng.BakMDriveIsRefitted) then sNumBakMDrive := IntToStr(Ship.Eng.BakNewMDNumb)
      else sNumBakMDrive := IntToStr(Ship.Eng.BakMDNum);
  if (Ship.Eng.BakJDriveIsRefitted) then sBakJDrive := IntToStr(Ship.Eng.BakNewJDrive)
      else sBakJDrive := IntToStr(Ship.Eng.BakJDrive);
  if (Ship.Eng.BakJDriveIsRefitted) then sNumBakJDrive := IntToStr(Ship.Eng.BakNewJDNumb)
      else sNumBakJDrive := IntToStr(Ship.Eng.BakJDNum);
  if (Ship.Eng.BakPPlantIsRefitted) then sBakPPlant := IntToStr(Ship.Eng.BakNewPPlant)
      else sBakPPlant := IntToStr(Ship.Eng.BakPPlant);
  if (Ship.Eng.BakPPlantIsRefitted) then sNumBakPPlant := IntToStr(Ship.Eng.BakNewPPNumb)
      else sNumBakPPlant := IntToStr(Ship.Eng.BakPPNum);
  if (Ship.Eng.BakPowerTonsIsRefitted) then sBakPowerTons := FloatToStrF(Ship.Eng.BakNewPowerTons, ffNumber, 18, 3)
      else sBakPowerTons := FloatToStrF(Ship.Eng.BakPowerTons, ffNumber, 18, 3);
  if (Ship.Eng.BakPowerTonsIsRefitted) then sNumBakPowerTons := IntToStr(Ship.Eng.BakNewPowerTonsNum)
      else sNumBakPowerTons := IntToStr(Ship.Eng.BakPowerTonsNum);
   //JDrive
   if (StrToInt(sBakJDrive) > 0) then begin
      EngBak := sNumBakJDrive + ' Jump-'
            + sBakJDrive + ' Backup';
      if (StrToInt(sNumBakJDrive) > 1) then begin
         EngBak := MakePlural(EngBak);
      end;
      if (Ship.Eng.BakJDriveIsRefitted) then
      begin
        EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakJDriveRefitTech) + ' Refit)';
      end;
   end;
   //MDrive
   if (StrToInt(sBakMDrive) > 0) then begin
      if (EngBak <> '') then begin
         EngBak := EngBak + ', ' + sNumBakMDrive
               + sBakMDrive + ' G Manuever Backup';
         if (StrToInt(sNumBakMDrive) > 1) then begin
            EngBak := MakePlural(EngBak);
         end;
         if (Ship.Eng.BakMDriveIsRefitted) then
         begin
           EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakMDriveRefitTech) + ' Refit)';
         end;
      end
      else begin
         EngBak := sNumBakMDrive
               + sBakMDrive + ' G Manuever Backup';
         if (StrToInt(sNumBakMDrive) > 1) then begin
            EngBak := MakePlural(EngBak);
         end;
         if (Ship.Eng.BakMDriveIsRefitted) then
         begin
           EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakMDriveRefitTech) + ' Refit)';
         end;
      end;
   end;
   //Power plant
   if (StrToint(sBakPPlant) > 0) and (Ship.DesignRules = 1) then begin
      if (EngBak <> '') then begin
         EngBak := EngBak + ', ' + sNumBakPPlant
               + ' Power plant-' + sBakPPlant + ' Backup';
         if (StrToInt(sNumBakPPlant) > 1) then begin
            EngBak := MakePlural(EngBak);
         end;
         if (Ship.Eng.BakPPlantIsRefitted) then
         begin
           EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakPPlantRefitTech) + ' Refit)';
         end;
      end
      else begin
         EngBak := sNumBakPPlant
               + ' Power plant-' + sBakPPlant + ' Backup';
         if (StrToInt(sNumBakPPlant) > 1) then begin
            EngBak := MakePlural(EngBak);
         end;
         if (Ship.Eng.BakPPlantIsRefitted) then
         begin
           EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakPPlantRefitTech) + ' Refit)';
         end;
      end;
   end;
   //Power tons
   if (StrToFloat(sBakPowerTons) > 0) and (Ship.DesignRules = 0) then begin
      if (EngBak <> '') then begin
         EngBak := EngBak + ', ' + sNumBakPowerTons + ' ' + sBakPowerTons
               + ' Ton Bakup Power plant';
         if (StrToInt(sNumBakPowerTons) > 1) then begin
            EngBak := MakePlural(EngBak);
         end;
         if (Ship.Eng.BakPowerTonsIsRefitted) then
         begin
           EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakPowerTonsRefitTech) + ' Refit)';
         end;
      end
      else begin
         EngBak := sNumBakPowerTons + ' ' + sBakPowerTons
               + ' Ton Bakup Power plant';
         if (StrToInt(sNumBakPowerTons) > 1) then begin
            EngBak := MakePlural(EngBak);
         end;
         if (Ship.Eng.BakPowerTonsIsRefitted) then
         begin
           EngBak := EngBak + ' (TL ' + IntToStr(Ship.Eng.BakPowerTonsRefitTech) + ' Refit)';
         end;
      end;
   end;
   Result := EngBak;
end;

function TDescExp.EngDetails: String;
//details of engineering
var
  sMDrive, sJDrive, sPPlant, sPowerTons: String;
begin
  if (Ship.Eng.MDriveIsRefitted) then sMDrive := IntToStr(Ship.Eng.NewMDrive)
      else sMDrive := IntToStr(Ship.Eng.MDrive);
  if (Ship.Eng.JDriveIsRefitted) then sJDrive := IntToStr(Ship.Eng.NewJDrive)
      else sJDrive := IntToStr(Ship.Eng.JDrive);
  if (Ship.Eng.PPlantIsRefitted) then sPPlant := IntToStr(Ship.Eng.NewPPlant)
      else sPPlant := IntToStr(Ship.Eng.PPlant);
  if (Ship.Eng.PowerTonsIsRefitted) then sPowerTons := FloatToStrF(Ship.Eng.NewPowerTons, ffNumber, 18, 3)
      else sPowerTons := FloatToStrF(Ship.Eng.PowerTons, ffNumber, 18, 3);
  if (Ship.DesignRules = 0) then
  begin
    Result := 'Jump-' + sJDrive;
    if (Ship.Eng.JDriveIsRefitted) then Result := Result + ' (TL '
        + IntToStr(Ship.Eng.JDriveRefitTech) + ' Refit)';
    Result := Result + ', ' + sMDrive + 'G Manuever';
    if (Ship.Eng.MDriveIsRefitted) then Result := Result + ' (TL '
        + IntToStr(Ship.Eng.MDriveRefitTech) + ' Refit)';
    Result := Result + ', ' + sPowerTons + ' Ton Power Plant, ';
    if (Ship.Eng.PowerTonsIsRefitted) then Result := Result + ' (TL '
        + IntToStr(Ship.Eng.PowerTonsRefitTech) + ' Refit) ';
    //Energy points
    Result := Result + FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3) + ' EP';
        //Agiltiy
    Result := Result + ', Agility ' + IntToStr(Ship.Agility);
  end
  else
  begin
    Result := 'Jump-' + sJDrive;
    if (Ship.Eng.JDriveIsRefitted) then Result := Result + ' (TL '
        + IntToStr(Ship.Eng.JDriveRefitTech) + ' Refit)';
    Result := Result + ', ' + sMDrive + 'G Manuever';
    if (Ship.Eng.MDriveIsRefitted) then Result := Result + '  (TL '
        + IntToStr(Ship.Eng.MDriveRefitTech) + ' Refit)';
    Result := Result + ', Power plant-' + sPPlant;
    if (Ship.Eng.PPlantIsRefitted) then Result := Result + ' (TL '
        + IntToStr(Ship.Eng.PPlantRefitTech) + ' Refit)';
        //Energy points
    Result := Result + ', ' +  FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3) + ' EP';
        //Agiltiy
    Result := Result + ', Agility ' + IntToStr(Ship.Agility);
  end;
end;

procedure TDescExp.ExportShip(ExportFile: String);
//export the ship as descriptive text

var
  ExportData : TStringList;
  Data : TData;
  Analysis : TAnalysis;
  ShipComp, BakComp, FlagComp : String;
  FuelTankage : Extended;
  CompExp : TCompExp;
  ePowerTons, RefitTimeMod: Extended;
  iPPlant: Integer;
begin
  if (Ship.Eng.PowerTonsIsRefitted) then ePowerTons := Ship.Eng.NewPowerTons
      else ePowerTons := Ship.Eng.PowerTons;
  if (Ship.Eng.PPlantIsRefitted) then iPPlant := Ship.Eng.NewPPlant
      else iPPlant := Ship.Eng.PPlant;
  if (EngineeringIsRefitted) then RefitTimeMod := 0.25  else RefitTimeMod := 0.1;
  ExportData := TStringList.Create;
  Data := TData.Create;
  Analysis := TAnalysis.Create;
  CompExp := TCompExp.Create;
  try
    Data.InitialiseData;
    Analysis.Analyise(-1);        //search here

    //Get the USP
    ExportData.AddStrings(Ship.USP);
//      ExportData.LoadFromFile(ExportFile);
    ExportData.Add('');
    ExportData.Add('');
    ExportData.Add('Detailed Description');
    if (Ship.DesignRules = 0) then
    begin
      ExportData.Add('  (T20 Design)');
    end
    else
    begin
      ExportData.Add('  (High Guard Design)');
    end;
    if (Ship.IsRefitted) then
    begin
      ExportData.Add('  (Refit at TL ' + IntToStr(Ship.RefitTechLevel) + ')');
    end;
    ExportData.Add('');

    //how big is the ship
    ExportData.Add('HULL');
    ExportData.Add(HullDetails);
    ExportData.Add('');

    //what is its crew
    ExportData.Add('CREW');
    if (Ship.CrewRules = 0) then
    begin
      ExportData.Add(Book2Crew);
    end
    else
    begin
      ExportData.Add(Book5Crew);
      //ExportData.Add(Book5CrewBreakdown);
    end;
    ExportData.Add('');

    //what is its performance
    ExportData.Add('ENGINEERING');
    ExportData.Add(EngDetails);
    if (EngBackups <> '') then
    begin
      ExportData.Add(EngBackups);
    end;
    ExportData.Add('');

    //Avionics
    ExportData.Add('AVIONICS');
    if (Ship.Avionics.RefitComp) then
    begin
      ShipComp := Copy(Data.GetComputerData(7, Ship.Avionics.NewComp), 3,
          Length(Data.GetComputerData(7, Ship.Avionics.NewComp)));
    end
    else
    begin
      ShipComp := Copy(Data.GetComputerData(7, Ship.Avionics.MainComp), 3,
          Length(Data.GetComputerData(7, Ship.Avionics.MainComp)));
    end;
    if (Ship.Avionics.RefitFlagComp) then
    begin
      FlagComp := Copy(Data.GetComputerData(7, Ship.Avionics.NewFlagComp), 3,
          Length(Data.GetComputerData(7, Ship.Avionics.NewFlagComp)));
    end
    else
    begin
      FlagComp := Copy(Data.GetComputerData(7, Ship.Avionics.FlagComp), 3,
          Length(Data.GetComputerData(7, Ship.Avionics.FlagComp)));
    end;
    if (Ship.Avionics.RefitBakComp) then
    begin
      BakComp := Copy(Data.GetComputerData(7, Ship.Avionics.NewBakComp), 3,
          Length(Data.GetComputerData(7, Ship.Avionics.NewBakComp)));
    end
    else
    begin
      BakComp := Copy(Data.GetComputerData(7, Ship.Avionics.BakComp), 3,
          Length(Data.GetComputerData(7, Ship.Avionics.BakComp)));
    end;
    ExportData.Add(AviDetails(ShipComp));
    //flag items
    if (Ship.Flagship) then
    begin
      ExportData.Add(FlagDetails(FlagComp));
    end;
    //Avionics backups
    if (AviBackups(BakComp) <> '') then
    begin
      ExportData.Add(AviBackups(BakComp));
    end;
    ExportData.Add('');

    //hardpoints
    ExportData.Add('HARDPOINTS');
    ExportData.Add(HardPointDetails);
    ExportData.Add('');

    //wespons
    ExportData.Add('ARMAMENT');
    ExportData.Add(ArmDetails(Analysis));
    ExportData.Add('');

    //defences
    ExportData.Add('DEFENCES');
    ExportData.Add(DefDetails(Analysis));
    if (ScreenBackups <> '') then
    begin
      ExportData.Add(ScreenBackups);
    end;
    ExportData.Add('');

    //craft
    ExportData.Add('CRAFT');
    ExportData.Add(CraftDetails);
    ExportData.Add('');

    //Fuel Treatment, tankage and endurance
    ExportData.Add('FUEL');
    if (Ship.DesignRules = 0) then
    begin
      FuelTankage := ((Ship.Tonnage * Ship.Fuel.JFuel) * 0.1)
          + ((Ship.Tonnage * (Ship.Fuel.PFuel / 28)) * (0.01 * iPPlant))
          + Ship.Fuel.ExtraFuel;  //need refit eng here
    end
    else
    begin
      FuelTankage := ((Ship.Tonnage * Ship.Fuel.JFuel) * 0.1)
          + ((Ship.Tonnage * (Ship.Fuel.PFuel / 28)) * (0.01 * iPPlant))
          + Ship.Fuel.ExtraFuel;
    end;
    if (Frac(FuelTankage) <> 0) then
    begin
      ExportData.Add(FloatToStrF(FuelTankage, ffNumber, 18, 3) + ' Tons Fuel'
          + ' (' + Range +')');
    end
    else
    begin
      ExportData.Add(FloatToStrF(FuelTankage, ffNumber, 18, 0) + ' Tons Fuel'
          + ' (' + Range +')');
    end;
    ExportData.Add(FuelTreatmentDetails);
    ExportData.Add('');

    //accommodations, cargo
    ExportData.Add('MISCELLANEOUS');
    ExportData.Add(AccomDetails);
    ExportData.Add('');

    //user defined
    ExportData.Add('USER DEFINED COMPONENTS');
    ExportData.Add(UserDefDetails);
    ExportData.Add('');

    //cost
    ExportData.Add('COST');
    ExportData.Add(CostDetails);
    ExportData.Add('');

    //construction time
    ExportData.Add('CONSTRUCTION TIME');
    ExportData.Add(IntToStr(Round(ConstructTime)) + ' Weeks Singly, '
        + IntToStr(Round(ConstructTime * 0.8)) + ' Weeks in Quantity');
    if (Ship.IsRefitted) then
    begin
      ExportData.Add('RefitTime: ' + IntToStr(Round(ConstructTime * RefitTimeMod)) + ' Weeks Singly, '
          + IntToStr(Round((ConstructTime * 0.8) * RefitTimeMod)) + ' Weeks in Quantity');
    end;
    ExportData.Add('');

    //comments
    ExportData.Add('COMMENTS');
    ExportData.AddStrings(Ship.ShipComments);

    //add component breakdown
    ExportData.Add('');
    ExportData.Add('');
    ExportData.Add('');
    CompExp.ComponentExportShip('dummy', False, ExportData);

    ExportData.SaveToFile(ExportFile);
  finally
    FreeAndNil(ExportData);
    FreeAndNil(Data);
    FreeAndNil(Analysis);
    FreeAndNil(CompExp);
  end;
end;

function TDescExp.FuelTreatmentDetails: String;
//details of fuel treatment

var
  ReturnString : String;
  LhydTankage : Extended;
  ePowerTons: Extended;
  iPPlant: Integer;
begin
  if (Ship.Eng.PowerTonsIsRefitted) then ePowerTons := Ship.Eng.NewPowerTons
      else ePowerTons := Ship.Eng.PowerTons;
  if (Ship.Eng.PPlantIsRefitted) then iPPlant := Ship.Eng.NewPPlant
      else iPPlant := Ship.Eng.PPlant;  ReturnString := '';
  //scoops
  if (Ship.Fuel.Scoops = 0) then
  begin
    ReturnString := 'On Board Fuel Scoops';
  end
  else
  begin
    ReturnString := 'No Fuel Scoops';
  end;
  //purification
  if (Ship.Fuel.Purif = 0) then
  begin
    ReturnString := ReturnString + ', On Board Fuel Purification Plant';
    if (Ship.Fuel.RefitPurif) then ReturnString := ReturnString + ' (TL '
        + IntToStr(Ship.Fuel.RefitPurifTech) + ' Refit)';
    if (Ship.Fuel.PurifyLHyd) then
    begin
      ReturnString := ReturnString + ' (Includes Purification for Drop Tanks)';
    end;
  end
  else
  begin
    ReturnString := ReturnString + ', No Fuel Purification Plant';
  end;
  //Lhyd tanks
  LHydTankage := Ship.Fuel.CalcLhydFuel(Ship.Tonnage, ePowerTons,iPPlant, Ship.TechLevel,
                                        Ship.ShipRace, Ship.DesignRules);
  {LhydTankage := ((Ship.Tonnage * 0.1) * Ship.Fuel.LhydJFuel)
        + (((Ship.Tonnage * 0.01) * Ship.Eng.PPlant) * (Ship.Fuel.LhydPFuel / 28));}
  if (LhydTankage > 0) then
  begin
    ReturnString := ReturnString + ', ' + FloatToStrF(LhydTankage, ffNumber, 19, 3)
        + ' ton drop tanks';
  end;
  Result := ReturnString;
end;

function TDescExp.GetCommType: String;
//decide the type of communications

begin
   case (Ship.Avionics.CommsType) of
      0: Result := '';
      1: Result := 'Maser ';
      2: Result := 'Meson ';
   end;
end;

function TDescExp.GetConfig: String;
//hull configuration

begin
   case (Ship.Hull.Config) of
      1: Result := 'Needle/Wedge';
      2: Result := 'Cone';
      3: Result := 'Cylinder';
      4: Result := 'Close Structure';
      5: Result := 'Sphere';
      6: Result := 'Flattened Sphere';
      7: Result := 'Dispersed Structure';
      8: Result := 'Planetoid';
      9: Result := 'Buffered Planetoid';
      else Result := 'Unknown';
   end;
end;

function TDescExp.GunCrew: Integer;
//calculate how many gunners the ship has

begin
   Result := Ship.SpinalMount.Crew + Ship.BigBays.Crew
         + Ship.LittleBays.Crew + Ship.Turrets.Crew
         + Ship.Screens.Crew
         + Min(1, Ship.SpinalMount.CmdCrew + Ship.BigBays.CmdCrew
            + Ship.LittleBays.CmdCrew + Ship.Turrets.CmdCrew
            + Ship.Screens.CmdCrew);
end;

function TDescExp.HardPointDetails: String;
//Hardpoint details

var
   HpString: String;
   TotalTurrets, TotalBigBays, TotalLittleBays: Integer;
begin
   HpString := '';
   //Spinal mount
   if ((Ship.SpinalMount.SpinalType > 0)and (not Ship.SpinalMount.RefitSpinalMount))
         or ((Ship.SpinalMount.NewSpinalType > 0)and (Ship.SpinalMount.RefitSpinalMount)) then begin
      HpString := 'Spinal Mount';
   end;
   //100t bays
   if (Ship.TotalBigBays > 0) then begin
      if (HpString <> '') then begin
         HpString := HpString + ', ' + IntToStr(Ship.TotalBigBays)
               + ' 100-ton bay';
         if (Ship.TotalBigBays > 1) then begin
            HpString := MakePlural(HpString);
         end;
      end
      else begin
         HpString := IntToStr(Ship.TotalBigBays) + ' 100-ton bay';
         if (Ship.TotalBigBays > 1) then begin
            HpString := MakePlural(HpString);
         end;
      end;
   end;
   //50t bays
   if (Ship.TotalLittleBays > 0) then begin
      if (HpString <> '') then begin
         HpString := HpString + ', ' + IntToStr(Ship.TotalLittleBays)
               + ' 50-ton bay';
         if (Ship.TotalLittleBays > 1) then begin
            HpString := MakePlural(HpString);
         end;
      end
      else begin
         HpString := IntToStr(Ship.TotalLittleBays) + ' 50-ton bay';
         if (Ship.TotalLittleBays > 1) then begin
            HpString := MakePlural(HpString);
         end;
      end;
   end;
   //turrets
   //calculate total turrets if using mixed turrets
   if (Ship.Turrets.MixedTurrets = 0) then begin
      TotalTurrets := Ship.Turrets.NumMixTurrets + Ship.Turrets.EmptyMixTurrets;
   end
   //calculate total turrets if using single turrets
   else begin
      TotalTurrets := Ship.Turrets.EmptyTurrets + Ship.Turrets.MissileTurrets
            + Ship.Turrets.LaserTurrets + Ship.Turrets.EnergyTurrets
            + Ship.Turrets.SandTurrets + Ship.Turrets.PATurrets;
   end;
   //add the turrets to the hardpoints string
   if (TotalTurrets > 0) then begin
      if (HpString <> '') then begin
         HpString := HpString + ', ' + IntToStr(TotalTurrets) + ' Hardpoint';
         if (TotalTurrets > 1) then begin
            HpString := MakePlural(HpString);
         end;
      end
      else begin
         HpString := IntToStr(TotalTurrets) + ' Hardpoint';
         if (TotalTurrets > 1) then begin
            HpString := MakePlural(HpString);
         end;
      end;
   end;
   if (HpString = '') then begin
      HpString := 'None';
   end;
   Result := HpString;
end;

function TDescExp.HullDetails: String;
//tonnage and streamlining details

var
  ReturnString : String;
  StructurePoints : Extended;
  ShipSize : Extended;
begin
  ShipSize := Ship.Tonnage;
  StructurePoints := 0;
  ReturnString := '';
  ReturnString := FloatToStrF(Ship.Tonnage, ffNumber, 18, 3) + ' tons standard, '
      + FloatToStrF(Ship.Tonnage * 14, ffNumber, 18, 3)
      + ' cubic meters, ';
  if (Ship.Hull.StreamLining = 0) then
  begin
    ReturnString := ReturnString + 'Streamlined ';
  end;
  if (Ship.Hull.Airframe = 0) then
  begin
    ReturnString := ReturnString + 'Airframe ';
  end;
  ReturnString := ReturnString + GetConfig + ' Configuration';
  if (Ship.DesignRules = 0) then
  begin
    StructurePoints := CalcStructure(ShipSize, Ship.Hull.Structure);
    ReturnString := ReturnString + ', '
        + FloatToStrF(StructurePoints, ffNumber, 18, 3) + ' Structure Points';
  end;
  if (Ship.Hull.Structure > 0) then
  begin
    ReturnString := ReturnString + ' (' + FloatToStrF(Ship.Hull.Structure, ffNumber, 18, 3)
        + ' Tons additional structure)';
  end;
  Result := ReturnString;
end;

function TDescExp.IndCraft(Num, Crew: Integer; Size, Price: Extended;
  Desc: String): String;
//details of individual craft

var
  ReturnString : String;
begin
  ReturnString := '';
  ReturnString := IntToStr(Num) + ' ' + FloatToStrF(Size, ffNumber, 18, 3)
      + ' ton ' + Desc;
  if (Num > 1) then begin
    ReturnString := MakePlural(ReturnString);
  end;
  ReturnString := ReturnString + ' (Crew of ' + IntToStr(Crew) + ', Cost of MCr ';
  ReturnString := ReturnString + FloatToStrF(Price, ffNumber, 18, 3) + ')';
  Result := ReturnString;
end;

function TDescExp.LittleBayWpnDetails(var Anal: TAnalysis;
  EngyType: String): String;
//50t bay weapons details

var
  ReturnString, EType: String;
  LittleWpnsBays, iMeson, iPa, iMissile, iEnergy, iTech: Integer;
begin
  ReturnString := '';
  LittleWpnsBays := 0;
  with (Ship.LittleBays) do
  begin
    if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
    if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
    if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
    if (RefitEnergyBays) then
    begin
      iEnergy := NewEnergyBays;
      if (NewEnergyType = 0) then EType := 'Plasma' else EType := 'Fusion';
    end
    else
    begin
      iEnergy := EnergyBays;
      if (EnergyType = 0) then EType := 'Plasma' else EType := 'Fusion';
    end;
  end;

  LittleWpnsBays := iMeson + iPa + iMissile + iEnergy;
  if (LittleWpnsBays > 0) then
  begin
    //meson guns
    if (iMeson > 0) then
    begin
      ReturnString := IntToStr(iMeson) + ' 50-ton Meson Bay';
    end;
    if (iMeson > 1) then
    begin
       ReturnString := MakePlural(ReturnString);
    end;
    if (iMeson > 0) then
    begin
      if (Ship.LittleBays.RefitMesonBays) then iTech := Ship.LittleBays.MesonBaysRefitTech
          else iTech := Ship.TechLevel;
      ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.LittleBays.MesonFactor(iTech));
      if (Ship.LittleBays.RefitMesonBays) then
      begin
        ReturnString := ReturnString + ', TL ' + IntToStr(iTech) + ' Refit)';
      end
      else
      begin
        ReturnString := ReturnString + ')';
      end;
    end;

    //PA bays
    if (iPa > 0) then
    begin
      if (ReturnString = '') then
      begin
        ReturnString := IntToStr(iPa) + ' 50-ton Particle Accelerator Bay';
       end
       else
       begin
         ReturnString := ReturnString + ', ' + IntToStr(iPa) + ' 50-ton Particle Accelerator Bay';
       end;
       if (iPa > 1) then
       begin
         ReturnString := MakePlural(ReturnString);
       end;
       if (iPa > 0) then
       begin
         if (Ship.LittleBays.RefitPaBays) then iTech := Ship.LittleBays.PaBaysRefitTech
             else iTech := Ship.TechLevel;
         ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.LittleBays.PaFactor(iTech));
         if (Ship.LittleBays.RefitPaBays) then
         begin
           ReturnString := ReturnString + ', TL ' + IntToStr(iTech) + ' Refit)';
         end
         else
         begin
           ReturnString := ReturnString + ')';
         end;
       end;
     end;

     //missile bays
     if (iMissile > 0) then
     begin
       if (ReturnString = '') then
       begin
         ReturnString := IntToStr(iMissile) + ' 50-ton Missile Bay';
       end
       else
       begin
         ReturnString := ReturnString + ', ' + IntToStr(iMissile) + ' 50-ton Missile Bay';
       end;
       if (iMissile > 1) then
       begin
         ReturnString := MakePlural(ReturnString);
       end;
       if (iMissile > 0) then
       begin
         if (Ship.LittleBays.RefitMissileBays) then iTech := Ship.LittleBays.MissileBaysRefitTech
             else iTech := Ship.TechLevel;
         ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.LittleBays.MissileFactor(iTech));
         if (Ship.LittleBays.RefitMissileBays) then
         begin
           ReturnString := ReturnString + ', TL ' + IntToStr(iTech) + ' Refit)';
         end
         else
         begin
           ReturnString := ReturnString + ')';
         end;
       end;
     end;

    //energy bays
    if (iEnergy > 0) then
    begin
      if (Ship.LittleBays.RefitEnergyBays) then iTech := Ship.LittleBays.EnergyBaysRefitTech
          else iTech := Ship.TechLevel;
      if (ReturnString = '') then
      begin
        ReturnString := IntToStr(iEnergy) + ' 50-ton ' + EType + ' Gun Bay';
      end
      else
      begin
          ReturnString := ReturnString + ', ' + IntToStr(iEnergy) + ' 50-ton ' + EType + ' Gun Bay';
      end;
      if (iEnergy > 1) then
      begin
        ReturnString := MakePlural(ReturnString);
      end;
      if (iEnergy > 0) then
      begin
        //ReturnString := ReturnString + ' (Factor-' + Anal.EnergyFact + ')';
        ReturnString := ReturnString + ' (Factor-' + IntToStr(Ship.LittleBays.EnergyFactor(iTech));
        if (Ship.LittleBays.RefitEnergyBays) then
        begin
          ReturnString := ReturnString + ', TL ' + IntToStr(iTech) + ' Refit)';
        end
        else
        begin
          ReturnString := ReturnString + ')';
        end;
      end;
    end;
  end;
  Result := ReturnString;
end;

function TDescExp.MixTurretWpns(var Anal: TAnalysis): String;
//gets the armament of mix turrets

var
   ReturnString : String;
begin
   ReturnString := '';
   //lasers
   if (Ship.Turrets.MixTurretLasers > 0) then begin
      //if (Ship.Turrets.MixLaserType = 0) then begin
      if (Ship.Turrets.LaserType = 0) then begin
         ReturnString := IntToStr(Ship.Turrets.MixTurretLasers) + ' Beam Laser';
         if (Ship.Turrets.MixTurretLasers > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' (Factor-'
             + IntToStr(Ship.Turrets.LaserFact(Ship.TechLevel)) + ')';
      end
      else begin
         ReturnString := IntToStr(Ship.Turrets.MixTurretLasers) + ' Pulse Laser';
         if (Ship.Turrets.MixTurretLasers > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' (Factor-'
             + IntToStr(Ship.Turrets.LaserFact(Ship.TechLevel)) + ')';
      end;
   end;
   //missiles
   if (Ship.Turrets.MixTurretMissiles > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Turrets.MixTurretMissiles) + ' Missile Rack';
         if (Ship.Turrets.MixTurretMissiles > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' (Factor-'
             + IntToStr(Ship.Turrets.MissileFact(Ship.TechLevel))+ ')';
      end
      else begin
         ReturnString := ReturnString + ', '
               + IntToStr(Ship.Turrets.MixTurretMissiles) + ' Missile Rack';
         if (Ship.Turrets.MixTurretMissiles > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' (Factor-'
             + IntToStr(Ship.Turrets.MissileFact(Ship.TechLevel))+ ')';
      end;
   end;
   //Energy
   if (Ship.Turrets.MixTurretEnergy > 0) then begin
      if (Ship.Turrets.EnergyType = 0) then begin
         ReturnString := IntToStr(Ship.Turrets.MixTurretEnergy) + ' Plasma Gun';
         if (Ship.Turrets.MixTurretEnergy > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' (Factor-'
             + IntToStr(Ship.Turrets.EnergyFact(Ship.TechLevel)) + ')';
      end
      else begin
         ReturnString := IntToStr(Ship.Turrets.MixTurretEnergy) + ' Fusion Gun';
         if (Ship.Turrets.MixTurretEnergy > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         ReturnString := ReturnString + ' (Factor-'
             + IntToStr(Ship.Turrets.EnergyFact(Ship.TechLevel)) + ')';
      end;
   end;
   if (ReturnString <> '') then begin
      ReturnString := ReturnString + '.';
   end;
   Result := ReturnString;
end;

function TDescExp.Range: String;
//range and endurance

var
   ReturnString : String;
begin
   ReturnString := IntToStr(Ship.Fuel.JFuel) + ' parsecs jump and '
         + IntToStr(Ship.Fuel.PFuel) + ' days endurance';
   if (Ship.Fuel.ExtraFuel > 0) then begin
      ReturnString := ReturnString + ', plus '
            + FloatToStrF(Ship.Fuel.ExtraFuel, ffNumber, 18, 3) + ' tons of '
            + 'additional fuel';
   end;
   Result := ReturnString;
end;

function TDescExp.RoundUp(TheNum: Extended): Integer;
//round a real up to the next number

begin
  if (TheNum > 0) then
  begin
    if (TheNum - Int(TheNum) = 0) then
    begin
      Result := StrToInt(FloatToStr(Int(TheNum)));
    end
    else
    begin
      Result := StrToInt(FloatToStr(Int(TheNum))) + 1;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TDescExp.ScreenBackups: String;
//backup screen details

var
   ReturnString : String;
begin
   ReturnString := '';

   //nuclear damper
   if (Ship.Screens.BakNucDampNum > 0) then begin
      ReturnString := IntToStr(Ship.Screens.BakNucDampNum)
            + ' Nuclear Damper Backup';
      if (Ship.Screens.BakNucDampNum > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      ReturnString := ReturnString + ' (Factor-'
            + IntToStr(Ship.Screens.BakNucDamp) + ')';
   end;

   //meson screens
   if (Ship.Screens.BakMesScrnNum > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Screens.BakMesScrnNum)
               + ' Meson Screen Backup';
      end
      else begin
         ReturnString := ReturnString + ', '
               + IntToStr(Ship.Screens.BakMesScrnNum) + ' Meson Screen Backup';
      end;
      if (Ship.Screens.BakMesScrnNum > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      ReturnString := ReturnString + ' (Factor-'
            + IntToStr(Ship.Screens.BakMesScrn) + ')';
   end;

   //black globes
   if (Ship.Screens.BakBlkGlbNum > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := IntToStr(Ship.Screens.BakBlkGlbNum)
               + ' Black Globe Backup';
      end
      else begin
         ReturnString := ReturnString + ', '
               + IntToStr(Ship.Screens.BakBlkGlbNum) + ' Black Globe Backup';
      end;
      if (Ship.Screens.BakBlkGlbNum > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      ReturnString := ReturnString + ' (Factor-'
            + IntToStr(Ship.Screens.BakBlkGlb) + ')';
   end;

   Result := ReturnString;
end;

function TDescExp.ScreenDetails: String;
//screen details

var
   ReturnString : String;
   CapTons : Extended;
begin
   ReturnString := '';
   //nuclear damper
   if (Ship.Screens.NucDamp > 0) then begin
      ReturnString := 'Nuclear Damper (Factor-' + IntToStr(Ship.Screens.NucDamp)
            + ')';
   end;

   //meson screen
   if (Ship.Screens.MesScrn > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := 'Meson Screen (Factor-' + IntToStr(Ship.Screens.MesScrn)
               + ')';
      end
      else begin
         ReturnString := ReturnString + ', '
               + 'Meson Screen (Factor-' + IntToStr(Ship.Screens.MesScrn) + ')';
      end;
   end;

   //black globe
   if (Ship.Screens.BlkGlb > 0) then begin
      if (ReturnString = '') then begin
         ReturnString := 'Black Globe (Factor-' + IntToStr(Ship.Screens.BlkGlb)
               + ')';
      end
      else begin
         ReturnString := ReturnString + ', '
               + 'Black Globe (Factor-' + IntToStr(Ship.Screens.BlkGlb) + ')';
      end;
      CapTons := ((Ship.Tonnage * Ship.Eng.JDrive) * 0.005) + Ship.Screens.ExtraCaps;
      ReturnString := ReturnString + ' with '
            + FloatToStrF(CapTons, ffNumber, 18, 3) + ' ton';
      if (CapTons > 1) then begin
         ReturnString := MakePlural(ReturnString);
      end;
      ReturnString := ReturnString + ' of capacitors (storing '
            + FloatToStrF((CapTons * 36), ffNumber, 18, 3) + ' energy points)';
   end;

   Result := ReturnString;
end;

function TDescExp.SmallCraftBridge: Boolean;
//is the ship a small craft with a bridge

begin
   Result := False;
   if (Ship.Tonnage < 100) and (Ship.Avionics.Bridge = 0) then begin
      Result := True;
   end;
end;

function TDescExp.TurretType(TurretStyle: Integer): String;
//gets the style of turret in use

begin
   case (TurretStyle) of
      0 : Result := 'None';
      1 : Result := 'Single';
      2 : Result := 'Dual';
      3 : Result := 'Triple';
   end;
end;

function TDescExp.TurretWpnDetails(var Anal: TAnalysis; LasType, EngyType,
  PAType: String): String;
//turret weapon details

//function too big, break up

var
   ReturnString : String;
   UsedMixTurrets, WpnsTurrets : Integer;
begin
   ReturnString := '';
   iTest := Ship.Turrets.NumMixTurrets;
   iTest := Ship.Turrets.EmptyMixTurrets;
   UsedMixTurrets := Ship.Turrets.NumMixTurrets - Ship.Turrets.EmptyMixTurrets;
   if (Ship.Turrets.MixedTurrets = 0) then begin   //mixed turrets
      if (UsedMixTurrets > 0) then begin   //if there are mixed turrets in use
         ReturnString := IntToStr(UsedMixTurrets) + ' '
               + TurretType(Ship.Turrets.MixTurretStyle)
               + ' Mixed Turret';
         if (UsedMixTurrets > 1) then begin
            ReturnString := ReturnString + 's each';
         end;
         ReturnString := ReturnString + ' with: ' + MixTurretWpns(Anal);
         if (Ship.Turrets.EmptyMixTurrets > 0) then begin  //empty turrets
            if (ReturnString = '') then begin
               ReturnString := IntToStr(Ship.Turrets.EmptyMixTurrets) + ' Empty '
                     + TurretType(Ship.Turrets.MixTurretStyle) + ' Turret';
               if (Ship.Turrets.EmptyMixTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
            end
            else begin
               ReturnString := ReturnString + ' ' + IntToStr(Ship.Turrets.EmptyMixTurrets)
                     + ' Empty ' + TurretType(Ship.Turrets.MixTurretStyle) + ' Turret';
               if (Ship.Turrets.EmptyMixTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
            end;
         end;
      end
      else begin    //if there are empty turrets and none in use
         if (Ship.Turrets.EmptyMixTurrets > 0) then begin
            ReturnString := IntToStr(Ship.Turrets.EmptyMixTurrets) + ' Empty '
                  + TurretType(Ship.Turrets.MixTurretStyle) + ' Turret';
            if (Ship.Turrets.EmptyMixTurrets > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
      end;
   end
   else begin   //normal
      WpnsTurrets := Ship.Turrets.EmptyTurrets + Ship.Turrets.MissileTurrets
            + Ship.Turrets.LaserTurrets + Ship.Turrets.EnergyTurrets
            + Ship.Turrets.PATurrets;
      if (WpnsTurrets > 0) then begin
         //missiles
         if (Ship.Turrets.MissileTurrets > 0) then begin
            ReturnString := IntToStr(Ship.Turrets.MissileTurrets)
                 + ' ' + TurretType(Ship.Turrets.MissileTurretStyle)
                 + ' Missile Turret';
            if (Ship.Turrets.MissileTurrets > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
            ReturnString := ReturnString + ' organised into '
                  + IntToStr(Ship.Turrets.MissileBatteries) + ' Batter';
            if (Ship.Turrets.MissileBatteries > 1) then begin
               ReturnString := ReturnString + 'ies (Factor-';
            end
            else begin
               ReturnString := ReturnString + 'y (Factor-';
            end;
            ReturnString := ReturnString
                  + IntToStr(Ship.Turrets.MissileFact(Ship.TechLevel))
                  + ')';
         end;
         //Lasers
         if (Ship.Turrets.LaserTurrets > 0) then begin
            if (ReturnString = '') then begin
               ReturnString := IntToStr(Ship.Turrets.LaserTurrets)
                    + ' ' + TurretType(Ship.Turrets.LaserTurretStyle)
                    + ' ' + LasType + ' Laser Turret';
               if (Ship.Turrets.LaserTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
               ReturnString := ReturnString + ' organised into '
                     + IntToStr(Ship.Turrets.LaserBatteries) + ' Batter';
               if (Ship.Turrets.LaserBatteries > 1) then begin
                  ReturnString := ReturnString + 'ies (Factor-';
               end
               else begin
                  ReturnString := ReturnString + 'y (Factor-';
               end;
               ReturnString := ReturnString
                     + IntToStr(Ship.Turrets.LaserFact(Ship.TechLevel)) + ')';
            end
            else begin
               ReturnString := ReturnString + ', ' + IntToStr(Ship.Turrets.LaserTurrets)
                    + ' ' + TurretType(Ship.Turrets.LaserTurretStyle)
                    + ' ' + LasType + ' Laser Turret';
               if (Ship.Turrets.LaserTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
               ReturnString := ReturnString + ' organised into '
                     + IntToStr(Ship.Turrets.LaserBatteries) + ' Batter';
               if (Ship.Turrets.LaserBatteries > 1) then begin
                  ReturnString := ReturnString + 'ies (Factor-';
               end
               else begin
                  ReturnString := ReturnString + 'y (Factor-';
               end;
               ReturnString := ReturnString
                     + IntToStr(Ship.Turrets.LaserFact(Ship.TechLevel)) + ')';
            end;
         end;
         //Energy
         if (Ship.Turrets.EnergyTurrets > 0) then begin
            if (ReturnString = '') then begin
               ReturnString := IntToStr(Ship.Turrets.EnergyTurrets)
                    + ' ' + TurretType(Ship.Turrets.EnergyTurretStyle)
                    + ' ' + EngyType + ' Gun Turret';
               if (Ship.Turrets.EnergyTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
               ReturnString := ReturnString + ' organised into '
                     + IntToStr(Ship.Turrets.EnergyBatteries) + ' Batter';
               if (Ship.Turrets.EnergyBatteries > 1) then begin
                  ReturnString := ReturnString + 'ies (Factor-';
               end
               else begin
                  ReturnString := ReturnString + 'y (Factor-';
               end;
               ReturnString := ReturnString
                     + IntToStr(Ship.Turrets.EnergyFact(Ship.TechLevel)) + ')';
            end
            else begin
               ReturnString := ReturnString + ', ' + IntToStr(Ship.Turrets.EnergyTurrets)
                    + ' ' + TurretType(Ship.Turrets.EnergyTurretStyle)
                    + ' ' + EngyType + ' Gun Turret';
               if (Ship.Turrets.EnergyTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
               ReturnString := ReturnString + ' organised into '
                     + IntToStr(Ship.Turrets.EnergyBatteries) + ' Batter';
               if (Ship.Turrets.EnergyBatteries > 1) then begin
                  ReturnString := ReturnString + 'ies (Factor-';
               end
               else begin
                  ReturnString := ReturnString + 'y (Factor-';
               end;
               ReturnString := ReturnString
                     + IntToStr(Ship.Turrets.EnergyFact(Ship.TechLevel)) + ')';
            end;
         end;
         //Particle Accelerators
         if (Ship.Turrets.PATurrets > 0) then begin
            if (ReturnString = '') then begin
               ReturnString := IntToStr(Ship.Turrets.PATurrets)
                    + ' Particle Accelerator ' + PAType;
               if (Ship.Turrets.PATurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
               ReturnString := ReturnString + ' organised into '
                     + IntToStr(Ship.Turrets.PABatteries) + ' Batter';
               if (Ship.Turrets.PABatteries > 1) then begin
                  ReturnString := ReturnString + 'ies (Factor-';
               end
               else begin
                  ReturnString := ReturnString + 'y (Factor-';
               end;
               ReturnString := ReturnString
                     + IntToStr(Ship.Turrets.PaFact(Ship.TechLevel)) + ')';
            end
            else begin
               ReturnString := ReturnString + ', ' + IntToStr(Ship.Turrets.PATurrets)
                    + ' Particle Accelerator ' + PAType;
               if (Ship.Turrets.PATurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
               ReturnString := ReturnString + ' organised into '
                     + IntToStr(Ship.Turrets.PABatteries) + ' Batter';
               if (Ship.Turrets.PABatteries > 1) then begin
                  ReturnString := ReturnString + 'ies (Factor-';
               end
               else begin
                  ReturnString := ReturnString + 'y (Factor-';
               end;
               ReturnString := ReturnString
                     + IntToStr(Ship.Turrets.PaFact(Ship.TechLevel)) + ')';
            end;
         end;
         //Empty
         if (Ship.Turrets.EmptyTurrets > 0) then begin
            if (ReturnString = '') then begin
               ReturnString := IntToStr(Ship.Turrets.EmptyTurrets)
                    + ' ' + TurretType(Ship.Turrets.EmptyTurretStyle)
                    + ' Empty Turret';
               if (Ship.Turrets.EnergyTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
            end
            else begin
               ReturnString := ReturnString + ', ' + IntToStr(Ship.Turrets.EmptyTurrets)
                    + ' ' + TurretType(Ship.Turrets.EmptyTurretStyle)
                    + ' Empty Turret';
               if (Ship.Turrets.EnergyTurrets > 1) then begin
                  ReturnString := MakePlural(ReturnString);
               end;
            end;
         end;
      end;
   end;
   Result := ReturnString;
end;

function TDescExp.UserDefDetails: String;
//details of user defined components

var
   ReturnString : String;
begin
   ReturnString := '';
   With Ship.UserDef do begin
      //item 1
      if (Item1Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item1Num) + ' ' + Item1Desc;
         if (Item1Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item1Size, ffNumber, 18, 3)
               + ' ton';
         if (Item1Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item1Crew);
         //ep
         if (Item1Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item1Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item1Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item1Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item1Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item1Hp)
                  + ' Hardpoint';
            if (Item1Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 2
      if (Item2Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item2Num) + ' ' + Item2Desc;
         if (Item2Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item2Size, ffNumber, 18, 3)
               + ' ton';
         if (Item2Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item2Crew);
         //ep
         if (Item2Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item2Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item2Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item2Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item2Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item2Hp)
                  + ' Hardpoint';
            if (Item2Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 3
      if (Item3Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item3Num) + ' ' + Item3Desc;
         if (Item3Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item3Size, ffNumber, 18, 3)
               + ' ton';
         if (Item3Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item3Crew);
         //ep
         if (Item3Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item3Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item3Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item3Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item3Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item3Hp)
                  + ' Hardpoint';
            if (Item3Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 4
      if (Item4Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item4Num) + ' ' + Item4Desc;
         if (Item4Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item4Size, ffNumber, 18, 3)
               + ' ton';
         if (Item4Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item4Crew);
         //ep
         if (Item4Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item4Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item4Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item4Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item4Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item4Hp)
                  + ' Hardpoint';
            if (Item4Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 5
      if (Item5Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item5Num) + ' ' + Item5Desc;
         if (Item5Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item5Size, ffNumber, 18, 3)
               + ' ton';
         if (Item5Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item5Crew);
         //ep
         if (Item5Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item5Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item5Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item5Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item5Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item5Hp)
                  + ' Hardpoint';
            if (Item5Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 6
      if (Item6Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item6Num) + ' ' + Item6Desc;
         if (Item6Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item6Size, ffNumber, 18, 3)
               + ' ton';
         if (Item6Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item6Crew);
         //ep
         if (Item6Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item6Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item6Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item6Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item6Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item6Hp)
                  + ' Hardpoint';
            if (Item6Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 7
      if (Item7Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item7Num) + ' ' + Item7Desc;
         if (Item7Num > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item7Size, ffNumber, 18, 3)
               + ' ton';
         if (Item7Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item7Crew);
         //ep
         if (Item7Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item7Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item7Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item7Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item7Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item7Hp)
                  + ' Hardpoint';
            if (Item7Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
      //item 8
      if (Item8Num > 0) then begin
         if (ReturnString <> '') then begin
            ReturnString := ReturnString + ', ';
         end;
         ReturnString := ReturnString + IntToStr(Item8Num) + ' ' + Item8Desc;
         if (Item8Num > 1) then begin
            ReturnString :=MakePlural(ReturnString);
         end;
         //size
         ReturnString := ReturnString
               + ' (' + FloatToStrF(Item8Size, ffNumber, 18, 3)
               + ' ton';
         if (Item8Size > 1) then begin
            ReturnString := MakePlural(ReturnString);
         end;
         //crew
         ReturnString := ReturnString + ', Crew ' + IntToStr(Item8Crew);
         //ep
         if (Item8Ep > 0) then begin
            ReturnString := ReturnString + ', ' + FloatToStrF(Item8Ep, ffNumber, 18, 3)
                  + ' Energy Point';
            if (Item8Ep > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         //cost
         ReturnString := ReturnString + ', Cost MCr ' + FloatToStrF(Item8Cost, ffNumber, 18, 3);
         //hardpoints
         if (Item8Hp > 0) then begin
            ReturnString := ReturnString + ', requires ' + IntToStr(Item8Hp)
                  + ' Hardpoint';
            if (Item8Hp > 1) then begin
               ReturnString := MakePlural(ReturnString);
            end;
         end;
         ReturnString := ReturnString + ')';
      end;
   end;

   if (ReturnString <> '') then begin
      Result := ReturnString;
   end
   else begin
      Result := 'None';
   end;
end;

end.
