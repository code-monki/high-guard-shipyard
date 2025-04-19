unit BigBaysPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas;

type

   { TBigBays }

   TBigBays = class(TWpnShipModule)
   private
      fEmptyBays: Integer;
      fMesonBays: Integer;
      FMesonBaysRefitTech: Integer;
      FMissileBaysRefitTech: Integer;
      FNewEmptyBays: Integer;
      FNewMesonBays: Integer;
      FNewMissileBays: Integer;
      FNewPaBays: Integer;
      FNewRepulsorBays: Integer;
      fPABays: Integer;
      FPaBaysRefitTech: Integer;
      FRefitEmptyBays: Boolean;
      FRefitMesonBays: Boolean;
      FRefitMissileBays: Boolean;
      FRefitPaBays: Boolean;
      FRefitRepulsorBays: Boolean;
      fRepulsorBays: Integer;
      fMissileBays: Integer;
      FRepulsorBaysRefitTech: Integer;
      function BaysCost(Race: Integer): Extended;
      function BaysSpace(Race: Integer): Extended;
      function CalcRefitCost(Race: Integer): Extended;
      procedure CalcHardPoints;
      procedure SetMesonBaysRefitTech(const AValue: Integer);
      procedure SetMissileBaysRefitTech(const AValue: Integer);
      procedure SetNewEmptyBays(const AValue: Integer);
      procedure SetNewMesonBays(const AValue: Integer);
      procedure SetNewMissileBays(const AValue: Integer);
      procedure SetNewPaBays(const AValue: Integer);
      procedure SetNewRepulsorBays(const AValue: Integer);
      procedure SetPaBaysRefitTech(const AValue: Integer);
      procedure SetRefitEmptyBays(const AValue: Boolean);
      procedure SetRefitMesonBays(const AValue: Boolean);
      procedure SetRefitMissileBays(const AValue: Boolean);
      procedure SetRefitPaBays(const AValue: Boolean);
      procedure SetRefitRepulsorBays(const AValue: Boolean);
      procedure SetRepulsorBaysRefitTech(const AValue: Integer);
   public
      procedure CalcCrew(Size: Extended; Rules: Integer);
      procedure CalcPower;
      property EmptyBays: Integer read fEmptyBays write fEmptyBays;
      property MesonBays: Integer read fMesonBays write fMesonBays;
      property PABays: Integer read fPABays write fPABays;
      property RepulsorBays: Integer read fRepulsorBays write fRepulsorBays;
      property MissileBays: Integer read fMissileBays write fMissileBays;
      //refit
      property RefitEmptyBays: Boolean read FRefitEmptyBays write SetRefitEmptyBays;
      property RefitMesonBays: Boolean read FRefitMesonBays write SetRefitMesonBays;
      property RefitPaBays: Boolean read FRefitPaBays write SetRefitPaBays;
      property RefitRepulsorBays: Boolean read FRefitRepulsorBays write SetRefitRepulsorBays;
      property RefitMissileBays: Boolean read FRefitMissileBays write SetRefitMissileBays;
      property MesonBaysRefitTech: Integer read FMesonBaysRefitTech write SetMesonBaysRefitTech;
      property PaBaysRefitTech: Integer read FPaBaysRefitTech write SetPaBaysRefitTech;
      property RepulsorBaysRefitTech: Integer read FRepulsorBaysRefitTech write SetRepulsorBaysRefitTech;
      property MissileBaysRefitTech: Integer read FMissileBaysRefitTech write SetMissileBaysRefitTech;
      property NewEmptyBays: Integer read FNewEmptyBays write SetNewEmptyBays;
      property NewMesonBays: Integer read FNewMesonBays write SetNewMesonBays;
      property NewPaBays: Integer read FNewPaBays write SetNewPaBays;
      property NewRepulsorBays: Integer read FNewRepulsorBays write SetNewRepulsorBays;
      property NewMissileBays: Integer read FNewMissileBays write SetNewMissileBays;

      procedure AssignDefaults(ShipData: String); virtual;
      procedure DesignBigBays(ShipData: String);
      function EmptyBaysCost(Race: Integer): Extended;
      function EmptyBaysSpace(Race: Integer): Extended;
      function MesonBaysCost(Race: Integer): Extended;
      function MesonBaysSpace(Race: Integer): Extended;
      function PaBaysCost(Race: Integer): Extended;
      function PaBaysSpace(Race: Integer): Extended;
      function RepulsorBaysCost(Race: Integer): Extended;
      function RepulsorBaysSpace(Race: Integer): Extended;
      function MissileBaysCost(Race: Integer): Extended;
      function MissileBaysSpace(Race: Integer): Extended;

      //usp stuff
      function RepulsorFactor(TechLevel: Integer): Integer;
      function PaFactor(TechLevel: Integer): Integer;
      function MesonFactor(TechLevel: Integer): Integer;
      function MissileFactor(TechLevel: Integer): Integer;
   end;

var
   BigBays : TBigBays;

implementation

{ TBigBays }

procedure TBigBays.AssignDefaults(ShipData: String);
//assign default values

var
  Props: TStringList;
begin
  Props := TStringList.Create;
  try
    Props.CommaText := ShipData;
    Space := 0;
    Cost := 0;
    HardPoints := 0;
    RefitCost := 0;
    EmptyBays := StrToInt(Props[0]);
    MesonBays := StrToInt(Props[1]);
    PABays := StrToInt(Props[2]);
    RepulsorBays := StrToInt(Props[3]);
    MissileBays := StrToInt(Props[4]);
    RefitEmptyBays := StrToBool(Props[5]);
    RefitMesonBays := StrToBool(Props[6]);
    RefitPaBays := StrToBool(Props[7]);
    RefitRepulsorBays := StrToBool(Props[8]);
    RefitMissileBays := StrToBool(Props[9]);
    MesonBaysRefitTech := StrToInt(Props[10]);
    PaBaysRefitTech := StrToInt(Props[11]);
    RepulsorBaysRefitTech := StrToInt(Props[12]);
    MissileBaysRefitTech := StrToInt(Props[13]);
    NewEmptyBays := StrToInt(Props[14]);
    NewMesonBays := StrToInt(Props[15]);
    NewPABays := StrToInt(Props[16]);
    NewRepulsorBays := StrToInt(Props[17]);
    NewMissileBays := StrToInt(Props[18]);
  finally
    FreeAndNil(Props);
  end;
end;

function TBigBays.BaysCost(Race: Integer): Extended;
//calculate the cost

begin
  Result := EmptyBaysCost(Race) + MesonBaysCost(Race) + PaBaysCost(Race)
      + RepulsorBaysCost(Race) + MissileBaysCost(Race);
end;

function TBigBays.BaysSpace(Race: Integer): Extended;
//calculate the space required

begin
  Result := EmptyBaysSpace(Race) + MesonBaysSpace(Race) + PaBaysSpace(Race)
      + RepulsorBaysSpace(Race) + MissileBaysSpace(Race);
end;

procedure TBigBays.CalcCrew(Size: Extended; Rules: Integer);
//calculate crew
var
  iEmpty, iMeson, iPa, iRepulsor, iMissile: Integer;
begin
  if (RefitEmptyBays) then iEmpty := NewEmptyBays else iEmpty := EmptyBays;
  if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
  if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
  if (RefitRepulsorBays) then iRepulsor := NewRepulsorBays else iRepulsor := RepulsorBays;
  if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  CmdCrew := 0;
  Crew := 0;
  //if book 5 include a gunnery officer
  if (Rules = 1) and (Size >= 100) then
  begin
    if ((iMeson + iPa + iRepulsor + iMissile) > 0) then CmdCrew := 1;
  end;
  Crew := (iMeson + iPa + iRepulsor + iMissile) * 2;
end;

procedure TBigBays.CalcHardPoints;
//calculate the hardpoints required
var
  iEmpty, iMeson, iPa, iRepulsor, iMissile: Integer;
begin
  if (RefitEmptyBays) then iEmpty := NewEmptyBays else iEmpty := EmptyBays;
  if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
  if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
  if (RefitRepulsorBays) then iRepulsor := NewRepulsorBays else iRepulsor := RepulsorBays;
  if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  HardPoints := (iEmpty + iMeson + iPa + iRepulsor + iMissile) * 10;
end;

function TBigBays.CalcRefitCost(Race: Integer): Extended;
var
  BaseBays, NewBays, BaysEmptied, BaysRemoved: Integer;
  EmptyRemoved, MesonsRemoved, PaRemoved, RepulsorsRemoved, MissilesRemoved: Integer;
begin
  //ERROR needs some way to work out number of new bays based on old bays.
  BaseBays := EmptyBays + MesonBays + PaBays + RepulsorBays + MissileBays;
  NewBays := NewEmptyBays + NewMesonBays + NewPaBays + NewRepulsorBays + NewMissileBays;
  if (RefitEmptyBays) then EmptyRemoved := EmptyBays - NewEmptyBays else EmptyRemoved := 0;
  if (RefitMesonBays) then MesonsRemoved := MesonBays - NewMesonBays else MesonsRemoved := 0;
  if (RefitPaBays) then PaRemoved := PaBays - NewPaBays else PaRemoved := 0;
  if (RefitRepulsorBays) then RepulsorsRemoved := RepulsorBays - NewRepulsorBays else RepulsorsRemoved := 0;
  if (RefitMissileBays) then MissilesRemoved := MissileBays - NewMissileBays else MissilesRemoved := 0;
  BaysRemoved := EmptyRemoved + MesonsRemoved + PaRemoved + RepulsorsRemoved + MissilesRemoved;

  if (RefitEmptyBays) then BaysEmptied := (NewEmptyBays - EmptyBays) + BaysRemoved
      else BaysEmptied := BaysRemoved;

  Result := 0;
  //has the number of bays been decreased
  if (BaysRemoved > 0) then
  begin
    Result := Result + (BaysRemoved * 0.25);
  end;

  //are there more empty bays
  if (BaysEmptied > 0) then
  begin
    if (RepulsorsRemoved > 0) then
    begin
      if (BaysEmptied >= RepulsorsRemoved) then
      begin
        Result := Result + (RepulsorsRemoved * 2.5);
      end
      else
      begin
        Result := Result + (BaysEmptied * 2.5);
      end;
      BaysEmptied := BaysEmptied - RepulsorsRemoved;
    end;
    if (MissilesRemoved > 0) then
    begin
      if (BaysEmptied >= MissilesRemoved) then
      begin
        Result := Result + (MissilesRemoved * 5);
      end
      else
      begin
        Result := Result + (BaysEmptied * 5);
      end;
      BaysEmptied := BaysEmptied - MissilesRemoved;
    end;
    if (PaRemoved > 0) then
    begin
      if (BaysEmptied >= PaRemoved) then
      begin
        Result := Result + (PaRemoved * 8.75);
      end
      else
      begin
        Result := Result + (BaysEmptied * 8.75);
      end;
      BaysEmptied := BaysEmptied - PaRemoved;
    end;
    if (MesonsRemoved > 0) then
    begin
      if (BaysEmptied >= MesonsRemoved) then
      begin
        Result := Result + (MesonsRemoved * 17.5);
      end
      else
      begin
        Result := Result + (BaysEmptied * 17.5);
      end;
      BaysEmptied := BaysEmptied - MesonsRemoved;
    end;
  end;

  //cost of new bays
  if (RefitMesonBays) then Result := Result + (NewMesonBays * 77);
  if (RefitPaBays) then Result := Result + (NewPaBays * 38.5);
  if (RefitRepulsorBays) then Result := Result + (NewRepulsorBays * 11);
  if (RefitMissileBays) then Result := Result + (NewMissileBays * 22);

  if (Race = 1) then Result := Result * 2;
end;

procedure TBigBays.SetMesonBaysRefitTech(const AValue: Integer);
begin
  if FMesonBaysRefitTech=AValue then exit;
  FMesonBaysRefitTech:=AValue;
end;

procedure TBigBays.SetMissileBaysRefitTech(const AValue: Integer);
begin
  if FMissileBaysRefitTech=AValue then exit;
  FMissileBaysRefitTech:=AValue;
end;

procedure TBigBays.SetNewEmptyBays(const AValue: Integer);
begin
  if FNewEmptyBays=AValue then exit;
  FNewEmptyBays:=AValue;
end;

procedure TBigBays.SetNewMesonBays(const AValue: Integer);
begin
  if FNewMesonBays=AValue then exit;
  FNewMesonBays:=AValue;
end;

procedure TBigBays.SetNewMissileBays(const AValue: Integer);
begin
  if FNewMissileBays=AValue then exit;
  FNewMissileBays:=AValue;
end;

procedure TBigBays.SetNewPaBays(const AValue: Integer);
begin
  if FNewPaBays=AValue then exit;
  FNewPaBays:=AValue;
end;

procedure TBigBays.SetNewRepulsorBays(const AValue: Integer);
begin
  if FNewRepulsorBays=AValue then exit;
  FNewRepulsorBays:=AValue;
end;

procedure TBigBays.SetPaBaysRefitTech(const AValue: Integer);
begin
  if FPaBaysRefitTech=AValue then exit;
  FPaBaysRefitTech:=AValue;
end;

procedure TBigBays.SetRefitEmptyBays(const AValue: Boolean);
begin
  if FRefitEmptyBays=AValue then exit;
  FRefitEmptyBays:=AValue;
end;

procedure TBigBays.SetRefitMesonBays(const AValue: Boolean);
begin
  if FRefitMesonBays=AValue then exit;
  FRefitMesonBays:=AValue;
end;

procedure TBigBays.SetRefitMissileBays(const AValue: Boolean);
begin
  if FRefitMissileBays=AValue then exit;
  FRefitMissileBays:=AValue;
end;

procedure TBigBays.SetRefitPaBays(const AValue: Boolean);
begin
  if FRefitPaBays=AValue then exit;
  FRefitPaBays:=AValue;
end;

procedure TBigBays.SetRefitRepulsorBays(const AValue: Boolean);
begin
  if FRefitRepulsorBays=AValue then exit;
  FRefitRepulsorBays:=AValue;
end;

procedure TBigBays.SetRepulsorBaysRefitTech(const AValue: Integer);
begin
  if FRepulsorBaysRefitTech=AValue then exit;
  FRepulsorBaysRefitTech:=AValue;
end;

procedure TBigBays.CalcPower;
//calculate the power required

var
  iEmpty, iMeson, iPa, iRepulsor, iMissile: Integer;
begin
  if (RefitEmptyBays) then iEmpty := NewEmptyBays else iEmpty := EmptyBays;
  if (RefitMesonBays) then iMeson := NewMesonBays else iMeson := MesonBays;
  if (RefitPaBays) then iPa := NewPaBays else iPa := PaBays;
  if (RefitRepulsorBays) then iRepulsor := NewRepulsorBays else iRepulsor := RepulsorBays;
  if (RefitMissileBays) then iMissile := NewMissileBays else iMissile := MissileBays;
  Power := (iMeson * 200) + (iPa * 60) + (iRepulsor * 10);
end;

procedure TBigBays.DesignBigBays(ShipData: String);
//design the module

var
  Size: Extended;
  ShipDetails: TStringList;
  Race, CrewRules: Integer;
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

function TBigBays.EmptyBaysCost(Race: Integer): Extended;
begin
  if (RefitEmptyBays) then
  begin
    if (Race = 1) then
    begin
       Result := NewEmptyBays * 2;
    end
    else
    begin
      Result := NewEmptyBays * 1;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
       Result := EmptyBays * 2;
    end
    else
    begin
      Result := EmptyBays * 1;
    end;
  end;
end;

function TBigBays.EmptyBaysSpace(Race: Integer): Extended;
begin
  if (RefitEmptyBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewEmptyBays * 200;
    end
    else
    begin
      Result := NewEmptyBays * 100;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := EmptyBays * 200;
    end
    else
    begin
      Result := EmptyBays * 100;
    end;
  end;
end;

function TBigBays.MesonBaysCost(Race: Integer): Extended;
begin
  if (RefitMesonBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMesonBays * 142;
    end
    else
    begin
      Result := NewMesonBays * 71;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MesonBays * 142;
    end
    else
    begin
      Result := MesonBays * 71;
    end;
  end;
end;

function TBigBays.MesonBaysSpace(Race: Integer): Extended;
begin
  if (RefitMesonBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMesonBays * 200;
    end
    else
    begin
      Result := NewMesonBays * 100;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MesonBays * 200;
    end
    else
    begin
      Result := MesonBays * 100;
    end;
  end;
end;

function TBigBays.PaBaysCost(Race: Integer): Extended;
begin
  if (RefitPaBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewPABays * 72;
    end
    else
    begin
      Result := NewPABays * 36;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := PABays * 72;
    end
    else
    begin
      Result := PABays * 36;
    end;
  end;
end;

function TBigBays.PaBaysSpace(Race: Integer): Extended;
begin
  if (RefitPaBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewPABays * 200;
    end
    else
    begin
      Result := NewPABays * 100;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := PABays * 200;
    end
    else
    begin
      Result := PABays * 100;
    end;
  end;
end;

function TBigBays.RepulsorBaysCost(Race: Integer): Extended;
begin
  if (RefitRepulsorBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewRepulsorBays * 22;
    end
    else
    begin
      Result := NewRepulsorBays * 11;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := RepulsorBays * 22;
    end
    else
    begin
      Result := RepulsorBays * 11;
    end;
  end;
end;

function TBigBays.RepulsorBaysSpace(Race: Integer): Extended;
begin
  if (RefitRepulsorBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewRepulsorBays * 200;
    end
    else
    begin
      Result := NewRepulsorBays * 100;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := RepulsorBays * 200;
    end
    else
    begin
      Result := RepulsorBays * 100;
    end;
  end;
end;

function TBigBays.MissileBaysCost(Race: Integer): Extended;
begin
  if (RefitMissileBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMissileBays * 42;
    end
    else
    begin
      Result := NewMissileBays * 21;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MissileBays * 42;
    end
    else
    begin
      Result := MissileBays * 21;
    end;
  end;
end;

function TBigBays.MissileBaysSpace(Race: Integer): Extended;
begin
  if (RefitMissileBays) then
  begin
    if (Race = 1) then
    begin
      Result := NewMissileBays * 200;
    end
    else
    begin
      Result := NewMissileBays * 100;
    end;
  end
  else
  begin
    if (Race = 1) then
    begin
      Result := MissileBays * 200;
    end
    else
    begin
      Result := MissileBays * 100;
    end;
  end;
end;

function TBigBays.MesonFactor(TechLevel: Integer): Integer;
begin
  if ((MesonBays > 0) and (not RefitMesonBays))
      or ((NewMesonBays > 0) and (RefitMesonBays)) then
  begin
    case (TechLevel) of
      0..12: Result := 0;
      13: Result := 3;
      14: Result := 5;
      else Result := 9;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TBigBays.MissileFactor(TechLevel: Integer): Integer;
begin
  if ((MissileBays > 0) and (not RefitMissileBays))
      or ((NewMissileBays > 0) and (RefitMissileBays)) then
  begin
    case (TechLevel) of
      0..6: Result := 0;
      7..9: Result := 7;
      10..11: Result := 8;
      else Result := 9;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TBigBays.RepulsorFactor(TechLevel: Integer): Integer;
begin
  if ((RepulsorBays > 0) and (not RefitRepulsorBays))
      or ((NewRepulsorBays > 0) and (RefitRepulsorBays)) then
  begin
    case TechLevel of
      0..9: Result := 0;
      10: Result := 2;
      11: Result := 4;
      12: Result := 6;
      13: Result := 7;
      14: Result := 8;
      else Result := 9;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TBigBays.PaFactor(TechLevel: Integer): Integer;
begin
  if ((PaBays > 0) and (not RefitPaBays))
      or ((NewPaBays > 0) and (RefitPaBays)) then
  begin
   case (TechLevel) of
      0..7: Result := 0;
      8..9: Result := 6;
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

end.
 
