unit AnalysisPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, Math, DataPas, ShipModulePas;

type
   TAnalysis = class(TShipExporter)
   private
      fSizeCode : String;
      fCrewCode : String;
      fSandFact : String;
      fSandBat : Integer;
      fSandBatBear : Integer;
      fRepulseFact : String;
      fRepulseBat : Integer;
      fRepulseBatBear : Integer;
      fLaserFact : String;
      fLaserBat : Integer;
      fLaserBatBear : Integer;
      fEnergyFact : String;
      fEnergyBat : Integer;
      fEnergyBatBear : Integer;
      fPAFact : String;
      fPABat : Integer;
      fPABatBear : Integer;
      fMesGunFact : String;
      fMesGunBat : Integer;
      fMesGunBatBear : Integer;
      fMissileFact : String;
      fMissileBat : Integer;
      fMissileBatBear : Integer;
      fShipCost : String;
      fDisp : String;
      function FloatToIntDown(TheFloat: Extended): Integer;
      function FloatToIntUp(TheFloat: Extended): Integer;
      function BatBear : Extended;
      function CalcSizeCode : String;
      function CalcCrewCode : String;
      function CalcSandFact(Turrs, Wpns : Integer) : String;
      function CalcRepulseFact : String;
      function CalcLaserFact(Turrs, Wpns, LaserType : Integer) : String;
      function CalcEnergyBayFact(EnergyType : Integer) : String;
      function CalcEnergyTurretFact(Turrs, Wpns, EnergyType : Integer) : String;
      function CalcPASpinalFact : String;
      function CalcPABigBayFact : String;
      function CalcPALittleBayFact : String;
      function CalcPATurretFact(Turrs, Wpns : Integer) : String;
      function CalcMesonSpinalFact : String;
      function CalcMesonBigBayFact : String;
      function CalcMesonLittleBayFact : String;
      function CalcMissileBigBayFact : String;
      function CalcMissileLittleBayFact : String;
      function CalcMissileTurretFact(Turrs, Wpns : Integer) : String;
      function CalcShipCost : String;
      function CalcDisp : String;
   public
      property SizeCode : String read fSizeCode write fSizeCode;
      property CrewCode : String read fCrewCode write fCrewCode;
      property SandFact : String read fSandFact write fSandFact;
      property SandBat : Integer read fSandBat write fSandBat;
      property SandBatBear : Integer read fSandBatBear write fSandBatBear;
      property RepulseFact : String read fRepulseFact write fRepulseFact;
      property RepulseBat : Integer read fRepulseBat write fRepulseBat;
      property RepulseBatBear : Integer read fRepulseBatBear write fRepulseBatBear;
      property LaserFact : String read fLaserFact write fLaserFact;
      property LaserBat : Integer read fLaserBat write fLaserBat;
      property LaserBatBear : Integer read fLaserBatBear write fLaserBatBear;
      property EnergyFact : String read fEnergyFact write fEnergyFact;
      property EnergyBat : Integer read fEnergyBat write fEnergyBat;
      property EnergyBatBear : Integer read fEnergyBatBear write fEnergyBatBear;
      property PAFact : String read fPAFact write fPAFact;
      property PABat : Integer read fPABat write fPABat;
      property PABatBear : Integer read fPABatBear write fPABatBear;
      property MesGunFact : String read fMesGunFact write fMesGunFact;
      property MesGunBat : Integer read fMesGunBat write fMesGunBat;
      property MesGunBatBear : Integer read fMesGunBatBear write fMesGunBatBear;
      property MissileFact : String read fMissileFact write fMissileFact;
      property MissileBat : Integer read fMissileBat write fMissileBat;
      property MissileBatBear : Integer read fMissileBatBear write fMissileBatBear;
      property ShipCost : String read fShipCost write fShipCost;
      property Disp : String read fDisp write fDisp;
      constructor Create;
      procedure Analyise(ShipIndex : Integer);
   end;

var
   Analysis : TAnalysis;

implementation

uses
   ShipPas, HullPas, EngPas, FuelPas, AvionicsPas, SpinalMountPas, BigBaysPas,
   LittleBaysPas, TurretsPas, ScreensPas, CraftPas, AccomPas, SquadronPas;

{ TAnalysis }

procedure TAnalysis.Analyise(ShipIndex: Integer);
//analyise the ship and produce the USP factors
var
  TheShip: TShip;
  EnType: Integer;
begin
  try
    if (ShipIndex > 0) then
    begin
      TheShip := Squadron.ShipList[ShipIndex];
    end
    else
    begin
      TheShip := Ship;
    end;
    SizeCode := CalcSizeCode;
    CrewCode := CalcCrewCode;
    //Sandcasters
    if (Ship.Turrets.MixedTurrets = 0) then
    begin
      SandFact := CalcSandFact(1, Ship.Turrets.MixTurretSand);
    end
    else begin
      if (Ship.Turrets.SandBatteries > 0) then
      begin
        SandFact := CalcSandFact((Ship.Turrets.SandTurrets
            div Ship.Turrets.SandBatteries), Ship.Turrets.SandTurretStyle);
      end
      else
      begin
        SandFact := '0';
      end;
    end;
    if (Ship.Turrets.MixedTurrets = 0) and (Ship.Turrets.MixTurretSand > 0) then
    begin
      SandBat := (Ship.Turrets.NumMixTurrets - Ship.Turrets.EmptyMixTurrets);
    end
    else
    begin
      SandBat := Ship.Turrets.SandBatteries;
    end;
    if (SandBat > 0) then
    begin
      SandBatBear := Max(1, Round(SandBat * BatBear));
    end
    else begin
      SandBatBear := 0;
    end;
    //Repulsors
    RepulseFact := CalcRepulseFact;
    if ((Ship.BigBays.RepulsorBays > 0) and (not Ship.BigBays.RefitRepulsorBays)) then
    begin
      RepulseBat := Ship.BigBays.RepulsorBays;
    end
    else if ((Ship.BigBays.NewRepulsorBays > 0) and (Ship.BigBays.RefitRepulsorBays)) then
    begin
      RepulseBat := Ship.BigBays.NewRepulsorBays;
    end
    else if (Ship.LittleBays.RepulsorBays > 0) and (not Ship.LittleBays.RefitRepulsorBays) then
    begin
      RepulseBat := Ship.LittleBays.RepulsorBays;
    end
    else if (Ship.LittleBays.NewRepulsorBays > 0) and (Ship.LittleBays.RefitRepulsorBays) then
    begin
      RepulseBat := Ship.LittleBays.NewRepulsorBays;
    end
    else
    begin
      RepulseBat := 0;
    end;
    if (RepulseBat > 0) then
    begin
      RepulseBatBear := Max(1, Round(RepulseBat * BatBear));
    end
    else
    begin
      RepulseBatBear := 0;
    end;
    //Lasers
    if (Ship.Turrets.MixedTurrets = 0) then
    begin
      //LaserFact := CalcLaserFact(1, Ship.Turrets.MixTurretLasers, Ship.Turrets.MixLaserType);
      LaserFact := CalcLaserFact(1, Ship.Turrets.MixTurretLasers, Ship.Turrets.LaserType);
    end
    else
    begin
      if (Ship.Turrets.LaserBatteries > 0) then
      begin
        LaserFact := CalcLaserFact((Ship.Turrets.LaserTurrets
            div Ship.Turrets.LaserBatteries), Ship.Turrets.LaserTurretStyle,
            Ship.Turrets.LaserType);
      end
      else
      begin
         LaserFact := '0';
      end;
    end;
    if (Ship.Turrets.MixedTurrets = 0) and (Ship.Turrets.MixTurretLasers > 0) then
    begin
      LaserBat := (Ship.Turrets.NumMixTurrets - Ship.Turrets.EmptyMixTurrets);
    end
    else begin
      LaserBat := Ship.Turrets.LaserBatteries;
    end;
    if (LaserBat > 0) then
    begin
      LaserBatBear := Max(1, Round(LaserBat * BatBear));
    end
    else
    begin
      LaserBatBear := 0;
    end;
    //Energy Weapons
    if (Ship.LittleBays.RefitEnergyBays) then EnType := Ship.LittleBays.NewEnergyType
        else EnType := Ship.LittleBays.EnergyType;
    if (Ship.LittleBays.EnergyBays > 0) and (not Ship.LittleBays.RefitEnergyBays) then
    begin
      EnergyFact := CalcEnergyBayFact(EnType);
      EnergyBat := Ship.LittleBays.EnergyBays;
    end
    else if (Ship.LittleBays.NewEnergyBays > 0) and (Ship.LittleBays.RefitEnergyBays) then
    begin
      EnergyFact := CalcEnergyBayFact(EnType);
      EnergyBat := Ship.LittleBays.NewEnergyBays;
    end
    else
    begin
      if (Ship.Turrets.EnergyBatteries > 0) then
      begin
        EnergyFact := CalcEnergyTurretFact((Ship.Turrets.EnergyTurrets
            div Ship.Turrets.EnergyBatteries), Ship.Turrets.EnergyTurretStyle,
            Ship.Turrets.EnergyType);
      end
      else
      begin
        EnergyFact := '0';
      end;
      EnergyBat := Ship.Turrets.EnergyBatteries;
    end;
    if (EnergyBat > 0) then
    begin
      EnergyBatBear := Max(1, Round(EnergyBat * BatBear));
    end
    else
    begin
       EnergyBatBear := 0;
    end;
    //Partical Accelerators
    if ((Ship.SpinalMount.SpinalType = 2) and (not Ship.SpinalMount.RefitSpinalMount))
        or ((Ship.SpinalMount.NewSpinalType = 2) and (Ship.SpinalMount.RefitSpinalMount)) then
    begin
      PAFact := CalcPASpinalFact;
      PABat := 1;
    end
    else if ((Ship.BigBays.PABays > 0) and (not Ship.BigBays.RefitPaBays))
        or ((Ship.BigBays.NewPaBays > 0) and (Ship.BigBays.RefitPaBays)) then
    begin
      PAFact := CalcPABigBayFact;
      if (Ship.BigBays.RefitPaBays) then
      begin
        PaBat := Ship.BigBays.NewPaBays;
      end
      else
      begin
        PaBat := Ship.BigBays.PaBays;
      end;
    end
    else if ((Ship.LittleBays.PABays > 0) and (not Ship.LittleBays.RefitPaBays))
        or ((Ship.LittleBays.NewPaBays > 0) and (Ship.LittleBays.RefitPaBays)) then
    begin
      PAFact := CalcPALittleBayFact;
      if (Ship.LittleBays.RefitPaBays) then
      begin
        PaBat := Ship.LittleBays.NewPaBays;
      end
      else
      begin
        PaBat := Ship.LittleBays.PaBays;
      end;
    end
    else
    begin
      if (Ship.Turrets.PABatteries > 0) then begin
        PAFact := CalcPATurretFact((Ship.Turrets.PATurrets
             div Ship.Turrets.PABatteries), Ship.Turrets.PATurretStyle);
      end
      else
      begin
        PAFact := '0';
      end;
      PABat := Ship.Turrets.PABatteries;
    end;
    if (PABat > 0) then
    begin
      PABatBear := Max(1, Round(PABat * BatBear));
    end
    else
    begin
      PABatBear := 0;
    end;
    //Meson Guns
    if ((Ship.SpinalMount.SpinalType = 1) and (not Ship.SpinalMount.RefitSpinalMount))
        or ((Ship.SpinalMount.NewSpinalType = 1) and (Ship.SpinalMount.RefitSpinalMount)) then
    begin
      MesGunFact := CalcMesonSpinalFact;
      MesGunBat := 1;
    end
    else if ((Ship.BigBays.MesonBays > 0) and (not Ship.BigBays.RefitMesonBays))
        or ((Ship.BigBays.NewMesonBays > 0) and (Ship.BigBays.RefitMesonBays)) then
    begin
      MesGunFact := CalcMesonBigBayFact;
      if (Ship.BigBays.RefitMesonBays) then
      begin
        MesGunBat := Ship.BigBays.NewMesonBays;
      end
      else
      begin
        MesGunBat := Ship.BigBays.MesonBays;
      end;
    end
    else if ((Ship.LittleBays.MesonBays > 0) and (not Ship.LittleBays.RefitMesonBays))
        or ((Ship.LittleBays.NewMesonBays > 0) and (Ship.LittleBays.RefitMesonBays)) then
    begin
      MesGunFact := CalcMesonLittleBayFact;
      if (Ship.LittleBays.RefitMesonBays) then
      begin
        MesGunBat := Ship.LittleBays.NewMesonBays;
      end
      else
      begin
        MesGunBat := Ship.LittleBays.MesonBays;
      end;
    end
    else
    begin
      MesGunFact := '0';
      MesGunBat := 0;
    end;
    if (MesGunBat > 0) then
    begin
      MesGunBatBear := Max(1, Round(MesGunBat * BatBear));
    end
    else
    begin
      MesGunBatBear := 0;
    end;
    //Missiles
    if ((Ship.BigBays.MissileBays > 0) and (not Ship.BigBays.RefitMissileBays))
        or ((Ship.BigBays.NewMissileBays > 0) and (Ship.BigBays.RefitMissileBays)) then
    begin
      MissileFact := CalcMissileBigBayFact;
      if (Ship.BigBays.RefitMissileBays) then
      begin
        MissileBat := Ship.BigBays.NewMissileBays;
      end
      else
      begin
        MissileBat := Ship.BigBays.MissileBays;
      end;
    end
    else if ((Ship.LittleBays.MissileBays > 0) and (not Ship.LittleBays.RefitMissileBays))
        or ((Ship.LittleBays.NewMissileBays > 0) and (Ship.LittleBays.RefitMissileBays)) then
    begin
      MissileFact := CalcMissileLittleBayFact;
      if (Ship.LittleBays.RefitMissileBays) then
      begin
        MissileBat := Ship.LittleBays.NewMissileBays;
      end
      else
      begin
        MissileBat := Ship.LittleBays.MissileBays;
      end;
    end
    else begin
      if (Ship.Turrets.MixedTurrets = 0) and (Ship.Turrets.MixTurretMissiles > 0) then begin
        MissileFact := CalcMissileTurretFact(1, Ship.Turrets.MixTurretMissiles);
        MissileBat := (Ship.Turrets.NumMixTurrets - Ship.Turrets.EmptyMixTurrets);
      end
      else begin
        if (Ship.Turrets.MissileBatteries > 0) then
        begin
          MissileFact := CalcMissileTurretFact((Ship.Turrets.MissileTurrets div
              Ship.Turrets.MissileBatteries), Ship.Turrets.MissileTurretStyle);
        end
        else
        begin
          MissileFact := '0';
        end;
        MissileBat := Ship.Turrets.MissileBatteries;
      end;
    end;
    if (MissileBat > 0) then
    begin
      MissileBatBear := Max(1, Round(MissileBat * BatBear));
    end
    else
    begin
      MissileBatBear := 0;
    end;
    //Other stuff
    ShipCost := CalcShipCost;
    Disp := CalcDisp;
   finally
     //
   end;
end;

function TAnalysis.BatBear: Extended;
//work out how many batteries are bearing

begin
   case (FloatToIntDown(Ship.Tonnage / 100)) of
      0..199: Result := 1;
      200..299: Result := 0.95;
      300..399: Result := 0.9;
      400..499: Result := 0.85;
      500..749: Result := 0.8;
      750..999: Result := 0.75;
      1000..1999: Result := 0.7;
      2000..2999: Result := 0.65;
      3000..3999: Result := 0.6;
      4000..4999: Result := 0.55;
      else Result := 0.5;
   end;
end;

function TAnalysis.CalcCrewCode: String;
//the crew code. Crew can't be bigger than 899,999,999
//mind you thats bigger than most planets!

begin
  case (Ship.GetTotalCmdCrew + Ship.GetTotalCrew) of
    0: Result := '0';
    1..9: Result := '1';
    10..99: Result := '2';
    100..999: Result := '3';
    1000..9999: Result := '4';
    10000..99999: Result := '5';
    100000..999999: Result := '6';
    1000000..9999999: Result := '7';
    10000000..99999999: Result := '8';
(*    100000000..899999999: Result := '9';  //var overflow after here
    900000000..999999999: Result := '9';
    1000000000..9999999999: Result := 'A';
    10000000000..99999999999: Result := 'B';
    100000000000..999999999999: Result := 'C';
    1000000000000..9999999999999: Result := 'D';
    10000000000000..99999999999999: Result := 'E';
    100000000000000..999999999999999: Result := 'F;
    1000000000000000..9999999999999999: Result := 'G';*)
  end;
end;

function TAnalysis.CalcDisp: String;
//work out how to report the ships displacement

begin
  if (Ship.Tonnage < 1000) then
  begin
    Result := FloatToStr(Ship.Tonnage) + ' Tons';
  end
  else if (Ship.Tonnage < 1000000) then
  begin
    Result := FloatToStr(Ship.Tonnage / 1000) + ' KTons';
  end
  else
  begin
    Result := FloatToStr(Ship.Tonnage / 1000000) + ' MTons';
  end;
end;

function TAnalysis.CalcEnergyBayFact(EnergyType: Integer): String;
//calculate the energy factor for bays
var
  iTech: Integer;
begin
  if (Ship.LittleBays.RefitEnergyBays) then iTech := Ship.LittleBays.EnergyBaysRefitTech
      else iTech := Ship.TechLevel;
  //plasma gund
  if (EnergyType = 0) then begin
    case (iTech) of
      0..9: Result := '0';
      10: Result := '4';
      11: Result := '5';
      else Result := '6';
    end;
  end
  //fusion guns
  else if (EnergyType = 1) then begin
    case (iTech) of
      0..11: Result := '0';
      12: Result := '7';
      13: Result := '8';
      else Result := '9';
    end;
  end;
end;

function TAnalysis.CalcEnergyTurretFact(Turrs, Wpns, EnergyType: Integer): String;
//calculate the factor for energy turrets

var
   Fact : Integer;
begin
   try
      Fact := 0;
      //plasma guns
      if (EnergyType = 0) then begin
         case (Turrs * Wpns) of
            0: Fact := 0;
            1..3: Fact := 1;
            4..9: Fact := 2;
            10..15: Fact := 3;
            16..19: Fact := 4;
            else Fact := 5;
         end;
         if (Ship.TechLevel > 10) and (Fact > 0) then begin
            Inc(Fact);
         end;
         if (Ship.TechLevel > 11) and (Fact > 0) then begin
            Inc(Fact);
         end;
         Result := IntToStr(Fact);
      end
      //fusion guns
      else begin
         case (Turrs * Wpns) of
            0: Fact := 0;
            1..3: Fact := 4;
            4..9: Fact := 5;
            10..15: Fact := 6;
            16..19: Fact := 7;
            else Fact := 8;
         end;
         if (Ship.TechLevel > 13) and (Fact > 0) then begin
            Inc(Fact);
         end;
         Result := IntToStr(Fact);
      end;
   except
      On EDivByZero do Result := '0';
   end;
end;

function TAnalysis.CalcLaserFact(Turrs, Wpns, LaserType: Integer): String;
//calculate the factor for lasers

var
  Fact : Integer;
begin
  try
    Fact := 0;
    //beam lasers
    if (LaserType = 0) then begin
      case (Turrs * Wpns) of
        0: Fact := 0;
        1: Fact := 1;
        2: Fact := 2;
        3..5: Fact := 3;
        6..9: Fact := 4;
        10..14: Fact := 5;
        15..20: Fact := 6;
        21..29: Fact := 7;
        else Fact := 8;
      end;
      if (Ship.TechLevel > 12) and (Fact > 0) then begin
        Inc(Fact);
      end;
      Result := IntToStr(Fact);
    end
    //pulse lasers
    else begin
      case (Turrs * Wpns) of
        0: Fact := 0;
        1..2: Fact := 1;
        3..5: Fact := 2;
        6..9: Fact := 3;
        10..20: Fact := 4;
        21..29: Fact := 5;
        else Fact := 6;
      end;
      if (Ship.TechLevel > 12) and (Fact > 0) then begin
        Inc(Fact);
      end;
      Result := IntToStr(Fact);
    end;
  except
    On EDivByZero do Result := '0';
  end;
end;

function TAnalysis.CalcMesonBigBayFact: String;
//calculate the factor for 100t meson bays
var
  iTech: Integer;
begin
  if (Ship.BigBays.RefitMesonBays) then iTech := Ship.BigBays.MesonBaysRefitTech
      else iTech := Ship.TechLevel;
  case (iTech) of
    0..12: Result := '0';
    13: Result := '3';
    14: Result := '5';
    else Result := '9';
  end;
end;

function TAnalysis.CalcMesonLittleBayFact: String;
//calculate the factor for 50t meson bays
var
  iTech: Integer;
begin
  if (Ship.LittleBays.RefitMesonBays) then iTech := Ship.LittleBays.MesonBaysRefitTech
      else iTech := Ship.TechLevel;
  case (iTech) of
    0..14: Result := '0';
    else Result := '4';
  end;
end;

function TAnalysis.CalcMesonSpinalFact: String;
//calculate the factor for spinal meson guns

//var
   //Data : TData;
begin
   //Data := TData.Create;
   try
      //Data.InitialiseData;
      //Result := Data.GetSpnlMesData(1, Ship.SpinalMount.SpinalMount)[1];
      Result := Ship.SpinalMount.SpinalMesonFactor;
   finally
      //FreeAndNil(Data);
   end;
end;

function TAnalysis.CalcMissileBigBayFact: String;
//calculate the factor for 100t missile bays
var
  iTech: Integer;
begin
  if (Ship.BigBays.RefitMissileBays) then iTech := Ship.BigBays.MissileBaysRefitTech
      else iTech := Ship.TechLevel;
  case (iTech) of
    0..6: Result := '0';
    7..9: Result := '7';
    10..11: Result := '8';
    else Result := '9';
  end;
end;

function TAnalysis.CalcMissileLittleBayFact: String;
//calculate the factor for 50t missile bays

var
  iTech: Integer;
begin
  if (Ship.LittleBays.RefitMissileBays) then iTech := Ship.LittleBays.MissileBaysRefitTech
      else iTech := Ship.TechLevel;
  case (iTech) of
    0..9: Result := '0';
    10..11: Result := '7';
    12..13: Result := '8';
    else Result := '9';
  end;
end;

function TAnalysis.CalcMissileTurretFact(Turrs, Wpns: Integer): String;
//calculate the factors for missile turrets

var
   Fact : Integer;
begin
   try
      Fact := 0;
      case (Turrs * Wpns) of
         0: Fact := 0;
         1..2: Fact := 1;
         3..5: Fact := 2;
         6..11: Fact := 3;
         12..17: Fact := 4;
         18..29: Fact := 5;
         else Fact := 6;
      end;
      if (Ship.TechLevel > 12) and (Fact > 0) then begin
         Inc(Fact);
      end;
      Result := IntToStr(Fact);
   except
      On EDivByZero do Result := '0';
   end
end;

function TAnalysis.CalcPABigBayFact: String;
//calculate the factor for 100t pa bays
var
  iTech: Integer;
begin
  if (Ship.BigBays.RefitPaBays) then iTech := Ship.BigBays.PaBaysRefitTech
      else iTech := Ship.TechLevel;
  case (iTech) of
    0..7: Result := '0';
    8..9: Result := '6';
    10..11: Result := '7';
    12..13: Result := '8';
    else Result := '9';
  end;
end;

function TAnalysis.CalcPALittleBayFact: String;
//calculate the factor for 50t pa bays
var
  iTech: Integer;
begin
  if (Ship.LittleBays.RefitPaBays) then iTech := Ship.LittleBays.PaBaysRefitTech
      else iTech := Ship.TechLevel;
  case (iTech) of
    0..9: Result := '0';
    10..11: Result := '3';
    12..13: Result := '4';
    else Result := '5';
  end;
end;

function TAnalysis.CalcPASpinalFact: String;
//calculate the factor for spinal pa's

//var
   //Data : TData;
begin
   //Data := TData.Create;
   try
      //Data.InitialiseData;
      Result := Ship.SpinalMount.SpinalPAFactor;
   finally
      //FreeAndNil(Data);
   end;
end;

function TAnalysis.CalcPATurretFact(Turrs, Wpns: Integer): String;
//calculate the factor for pa turrets

var
   Fact : Integer;
begin
   try
      Fact := 0;
      case (Turrs * Wpns) of
         0: Fact := 0;
         1: Fact := 1;
         2..3: Fact := 2;
         4..5: Fact := 3;
         6..7: Fact := 4;
         8..9: Fact := 5;
         else Fact := 6;
      end;
      if (Ship.TechLevel > 14) and (Fact > 0) then begin
         Inc(Fact);
      end;
      Result := IntToStr(Fact);
   except
      On EDivByZero do Result := '0';
   end
end;

function TAnalysis.CalcShipCost: String;
//calculate how to report the ship's cost

var
  Cost : Extended;
begin
  Cost := Ship.Price + Ship.CraftCost;
  if (Cost < 1000000) then
  begin
    Result := 'MCr ' + FloatToStrF(Cost, ffNumber, 18, 3);
  end
  else if (Cost < 1000000000) then
  begin
    Result := 'GCr ' + FloatToStrF(Cost / 1000, ffNumber, 18, 3);
  end
  else
  begin
    Result := 'TCr ' + FloatToStrF(Cost / 1000000, ffNumber, 18, 3);
  end;
end;

function TAnalysis.CalcRepulseFact: String;
//calculate the repulsor factor
var
  iTech: Integer;
begin
 //if using 100t bays
  if (Ship.BigBays.RepulsorBays > 0) then
  begin
    if (Ship.BigBays.RefitRepulsorBays) then iTech := Ship.BigBays.RepulsorBaysRefitTech
        else iTech := Ship.TechLevel;
    case (iTech) of
      0..9: Result := '0';
      10: Result := '2';
      11: Result := '4';
      12: Result := '6';
      13: Result := '7';
      14: Result := '8';
      else Result := '9';
    end;
  end
  //if using 50t bays
  else if (Ship.LittleBays.RepulsorBays > 0) then
  begin
    if (Ship.LittleBays.RefitRepulsorBays) then iTech := Ship.LittleBays.RepulsorBaysRefitTech
        else iTech := Ship.TechLevel;
    case (iTech) of
      0..13: Result := '0';
      14: Result := '3';
      else Result := '5';
    end;
  end
  else
  begin
    Result := '0';
  end;
end;

function TAnalysis.CalcSandFact(Turrs, Wpns: Integer): String;
//calculate the sandcaster factor

var
  Fact : Integer;
begin
  try
    Fact := 0;
    case (Turrs * Wpns) of
      0: Fact := 0;
      1..2: Fact := 1;
      3..5: Fact := 2;
      6..7: Fact := 3;
      8..9: Fact := 4;
      10..19: Fact := 5;
      20..29: Fact := 6;
      else Fact := 7;
    end;
    if (Ship.TechLevel > 7) and (Fact > 0) then begin
      Inc(Fact);
    end;
    if (Ship.TechLevel > 9) and (Fact > 0) then begin
      Inc(Fact);
    end;
    Result := IntToStr(Fact);
  except
    On EDivByZero do Result := '0';
  end
end;

function TAnalysis.CalcSizeCode: String;
//calculate the ship's size code

begin
  case (FloatToIntDown(Ship.Tonnage / 100)) of
    0: Result := '0';
    1: Result := '1';
    2: Result := '2';
    3: Result := '3';
    4: Result := '4';
    5: Result := '5';
    6: Result := '6';
    7: Result := '7';
    8: Result := '8';
    9: Result := '9';
    10..19: Result := 'A';
    20..29: Result := 'B';
    30..39: Result := 'C';
    40..49: Result := 'D';
    50..59: Result := 'E';
    60..69: Result := 'F';
    70..79: Result := 'G';
    80..89: Result := 'H';
    90..99: Result := 'J';
    100..199: Result := 'K';
    200..299: Result := 'L';
    300..399: Result := 'M';
    400..499: Result := 'N';
    500..749: Result := 'P';
    750..999: Result := 'Q';
    1000..1999: Result := 'R';
    2000..2999: Result := 'S';
    3000..3999: Result := 'T';
    4000..4999: Result := 'U';
    5000..6999: Result := 'V';
    7000..8999: Result := 'W';
    9000..9999: Result := 'X';
    10000..19999: Result := 'Y';
    else Result := 'Z';
  end;
end;

constructor TAnalysis.Create;
//create the module, procedure for future development

begin
   inherited
//   Analyise;
end;

function TAnalysis.FloatToIntDown(TheFloat: Extended): Integer;
//convert float to int rounding down

begin
   Result := StrToInt(FloatToStr(Int(TheFloat)));
end;

function TAnalysis.FloatToIntUp(TheFloat: Extended): Integer;
//convert float to int rounding up

begin
   if ((TheFloat - Int(TheFloat)) <> 0) then begin
      Result := FloatToIntDown(TheFloat) + 1;
   end
   else begin
      Result := FloatToIntDown(TheFloat);
   end;
end;

end.

