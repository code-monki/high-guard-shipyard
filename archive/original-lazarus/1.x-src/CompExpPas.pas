unit CompExpPas;

{$mode delphi}

interface

uses
  Classes, SysUtils, Math, DataPas, AnalysisPas;

type

  { TCompExp }

  TCompExp = Class
  private
    function GetComputerModel (ComputerNo : Integer) : String;
    function IsVehicle(Test : Integer) : Boolean;
    function UserDefString(Data : TData; Anal : TAnalysis; ItemDesc : String;
                           ItemNum, ItemHP : Integer; ItemSize, ItemCost,
                           ItemEP : Extended) : String;
    function CraftString(Number, CraftCrew, IsAVehicle: Integer; CraftTonnage, Price: Extended;
                         Desc: String): String;
    function Book5CrewBreakdown: String;
    function RoundUp(TheNum: Extended): Integer;
    function GunCrew : Integer;
    procedure HullDetails(ExportData: TStringList; Tonnage: Extended; TechLevel, DesignRules: Integer);
    procedure SpinalDetails(ExportData: TStringList; Data: TData; ShipRace: Integer);
    procedure EmptyBays(ExportData: TStringList; ShipRace: Integer);
    procedure MesonBays(ExportData: TStringList; ShipRace: Integer);
    procedure PaBays(ExportData: TStringList; ShipRace: Integer);
    procedure RepulsorBays(ExportData: TStringList; ShipRace: Integer);
    procedure MissileBays(ExportData: TStringList; ShipRace: Integer);
    procedure EnergyBays(ExportData: TStringList; ShipRace: Integer);
  public
    function ComponentExportShip (ExportFile : String; DoWrite : Boolean; ExportData : TStringList) : TStringList;
  end;

var
  CompExp : TCompExp;

implementation

uses
  ShipPas, HullPas, EngPas, FuelPas, AvionicsPas, SpinalMountPas, BigBaysPas,
  LittleBaysPas, TurretsPas, ScreensPas, CraftPas, AccomPas;

{ TCompExp }

function TCompExp.GetComputerModel (ComputerNo: Integer): String;
begin
  case (ComputerNo) of
    0  : Result := 'None';
    1  : Result := 'Model/1';
    2  : Result := 'Model/1fib';
    3  : Result := 'Model/1bis';
    4  : Result := 'Model/2';
    5  : Result := 'Model/2fib';
    6  : Result := 'Model/2bis';
    7  : Result := 'Model/3';
    8  : Result := 'Model/3fib';
    9  : Result := 'Model/4';
    10 : Result := 'Model/4fib';
    11 : Result := 'Model/5';
    12 : Result := 'Model/5fib';
    13 : Result := 'Model/6';
    14 : Result := 'Model/6fib';
    15 : Result := 'Model/7';
    16 : Result := 'Model/7fib';
    17 : Result := 'Model/8';
    18 : Result := 'Model/8fib';
    19 : Result := 'Model/9';
    20 : Result := 'Model/9fib';
    else Result := 'Error';
  end;
end;

function TCompExp.IsVehicle(Test: Integer): Boolean;
begin
  Result := False;
  if (Test = 1) then
  begin
    Result := True;
  end;
end;

function TCompExp.UserDefString(Data: TData; Anal: TAnalysis; ItemDesc: String;
  ItemNum, ItemHP: Integer; ItemSize, ItemCost, ItemEP: Extended): String;
begin
  Result := IntToStr(ItemNum) + ' x ' + ItemDesc + ': '
      + FloatToStrF(ItemNum * ItemSize, ffNumber, 18, 3) + ' Td; MCr '
      + FloatToStrF(ItemNum * ItemCost, ffNumber, 18, 3)
      + '; -' + FloatToStrF(ItemNum * ItemEP, ffNumber, 18, 3) + ' EP';
end;

function TCompExp.CraftString(Number, CraftCrew, IsAVehicle: Integer; CraftTonnage,
  Price: Extended; Desc: String): String;
begin
  Result := IntToStr(Number) + ' x ' + Desc + ': '
      + FloatToStrF(Ship.Craft.CraftSpace(Number, Ship.Hull.Config, CraftTonnage,
                    Ship.Tonnage, IsVehicle(IsAVehicle)), ffNumber, 18,03)
      + 'Td; MCr '
      + FloatToStrF(Ship.Craft.CraftCost(Number, Ship.Hull.Config, CraftTonnage,
                    Ship.Tonnage, IsVehicle(IsAVehicle)), ffNumber, 18, 3)
      + '; Cost of craft: MCr ' + FloatToStrF(Number * Price, ffNumber, 18, 3);
end;

function TCompExp.Book5CrewBreakdown: String;
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

function TCompExp.RoundUp(TheNum: Extended): Integer;
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

function TCompExp.GunCrew: Integer;
begin
   Result := Ship.SpinalMount.Crew + Ship.BigBays.Crew
         + Ship.LittleBays.Crew + Ship.Turrets.Crew
         + Ship.Screens.Crew
         + Min(1, Ship.SpinalMount.CmdCrew + Ship.BigBays.CmdCrew
            + Ship.LittleBays.CmdCrew + Ship.Turrets.CmdCrew
            + Ship.Screens.CmdCrew);
end;

procedure TCompExp.HullDetails(ExportData: TStringList; Tonnage: Extended; TechLevel, DesignRules: Integer);
begin
  if (Ship.Hull.Config < 8) then
  begin
    ExportData.Add('Hull: 0.000 Td; MCr '
        + FloatToStrF(Ship.Hull.ConfigCost(Tonnage), ffNumber, 18, 3));
  end
  else
  begin
    ExportData.Add('Hull: '
        + FloatToStrF(Ship.Hull.ConfigSpace(Tonnage), ffNumber, 18, 3)
        + ' Td; MCr '
        + FloatToStrF(Ship.Hull.ConfigCost(Tonnage), ffNumber, 18, 3));
  end;
  ExportData.Add('Armour Factor-' + IntToStr(Ship.Hull.Armour) + ': '
      + FloatToStrF(Ship.Hull.ArmourSpace(Tonnage, TechLevel), ffNumber, 18, 3)
      + ' Td; MCr '
      + FloatToStrF(Ship.Hull.ArmourCost(Tonnage, TechLevel), ffNumber, 18, 3));
  if (DesignRules = 0) then
  begin
    ExportData.Add('Controls: '
        + FloatToStrF(Ship.Hull.ControlsSpace(Tonnage), ffNumber, 18, 3)
        + ' Td; MCr 0.000');
  end;
end;

procedure TCompExp.SpinalDetails(ExportData: TStringList; Data: TData;
  ShipRace: Integer);
begin
  if ((Ship.SpinalMount.SpinalMount > 0) and (not Ship.SpinalMount.RefitSpinalMount))
      or ((Ship.SpinalMount.NewSpinalMount > 0) and (Ship.SpinalMount.RefitSpinalMount)) then
  begin
    if (Ship.SpinalMount.RefitSpinalMount) then
    begin
      case (Ship.SpinalMount.NewSpinalType) of
        0 : ExportData.Add('No Spinal Mount, please report error to Andrea if you see this');
        1 : ExportData.Add('Spinal Meson Gun Factor-' + Ship.SpinalMount.SpinalMesonFactor
                + ': '
                + FloatToStrF(Ship.SpinalMount.RefitSpinalMountSpace(ShipRace, Data), ffNumber, 18, 3)
                + ' Td; MCr '
                + FloatToStrF(Ship.SpinalMount.RefitSpinalMountCost(ShipRace, Data), ffNumber, 18, 3)
                + '; -'+ Data.GetSpnlMesData(5, Ship.SpinalMount.NewSpinalMount)
                + ' EP');
        2 : ExportData.Add('Spinal Particle Accelerator Factor-' + Ship.SpinalMount.SpinalPAFactor
                + ': '
                + FloatToStrF(Ship.SpinalMount.RefitSpinalMountSpace(ShipRace, Data), ffNumber, 18, 3)
                + ' Td; MCr '
                + FloatToStrF(Ship.SpinalMount.RefitSpinalMountCost(ShipRace, Data), ffNumber, 18, 3)
                + '; -' + Data.GetSpnlPAData(5, Ship.SpinalMount.NewSpinalMount)
                + ' EP');
      end;
    end
    else
    begin
      case (Ship.SpinalMount.SpinalType) of
        0 : ExportData.Add('No Spinal Mount, please report error to Andrea if you see this');
        1 : ExportData.Add('Spinal Meson Gun Factor-' + Ship.SpinalMount.SpinalMesonFactor
                + ': '
                + FloatToStrF(Ship.SpinalMount.SpinalMountSpace(ShipRace, Data), ffNumber, 18, 3)
                + ' Td; MCr '
                + FloatToStrF(Ship.SpinalMount.SpinalMountCost(ShipRace, Data), ffNumber, 18, 3)
                + '; -'+ Data.GetSpnlMesData(5, Ship.SpinalMount.SpinalMount)
                + ' EP');
        2 : ExportData.Add('Spinal Particle Accelerator Factor-' + Ship.SpinalMount.SpinalPAFactor
                + ': '
                + FloatToStrF(Ship.SpinalMount.SpinalMountSpace(ShipRace, Data), ffNumber, 18, 3)
                + ' Td; MCr '
                + FloatToStrF(Ship.SpinalMount.SpinalMountCost(ShipRace, Data), ffNumber, 18, 3)
                + '; -' + Data.GetSpnlPAData(5, Ship.SpinalMount.SpinalMount)
                + ' EP');
      end;
    end;
  end;
end;

procedure TCompExp.EmptyBays(ExportData: TStringList; ShipRace: Integer);
begin
  if ((Ship.BigBays.EmptyBays > 0) and (not Ship.BigBays.RefitEmptyBays))
      or ((Ship.BigBays.NewEmptyBays > 0) and (Ship.BigBays.RefitEmptyBays)) then
  begin
    if (Ship.BigBays.RefitEmptyBays) then
    begin
      ExportData.Add(IntToStr(Ship.BigBays.NewEmptyBays) + ' x Empty 100T Bays: '
          + FloatToStrF(Ship.BigBays.EmptyBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.EmptyBaysCost(ShipRace), ffNumber, 18, 3));
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.BigBays.EmptyBays) + ' x Empty 100T Bays: '
          + FloatToStrF(Ship.BigBays.EmptyBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.EmptyBaysCost(ShipRace), ffNumber, 18, 3));
    end;
  end
  else
  begin
    //
  end;

  if ((Ship.LittleBays.EmptyBays > 0) and (not Ship.LittleBays.RefitEmptyBays))
      or ((Ship.LittleBays.NewEmptyBays > 0) and (Ship.LittleBays.RefitEmptyBays)) then
  begin
    if (Ship.LittleBays.RefitEmptyBays) then
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.NewEmptyBays) + ' x Empty 50T Bays: '
          + FloatToStrF(Ship.LittleBays.EmptyBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.EmptyBaysCost(ShipRace), ffNumber, 18, 3));
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.EmptyBays) + ' x Empty 50T Bays: '
          + FloatToStrF(Ship.LittleBays.EmptyBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.EmptyBaysCost(ShipRace), ffNumber, 18, 3));
    end;
  end
  else
  begin
    //
  end;
end;

procedure TCompExp.MesonBays(ExportData: TStringList; ShipRace: Integer);
begin
  if ((Ship.BigBays.MesonBays > 0) and (not Ship.BigBays.RefitMesonBays))
      or ((Ship.BigBays.NewMesonBays > 0) and (Ship.BigBays.RefitMesonBays)) then
  begin
    if (Ship.BigBays.RefitMesonBays) then
    begin
      ExportData.Add(IntToStr(Ship.BigBays.NewMesonBays) + ' x 100T Meson Bays: '
          + FloatToStrF(Ship.BigBays.MesonBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.MesonBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.NewMesonBays * 200) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.BigBays.MesonBays) + ' x 100T Meson Bays: '
          + FloatToStrF(Ship.BigBays.MesonBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.MesonBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.MesonBays * 200) + ' EP');
    end;
  end
  else
  if ((Ship.LittleBays.MesonBays > 0) and (not Ship.LittleBays.RefitMesonBays))
      or ((Ship.LittleBays.NewMesonBays > 0) and (Ship.LittleBays.RefitMesonBays)) then
  begin
    if (Ship.LittleBays.RefitMesonBays) then
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.NewMesonBays) + ' x 50T Meson Bays: '
          + FloatToStrF(Ship.LittleBays.MesonBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.MesonBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.NewMesonBays * 100) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.MesonBays) + ' x 50T Meson Bays: '
          + FloatToStrF(Ship.LittleBays.MesonBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.MesonBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.MesonBays * 100) + ' EP');
    end;
  end
  else
  begin
    //
  end;
end;

procedure TCompExp.PaBays(ExportData: TStringList; ShipRace: Integer);
begin
  if ((Ship.BigBays.PABays > 0) and (not Ship.BigBays.RefitPaBays))
      or ((Ship.BigBays.NewPaBays > 0) and (Ship.BigBays.RefitPaBays)) then
  begin
    if (Ship.BigBays.RefitPaBays) then
    begin
      ExportData.Add(IntToStr(Ship.BigBays.NewPABays) + ' x 100T Particle Accelerator Bays: '
          + FloatToStrF(Ship.BigBays.PaBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.PaBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.NewPABays * 60) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.BigBays.PABays) + ' x 100T Particle Accelerator Bays: '
          + FloatToStrF(Ship.BigBays.PaBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.PaBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.PABays * 60) + ' EP');
    end;
  end
  else
  if ((Ship.LittleBays.PABays > 0) and (not Ship.LittleBays.RefitPaBays))
      or ((Ship.LittleBays.NewPaBays > 0) and (Ship.LittleBays.RefitPaBays)) then
  begin
    if (Ship.LittleBays.RefitPaBays) then
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.NewPABays) + ' x 50T Particle Accelerator Bays: '
          + FloatToStrF(Ship.LittleBays.PaBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.PaBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.NewPABays * 30) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.PABays) + ' x 50T Particle Accelerator Bays: '
          + FloatToStrF(Ship.LittleBays.PaBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.PaBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.PABays * 30) + ' EP');
    end;
  end
  else
  begin
    //
  end;
end;

procedure TCompExp.RepulsorBays(ExportData: TStringList; ShipRace: Integer);
begin
  if ((Ship.BigBays.RepulsorBays > 0) and (not Ship.BigBays.RefitRepulsorBays))
      or ((Ship.BigBays.NewRepulsorBays > 0) and (Ship.BigBays.RefitRepulsorBays)) then
  begin
    if (Ship.BigBays.RefitRepulsorBays) then
    begin
      ExportData.Add(IntToStr(Ship.BigBays.NewRepulsorBays) + ' x 100T Repulsor Bays: '
          + FloatToStrF(Ship.BigBays.RepulsorBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.RepulsorBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.NewRepulsorBays * 10) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.BigBays.RepulsorBays) + ' x 100T Repulsor Bays: '
          + FloatToStrF(Ship.BigBays.RepulsorBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.BigBays.RepulsorBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.RepulsorBays * 10) + ' EP');
    end;
  end
  else
  if ((Ship.LittleBays.RepulsorBays > 0) and (not Ship.LittleBays.RefitRepulsorBays))
      or ((Ship.LittleBays.NewRepulsorBays > 0) and (Ship.LittleBays.RefitRepulsorBays)) then
  begin
    if (Ship.LittleBays.RefitRepulsorBays) then
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.NewRepulsorBays) + ' x 50T Repulsor Bays: '
          + FloatToStrF(Ship.LittleBays.RepulsorBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.RepulsorBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.BigBays.NewRepulsorBays * 5) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.RepulsorBays) + ' x 50T Repulsor Bays: '
          + FloatToStrF(Ship.LittleBays.RepulsorBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.RepulsorBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.RepulsorBays * 5) + ' EP');
    end;
  end
  else
  begin
    //
  end;
end;

procedure TCompExp.MissileBays(ExportData: TStringList; ShipRace: Integer);
begin
    if ((Ship.BigBays.MissileBays > 0) and (not Ship.BigBays.RefitMissileBays))
        or ((Ship.BigBays.NewMissileBays > 0) and (Ship.BigBays.RefitMissileBays)) then
    begin
      if (Ship.BigBays.RefitMissileBays) then
      begin
        ExportData.Add(IntToStr(Ship.BigBays.NewMissileBays) + ' x 100T Missile Bays: '
            + FloatToStrF(Ship.BigBays.MissileBaysSpace(ShipRace), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.BigBays.MissileBaysCost(ShipRace), ffNumber, 18, 3));
      end
      else
      begin
        ExportData.Add(IntToStr(Ship.BigBays.MissileBays) + ' x 100T Missile Bays: '
            + FloatToStrF(Ship.BigBays.MissileBaysSpace(ShipRace), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.BigBays.MissileBaysCost(ShipRace), ffNumber, 18, 3));
      end;
    end
    else
    if ((Ship.LittleBays.MissileBays > 0) and (not Ship.LittleBays.RefitMissileBays))
        or ((Ship.LittleBays.NewMissileBays > 0) and (Ship.LittleBays.RefitMissileBays)) then
    begin
      if (Ship.LittleBays.RefitMissileBays) then
      begin
        ExportData.Add(IntToStr(Ship.LittleBays.NewMissileBays) + ' x 50T Missile Bays: '
            + FloatToStrF(Ship.LittleBays.MissileBaysSpace(ShipRace), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.LittleBays.MissileBaysCost(ShipRace), ffNumber, 18, 3));
      end
      else
      begin
        ExportData.Add(IntToStr(Ship.LittleBays.MissileBays) + ' x 50T Missile Bays: '
            + FloatToStrF(Ship.LittleBays.MissileBaysSpace(ShipRace), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.LittleBays.MissileBaysCost(ShipRace), ffNumber, 18, 3));
      end;
    end
    else
    begin
      //
    end;
end;

procedure TCompExp.EnergyBays(ExportData: TStringList; ShipRace: Integer);
var
  iWorking: Integer;
  sType: String;
begin
  if (Ship.LittleBays.RefitEnergyBays) then iWorking := 10 + (Ship.LittleBays.NewEnergyType * 10)
      else iWorking := 10 + (Ship.LittleBays.EnergyType * 10);
  if (Ship.LittleBays.RefitEnergyBays) then
  begin
    if (Ship.LittleBays.NewEnergyType = 0) then sType := 'Plasma' else sType := 'Fusion';
  end
  else
  begin
    if (Ship.LittleBays.EnergyType = 0) then sType := 'Plasma' else sType := 'Fusion';
  end;
  if ((Ship.LittleBays.EnergyBays > 0) and (not Ship.LittleBays.RefitEnergyBays))
      or ((Ship.LittleBays.EnergyBays > 0) and (Ship.LittleBays.RefitEnergyBays)) then
  begin
    if (Ship.LittleBays.RefitEnergyBays) then
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.NewEnergyBays)
          + ' x 50T ' + sType + ' Gun Bays: '
          + FloatToStrF(Ship.LittleBays.EnergyBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.EnergyBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.NewEnergyBays * iWorking) + ' EP');
    end
    else
    begin
      ExportData.Add(IntToStr(Ship.LittleBays.EnergyBays) + ' x 50T '
          + sType + ' Gun Bays: '
          + FloatToStrF(Ship.LittleBays.EnergyBaysSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.LittleBays.EnergyBaysCost(ShipRace), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.LittleBays.EnergyBays * iWorking) + ' EP');
    end;
  end
  else
  begin
    //
  end;
end;

function TCompExp.ComponentExportShip(ExportFile : String; DoWrite : Boolean; ExportData : TStringList) : TStringList;
//TOO BIG (understatement) Break it up

var
  TechLevel, PowTech, ShipRace, CrewRules, DesignRules, iWorking : Integer;
  MilStdJump: Boolean;
  Tonnage : Extended;
  Data : TData;
  Anal : TAnalysis;
  ePowerTons: Extended;
  iPPlant: Integer;
begin
  try
    if (Ship.Eng.PowerTonsIsRefitted) then ePowerTons := Ship.Eng.NewPowerTons
        else ePowerTons := Ship.Eng.PowerTons;
    if (Ship.Eng.PPlantIsRefitted) then iPPlant := Ship.Eng.NewPPlant
        else iPPlant := Ship.Eng.PPlant;
    if (Ship.Eng.PowerTonsIsRefitted) then PowTech := Ship.Eng.PowerTonsRefitTech
        else PowTech := Ship.TechLevel;
    Data := TData.Create;
    Data.InitialiseData;
    Anal := TAnalysis.Create;
    Anal.Analyise(0);
    TechLevel := Ship.TechLevel;
    ShipRace := Ship.ShipRace;
    CrewRules := Ship.CrewRules;
    DesignRules := Ship.DesignRules;
    Tonnage := Ship.Tonnage;
    MilStdJump := Ship.Options.MilStdJump;

    ExportData.Add(Ship.ShipClass + ' Class ' + Ship.ShipType);
    ExportData.Add('');

    if (Ship.CrewRules = 1) then
    begin
      ExportData.Add('Book 5 Crew Breakdown');
      ExportData.Add(Book5CrewBreakdown);
    end;

    //hull
    ExportData.Add('HULL');
    HullDetails(ExportData, Tonnage, TechLevel, DesignRules);
    ExportData.Add('');

    //engineering
    ExportData.Add('ENGINEERING');
    if (Ship.Eng.MDriveIsRefitted) then
    begin
      ExportData.Add('M-Drive Factor-' + IntToStr(Ship.Eng.NewMDrive) + ': '
          + FloatToStrF(Ship.Eng.RefittedMDriveSpace(Tonnage, DesignRules), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Eng.RefittedMDriveCost(Tonnage, DesignRules), ffNumber, 18, 3));
    end
    else
    begin
      ExportData.Add('M-Drive Factor-' + IntToStr(Ship.Eng.MDrive) + ': '
          + FloatToStrF(Ship.Eng.MDriveSpace(Tonnage, DesignRules), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Eng.MDriveCost(Tonnage, DesignRules), ffNumber, 18, 3));
    end;
    if (Ship.Eng.JDriveIsRefitted) then
    begin
      ExportData.Add('J-Drive Factor-' + IntToStr(Ship.Eng.NewJDrive) + ': '
          + FloatToStrF(Ship.Eng.RefittedJDriveSpace(Tonnage, DesignRules), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Eng.RefittedJDriveCost(Tonnage, DesignRules, MilStdJump), ffNumber, 18, 3));
    end
    else
    begin
      ExportData.Add('J-Drive Factor-' + IntToStr(Ship.Eng.JDrive) + ': '
          + FloatToStrF(Ship.Eng.JDriveSpace(Tonnage, DesignRules), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Eng.JDriveCost(Tonnage, DesignRules, MilStdJump), ffNumber, 18, 3));
    end;
    if (DesignRules = 0) then
    begin
      if (Ship.Eng.PowerTonsIsRefitted) then
      begin
        ExportData.Add('P-Plant: ' + FloatToStrF(Ship.Eng.NewPowerTons, ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.RefittedPPlantCost(Tonnage, TechLevel,
                          ShipRace, DesignRules), ffNumber, 18,3));

      end
      else
      begin
        ExportData.Add('P-Plant: ' + FloatToStrF(Ship.Eng.PowerTons, ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.PPlantCost(Tonnage, TechLevel,
                          ShipRace, DesignRules), ffNumber, 18,3));

      end;
    end
    else
    begin
      if (Ship.Eng.PPlantIsRefitted) then
      begin
        ExportData.Add('P-Plant Factor-' + IntToStr(Ship.Eng.NewPPlant) + ': '
            + FloatToStrF(Ship.Eng.RefittedPPlantSpace(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.RefittedPPlantCost(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18,3)
            + '; +' + FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3) + ' EP');
      end
      else
      begin
        ExportData.Add('P-Plant Factor-' + IntToStr(Ship.Eng.PPlant) + ': '
            + FloatToStrF(Ship.Eng.PPlantSpace(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.PPlantCost(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18,3)
            + '; +' + FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3) + ' EP');
      end;
    end;
    //backup
    if (Ship.Eng.BakMDriveIsRefitted) then
    begin
      if (Ship.Eng.BakNewMDNumb > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakNewMDNumb) + ' x Backup M-Drive Factor-'
            + IntToStr(Ship.Eng.BakMDrive) + ': '
            + FloatToStrF(Ship.Eng.RefittedBakMDriveSpace(Tonnage, DesignRules), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.RefittedBakMDriveCost(Tonnage, DesignRules), ffNumber, 18, 3));
      end;
    end
    else
    begin
      if (Ship.Eng.BakMDNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakMDNum) + ' x Backup M-Drive Factor-'
            + IntToStr(Ship.Eng.BakMDrive) + ': '
            + FloatToStrF(Ship.Eng.BakMDriveSpace(Tonnage, DesignRules), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.BakMDriveCost(Tonnage, DesignRules), ffNumber, 18, 3));
      end;
    end;
    if (Ship.Eng.BakJDriveIsRefitted) then
    begin
      if (Ship.Eng.BakNewJDNumb > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakNewJDNumb) + ' x Backup J-Drive Factor-'
            + IntToStr(Ship.Eng.BakNewJDrive) + ': '
            + FloatToStrF(Ship.Eng.RefittedBakJDriveSpace(Tonnage, DesignRules), ffNumber, 18,3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.RefittedBakJDriveCost(Tonnage, DesignRules, MilStdJump), ffNumber, 18, 3));
      end;
    end
    else
    begin
      if (Ship.Eng.BakJDNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakJDNum) + ' x Backup J-Drive Factor-'
            + IntToStr(Ship.Eng.BakJDrive) + ': '
            + FloatToStrF(Ship.Eng.BakJDriveSpace(Tonnage, DesignRules), ffNumber, 18,3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.BakJDriveCost(Tonnage, DesignRules, MilStdJump), ffNumber, 18, 3));
      end;
    end;
    if (Ship.Eng.BakPPlantIsRefitted) and (DesignRules = 1) then
    begin
      if (Ship.Eng.BakNewPPNumb > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakNewPPNumb) + ' x Backup P-Plant Factor-'
            + IntToStr(Ship.Eng.BakNewPPlant) + ': '
            + FloatToStrF(Ship.Eng.RefittedBakPPlantSpace(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.RefittedBakPPlantCost(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18, 3));
      end;
    end
    else
    begin
      if (Ship.Eng.BakPPNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakPPNum) + ' x Backup P-Plant Factor-'
            + IntToStr(Ship.Eng.BakPPlant) + ': '
            + FloatToStrF(Ship.Eng.BakPPlantSpace(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Eng.BakPPlantCost(Tonnage, TechLevel, ShipRace, DesignRules),
                          ffNumber, 18, 3));
      end;
    end;
    if (Ship.Eng.BakPowerTonsIsRefitted) and (DesignRules = 0) then
    begin
      if (Ship.Eng.BakNewPowerTonsNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakNewPowerTonsNum) + ' x Backup P-Plant: '
            + FloatToStrF(Ship.Eng.BakNewPowerTons, ffNumber, 18, 3) + ' Td; MCr '
            + FloatToStrF(Ship.Eng.RefittedBakPPlantCost(Tonnage, TechLevel, ShipRace,
                          DesignRules), ffNumber, 18,3)
            + '; +' + FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3) + ' EP');
      end;
    end
    else
    begin
      if (Ship.Eng.BakPowerTonsNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Eng.BakPPNum) + ' x Backup P-Plant: '
            + FloatToStrF(Ship.Eng.BakPowerTons, ffNumber, 18, 3) + ' Td; MCr '
            + FloatToStrF(Ship.Eng.BakPPlantCost(Tonnage, TechLevel, ShipRace,
                          DesignRules), ffNumber, 18,3)
            + '; +' + FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3) + ' EP');
      end;
    end;
    ExportData.Add('');

    //fuel
    ExportData.Add('FUEL');
    ExportData.Add('P-Fuel: '
        + FloatToStrF(Max(Ship.Fuel.PFuelSpace(Tonnage, Ship.Eng.PowerTons,
                      Ship.Eng.PPlant, TechLevel, ShipRace, DesignRules), 1),
                      ffNumber, 18, 3)       //refit eng need here
        + ' Td; MCr 0,000');
    ExportData.Add('J-Fuel: '
        + FloatToStrF(Ship.Fuel.JFuelSpace(Tonnage), ffNumber, 18, 3)
        + ' Td; MCr 0.000');
    if (Ship.Fuel.ExtraFuel > 0) then
    begin
      ExportData.Add('Extra Fuel: '
          + FloatToStrF(Ship.Fuel.ExtraFuel, ffNumber, 18, 3)
          + ' Td; MCr 0.000');
    end;
    ExportData.Add('Scoops: 0.000 Td; MCr '
        + FloatToStrF(Ship.Fuel.ScoopsCost(Tonnage), ffNumber, 18, 3));
    ExportData.Add('Purification: ' + FloatToStrF(Ship.Fuel.PurifSpace(Tonnage,
          ePowerTons, TechLevel, PowTech, ShipRace, iPPlant, DesignRules),
          ffNumber, 18, 3)
        + ' Td; MCr '
        + FloatTostrF(Ship.Fuel.PurifCost(Tonnage, ePowerTons,
          TechLevel, PowTech, ShipRace, iPPlant, DesignRules), ffNumber, 18, 3));
    ExportData.Add('L-Hyd Drop Tanks: 0.000 Td; MCr '
        + FloatToStrF(Ship.Fuel.LhydFuelCost(Tonnage, iPPlant), ffNumber, 18, 3));
    ExportData.Add('');

    //avionics
    ExportData.Add('AVIONICS');
    ExportData.Add('Bridge: ' + FloatToStrF(Ship.Avionics.BridgeSpace(Tonnage), ffNumber, 18, 3)
        + ' Td; MCr ' + FloatToStrF(Ship.Avionics.BridgeCost(Tonnage, ShipRace), ffNumber, 18, 3));
    if (Ship.Avionics.RefitComp) then
    begin
      ExportData.Add('Computer '
          + Copy(Data.GetComputerData(7, Ship.Avionics.NewComp), 3,
                 Length(Data.GetComputerData(7, Ship.Avionics.NewComp)))
          + ': '
          + FloatToStrF(Ship.Avionics.RefitCompSpace(Data) , ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Avionics.RefitCompCost(ShipRace, Data), ffNumber, 18, 3)
          + '; -' + Data.GetComputerData(6, Ship.Avionics.NewComp) + ' EP');
    end
    else
    begin
      ExportData.Add('Computer '
          + Copy(Data.GetComputerData(7, Ship.Avionics.MainComp), 3,
                 Length(Data.GetComputerData(7, Ship.Avionics.MainComp)))
          + ': '
          + FloatToStrF(Ship.Avionics.MainCompSpace(Data) , ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Avionics.MainCompCost(ShipRace, Data), ffNumber, 18, 3)
          + '; -' + Data.GetComputerData(6, Ship.Avionics.MainComp) + ' EP');
    end;
    //t20 items
    if (DesignRules = 0) then
    begin
      if (Ship.Avionics.RefitFltAvionics) then
      begin
        ExportData.Add('Flight Avionics Model/' + IntToStr(Ship.Avionics.NewFltAvionics)
            + ': ' + FloatToStrF(Ship.Avionics.RefitFltAvionicsSpace, ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.RefitFltAvionicsCost(ShipRace), ffNumber, 18, 3));
      end
      else
      begin
        ExportData.Add('Flight Avionics Model/' + IntToStr(Ship.Avionics.FltAvionics)
            + ': ' + FloatToStrF(Ship.Avionics.FltAvionicsSpace, ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.FltAvionicsCost(ShipRace), ffNumber, 18, 3));
      end;
      if (Ship.Avionics.RefitSensors) then
      begin
        ExportData.Add('Sensors Model/' + IntToStr(Ship.Avionics.NewSensors) + ': '
            + FloatToStrF(Ship.Avionics.RefitSensorsSpace, ffNumber, 18, 3) + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.RefitSensorsCost(ShipRace), ffNumber, 18, 3));
      end
      else
      begin
        ExportData.Add('Sensors Model/' + IntToStr(Ship.Avionics.Sensors) + ': '
            + FloatToStrF(Ship.Avionics.SensorsSpace, ffNumber, 18, 3) + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.SensorsCost(ShipRace), ffNumber, 18, 3));
      end;
      if (Ship.Avionics.RefitComms) then
      begin
        ExportData.Add('Communications Model/' + IntToStr(Ship.Avionics.NewComms) + ': '
            + FloatToStrF(Ship.Avionics.RefitCommsSpace, ffNumber, 18, 3) + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.RefitCommsCost(ShipRace), ffNumber, 18, 3));
      end
      else
      begin
        ExportData.Add('Communications Model/' + IntToStr(Ship.Avionics.Comms) + ': '
            + FloatToStrF(Ship.Avionics.CommsSpace, ffNumber, 18, 3) + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.CommsCost(ShipRace), ffNumber, 18, 3));
      end;
    end;
    //flag items go here
    if (Ship.Flagship) then
    begin
      if (Ship.Avionics.FlagBridge) then
      begin
        ExportData.Add('Flag Bridge: '
            + FloatToStrF(Ship.Avionics.FlagBridgeSpace(Tonnage), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.FlagBridgeCost(Tonnage, ShipRace), ffNumber, 18, 3));
      end;
      if (Ship.Avionics.RefitFlagComp) then
      begin
        ExportData.Add('Flag Computer '
            + Copy(Data.GetComputerData(7, Ship.Avionics.NewFlagComp), 3,
                   Length(Data.GetComputerData(7, Ship.Avionics.NewFlagComp)))
            + ': '
            + FloatToStrF(Ship.Avionics.RefitFlagCompSpace(Data), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.RefitFlagCompCost(ShipRace, Data), ffNumber, 18, 3)
            + '; -' + Data.GetComputerData(6, Ship.Avionics.NewFlagComp) + ' EP');
      end
      else
      begin
        ExportData.Add('Flag Computer '
            + Copy(Data.GetComputerData(7, Ship.Avionics.FlagComp), 3,
                   Length(Data.GetComputerData(7, Ship.Avionics.FlagComp)))
            + ': '
            + FloatToStrF(Ship.Avionics.FlagCompSpace(Data), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.FlagCompCost(ShipRace, Data), ffNumber, 18, 3)
            + '; -' + Data.GetComputerData(6, Ship.Avionics.FlagComp) + ' EP');
      end;
    end;
    //backups
    if (Ship.Avionics.RefitBakBridge) then
    begin
      if (Ship.Avionics.NewBakBridgeNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Avionics.NewBakBridgeNum) + ' x Backup Bridge: '
            + FloatToStrF(Ship.Avionics.RefitBakBridgeSpace(Tonnage), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.RefitBakBridgeCost(Tonnage, ShipRace), ffNumber, 18, 3));
      end;
    end
    else
    begin
      if (Ship.Avionics.BakBridgeNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Avionics.BakBridgeNum) + ' x Backup Bridge: '
            + FloatToStrF(Ship.Avionics.BakBridgeSpace(Tonnage), ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.BakBridgeCost(Tonnage, ShipRace), ffNumber, 18, 3));
      end;
    end;
    if (Ship.Avionics.RefitBakComp) then
    begin
      if (Ship.Avionics.NewBakCompNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Avionics.NewBakCompNum) + ' x Backup Computer '
            + Copy(Data.GetComputerData(7, Ship.Avionics.NewBakComp), 3,
                   Length(Data.GetComputerData(7, Ship.Avionics.NewBakComp)))
            + ': '
            + FloatToStrF(Ship.Avionics.RefitBakCompSpace(Data) , ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.RefitBakCompCost(ShipRace, Data) , ffNumber, 18, 3));
      end;
    end
    else
    begin
      if (Ship.Avionics.BakCompNum > 0) then
      begin
        ExportData.Add(IntToStr(Ship.Avionics.BakCompNum) + ' x Backup Computer '
            + Copy(Data.GetComputerData(7, Ship.Avionics.BakComp), 3,
                   Length(Data.GetComputerData(7, Ship.Avionics.BakComp)))
            + ': '
            + FloatToStrF(Ship.Avionics.BakCompSpace(Data) , ffNumber, 18, 3)
            + ' Td; MCr '
            + FloatToStrF(Ship.Avionics.BakCompCost(ShipRace, Data) , ffNumber, 18, 3));
      end;
    end;
    //t20 items
    if (DesignRules = 0) then
    begin
      if (Ship.Avionics.RefitBakFltAvionics) then
      begin
        if (Ship.Avionics.NewBakFltAvionicsNum > 0) then
        begin
          ExportData.Add(IntToStr(Ship.Avionics.NewBakFltAvionicsNum)
              + ' x Backup Flight Avionics Model/' + IntToStr(Ship.Avionics.NewBakFltAvionics)
              + ': ' + FloatToStrF(Ship.Avionics.RefitBakFltAvionicsSpace, ffNumber, 18, 3)
              + ' Td; MCr '
              + FloatToStrF(Ship.Avionics.RefitBakFltAvionicsCost(ShipRace), ffNumber, 18, 3));
        end;
      end
      else
      begin
        if (Ship.Avionics.BakFltAvionicsNum > 0) then
        begin
          ExportData.Add(IntToStr(Ship.Avionics.BakFltAvionicsNum)
              + ' x Backup Flight Avionics Model/' + IntToStr(Ship.Avionics.BakFltAvionics)
              + ': ' + FloatToStrF(Ship.Avionics.BakFltAvionicsSpace, ffNumber, 18, 3)
              + ' Td; MCr '
              + FloatToStrF(Ship.Avionics.BakFltAvionicsCost(ShipRace), ffNumber, 18, 3));
        end;
      end;
      if (Ship.Avionics.RefitBakSensors) then
      begin
        if (Ship.Avionics.NewBakSensorsNum > 0) then
        begin
          ExportData.Add(IntToStr(Ship.Avionics.NewBakSensorsNum)
             + ' x Backup Sensors Model/' + IntToStr(Ship.Avionics.NewBakSensors) + ': '
             + FloatToStrF(Ship.Avionics.RefitBakSensorsSpace, ffNumber, 18, 3) + ' Td; MCr '
             + FloatToStrF(Ship.Avionics.RefitBakSensorsCost(ShipRace), ffNumber, 18, 3));
        end;
      end
      else
      begin
        if (Ship.Avionics.BakSensorsNum > 0) then
        begin
          ExportData.Add(IntToStr(Ship.Avionics.BakSensorsNum)
             + ' x Backup Sensors Model/' + IntToStr(Ship.Avionics.BakSensors) + ': '
             + FloatToStrF(Ship.Avionics.BakSensorsSpace, ffNumber, 18, 3) + ' Td; MCr '
             + FloatToStrF(Ship.Avionics.BakSensorsCost(ShipRace), ffNumber, 18, 3));
        end;
      end;
      if (Ship.Avionics.RefitBakComms) then
      begin
        if (Ship.Avionics.NewBakCommsNum > 0) then
        begin
          ExportData.Add(IntToStr(Ship.Avionics.NewBakCommsNum)
              + ' x Backup Communications Model/' + IntToStr(Ship.Avionics.NewBakComms) + ': '
              + FloatToStrF(Ship.Avionics.RefitBakCommsSpace, ffNumber, 18, 3) + ' Td; MCr '
              + FloatToStrF(Ship.Avionics.RefitBakCommsCost(ShipRace), ffNumber, 18, 3));
        end;
      end
      else
      begin
        if (Ship.Avionics.BakCommsNum > 0) then
        begin
          ExportData.Add(IntToStr(Ship.Avionics.BakCommsNum)
              + ' x Backup Communications Model/' + IntToStr(Ship.Avionics.BakComms) + ': '
              + FloatToStrF(Ship.Avionics.BakCommsSpace, ffNumber, 18, 3) + ' Td; MCr '
              + FloatToStrF(Ship.Avionics.BakCommsCost(ShipRace), ffNumber, 18, 3));
        end;
      end;
    end;
    ExportData.Add('');

    //weapons
    ExportData.Add('WEAPONRY');
    //spinal mount
    SpinalDetails(ExportData, Data, ShipRace);
    //bays
    EmptyBays(ExportData, ShipRace);
    MesonBays(ExportData, ShipRace);
    PaBays(ExportData, ShipRace);
    RepulsorBays(ExportData, ShipRace);
    MissileBays(ExportData, ShipRace);
    EnergyBays(ExportData, ShipRace);

    //turrets
    if (Ship.Turrets.EmptyTurrets > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Turrets.EmptyTurrets) + ' x Empty Turrets: '
          + FloatToStrF(Ship.Turrets.EmptyTurretSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.EmptyTurretCost(ShipRace, Ship.Options.ChargeForHardpoints), ffNumber, 18, 3));
    end
    else
    if (Ship.Turrets.EmptyMixTurrets > 0) then
    begin
      //
    end
    else
    begin
      //
    end;

    if (Ship.Turrets.MissileTurrets > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Turrets.MissileTurrets) + ' x Missile Turrets: '
          + FloatToStrF(Ship.Turrets.MissileTurretSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.MissileTurretCost(ShipRace, Ship.Options.ChargeForHardpoints), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Turrets.LaserTurrets > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Turrets.LaserTurrets) + ' x Laser Turrets: '
          + FloatToStrF(Ship.Turrets.LaserTurretSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.LaserTurretCost(ShipRace, Ship.Options.ChargeForHardpoints),
                        ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.Turrets.LaserTurrets * Ship.Turrets.LaserTurretStyle)
          + ' EP');
    end
    else
    begin
      //
    end;

    if (Ship.Turrets.EnergyTurrets > 0) then
    begin
      iWorking := 1 + Ship.Turrets.EnergyType;
      ExportData.Add(IntToStr(Ship.Turrets.EnergyTurrets) + ' x Energy Turrets: '
          + FloatToStrF(Ship.Turrets.EnergyTurretSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.EnergyTurretCost(ShipRace, Ship.Options.ChargeForHardpoints),
                        ffNumber, 18, 3)
          + '; -'
          + IntToStr(Ship.Turrets.EnergyTurrets * Ship.Turrets.EnergyTurretStyle * iWorking)
          + ' EP');
      iWorking := 0;
    end
    else
    begin
      //
    end;

    if (Ship.Turrets.SandTurrets > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Turrets.SandTurrets) + ' x Sand Turrets: '
          + FloatToStrF(Ship.Turrets.SandTurretSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.SandTurretCost(ShipRace, Ship.Options.ChargeForHardpoints), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Turrets.PATurrets > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Turrets.PATurrets) + ' x Particle Accelerator Turrets: '
          + FloatToStrF(Ship.Turrets.PATurretSpace(ShipRace, TechLevel), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.PATurretCost(ShipRace, TechLevel,
                        Ship.Options.ChargeForHardpoints), ffNumber, 18, 3)
          + '; -' + IntToStr(Ship.Turrets.PATurrets * Ship.Turrets.PATurretStyle * 5)
          + ' EP');
    end
    else
    begin
      //
    end;

    if (Ship.Turrets.NumMixTurrets > 0) and (Ship.Turrets.MixedTurrets = 0) then
    begin
      ExportData.Add(IntToStr(Ship.Turrets.NumMixTurrets) + ' x Mixed Turrets: '
          + FloatToStrF(Ship.Turrets.MixedTurretSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Turrets.MixedTurretCost(ShipRace, Ship.Options.ChargeForHardpoints), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;
    ExportData.Add('');

    //screens
    ExportData.Add('SCREENS');
    if (Ship.Screens.NucDamp > 0) then
    begin
      ExportData.Add('Nuclear Damper Factor-' + IntToStr(Ship.Screens.NucDamp)
          + ': '
          + FloatToStrF(Ship.Screens.NucDampSpace(Data), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.NucDampCost(Data), ffNumber, 18, 3)
          + '; -' + FloatToStrF((Ship.Screens.NucDamp * 10), ffNumber, 18, 3)
          + ' EP');
    end
    else
    begin
      //
    end;

    if (Ship.Screens.MesScrn > 0) then
    begin
      ExportData.Add('Meson Screen Factor-' + IntToStr(Ship.Screens.MesScrn)
          + ': '
          + FloatToStrF(Ship.Screens.MesScrnSpace(Data), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.MesScrnCost(Data), ffNumber, 18, 3)
          + '; -' + FloatToStrF((Ship.Screens.MesScrn * 0.2 * Ship.Tonnage) / 100,
                                 ffNumber, 18, 3)
          + ' EP');
    end
    else
    begin
      //
    end;

    if (Ship.Screens.BlkGlb > 0) then
    begin
      ExportData.Add('Black Globe Factor-' + IntToStr(Ship.Screens.BlkGlb)
          + ': '
          + FloatToStrF(Ship.Screens.BlkGlbSpace(Data), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.BlkGlbCost(Data), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Screens.ExtraCaps > 0) then
    begin
      ExportData.Add('Extra Capacitors: '
          + FloatToStrF(Ship.Screens.ExtraCapsSpace, ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.ExtraCapsCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Screens.BakNucDampNum > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Screens.BakNucDampNum)
          + ' x Backup Nuclear Dampers Factor-' + IntToStr(Ship.Screens.BakNucDamp) + ': '
          + FloatToStrF(Ship.Screens.BakNucDampSpace(Data), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.BakNucDampCost(Data), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Screens.BakMesScrnNum > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Screens.BakMesScrnNum)
          + ' x Backup Meson Screens Factor-' + IntToStr(Ship.Screens.BakMesScrn) + ': '
          + FloatToStrF(Ship.Screens.BakMesScrnSpace(Data), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.BakMesScrnCost(Data), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Screens.BakBlkGlbNum > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Screens.BakBlkGlbNum)
          + ' x Backup Black Globes Factor-' + IntToStr(Ship.Screens.BakBlkGlb) + ': '
          + FloatToStrF(Ship.Screens.BakBlkGlbSpace(Data), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Screens.BakBlkGlbCost(Data), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;
    ExportData.Add('');

    //craft
    ExportData.Add('CRAFT');
    if (Ship.Craft.Cr1Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr1Num, Ship.Craft.Cr1Crew, Ship.Craft.Cr1Vehicle,
                     Ship.Craft.Cr1Tonnage, Ship.Craft.Cr1Price, Ship.Craft.Cr1Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr2Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr2Num, Ship.Craft.Cr2Crew, Ship.Craft.Cr2Vehicle,
                     Ship.Craft.Cr2Tonnage, Ship.Craft.Cr2Price, Ship.Craft.Cr2Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr3Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr3Num, Ship.Craft.Cr3Crew, Ship.Craft.Cr3Vehicle,
                     Ship.Craft.Cr3Tonnage, Ship.Craft.Cr3Price, Ship.Craft.Cr3Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr4Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr4Num, Ship.Craft.Cr4Crew, Ship.Craft.Cr4Vehicle,
                     Ship.Craft.Cr4Tonnage, Ship.Craft.Cr4Price, Ship.Craft.Cr4Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr5Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr5Num, Ship.Craft.Cr5Crew, Ship.Craft.Cr5Vehicle,
                     Ship.Craft.Cr5Tonnage, Ship.Craft.Cr5Price, Ship.Craft.Cr5Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr6Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr6Num, Ship.Craft.Cr6Crew, Ship.Craft.Cr6Vehicle,
                     Ship.Craft.Cr6Tonnage, Ship.Craft.Cr6Price, Ship.Craft.Cr6Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr7Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr7Num, Ship.Craft.Cr7Crew, Ship.Craft.Cr7Vehicle,
                     Ship.Craft.Cr7Tonnage, Ship.Craft.Cr7Price, Ship.Craft.Cr7Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.Cr8Num > 0) then
    begin
      ExportData.Add(CraftString(Ship.Craft.Cr8Num, Ship.Craft.Cr8Crew, Ship.Craft.Cr8Vehicle,
                     Ship.Craft.Cr8Tonnage, Ship.Craft.Cr8Price, Ship.Craft.Cr8Desc));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.LF1Num > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Craft.LF1Num) + ' x '
          + FloatToStrF(Ship.Craft.LF1Size, ffNumber, 18, 3)
          + ' Td Launch Facilities: '
          + FloatToStrF(Ship.Craft.LauncherSpace(Ship.Craft.LF1Num, Ship.Craft.LF1Size), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Craft.LauncherCost(Ship.Craft.LF1Num, Ship.Craft.LF1Size), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Craft.LF2Num > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Craft.LF2Num) + ' x '
          + FloatToStrF(Ship.Craft.LF2Size, ffNumber, 18, 3)
          + ' Td Launch Facilities: '
          + FloatToStrF(Ship.Craft.LauncherSpace(Ship.Craft.LF2Num, Ship.Craft.LF2Size), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Craft.LauncherCost(Ship.Craft.LF2Num, Ship.Craft.LF2Size), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;
    ExportData.Add('');

    //accomodations
    ExportData.Add('ACCOMODATIONS');
    if (Ship.Accom.StRoom > 0) then
    begin
      ExportData.Add(FloatToStrF(Ship.Accom.StRoom, ffNumber, 18, 1)
          + ' x Staterooms: '
          + FloatToStrF(Ship.Accom.StRoomSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Accom.StRoomCost(ShipRace, DesignRules), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.SmStRoom > 0) then
    begin
      ExportData.Add(FloatToStrF(Ship.Accom.SmStRoom, ffNumber, 18, 1)
          + ' x Small Staterooms: '
          + FloatToStrF(Ship.Accom.SmStRoomSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr '
          + FloatToStrF(Ship.Accom.SmStRoomCost(ShipRace, DesignRules), ffNumber, 18, 3));    end
    else
    begin
      //
    end;

    if (Ship.Accom.Couches > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.Couches) + ' x Couches: '
          + FloatToStrF(Ship.Accom.CouchesSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.CouchesCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.LowBerth > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.LowBerth) + ' x Low Berths: '
          + FloatToStrF(Ship.Accom.LowBerthSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.LowBerthCost(ShipRace), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.EmLowBerth > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.EmLowBerth) + ' x Emergency Low Berths: '
          + FloatToStrF(Ship.Accom.EmLowBerthSpace(ShipRace), ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.EmLowBerthCost(ShipRace), ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.DropCaps > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.DropCaps) + ' x Drop Capsule Launchers: '
          + FloatToStrF(Ship.Accom.DropCapsSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.DropCapsCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.ReadyDropCaps > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.ReadyDropCaps) + ' x Ready Drop Capsules: '
          + FloatToStrF(Ship.Accom.ReadyDropCapsSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.ReadyDropCapsCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.StoredDropCaps > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.StoredDropCaps) + ' x Stored Drop Capsules: '
          + FloatToStrF(Ship.Accom.StoredDropCapsSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.StoredDropCapsCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.EngShop > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.EngShop) + ' x Engineering Shops: '
          + FloatToStrF(Ship.Accom.EngShopSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.EngShopCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.VehicleShop > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.VehicleShop) + ' x Vehicle Shops: '
          + FloatToStrF(Ship.Accom.VehicleShopSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.VehicleShopCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.Labs > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.Labs) + ' x Laboratories: '
          + FloatToStrF(Ship.Accom.LabsSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.LabsCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.SickBay > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.SickBay) + ' x Sickbays: '
          + FloatToStrF(Ship.Accom.SickBaySpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.SickBayCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.AutoDoc > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.AutoDoc) + ' x Autodocs: '
          + FloatToStrF(Ship.Accom.AutoDocSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.AutoDocCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.Airlock > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.Airlock) + ' x Extra Airlocks: '
          + FloatToStrF(Ship.Accom.AirlockSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.AirlockCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.Fresher > 0) then
    begin
      ExportData.Add(IntToStr(Ship.Accom.Fresher) + ' x Freshers: '
          + FloatToStrF(Ship.Accom.FresherSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.FresherCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;

    if (Ship.Accom.MissileMag > 0) then
    begin
      ExportData.Add('Missile Magazines: '
          + FloatToStrF(Ship.Accom.MissileMagSpace, ffNumber, 18, 3)
          + ' Td; MCr ' + FloatToStrF(Ship.Accom.MissileMagCost, ffNumber, 18, 3));
    end
    else
    begin
      //
    end;


    if (Ship.Accom.Cargo > 0) then
    begin
      ExportData.Add('Cargo: '
          + FloatToStrF(Ship.Accom.Cargo, ffNumber, 18, 3)
          + ' Td; MCr 0.000');
    end
    else
    begin
      ExportData.Add('Cargo: '
          + FloatToStrF(Ship.GetRemTonnage + Ship.Eng.UpgradeSpaceAvailable, ffNumber, 18, 3)
          + ' Td; MCr 0.000');
    end;
    ExportData.Add('');

    //user defined
    ExportData.Add('USER DEFINED');
    if (Ship.UserDef.Item1Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item1Desc, Ship.UserDef.Item1Num,
                                   Ship.UserDef.Item1Hp, Ship.UserDef.Item1Size,
                                   Ship.UserDef.Item1Cost, Ship.UserDef.Item1Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item2Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item2Desc, Ship.UserDef.Item2Num,
                                   Ship.UserDef.Item2Hp, Ship.UserDef.Item2Size,
                                   Ship.UserDef.Item2Cost, Ship.UserDef.Item2Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item3Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item3Desc, Ship.UserDef.Item3Num,
                                   Ship.UserDef.Item3Hp, Ship.UserDef.Item3Size,
                                   Ship.UserDef.Item3Cost, Ship.UserDef.Item3Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item4Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item4Desc, Ship.UserDef.Item4Num,
                                   Ship.UserDef.Item4Hp, Ship.UserDef.Item4Size,
                                   Ship.UserDef.Item4Cost, Ship.UserDef.Item4Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item5Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item5Desc, Ship.UserDef.Item5Num,
                                   Ship.UserDef.Item5Hp, Ship.UserDef.Item5Size,
                                   Ship.UserDef.Item5Cost, Ship.UserDef.Item5Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item6Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item6Desc, Ship.UserDef.Item6Num,
                                   Ship.UserDef.Item6Hp, Ship.UserDef.Item6Size,
                                   Ship.UserDef.Item6Cost, Ship.UserDef.Item6Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item7Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item7Desc, Ship.UserDef.Item7Num,
                                   Ship.UserDef.Item7Hp, Ship.UserDef.Item7Size,
                                   Ship.UserDef.Item7Cost, Ship.UserDef.Item7Ep));
    end
    else
    begin
      //
    end;

    if (Ship.UserDef.Item8Num > 0) then
    begin
      ExportData.Add(UserDefString(Data, Anal, Ship.UserDef.Item8Desc, Ship.UserDef.Item8Num,
                                   Ship.UserDef.Item8Hp, Ship.UserDef.Item8Size,
                                   Ship.UserDef.Item8Cost, Ship.UserDef.Item8Ep));
    end
    else
    begin
      //
    end;

    //write to file
    if (DoWrite) then
    begin
      ExportData.SaveToFile(ExportFile);
    end;

    Result := ExportData;
  Finally
    FreeAndNil(Data);
    FreeAndNil(Anal);
  end;
end;


end.

