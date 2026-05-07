unit LittleBaysPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas;

type

   { TLittleBays }

   TLittleBays = class(TWpnShipModule)
   private
      fEmptyBays : Integer;
      FEnergyBaysRefitTech: Integer;
      fMesonBays : Integer;
      FMesonBaysRefitTech: Integer;
      FMissileBaysRefitTech: Integer;
      FNewEmptyBays: Integer;
      FNewEnergyBays: Integer;
      FNewEnergyType: Integer;
      FNewMesonBays: Integer;
      FNewMissileBays: Integer;
      FNewPaBays: Integer;
      FNewRepulsorBays: Integer;
      fPABays : Integer;
      FPaBaysRefitTech: Integer;
      FRefitEmptyBays: Boolean;
      FRefitEnergyBays: Boolean;
      FRefitMesonBays: Boolean;
      FRefitMissileBays: Boolean;
      FRefitPaBays: Boolean;
      FRefitRepulsorBays: Boolean;
      fRepulsorBays : Integer;
      fMissileBays : Integer;
      fEnergyBays : Integer;
      fEnergyType : Integer;
      FRepulsorBaysRefitTech: Integer;
      function BaysCost(Race : Integer) : Extended;
      function BaysSpace(Race : Integer) : Extended;
      function CalcRefitCost(Race: Integer): Extended;
      procedure SetEnergyBaysRefitTech(const AValue: Integer);
      procedure SetMesonBaysRefitTech(const AValue: Integer);
      procedure SetMissileBaysRefitTech(const AValue: Integer);
      procedure SetNewEmptyBays(const AValue: Integer);
      procedure SetNewEnergyBays(const AValue: Integer);
      procedure SetNewEnergyType(const AValue: Integer);
      procedure SetNewMesonBays(const AValue: Integer);
      procedure SetNewMissileBays(const AValue: Integer);
      procedure SetNewPaBays(const AValue: Integer);
      procedure SetNewRepulsorBays(const AValue: Integer);
      procedure SetPaBaysRefitTech(const AValue: Integer);
      procedure SetRefitEmptyBays(const AValue: Boolean);
      procedure SetRefitEnergyBays(const AValue: Boolean);
      procedure SetRefitMesonBays(const AValue: Boolean);
      procedure SetRefitMissileBays(const AValue: Boolean);
      procedure SetRefitPaBays(const AValue: Boolean);
      procedure SetRefitRepulsorBays(const AValue: Boolean);
      procedure SetRepulsorBaysRefitTech(const AValue: Integer);
   public
      procedure CalcCrew(Size: Extended; Rules: Integer);
      procedure CalcPower;
      procedure CalcHardPoints;
      property EmptyBays : Integer read fEmptyBays write fEmptyBays;
      property MesonBays : Integer read fMesonBays write fMesonBays;
      property PABays : Integer read fPABays write fPABays;
      property RepulsorBays : Integer read fRepulsorBays write fRepulsorBays;
      property MissileBays : Integer read fMissileBays write fMissileBays;
      property EnergyBays : Integer read fEnergyBays write fEnergyBays;
      property EnergyType : Integer read fEnergyType write fEnergyType;
      //REFIT
      property RefitEmptyBays: Boolean read FRefitEmptyBays write SetRefitEmptyBays;
      property RefitMesonBays: Boolean read FRefitMesonBays write SetRefitMesonBays;
      property RefitPaBays: Boolean read FRefitPaBays write SetRefitPaBays;
      property RefitRepulsorBays: Boolean read FRefitRepulsorBays write SetRefitRepulsorBays;
      property RefitMissileBays: Boolean read FRefitMissileBays write SetRefitMissileBays;
      property RefitEnergyBays: Boolean read FRefitEnergyBays write SetRefitEnergyBays;
      property MesonBaysRefitTech: Integer read FMesonBaysRefitTech write SetMesonBaysRefitTech;
      property PaBaysRefitTech: Integer read FPaBaysRefitTech write SetPaBaysRefitTech;
      property RepulsorBaysRefitTech: Integer read FRepulsorBaysRefitTech write SetRepulsorBaysRefitTech;
      property MissileBaysRefitTech: Integer read FMissileBaysRefitTech write SetMissileBaysRefitTech;
      property EnergyBaysRefitTech: Integer read FEnergyBaysRefitTech write SetEnergyBaysRefitTech;
      property NewEmptyBays: Integer read FNewEmptyBays write SetNewEmptyBays;
      property NewMesonBays: Integer read FNewMesonBays write SetNewMesonBays;
      property NewPaBays: Integer read FNewPaBays write SetNewPaBays;
      property NewRepulsorBays: Integer read FNewRepulsorBays write SetNewRepulsorBays;
      property NewMissileBays: Integer read FNewMissileBays write SetNewMissileBays;
      property NewEnergyBays: Integer read FNewEnergyBays write SetNewEnergyBays;
      property NewEnergyType: Integer read FNewEnergyType write SetNewEnergyType;

      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignLittleBays(ShipData : String);
      function EmptyBaysCost(Race : Integer) : Extended;
      function EmptyBaysSpace (Race : Integer) : Extended;
      function MesonBaysCost(Race : Integer) : Extended;
      function MesonBaysSpace (Race : Integer) : Extended;
      function PaBaysCost(Race : Integer) : Extended;
      function PaBaysSpace (Race : Integer) : Extended;
      function RepulsorBaysCost(Race : Integer) : Extended;
      function RepulsorBaysSpace (Race : Integer) : Extended;
      function MissileBaysCost(Race : Integer) : Extended;
      function MissileBaysSpace (Race : Integer) : Extended;
      function EnergyBaysCost(Race : Integer) : Extended;
      function EnergyBaysSpace (Race : Integer) : Extended;

      //usp stuff
      function RepulsorFactor(TechLevel: Integer): Integer;
      function EnergyFactor(TechLevel: Integer): Integer;
      function PaFactor(TechLevel: Integer): Integer;
      function MesonFactor(TechLevel: Integer): Integer;
      function MissileFactor(TechLevel: Integer): Integer;
   end;

var
   LittleBays : TLittleBays;

implementation

{ TLittleBays }

procedure TLittleBays.AssignDefaults(ShipData: String);
//assign default values

var
  Props : TStringList;
begin
  Props := TStringList.Create;
  try
    Props.CommaText := ShipData;
    Space := 0;
    Cost := 0;
    HardPoints := 0;
    EmptyBays := StrToInt(Props[0]);
    MesonBays := StrToInt(Props[1]);
    PABays := StrToInt(Props[2]);
    RepulsorBays := StrToInt(Props[3]);
    MissileBays := StrToInt(Props[4]);
    EnergyBays := StrToInt(Props[5]);
    EnergyType := StrToInt(Props[6]);
    RefitEmptyBays := StrToBool(Props[7]);
    RefitMesonBays := StrToBool(Props[8]);
    RefitPaBays := StrToBool(Props[9]);
    RefitRepulsorBays := StrToBool(Props[10]);
    RefitMissileBays := StrToBool(Props[11]);
    RefitEnergyBays := StrToBool(Props[12]);
    MesonBaysRefitTech := StrToInt(Props[13]);
    PaBaysRefitTech := StrToInt(Props[14]);
    RepulsorBaysRefitTech := StrToInt(Props[15]);
    MissileBaysRefitTech := StrToInt(Props[16]);
    EnergyBaysRefitTech := StrToInt(Props[17]);
    NewEmptyBays := StrToInt(Props[18]);
    NewMesonBays := StrToInt(Props[19]);
    NewPABays := StrToInt(Props[20]);
    NewRepulsorBays := StrToInt(Props[21]);
    NewMissileBays := StrToInt(Props[22]);
    NewEnergyBays := StrToInt(Props[23]);
    NewEnergyType := StrToInt(Props[24]);
  finally
    FreeAndNil(Props);
   end;
end;

function TLittleBays.BaysCost(Race: Integer): Extended;
//calculate the cost

begin
  Result := EmptyBaysCost(Race) + MesonBaysCost(Race) + PABaysCost(Race)
      + RepulsorBaysCost(Race) + MissileBaysCost(Race) + EnergyBaysCost(Race);
end;

function TLittleBays.BaysSpace(Race: Integer): Extended;
//calculate the space required

begin
  Result := EmptyBaysSpace(Race) + MesonBaysSpace(Race) + PABaysSpace(Race)
      + RepulsorBaysSpace(Race) + MissileBaysSpace(Race) + EnergyBaysSpace(Race);
end;

function TLittleBays.CalcRefitCost(Race: Integer): Extended;
var
  BaseBays, NewBays, BaysEmptied, BaysRemoved, EType: Integer;
  EmptyRemoved, MesonsRemoved, PaRemoved, RepulsorsRemoved, MissilesRemoved, EnergyRemoved: Integer;
begin
  //ERROR needs some way to work out number of new bays based on old bays.
  BaseBays := EmptyBays + MesonBays + PaBays + RepulsorBays + MissileBays;
  NewBays := NewEmptyBays + NewMesonBays + NewPaBays + NewRepulsorBays + NewMissileBays;
  if (RefitEmptyBays) then EmptyRemoved := EmptyBays - NewEmptyBays else EmptyRemoved := 0;
  if (RefitMesonBays) then MesonsRemoved := MesonBays - NewMesonBays else MesonsRemoved := 0;
  if (RefitPaBays) then PaRemoved := PaBays - NewPaBays else PaRemoved := 0;
  if (RefitRepulsorBays) then RepulsorsRemoved := RepulsorBays - NewRepulsorBays else RepulsorsRemoved := 0;
  if (RefitMissileBays) then MissilesRemoved := MissileBays - NewMissileBays else MissilesRemoved := 0;
  if (RefitEnergyBays) then EnergyRemoved := EnergyBays - NewEnergyBays else EnergyRemoved := 0;
  if (RefitEnergyBays) then EType := NewEnergyType else EType := EnergyType;
  BaysRemoved := EmptyRemoved + MesonsRemoved + PaRemoved + RepulsorsRemoved + MissilesRemoved + EnergyRemoved;

  if (RefitEmptyBays) then BaysEmptied := (NewEmptyBays - EmptyBays) + BaysRemoved
      else BaysEmptied := BaysRemoved;

  Result := 0;
  //has the number of bays been decreased
  if (BaysRemoved > 0) then
  begin
    Result := Result + (BaysRemoved * 0.125);
  end;

  //are there more empty bays
  if (BaysEmptied > 0) then
  begin
    if (EnergyRemoved > 0) and (EType = 0) then
    begin
      if (BaysEmptied >= EnergyRemoved) then
      begin
        Result := Result + (EnergyRemoved * 1.25);
      end
      else
      begin
        Result := Result + (BaysEmptied * 1.25);
      end;
      BaysEmptied := BaysEmptied - EnergyRemoved;
    end;
    if (RepulsorsRemoved > 0) then
    begin
      if (BaysEmptied >= RepulsorsRemoved) then
      begin
        Result := Result + (RepulsorsRemoved * 1.5);
      end
      else
      begin
        Result := Result + (BaysEmptied * 1.5);
      end;
      BaysEmptied := BaysEmptied - RepulsorsRemoved;
    end;
    if (EnergyRemoved > 0) and (EType = 1) then
    begin
      if (BaysEmptied >= EnergyRemoved) then
      begin
        Result := Result + (EnergyRemoved * 2);
      end
      else
      begin
        Result := Result + (BaysEmptied * 2);
      end;
      BaysEmptied := BaysEmptied - EnergyRemoved;
    end;
    if (MissilesRemoved > 0) then
    begin
      if (BaysEmptied >= MissilesRemoved) then
      begin
        Result := Result + (MissilesRemoved * 3);
      end
      else
      begin
        Result := Result + (BaysEmptied * 3);
      end;
      BaysEmptied := BaysEmptied - MissilesRemoved;
    end;
    if (PaRemoved > 0) then
    begin
      if (BaysEmptied >= PaRemoved) then
      begin
        Result := Result + (PaRemoved * 5);
      end
      else
      begin
        Result := Result + (BaysEmptied * 5);
      end;
      BaysEmptied := BaysEmptied - PaRemoved;
    end;
    if (MesonsRemoved > 0) then
    begin
      if (BaysEmptied >= MesonsRemoved) then
      begin
        Result := Result + (MesonsRemoved * 12.5);
      end
      else
      begin
        Result := Result + (BaysEmptied * 12.5);
      end;
      BaysEmptied := BaysEmptied - MesonsRemoved;
    end;
  end;

  //cost of new bays
  if (RefitMesonBays) then Result := Result + (NewMesonBays * 55);
  if (RefitPaBays) then Result := Result + (NewPaBays * 22);
  if (RefitRepulsorBays) then Result := Result + (NewRepulsorBays * 6.6);
  if (RefitMissileBays) then Result := Result + (NewMissileBays * 13.2);
  if (RefitEnergyBays) then Result := Result + (NewEnergyBays * ((5 + (Etype * 3)) * 1.1));

  if (Race = 1) then Result := Result * 2;
end;

procedure TLittleBays.SetEnergyBaysRefitTech(const AValue: Integer);
begin
  if FEnergyBaysRefitTech=AValue then exit;
  FEnergyBaysRefitTech:=AValue;
end;

procedure TLittleBays.SetMesonBaysRefitTech(const AValue: Integer);
begin
  if FMesonBaysRefitTech=AValue then exit;
  FMesonBaysRefitTech:=AValue;
end;

procedure TLittleBays.SetMissileBaysRefitTech(const AValue: Integer);
begin
  if FMissileBaysRefitTech=AValue then exit;
  FMissileBaysRefitTech:=AValue;
end;

procedure TLittleBays.SetNewEmptyBays(const AValue: Integer);
begin
  if FNewEmptyBays=AValue then exit;
  FNewEmptyBays:=AValue;
end;

procedure TLittleBays.SetNewEnergyBays(const AValue: Integer);
begin
  if FNewEnergyBays=AValue then exit;
  FNewEnergyBays:=AValue;
end;

procedure TLittleBays.SetNewEnergyType(const AValue: Integer);
begin
  if FNewEnergyType=AValue then exit;
  FNewEnergyType:=AValue;
end;

procedure TLittleBays.SetNewMesonBays(const AValue: Integer);
begin
  if FNewMesonBays=AValue then exit;
  FNewMesonBays:=AValue;
end;

procedure TLittleBays.SetNewMissileBays(const AValue: Integer);
begin
  if FNewMissileBays=AValue then exit;
  FNewMissileBays:=AValue;
end;

procedure TLittleBays.SetNewPaBays(const AValue: Integer);
begin
  if FNewPaBays=AValue then exit;
  FNewPaBays:=AValue;
end;

procedure TLittleBays.SetNewRepulsorBays(const AValue: Integer);
begin
  if FNewRepulsorBays=AValue then exit;
  FNewRepulsorBays:=AValue;
end;

procedure TLittleBays.SetPaBaysRefitTech(const AValue: Integer);
begin
  if FPaBaysRefitTech=AValue then exit;
  FPaBaysRefitTech:=AValue;
end;

procedure TLittleBays.SetRefitEmptyBays(const AValue: Boolean);
begin
  if FRefitEmptyBays=AValue then exit;
  FRefitEmptyBays:=AValue;
end;

procedure TLittleBays.SetRefitEnergyBays(const AValue: Boolean);
begin
  if FRefitEnergyBays=AValue then exit;
  FRefitEnergyBays:=AValue;
end;

procedure TLittleBays.SetRefitMesonBays(const AValue: Boolean);
begin
  if FRefitMesonBays=AValue then exit;
  FRefitMesonBays:=AValue;
end;

procedure TLittleBays.SetRefitMissileBays(const AValue: Boolean);
begin
  if FRefitMissileBays=AValue then exit;
  FRefitMissileBays:=AValue;
end;

procedure TLittleBays.SetRefitPaBays(const AValue: Boolean);
begin
  if FRefitPaBays=AValue then exit;
  FRefitPaBays:=AValue;
end;

procedure TLittleBays.SetRefitRepulsorBays(const AValue: Boolean);
begin
  if FRefitRepulsorBays=AValue then exit;
  FRefitRepulsorBays:=AValue;
end;

procedure TLittleBays.SetRepulsorBaysRefitTech(const AValue: Integer);
begin
  if FRepulsorBaysRefitTech=AValue then exit;
  FRepulsorBaysRefitTech:=AValue;
end;

procedure TLittleBays.CalcCrew(Size: Extended; Rules: Integer);
//calculate crew

var
  iEmpty, iMeson, iPa, iRepulsor, iMissile, iEnergy: Integer;
begin
  if (RefitEmptyBays) then iEmpty := NewEmptyBays else iEmpty := EmptyBays;
  if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
  if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
  if (RefitRepulsorBays) then iRepulsor := NewRepulsorBays else iRepulsor := RepulsorBays;
  if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  if (RefitEnergyBays) then iEnergy := NewEnergyBays else iEnergy := EnergyBays;
  CmdCrew := 0;
  Crew := 0;
  //if book 5 include a gunnery officer
  if (Rules = 1) and (Size >= 100) then
  begin
    if ((iMeson + iPa + iRepulsor + iMissile + iEnergy) > 0) then CmdCrew := 1;
  end;
  Crew := (iMeson + iPa + iRepulsor + iMissile + iEnergy) * 2;
end;

procedure TLittleBays.CalcHardPoints;
//calculate the hardpoints required

var
  iEmpty, iMeson, iPa, iRepulsor, iMissile, iEnergy: Integer;
begin
  if (RefitEmptyBays) then iEmpty := NewEmptyBays else iEmpty := EmptyBays;
  if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
  if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
  if (RefitRepulsorBays) then iRepulsor := NewRepulsorBays else iRepulsor := RepulsorBays;
  if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  if (RefitEnergyBays) then iEnergy := NewEnergyBays else iEnergy := EnergyBays;
  HardPoints := (iEmpty + iMeson + iPa + iRepulsor + iMissile + iEnergy) * 10;
end;

procedure TLittleBays.CalcPower;
//calculate the power required

var
  iEmpty, iMeson, iPa, iRepulsor, iMissile, iEnergy, EType: Integer;
begin
  if (RefitEmptyBays) then iEmpty := NewEmptyBays else iEmpty := EmptyBays;
  if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
  if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
  if (RefitRepulsorBays) then iRepulsor := NewRepulsorBays else iRepulsor := RepulsorBays;
  if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  if (RefitEnergyBays) then iEnergy := NewEnergyBays else iEnergy := EnergyBays;
  if (RefitEnergyBays) then EType := NewEnergyType else EType := EnergyType;
  Power := (iMeson * 100) + (iPa * 30) + (iRepulsor * 5) + (iEnergy * (10 + (Etype * 10)));
end;

procedure TLittleBays.DesignLittleBays(ShipData: String);
//design the module

var
  Size: Extended;
  ShipDetails : TStringList;
  Race, CrewRules : Integer;
begin
  ShipDetails := TStringList.Create;
  try
    ShipDetails.CommaText := ShipData;
    Size := StrToFloat(ShipDetails[1]);
    Race := StrToInt(ShipDetails[2]);
    CrewRules := StrToInt(ShipDetails[3]);
    Cost := BaysCost(Race);
    Space := BaysSpace(Race);
    RefitCost := CalcRefitCost(Race);
    CalcCrew(Size, CrewRules);
    CalcPower;
    CalcHardPoints;
  finally
    FreeAndNil(ShipDetails);
  end;
end;

function TLittleBays.EmptyBaysCost(Race: Integer): Extended;
begin
  if (RefitEmptyBays) then
  begin
    if (Race = 1) then
    begin
       Result := NewEmptyBays * 1;
    end
    else
    begin
      Result := NewEmptyBays * 0.5;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
       Result := EmptyBays * 1;
    end
    else
    begin
      Result := EmptyBays * 0.5;
    end;
  end;
end;

function TLittleBays.EmptyBaysSpace(Race: Integer): Extended;
begin
  if (RefitEmptyBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewEmptyBays * 100;
    end
    else
    begin
      Result := NewEmptyBays * 50;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := EmptyBays * 100;
    end
    else
    begin
      Result := EmptyBays * 50;
    end;
  end;
end;

function TLittleBays.MesonBaysCost(Race: Integer): Extended;
begin
  if (RefitMesonBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMesonBays * 101;
    end
    else
    begin
      Result := NewMesonBays * 50.5;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MesonBays * 101;
    end
    else
    begin
      Result := MesonBays * 50.5;
    end;
  end;
end;

function TLittleBays.MesonBaysSpace(Race: Integer): Extended;
begin
  if (RefitMesonBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMesonBays * 100;
    end
    else
    begin
      Result := NewMesonBays * 50;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MesonBays * 100;
    end
    else
    begin
      Result := MesonBays * 50;
    end;
  end;
end;

function TLittleBays.PaBaysCost(Race: Integer): Extended;
begin
  if (RefitPaBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewPABays * 41;
    end
    else
    begin
      Result := NewPABays * 20.5;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := PABays * 41;
    end
    else
    begin
      Result := PABays * 20.5;
    end;
  end;
end;

function TLittleBays.PaBaysSpace(Race: Integer): Extended;
begin
  if (RefitPaBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewPABays * 100;
    end
    else
    begin
      Result := NewPABays * 50;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := PABays * 100;
    end
    else
    begin
      Result := PABays * 50;
    end;
  end;
end;

function TLittleBays.RepulsorBaysCost(Race: Integer): Extended;
begin
  if (RefitRepulsorBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewRepulsorBays * 13;
    end
    else
    begin
      Result := NewRepulsorBays * 6.5;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := RepulsorBays * 13;
    end
    else
    begin
      Result := RepulsorBays * 6.5;
    end;
  end;
end;

function TLittleBays.RepulsorBaysSpace(Race: Integer): Extended;
begin
  if (RefitRepulsorBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewRepulsorBays * 100;
    end
    else
    begin
      Result := NewRepulsorBays * 50;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := RepulsorBays * 100;
    end
    else
    begin
      Result := RepulsorBays * 50;
    end;
  end;
end;

function TLittleBays.MissileBaysCost(Race: Integer): Extended;
begin
  if (RefitMissileBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMissileBays * 25;
    end
    else
    begin
      Result := NewMissileBays * 12.5;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MissileBays * 25;
    end
    else
    begin
      Result := MissileBays * 12.5;
    end;
  end;
end;

function TLittleBays.MissileBaysSpace(Race: Integer): Extended;
begin
  if (RefitMissileBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMissileBays * 100;
    end
    else
    begin
      Result := NewMissileBays * 50;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MissileBays * 100;
    end
    else
    begin
      Result := MissileBays * 50;
    end;
  end;
end;

function TLittleBays.EnergyBaysCost(Race: Integer): Extended;
begin
  if (RefitEnergyBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewEnergyBays * (11 + (NewEnergyType * 6));
    end
    else
    begin
      Result := NewEnergyBays * (5.5 + (NewEnergyType * 3));
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := EnergyBays * (11 + (EnergyType * 6));
    end
    else
    begin
      Result := EnergyBays * (5.5 + (EnergyType * 3));
    end;
  end;
end;

function TLittleBays.EnergyBaysSpace(Race: Integer): Extended;
begin
  if (RefitEnergyBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewEnergyBays * 100;
    end
    else
    begin
      Result := NewEnergyBays * 50;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := EnergyBays * 100;
    end
    else
    begin
      Result := EnergyBays * 50;
    end;
  end;
end;

function TLittleBays.MesonFactor(TechLevel: Integer): Integer;
begin
  if ((MesonBays > 0) and (RefitMesonBays))
      or ((NewMesonBays > 0) and (RefitMesonBays)) then
  begin
    case (TechLevel) of
      0..14: Result := 0;
      else Result := 4;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TLittleBays.MissileFactor(TechLevel: Integer): Integer;
begin
  if ((MissileBays > 0) and (not RefitMissileBays))
      or ((NewMissileBays > 0) and (RefitMissileBays)) then
  begin
    case (TechLevel) of
      0..9: Result := 0;
      10..11: Result := 7;
      12..13: Result := 8;
      else Result := 9;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TLittleBays.RepulsorFactor(TechLevel: Integer): Integer;
begin
  if ((RepulsorBays > 0) and (not RefitRepulsorBays))
      or ((NewRepulsorBays > 0) and (RefitRepulsorBays)) then
  begin
    case TechLevel of
      0..13: Result := 0;
      14: Result := 3;
      else Result := 5;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TLittleBays.EnergyFactor(TechLevel: Integer): Integer;
begin
  if ((EnergyBays > 0) and (not RefitEnergyBays))
      or ((NewEnergyBays > 0) and (RefitEnergyBays)) then
  begin
    if (RefitEnergyBays) then
    begin
      //plasma guns
      if (NewEnergyType = 0) then
      begin
        case (TechLevel) of
          0..9: Result := 0;
          10: Result := 4;
          11: Result := 5;
          else Result := 6;
        end;
      end
      //fusion guns
      else
      begin
        case (TechLevel) of
          0..1: Result := 0;
          12: Result := 7;
          13: Result := 8;
          else Result := 9;
        end;
      end;
    end
    else
    begin
      //plasma guns
      if (EnergyType = 0) then
      begin
        case (TechLevel) of
          0..9: Result := 0;
          10: Result := 4;
          11: Result := 5;
          else Result := 6;
        end;
      end
      //fusion guns
      else
      begin
        case (TechLevel) of
          0..1: Result := 0;
          12: Result := 7;
          13: Result := 8;
          else Result := 9;
        end;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TLittleBays.PaFactor(TechLevel: Integer): Integer;
begin
  if ((PaBays > 0) and (not RefitPaBays))
      or ((NewPaBays > 0) and (RefitPaBays)) then
  begin
   case (TechLevel) of
      0..9: Result := 0;
      10..11: Result := 3;
      12..13: Result := 4;
      else Result := 5;
   end;
  end
  else
  begin
    Result := 0;
  end;
end;

end.

