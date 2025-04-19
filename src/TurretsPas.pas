unit TurretsPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, Math, ShipModulePas;

type

   { TTurrets }

   TTurrets = class(TWpnShipModule)
   private
      fEmptyTurrets : Integer;
      fEmptyTurretStyle : Integer;
      FEnergyTurretsRefitTech: Integer;
      FLaserTurretsRefitTech: Integer;
      fMissileTurrets : Integer;
      FMissileTurretsRefitTech: Integer;
      fMissileTurretStyle : Integer;
      fMissileBatteries : Integer;
      fLaserTurrets : Integer;
      fLaserTurretStyle : Integer;
      fLaserBatteries : Integer;
      fLaserType : Integer;
      fEnergyTurrets : Integer;
      fEnergyTurretStyle : Integer;
      fEnergyBatteries : Integer;
      fEnergyType : Integer;
      FMixTurretEnergy: Integer;
      FMixTurretsRefitTech: Integer;
      FNewEmptyMixTurrets: Integer;
      FNewEmptyTurrets: Integer;
      FNewEmptyTurretStyle: Integer;
      FNewEnergyTurrets: Integer;
      FNewEnergyTurretStyle: Integer;
      FNewEnergyType: Integer;
      FNewLaserTurrets: Integer;
      FNewLaserTurretStyle: Integer;
      FNewLaserType: Integer;
      FNewMissileTurrets: Integer;
      FNewMissileTurretStyle: Integer;
      FNewMixTurretEnergy: Integer;
      FNewMixTurretLasers: Integer;
      FNewMixTurretMissiles: Integer;
      FNewMixTurretSand: Integer;
      FNewMixTurretStyle: Integer;
      FNewNumMixTurrets: Integer;
      FNewPATurrets: Integer;
      FNewPATurretStyle: Integer;
      FNewSandTurrets: Integer;
      FNewSandTurretStyle: Integer;
      FPATurretsRefitTech: Integer;
      FRefitEmptyTurrets: Boolean;
      FRefitEnergyTurrets: Boolean;
      FRefitLaserTurrets: Boolean;
      FRefitMissileTurrets: Boolean;
      FRefitMixTurrets: Boolean;
      FRefitPATurrets: Boolean;
      FRefitSandTurrets: Boolean;
      fSandTurrets : Integer;
      FSandTurretsRefitTech: Integer;
      fSandTurretStyle : Integer;
      fSandBatteries : Integer;
      fPATurrets : Integer;
      fPATurretStyle : Integer;
      fPABatteries : Integer;
      fMixedTurrets : Integer;
      fNumMixTurrets : Integer;
      fEmptyMixTurrets : Integer;
      fMixTurretStyle : Integer;
      fMixTurretMissiles : Integer;
      fMixTurretLasers : Integer;
      fMixLaserType : Integer;
      fMixTurretSand : Integer;
      procedure CalcHardPoints;
      procedure SetEnergyTurretsRefitTech(const AValue: Integer);
      procedure SetLaserTurretsRefitTech(const AValue: Integer);
      procedure SetMissileTurretsRefitTech(const AValue: Integer);
      procedure SetMixTurretEnergy(const AValue: Integer);
      function CalcSandFactor(Wpns, TechLevel: Integer): Integer;
      function CalcPlasmaFactor(Wpns, TechLevel: Integer): Integer;
      function CalcFusionFactor(Wpns, TechLevel: Integer): Integer;
      function CalcPlaserFactor(Wpns, TechLevel: Integer): Integer;
      function CalcBlaserFactor(Wpns, TechLevel: Integer): Integer;
      function CalcPaFactor(Wpns, TechLevel: Integer): Integer;
      function CalcMissileFactor(Wpns, TechLevel: Integer): Integer;
      procedure SetMixTurretsRefitTech(const AValue: Integer);
      procedure SetNewEmptyMixTurrets(const AValue: Integer);
      procedure SetNewEmptyTurrets(const AValue: Integer);
      procedure SetNewEmptyTurretStyle(const AValue: Integer);
      procedure SetNewEnergyTurrets(const AValue: Integer);
      procedure SetNewEnergyTurretStyle(const AValue: Integer);
      procedure SetNewEnergyType(const AValue: Integer);
      procedure SetNewLaserTurrets(const AValue: Integer);
      procedure SetNewLaserTurretStyle(const AValue: Integer);
      procedure SetNewLaserType(const AValue: Integer);
      procedure SetNewMissileTurrets(const AValue: Integer);
      procedure SetNewMissileTurretStyle(const AValue: Integer);
      procedure SetNewMixTurretEnergy(const AValue: Integer);
      procedure SetNewMixTurretLasers(const AValue: Integer);
      procedure SetNewMixTurretMissiles(const AValue: Integer);
      procedure SetNewMixTurretSand(const AValue: Integer);
      procedure SetNewMixTurretStyle(const AValue: Integer);
      procedure SetNewNumMixTurrets(const AValue: Integer);
      procedure SetNewPATurrets(const AValue: Integer);
      procedure SetNewPATurretStyle(const AValue: Integer);
      procedure SetNewSandTurrets(const AValue: Integer);
      procedure SetNewSandTurretStyle(const AValue: Integer);
      procedure SetPATurretsRefitTech(const AValue: Integer);
      procedure SetRefitEmptyTurrets(const AValue: Boolean);
      procedure SetRefitEnergyTurrets(const AValue: Boolean);
      procedure SetRefitLaserTurrets(const AValue: Boolean);
      procedure SetRefitMissileTurrets(const AValue: Boolean);
      procedure SetRefitMixTurrets(const AValue: Boolean);
      procedure SetRefitPATurrets(const AValue: Boolean);
      procedure SetRefitSandTurrets(const AValue: Boolean);
      procedure SetSandTurretsRefitTech(const AValue: Integer);
   public
      function EmptyTurretCost(Race, ChgHP : Integer) : Extended;
      function EmptyTurretSpace(Race : Integer) : Extended;
      function MissileTurretCost(Race, ChgHP : Integer) : Extended;
      function MissileTurretSpace(Race : Integer) : Extended;
      function LaserTurretCost(Race, ChgHP : Integer) : Extended;
      function LaserTurretSpace(Race : Integer) : Extended;
      function EnergyTurretCost(Race, ChgHP : Integer) : Extended;
      function EnergyTurretSpace(Race : Integer) : Extended;
      function SandTurretCost(Race, ChgHP : Integer) : Extended;
      function SandTurretSpace(Race : Integer) : Extended;
      function PATurretCost(Race, TL, ChgHP : Integer) : Extended;
      function PATurretSpace(Race, TL : Integer) : Extended;
      function MixedTurretCost(Race, ChgHP : Integer) : Extended;
      function MixedTurretSpace(Race : Integer) : Extended;
      function MixBatteries(WpnStyle: Integer) : Integer;
      procedure CalcCrew(Rules : Integer; Size : Extended);
      procedure CalcPower;
      property EmptyTurrets : Integer read fEmptyTurrets write fEmptyTurrets;
      property EmptyTurretStyle : Integer read fEmptyTurretStyle write fEmptyTurretStyle;
      property MissileTurrets : Integer read fMissileTurrets write fMissileTurrets;
      property MissileTurretStyle : Integer read fMissileTurretStyle write fMissileTurretStyle;
      property MissileBatteries : Integer read fMissileBatteries write fMissileBatteries;
      property LaserTurrets : Integer read fLaserTurrets write fLaserTurrets;
      property LaserTurretStyle : Integer read fLaserTurretStyle write fLaserTurretStyle;
      property LaserBatteries : Integer read fLaserBatteries write fLaserBatteries;
      property LaserType : Integer read fLaserType write fLaserType;
      property EnergyTurrets : Integer read fEnergyTurrets write fEnergyTurrets;
      property EnergyTurretStyle : Integer read fEnergyTurretStyle write fEnergyTurretStyle;
      property EnergyBatteries : Integer read fEnergyBatteries write fEnergyBatteries;
      property EnergyType : Integer read fEnergyType write fEnergyType;
      property SandTurrets : Integer read fSandTurrets write fSandTurrets;
      property SandTurretStyle : Integer read fSandTurretStyle write fSandTurretStyle;
      property SandBatteries : Integer read fSandBatteries write fSandBatteries;
      property PATurrets : Integer read fPATurrets write fPATurrets;
      property PATurretStyle : Integer read fPATurretStyle write fPATurretStyle;
      property PABatteries : Integer read fPABatteries write fPABatteries;
      property MixedTurrets : Integer read fMixedTurrets write fMixedTurrets;
      property NumMixTurrets : Integer read fNumMixTurrets write fNumMixTurrets;
      property EmptyMixTurrets : Integer read fEmptyMixTurrets write fEmptyMixTurrets;
      property MixTurretStyle : Integer read fMixTurretStyle write fMixTurretStyle;
      property MixTurretMissiles : Integer read fMixTurretMissiles write fMixTurretMissiles;
      property MixTurretLasers : Integer read fMixTurretLasers write fMixTurretLasers;
      property MixLaserType : Integer read fMixLaserType write fMixLaserType;
      property MixTurretSand : Integer read fMixTurretSand write fMixTurretSand;
      property MixTurretEnergy: Integer read FMixTurretEnergy write SetMixTurretEnergy;
//(*
      property RefitEmptyTurrets: Boolean read FRefitEmptyTurrets write SetRefitEmptyTurrets;
      property RefitMissileTurrets: Boolean read FRefitMissileTurrets write SetRefitMissileTurrets;
      property RefitLaserTurrets: Boolean read FRefitLaserTurrets write SetRefitLaserTurrets;
      property RefitEnergyTurrets: Boolean read FRefitEnergyTurrets write SetRefitEnergyTurrets;
      property RefitSandTurrets: Boolean read FRefitSandTurrets write SetRefitSandTurrets;
      property RefitPATurrets: Boolean read FRefitPATurrets write SetRefitPATurrets;
      property MissileTurretsRefitTech: Integer read FMissileTurretsRefitTech write SetMissileTurretsRefitTech;
      property LaserTurretsRefitTech: Integer read FLaserTurretsRefitTech write SetLaserTurretsRefitTech;
      property EnergyTurretsRefitTech: Integer read FEnergyTurretsRefitTech write SetEnergyTurretsRefitTech;
      property SandTurretsRefitTech: Integer read FSandTurretsRefitTech write SetSandTurretsRefitTech;
      property PATurretsRefitTech: Integer read FPATurretsRefitTech write SetPATurretsRefitTech;
      property NewEmptyTurrets: Integer read FNewEmptyTurrets write SetNewEmptyTurrets;
      property NewMissileTurrets: Integer read FNewMissileTurrets write SetNewMissileTurrets;
      property NewLaserTurrets: Integer read FNewLaserTurrets write SetNewLaserTurrets;
      property NewEnergyTurrets: Integer read FNewEnergyTurrets write SetNewEnergyTurrets;
      property NewSandTurrets: Integer read FNewSandTurrets write SetNewSandTurrets;
      property NewPATurrets: Integer read FNewPATurrets write SetNewPATurrets;
      property NewEmptyTurretStyle: Integer read FNewEmptyTurretStyle write SetNewEmptyTurretStyle;
      property NewMissileTurretStyle: Integer read FNewMissileTurretStyle write SetNewMissileTurretStyle;
      property NewLaserTurretStyle: Integer read FNewLaserTurretStyle write SetNewLaserTurretStyle;
      property NewEnergyTurretStyle: Integer read FNewEnergyTurretStyle write SetNewEnergyTurretStyle;
      property NewSandTurretStyle: Integer read FNewSandTurretStyle write SetNewSandTurretStyle;
      property NewPATurretStyle: Integer read FNewPATurretStyle write SetNewPATurretStyle;
      property NewLaserType: Integer read FNewLaserType write SetNewLaserType;
      property NewEnergyType: Integer read FNewEnergyType write SetNewEnergyType;

      property RefitMixTurrets: Boolean read FRefitMixTurrets write SetRefitMixTurrets;
      property MixTurretsRefitTech: Integer read FMixTurretsRefitTech write SetMixTurretsRefitTech;
      property NewNumMixTurrets: Integer read FNewNumMixTurrets write SetNewNumMixTurrets;
      property NewEmptyMixTurrets: Integer read FNewEmptyMixTurrets write SetNewEmptyMixTurrets;
      property NewMixTurretStyle: Integer read FNewMixTurretStyle write SetNewMixTurretStyle;
      property NewMixTurretMissiles: Integer read FNewMixTurretMissiles write SetNewMixTurretMissiles;
      property NewMixTurretLasers: Integer read FNewMixTurretLasers write SetNewMixTurretLasers;
      property NewMixTurretSand: Integer read FNewMixTurretSand write SetNewMixTurretSand;
      property NewMixTurretEnergy: Integer read FNewMixTurretEnergy write SetNewMixTurretEnergy;
//*)
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignTurrets(ShipData : String);

      //usp stuff
      function SandFact(TechLevel: Integer): Integer;
      function LaserFact(TechLevel: Integer): Integer;
      function EnergyFact(TechLevel: Integer): Integer;
      function PaFact(TechLevel: Integer): Integer;
      function MissileFact(TechLevel: Integer): Integer;
   end;

var
   Turrets : TTurrets;

implementation

{ TTurrets }

procedure TTurrets.AssignDefaults(ShipData: String);
var
   Props : TStringList;
begin
   Props := TStringList.Create;
   try
      Props.CommaText := ShipData;
      Space := 0;
      Cost := 0;
      HardPoints := 0;
      EmptyTurrets := StrToInt(Props[0]);
      EmptyTurretStyle := StrToInt(Props[1]);
      MissileTurrets := StrToInt(Props[2]);
      MissileTurretStyle := StrToInt(Props[3]);
      MissileBatteries := StrToInt(Props[4]);
      LaserTurrets := StrToInt(Props[5]);
      LaserTurretStyle := StrToInt(Props[6]);
      LaserBatteries := StrToInt(Props[7]);
      LaserType := StrToInt(Props[8]);
      EnergyTurrets := StrToInt(Props[9]);
      EnergyTurretStyle := StrToInt(Props[10]);
      EnergyBatteries := StrToInt(Props[11]);
      EnergyType := StrToInt(Props[12]);
      SandTurrets := StrToInt(Props[13]);
      SandTurretStyle := StrToInt(Props[14]);
      SandBatteries := StrToInt(Props[15]);
      PATurrets := StrToInt(Props[16]);
      PATurretStyle := StrToInt(Props[17]);
      PABatteries := StrToInt(Props[18]);
      MixedTurrets := StrToInt(Props[19]);
      NumMixTurrets := StrToInt(Props[20]);
      EmptyMixTurrets := StrToInt(Props[21]);
      MixTurretStyle := StrToInt(Props[22]);
      MixTurretMissiles := StrToInt(Props[23]);
      MixTurretLasers := StrToInt(Props[24]);
      MixLaserType := StrToInt(Props[25]);
      MixTurretSand := StrToInt(Props[26]);
      MixTurretEnergy := StrToInt(Props[27]);
   finally
      FreeAndNil(Props);
   end;
end;

procedure TTurrets.CalcCrew(Rules: Integer; Size: Extended);
//calculate the gunnery crew

var
  SandGunners, LaserGunners, EnergyGunners, PAGunners, MissGunners, MixGunners: Integer;
begin
  CmdCrew := 0;
  Crew := 0;
  //a type of weapon may never require more gunners than turrets
  SandGunners := Min(SandTurrets, SandBatteries);
  LaserGunners := Min(LaserTurrets, LaserBatteries);
  EnergyGunners := Min(EnergyTurrets, EnergyBatteries);
  PAGunners := Min(PATurrets, PABatteries);
  MissGunners := Min(MissileTurrets, MissileBatteries);
  //book 2 crew
  if (Rules = 0) then
  begin
    CmdCrew := 0;
    if (MixedTurrets = 0) then
    begin
      if (Size < 100) then
      begin
        Crew := Max(0, ((MixTurretLasers * NumMixTurrets)
            + (MixTurretMissiles * NumMixTurrets)
            + (MixTurretEnergy * NumMixTurrets)
            + MixTurretSand * NumMixTurrets));
        //make sure only a max of one gunner per turret
        Crew := Min(NumMixTurrets, Crew);
      end
      else
      begin
        Crew := NumMixTurrets - EmptyMixTurrets;
      end;
    end
    else
    begin
      //small craft
      if (Size < 100) then
      begin
        Crew := Max(0, (SandGunners + LaserGunners + EnergyGunners
            + PAGunners + MissGunners));
        //make sure only a max of one gunner
        //Crew := Min(1, Crew);
      end
      else
      begin
        Crew := SandGunners + LaserGunners + EnergyGunners + PAGunners
            + MissGunners;
      end;
    end;
  end
  //book 5 crew
  else
  begin
    if (Size < 100) then
    begin
      if (MixedTurrets = 0) then
      begin
        //Crew := Max(0, (MixTurretLasers + MixTurretMissiles + MixTurretEnergy) - 1);
        MixGunners := 0;
        if (MixTurretLasers > 0) then Inc(MixGunners, NumMixTurrets);
        if (MixTurretMissiles > 0) then Inc(MixGunners, NumMixTurrets);
        if (MixTurretEnergy > 0) then Inc(MixGunners, NumMixTurrets);
        Dec(MixGunners, 1);
        Crew := Max(0, MixGunners);
      end
      else
      begin
        Crew := Max(0, (LaserGunners + EnergyGunners + PAGunners + MissGunners) - 1);
      end;
    end
    else
    begin
      if ((MissileBatteries + LaserBatteries + EnergyBatteries + SandBatteries
          + PABatteries) > 0) then
      begin
        CmdCrew := 1;
      end;
      Crew := SandGunners + LaserGunners + EnergyGunners + PAGunners
          + MissGunners;
    end;
  end;
  //make sure number of gunners does not exceed number of turrets
  //Crew := Min(Crew,
end;

procedure TTurrets.CalcHardPoints;
begin
  if (MixedTurrets = 0) then
  begin
    HardPoints := NumMixTurrets;
  end
  else
  begin
    HardPoints := (EmptyTurrets + MissileTurrets + LaserTurrets + EnergyTurrets + SandTurrets + PATurrets)
  end;
end;

procedure TTurrets.SetEnergyTurretsRefitTech(const AValue: Integer);
begin
  if FEnergyTurretsRefitTech=AValue then exit;
  FEnergyTurretsRefitTech:=AValue;
end;

procedure TTurrets.SetLaserTurretsRefitTech(const AValue: Integer);
begin
  if FLaserTurretsRefitTech=AValue then exit;
  FLaserTurretsRefitTech:=AValue;
end;

procedure TTurrets.SetMissileTurretsRefitTech(const AValue: Integer);
begin
  if FMissileTurretsRefitTech=AValue then exit;
  FMissileTurretsRefitTech:=AValue;
end;

procedure TTurrets.SetMixTurretEnergy(const AValue: Integer);
begin
  if FMixTurretEnergy=AValue then exit;
  FMixTurretEnergy:=AValue;
end;

function TTurrets.CalcSandFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1..2: Result := 1;
    3..5: Result := 2;
    6..7: Result := 3;
    8..9: Result := 4;
    10..19: Result := 5;
    20..29: Result := 6;
    else Result := 7;
  end;
  if (TechLevel > 7) and (Result > 0) then begin
    Inc(Result);
  end;
  if (TechLevel > 9) and (Result > 0) then begin
    Inc(Result);
  end;
end;

function TTurrets.CalcPlasmaFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1..3: Result := 1;
    4..9: Result := 2;
    10..15: Result := 3;
    16..19: Result := 4;
    else Result := 5;
  end;
  if (TechLevel > 10) and (Result > 0) then
  begin
    Inc(Result);
  end;
  if (TechLevel > 11) and (Result > 0) then
  begin
    Inc(Result);
  end;
end;

function TTurrets.CalcFusionFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1..3: Result := 4;
    4..9: Result := 5;
    10..15: Result := 6;
    16..19: Result := 7;
    else Result := 8;
  end;
  if (TechLevel > 13) and (Result > 0) then
  begin
    Inc(Result);
  end;
end;

function TTurrets.CalcPlaserFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1..2: Result := 1;
    3..5: Result := 2;
    6..9: Result := 3;
    10..20: Result := 4;
    21..29: Result := 5;
    else Result := 6;
  end;
  if (TechLevel > 12) and (Result > 0) then
  begin
    Inc(Result);
  end;
end;

function TTurrets.CalcBlaserFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1: Result := 1;
    2: Result := 2;
    3..5: Result := 3;
    6..9: Result := 4;
    10..14: Result := 5;
    15..20: Result := 6;
    21..29: Result := 7;
    else Result := 8;
  end;
  if (TechLevel > 12) and (Result > 0) then
  begin
    Inc(Result);
  end;
end;

function TTurrets.CalcPaFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1: Result := 1;
    2..3: Result := 2;
    4..5: Result := 3;
    6..7: Result := 4;
    8..9: Result := 5;
    else Result := 6;
  end;
  if (TechLevel > 14) and (Result > 0) then begin
    Inc(Result);
  end;
end;

function TTurrets.CalcMissileFactor(Wpns, TechLevel: Integer): Integer;
begin
  case (Wpns) of
    0: Result := 0;
    1..2: Result := 1;
    3..5: Result := 2;
    6..11: Result := 3;
    12..17: Result := 4;
    18..29: Result := 5;
    else Result := 6;
  end;
  if (TechLevel > 12) and (Result > 0) then
  begin
    Inc(Result);
  end;
end;

procedure TTurrets.SetMixTurretsRefitTech(const AValue: Integer);
begin
  if FMixTurretsRefitTech=AValue then exit;
  FMixTurretsRefitTech:=AValue;
end;

procedure TTurrets.SetNewEmptyMixTurrets(const AValue: Integer);
begin
  if FNewEmptyMixTurrets=AValue then exit;
  FNewEmptyMixTurrets:=AValue;
end;

procedure TTurrets.SetNewEmptyTurrets(const AValue: Integer);
begin
  if FNewEmptyTurrets=AValue then exit;
  FNewEmptyTurrets:=AValue;
end;

procedure TTurrets.SetNewEmptyTurretStyle(const AValue: Integer);
begin
  if FNewEmptyTurretStyle=AValue then exit;
  FNewEmptyTurretStyle:=AValue;
end;

procedure TTurrets.SetNewEnergyTurrets(const AValue: Integer);
begin
  if FNewEnergyTurrets=AValue then exit;
  FNewEnergyTurrets:=AValue;
end;

procedure TTurrets.SetNewEnergyTurretStyle(const AValue: Integer);
begin
  if FNewEnergyTurretStyle=AValue then exit;
  FNewEnergyTurretStyle:=AValue;
end;

procedure TTurrets.SetNewEnergyType(const AValue: Integer);
begin
  if FNewEnergyType=AValue then exit;
  FNewEnergyType:=AValue;
end;

procedure TTurrets.SetNewLaserTurrets(const AValue: Integer);
begin
  if FNewLaserTurrets=AValue then exit;
  FNewLaserTurrets:=AValue;
end;

procedure TTurrets.SetNewLaserTurretStyle(const AValue: Integer);
begin
  if FNewLaserTurretStyle=AValue then exit;
  FNewLaserTurretStyle:=AValue;
end;

procedure TTurrets.SetNewLaserType(const AValue: Integer);
begin
  if FNewLaserType=AValue then exit;
  FNewLaserType:=AValue;
end;

procedure TTurrets.SetNewMissileTurrets(const AValue: Integer);
begin
  if FNewMissileTurrets=AValue then exit;
  FNewMissileTurrets:=AValue;
end;

procedure TTurrets.SetNewMissileTurretStyle(const AValue: Integer);
begin
  if FNewMissileTurretStyle=AValue then exit;
  FNewMissileTurretStyle:=AValue;
end;

procedure TTurrets.SetNewMixTurretEnergy(const AValue: Integer);
begin
  if FNewMixTurretEnergy=AValue then exit;
  FNewMixTurretEnergy:=AValue;
end;

procedure TTurrets.SetNewMixTurretLasers(const AValue: Integer);
begin
  if FNewMixTurretLasers=AValue then exit;
  FNewMixTurretLasers:=AValue;
end;

procedure TTurrets.SetNewMixTurretMissiles(const AValue: Integer);
begin
  if FNewMixTurretMissiles=AValue then exit;
  FNewMixTurretMissiles:=AValue;
end;

procedure TTurrets.SetNewMixTurretSand(const AValue: Integer);
begin
  if FNewMixTurretSand=AValue then exit;
  FNewMixTurretSand:=AValue;
end;

procedure TTurrets.SetNewMixTurretStyle(const AValue: Integer);
begin
  if FNewMixTurretStyle=AValue then exit;
  FNewMixTurretStyle:=AValue;
end;

procedure TTurrets.SetNewNumMixTurrets(const AValue: Integer);
begin
  if FNewNumMixTurrets=AValue then exit;
  FNewNumMixTurrets:=AValue;
end;

procedure TTurrets.SetNewPATurrets(const AValue: Integer);
begin
  if FNewPATurrets=AValue then exit;
  FNewPATurrets:=AValue;
end;

procedure TTurrets.SetNewPATurretStyle(const AValue: Integer);
begin
  if FNewPATurretStyle=AValue then exit;
  FNewPATurretStyle:=AValue;
end;

procedure TTurrets.SetNewSandTurrets(const AValue: Integer);
begin
  if FNewSandTurrets=AValue then exit;
  FNewSandTurrets:=AValue;
end;

procedure TTurrets.SetNewSandTurretStyle(const AValue: Integer);
begin
  if FNewSandTurretStyle=AValue then exit;
  FNewSandTurretStyle:=AValue;
end;

procedure TTurrets.SetPATurretsRefitTech(const AValue: Integer);
begin
  if FPATurretsRefitTech=AValue then exit;
  FPATurretsRefitTech:=AValue;
end;

procedure TTurrets.SetRefitEmptyTurrets(const AValue: Boolean);
begin
  if FRefitEmptyTurrets=AValue then exit;
  FRefitEmptyTurrets:=AValue;
end;

procedure TTurrets.SetRefitEnergyTurrets(const AValue: Boolean);
begin
  if FRefitEnergyTurrets=AValue then exit;
  FRefitEnergyTurrets:=AValue;
end;

procedure TTurrets.SetRefitLaserTurrets(const AValue: Boolean);
begin
  if FRefitLaserTurrets=AValue then exit;
  FRefitLaserTurrets:=AValue;
end;

procedure TTurrets.SetRefitMissileTurrets(const AValue: Boolean);
begin
  if FRefitMissileTurrets=AValue then exit;
  FRefitMissileTurrets:=AValue;
end;

procedure TTurrets.SetRefitMixTurrets(const AValue: Boolean);
begin
  if FRefitMixTurrets=AValue then exit;
  FRefitMixTurrets:=AValue;
end;

procedure TTurrets.SetRefitPATurrets(const AValue: Boolean);
begin
  if FRefitPATurrets=AValue then exit;
  FRefitPATurrets:=AValue;
end;

procedure TTurrets.SetRefitSandTurrets(const AValue: Boolean);
begin
  if FRefitSandTurrets=AValue then exit;
  FRefitSandTurrets:=AValue;
end;

procedure TTurrets.SetSandTurretsRefitTech(const AValue: Integer);
begin
  if FSandTurretsRefitTech=AValue then exit;
  FSandTurretsRefitTech:=AValue;
end;

procedure TTurrets.CalcPower;
var
  EP : Extended;
begin
  EP := 0;
  if (MixedTurrets = 0) then
  begin
    Power := ((MixBatteries(MixTurretLasers)) * 1)
        + (MixBatteries(MixTurretEnergy) * (1 + EnergyType));
  end
  else begin
    EP := EP + (LaserTurrets * LaserTurretStyle) * 1;
    if (EnergyType = 0) then
    begin
      EP := EP + (EnergyTurrets * EnergyTurretStyle) * 1;
    end
    else
    begin
      EP := EP + (EnergyTurrets * EnergyTurretStyle) * 2;
    end;
    EP := EP + (PATurrets * PATurretStyle) * 5;
    Power := EP;
  end;
end;

procedure TTurrets.DesignTurrets(ShipData: String);
var
  ShipDetails : TStringList;
  TechLevel, Race, CrewRules, ChargeHP : Integer;
  Tonnage : Extended;
begin
  ShipDetails := TStringList.Create;
  try
    ShipDetails.CommaText := ShipData;
    TechLevel := StrToInt(ShipDetails[0]);
    Tonnage := StrToFloat(ShipDetails[1]);
    Race := StrToInt(ShipDetails[2]);
    CrewRules := StrToInt(ShipDetails[3]);
    ChargeHP := StrToInt(ShipDetails[6]);
    if (MixedTurrets = 0) then
    begin
      Cost := MixedTurretCost(Race, ChargeHP);
      Space := MixedTurretSpace(Race);
    end
    else
    begin
      Cost := (EmptyTurretCost(Race, ChargeHP) + MissileTurretCost(Race, ChargeHP)
          + LaserTurretCost(Race, ChargeHP) + EnergyTurretCost(Race, ChargeHP)
          + SandTurretCost(Race, ChargeHP) + PATurretCost(Race, TechLevel, ChargeHP));
      Space := (EmptyTurretSpace(Race) + MissileTurretSpace(Race)
          + LaserTurretSpace(Race) + EnergyTurretSpace(Race)
          + SandTurretSpace(Race) + PATurretSpace(Race, TechLevel));
    end;
    CalcCrew(CrewRules, Tonnage);
    CalcPower;
    CalcHardPoints;
  finally
    FreeAndNil(ShipDetails);
  end;
end;

function TTurrets.SandFact(TechLevel: Integer): Integer;
begin
  if (MixedTurrets = 0) then
  begin
    if (MixBatteries(MixTurretSand) > 0) and (MixTurretSand > 0) then
    begin
      Result := CalcSandFactor(1, TechLevel);
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    if (SandBatteries > 0) then
    begin
      Result := CalcSandFactor((SandTurrets div SandBatteries) * SandTurretStyle, TechLevel);
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TTurrets.LaserFact(TechLevel: Integer): Integer;
begin
  //mixed turrets
  if (MixBatteries(MixTurretLasers) > 0) and (MixTurretLasers > 0) then
  begin
    //beam laster
    //if (MixLaserType = 0) then
    if (LaserType = 0) then
    begin
      Result := CalcBlaserFactor(1, TechLevel);
    end
    else
    //pulse lasers
    begin
      Result := CalcPlaserFactor(1, TechLevel);
    end;
  end
  else
  begin
    if (LaserBatteries > 0) then
    begin
      //beam lasers
      if (LaserType = 0) then
      begin
        Result := CalcBlaserFactor(((LaserTurrets div LaserBatteries) * LaserTurretStyle), TechLevel)
      end
      else
      //pulse lasers
      begin
        Result := CalcPlaserFactor(((LaserTurrets div LaserBatteries) * LaserTurretStyle), TechLevel)
      end;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TTurrets.EnergyFact(TechLevel: Integer): Integer;
begin
  //mixed turrets
  if (MixedTurrets = 0) then
  begin
    if (MixBatteries(MixTurretEnergy) > 0) and (MixTurretEnergy > 0) then
    begin
      //plasma guns
      if (EnergyType = 0) then
      begin
        Result := CalcPlasmaFactor(1, TechLevel);
      end
      //fusion guns
      else
      begin
        Result := CalcFusionFactor(1, TechLevel);
      end;
    end
    else
    begin
      Result := 0;
    end;
  end
  //normal turrets
  else
  begin
    if (EnergyBatteries > 0) then
    begin
      //plasma guns
      if (EnergyType = 0) then
      begin
        Result := CalcPlasmaFactor((EnergyTurrets div EnergyBatteries) * EnergyTurretStyle, TechLevel);
      end
      else
      //fusion guns
      begin
        Result := CalcFusionFactor((EnergyTurrets div EnergyBatteries) * EnergyTurretStyle, TechLevel);
      end;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TTurrets.PaFact(TechLevel: Integer): Integer;
begin
  if (PaBatteries > 0) then
  begin
    Result := CalcPaFactor(((PaTurrets div PaBatteries) * PaTurretStyle), TechLevel);
  end
  else
  begin
    Result := 0;
  end;
end;

function TTurrets.MissileFact(TechLevel: Integer): Integer;
begin
  //mixed turrets
  if (MixedTurrets = 0) then
  begin
    if (MixBatteries(MixTurretMissiles) > 0) and (MixTurretMissiles > 0) then
    begin
      Result := CalcMissileFactor(1, TechLevel);
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    if (MissileBatteries > 0) then
    begin
      Result := CalcMissileFactor((MissileTurrets div MissileBatteries) * MissileTurretStyle, TechLevel);
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TTurrets.EmptyTurretCost(Race, ChgHP: Integer): Extended;
begin
   if (ChgHP = 0) then begin
      Result := 0;
   end
   else begin
      if (Race = 1) then begin
         case (EmptyTurretStyle) of
            0: Result := (0.1 * EmptyTurrets) * 2;
            1: Result := ((0.1 + 0.2) * EmptyTurrets) * 2;
            2: Result := ((0.1 + 0.5) * EmptyTurrets) * 2;
            3: Result := ((0.1 + 1) * EmptyTurrets) * 2;
         end;
      end
      else begin
         case (EmptyTurretStyle) of
            0: Result := 0.1 * EmptyTurrets;
            1: Result := (0.1 + 0.2) * EmptyTurrets;
            2: Result := (0.1 + 0.5) * EmptyTurrets;
            3: Result := (0.1 + 1) * EmptyTurrets;
         end;
      end;
   end;
end;

function TTurrets.EmptyTurretSpace(Race: Integer): Extended;
begin
  if (Race = 1) then
  begin
    Result := (EmptyTurrets * 1) * 2;
  end
  else
  begin
    Result := EmptyTurrets * 1;
  end;
end;

function TTurrets.EnergyTurretCost(Race, ChgHP: Integer): Extended;
var
   HPCost, WpnCost : Extended;
begin
   case (EnergyTurretStyle) of
      0: HPCost := (0.1 * EnergyTurrets);
      1: HPCost := ((0.1 + 0.5) * EnergyTurrets);
      2: HPCost := ((0.1 + 1) * EnergyTurrets);
   end;
   if (Race = 1) then begin
      HPCost := HPCost * 2;
   end;
   case (EnergyType) of
      0: if (Race = 1) then begin
           WpnCost := ((EnergyTurrets * EnergyTurretStyle) * 1.5) * 2;
         end
         else begin
            WpnCost := (EnergyTurrets * EnergyTurretStyle) * 1.5;
         end;
      1: if (Race = 1) then begin
           WpnCost := ((EnergyTurrets * EnergyTurretStyle) * 2) * 2;
         end
         else begin
            WpnCost := (EnergyTurrets * EnergyTurretStyle) * 2;
         end;
   end;
   if (ChgHP = 0) then begin
      Result := WpnCost;
   end
   else begin
      Result := WpnCost + HPCost;
   end;
end;

function TTurrets.EnergyTurretSpace(Race: Integer): Extended;
begin
   if (Race = 1) then begin
      Result := (EnergyTurrets * 2) * 2;
   end
   else begin
      Result := EnergyTurrets * 2;
   end;
end;

function TTurrets.LaserTurretCost(Race, ChgHP: Integer): Extended;
var
   HPCost, WpnCost : Extended;
begin
   case (LaserTurretStyle) of
      0: HPCost := (0.1 * LaserTurrets);
      1: HPCost := ((0.1 + 0.2) * LaserTurrets);
      2: HPCost := ((0.1 + 0.5) * LaserTurrets);
      3: HPCost := ((0.1 + 1) * LaserTurrets);
   end;
   if (Race = 1) then begin
      HPCost := HPCost * 2;
   end;
   Case (LaserType) of
   0: if (Race = 1) then begin
         WpnCost := ((LaserTurrets * LaserTurretStyle) * 1) * 2;
      end
      else begin
         WpnCost := (LaserTurrets * LaserTurretStyle) * 1;
      end;
   1: if (Race = 1) then begin
         WpnCost := ((LaserTurrets * LaserTurretStyle) * 0.5) * 2;
      end
      else begin
         WpnCost := (LaserTurrets * LaserTurretStyle) * 0.5;
      end;
   end;
   if (ChgHP = 0) then begin
      Result := WpnCost;
   end
   else begin
      Result := WpnCost + HPCost;
   end;
end;

function TTurrets.LaserTurretSpace(Race: Integer): Extended;
begin
   if (Race = 1) then begin
      Result := (LaserTurrets * 1) * 2;
   end
   else begin
      Result := LaserTurrets * 1;
   end;
end;

function TTurrets.MissileTurretCost(Race, ChgHP: Integer): Extended;
var
   HPCost, WpnCost : Extended;
begin
   case (MissileTurretStyle) of
      0: HPCost := (0.1 * MissileTurrets);
      1: HPCost := ((0.1 + 0.2) * MissileTurrets);
      2: HPCost := ((0.1 + 0.5) * MissileTurrets);
      3: HPCost := ((0.1 + 1) * MissileTurrets);
   end;
   if (Race = 1) then begin
      HPCost := HPCost * 2;
   end;
   if (Race = 1) then begin
      WpnCost := ((MissileTurrets * MissileTurretStyle) * 0.75) * 2;
   end
   else begin
      WpnCost := (MissileTurrets * MissileTurretStyle) * 0.75;
   end;
   if (ChgHP = 0) then begin
      Result := WpnCost;
   end
   else begin
      Result := WpnCost + HPCost;
   end;
end;

function TTurrets.MissileTurretSpace(Race: Integer): Extended;
begin
   if (Race = 1) then begin
      Result := (MissileTurrets * 1) * 2;
   end
   else begin
      Result := MissileTurrets * 1;
   end;
end;

function TTurrets.MixedTurretCost(Race, ChgHP: Integer): Extended;
var
  Price, HPCost, WpnCost : Extended;
begin
  case (MixTurretStyle) of
    0: HPCost := (0.1 * NumMixTurrets);
    1: HPCost := ((0.1 + 0.2) * NumMixTurrets);
    2: HPCost := ((0.1 + 0.5) * NumMixTurrets);
    3: HPCost := ((0.1 + 1) * NumMixTurrets);
  end;
  if (Race = 1) then
  begin
    HPCost := HPCost * 2;
  end;
  Price := 0;
  Price := Price + (MixBatteries(MixTurretMissiles) * 0.75);
  //if (MixLaserType = 0) then begin
  if (LaserType = 0) then
  begin
    Price := Price + (MixBatteries(MixTurretLasers) * 1);
  end
  else
  begin
    Price := Price + (MixBatteries(MixTurretLasers) * 0.5);
  end;
  if (EnergyType = 0) then
  begin
    Price := Price + (MixBatteries(MixTurretEnergy) * 1.5)
  end
  else
  begin
    Price := Price + (MixBatteries(MixTurretEnergy) * 2)
  end;
  Price := Price + (MixBatteries(MixTurretSand)) * 0.25;
  if (Race = 1) then
  begin
    WpnCost := Price * 2;
  end
  else
  begin
    WpnCost := Price;
  end;
  if (ChgHP = 0) then
  begin
    Result := WpnCost;
  end
  else
  begin
    Result := WpnCost + HPCost;
  end;
end;

function TTurrets.MixedTurretSpace(Race: Integer): Extended;
var
  MixedSpace: Integer;
begin
  MixedSpace := 0;
  //if there are energy weapons 2 tons per turret
  if (MixTurretEnergy > 0) then
  begin
    MixedSpace := (NumMixTurrets) * 2;
  end
  //otherwise 1 ton per turret
  else
  begin
    MixedSpace := NumMixTurrets * 1;
  end;
  //if its Kkree multiply by 2
  if (Race = 1) then
  begin
    MixedSpace := MixedSpace * 2;
  end;
  Result :=  MixedSpace;
  (*if (Race = 1) then
  begin
    Result := (NumMixTurrets * 1) * 2;
  end
  else
  begin
    Result := NumMixTurrets * 1;
  end;*)
end;

function TTurrets.MixBatteries(WpnStyle: Integer): Integer;
begin
   Result := (NumMixTurrets - EmptyMixTurrets) * WpnStyle;
end;

function TTurrets.PATurretCost(Race, TL, ChgHP: Integer): Extended;
var
   HPCost, WpnCost : Extended;
begin
   case (PATurretStyle) of
      0: HPCost := (0.1 * PATurrets);
      1: if (TL < 15) then begin
            HPCost := ((0.1 + 1.5) * PATurrets);
         end
         else begin
            HPCost := ((0.1 + 1) * PATurrets);
         end;
   end;
   if (Race = 1) then begin
      HPCost := HPCost * 2;
   end;
   if (TL < 15) then begin
      if (Race = 1) then begin
         WpnCost := ((PATurrets * PATurretStyle) * 4) * 2;
      end
      else begin
         WpnCost := (PATurrets * PATurretStyle) * 4;
      end;
   end
   else begin
      if (Race = 1) then begin
         WpnCost := ((PATurrets * PATurretStyle) * 3) * 2;
      end
      else begin
         WpnCost := (PATurrets * PATurretStyle) * 3;
      end;
   end;
   if (ChgHP = 0) then begin
      Result := WpnCost;
   end
   else begin
      Result := WpnCost + HPCost;
   end;
end;

function TTurrets.PATurretSpace(Race, TL: Integer): Extended;
begin
   if (TL < 15) then begin
      if (Race = 1) then begin
         Result := (PATurrets * 5) * 2;
      end
      else begin
         Result := PATurrets * 5;
      end;
   end
   else begin
      if (Race = 1) then begin
         Result := (PATurrets * 3) * 2;
      end
      else begin
         Result := PATurrets * 3;
      end;
   end;
end;

function TTurrets.SandTurretCost(Race, ChgHP: Integer): Extended;
var
   HPCost, WpnCost : Extended;
begin
   case (SandTurretStyle) of
      0: HPCost := (0.1 * SandTurrets);
      1: HPCost := ((0.1 + 0.2) * SandTurrets);
      2: HPCost := ((0.1 + 0.5) * SandTurrets);
      3: HPCost := ((0.1 + 1) * SandTurrets);
   end;
   if (Race = 1) then begin
      HPCost := HPCost * 2;
   end;
   if (Race = 1) then begin
      WpnCost := ((SandTurrets * SandTurretStyle) * 0.25) * 2;
   end
   else begin
      WpnCost := (SandTurrets * SandTurretStyle) * 0.25;
   end;
   if (ChgHP = 0) then begin
      Result := WpnCost;
   end
   else begin
      Result := WpnCost + HPCost;
   end;
end;

function TTurrets.SandTurretSpace(Race: Integer): Extended;
begin
   if (Race = 1) then begin
      Result := (SandTurrets * 1) * 2;
   end
   else begin
      Result := SandTurrets * 1;
   end;
end;

end.

