unit varAnalysisPas;

interface

uses
   Classes, SysUtils, Math, DataPas, ShipPas;

type
   TAnalysis = class
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
      function BatBear(Size : Extended) : Extended;
      function CalcSizeCode(Size : Extended) : String;
      function CalcCrewCode : String;
      function CalcSandFact(Turrs, Wpns, Tech : Integer) : String;
      function CalcRepulseFact(BigBays, LittleBays, Tech : Integer) : String;
      function CalcLaserFact(Turrs, Wpns, LaserType, Tech : Integer) : String;
      function CalcEnergyBayFact(EnergyType, Tech : Integer) : String;
      function CalcEnergyTurretFact(Turrs, Wpns, EnergyType, Tech : Integer) : String;
      function CalcPASpinalFact : String;
      function CalcPABigBayFact(Tech : Integer) : String;
      function CalcPALittleBayFact(Tech : Integer) : String;
      function CalcPATurretFact(Turrs, Wpns, Tech : Integer) : String;
      function CalcMesonSpinalFact : String;
      function CalcMesonBigBayFact(Tech : Integer) : String;
      function CalcMesonLittleBayFact(Tech : Integer) : String;
      function CalcMissileBigBayFact(Tech : Integer) : String;
      function CalcMissileLittleBayFact(Tech : Integer) : String;
      function CalcMissileTurretFact(Turrs, Wpns, Tech : Integer) : String;
      function CalcShipCost(ThePrice, TheCraftCost : Extended) : String;
      function CalcDisp(Size : Extended) : String;
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
      procedure Analyise(AnShip : TShip);
   end;

var
   Analysis : TAnalysis;

implementation

uses
   ShipPas, HullPas, EngPas, FuelPas, AvionicsPas, SpinalMountPas, BigBaysPas,
   LittleBaysPas, TurretsPas, ScreensPas, CraftPas, AccomPas;

{ TAnalysis }

procedure TAnalysis.Analyise(AnShip: TShip);
//analyise the ship and produce the USP factors

begin
   SizeCode := CalcSizeCode(AnShip.Tonnage);
   CrewCode := CalcCrewCode;
   //Sandcasters
   if (AnShip.Turrets.MixedTurrets = 0) then begin
      SandFact := CalcSandFact(1, AnShip.Turrets.MixTurretSand, AnShip.TechLevel);
   end
   else begin
      if (AnShip.Turrets.SandBatteries > 0) then begin
         SandFact := CalcSandFact((AnShip.Turrets.SandTurrets
               div AnShip.Turrets.SandBatteries), AnShip.Turrets.SandTurretStyle,
               AnShip.TechLevel);
      end
      else begin
         SandFact := '0';
      end;
   end;
   if (AnShip.Turrets.MixedTurrets = 0) and (AnShip.Turrets.MixTurretSand > 0) then begin
      SandBat := (AnShip.Turrets.NumMixTurrets - AnShip.Turrets.EmptyMixTurrets);
   end
   else begin
      SandBat := AnShip.Turrets.SandBatteries;
   end;
   if (SandBat > 0) then begin
      SandBatBear := Max(1, Round(SandBat * BatBear(AnShip.Tonnage)));
   end
   else begin
      SandBatBear := 0;
   end;
   //Repulsors
   RepulseFact := CalcRepulseFact(AnShip.BigBays.RepulsorBays,
         AnShip.LittleBays.RepulsorBays, AnShip.TechLevel);
   if (AnShip.BigBays.RepulsorBays > 0) then begin
      RepulseBat := AnShip.BigBays.RepulsorBays;
   end
   else if (AnShip.LittleBays.RepulsorBays > 0) then begin
      RepulseBat := AnShip.LittleBays.RepulsorBays;
   end
   else begin
      RepulseBat := 0;
   end;
   if (RepulseBat > 0) then begin
      RepulseBatBear := Max(1, Round(RepulseBat * BatBear(AnShip.Tonnage)));
   end
   else begin
      RepulseBatBear := 0;
   end;
   //Lasers
   if (AnShip.Turrets.MixedTurrets = 0) then begin
      LaserFact := CalcLaserFact(1, AnShip.Turrets.MixTurretLasers,
            AnShip.Turrets.MixLaserType, AnShip.TechTevel);
   end
   else begin
      if (AnShip.Turrets.LaserBatteries > 0) then begin
         LaserFact := CalcLaserFact((AnShip.Turrets.LaserTurrets
               div AnShip.Turrets.LaserBatteries), AnShip.Turrets.LaserTurretStyle,
               AnShip.Turrets.LaserType, AnShip.TechTevel);
      end
      else begin
         LaserFact := '0';
      end;
   end;
   if (AnShip.Turrets.MixedTurrets = 0) and (AnShip.Turrets.MixTurretLasers > 0) then begin
      LaserBat := (AnShip.Turrets.NumMixTurrets - AnShip.Turrets.EmptyMixTurrets);
   end
   else begin
      LaserBat := AnShip.Turrets.LaserBatteries;
   end;
   if (LaserBat > 0) then begin
      LaserBatBear := Max(1, Round(LaserBat * BatBear(AnShip.Tonnage)));
   end
   else begin
      LaserBatBear := 0;
   end;
   //Energy Weapons
   if (AnShip.LittleBays.EnergyBays > 0) then begin
      EnergyFact := CalcEnergyBayFact(AnShip.LittleBays.EnergyType, AnShip.TechLevel);
      EnergyBat := AnShip.LittleBays.EnergyBays;
   end
   else begin
      if (AnShip.Turrets.EnergyBatteries > 0) then begin
         EnergyFact := CalcEnergyTurretFact((AnShip.Turrets.EnergyTurrets
               div AnShip.Turrets.EnergyBatteries), AnShip.Turrets.EnergyTurretStyle,
               AnShip.Turrets.EnergyType, AnShip.TechTevel);
      end
      else begin
         EnergyFact := '0';
      end;
      EnergyBat := AnShip.Turrets.EnergyBatteries;
   end;
   if (EnergyBat > 0) then begin
      EnergyBatBear := Max(1, Round(EnergyBat * BatBear(AnShip.Tonnage)));
   end
   else begin
      EnergyBatBear := 0;
   end;
   //Partical Accelerators
   if (AnShip.SpinalMount.SpinalType = 2) then begin
      PAFact := CalcPASpinalFact;
      PABat := 1;
   end
   else if (AnShip.BigBays.PABays > 0) then begin
      PAFact := CalcPABigBayFact(AnShip.TechTevel);
      PABat := AnShip.BigBays.PABays;
   end
   else if (AnShip.LittleBays.PABays > 0) then begin
      PAFact := CalcPALittleBayFact(AnShip.TechTevel);
      PABat := AnShip.LittleBays.PABays;
   end
   else begin
      if (AnShip.Turrets.PABatteries > 0) then begin
         PAFact := CalcPATurretFact((AnShip.Turrets.PATurrets
               div AnShip.Turrets.PABatteries), AnShip.Turrets.PATurretStyle,
               AnShip.TechTevel);
      end
      else begin
         PAFact := '0';
      end;
      PABat := AnShip.Turrets.PABatteries;
   end;
   if (PABat > 0) then begin
      PABatBear := Max(1, Round(PABat * BatBear(AnShip.Tonnage)));
   end
   else begin
      PABatBear := 0;
   end;
   //Meson Guns
   if (AnShip.SpinalMount.SpinalType = 1) then begin
      MesGunFact := CalcMesonSpinalFact;
      MesGunBat := 1;
   end
   else if (AnShip.BigBays.MesonBays > 0) then begin
      MesGunFact := CalcMesonBigBayFact(AnShip.TechTevel);
      MesGunBat := AnShip.BigBays.MesonBays;
   end
   else if (AnShip.LittleBays.MesonBays > 0) then begin
      MesGunFact := CalcMesonLittleBayFact(AnShip.TechTevel);
      MesGunBat := AnShip.LittleBays.MesonBays;
   end
   else begin
      MesGunFact := '0';
      MesGunBat := 0;
   end;
   if (MesGunBat > 0) then begin
      MesGunBatBear := Max(1, Round(MesGunBat * BatBear(AnShip.Tonnage)));
   end
   else begin
      MesGunBatBear := 0;
   end;
   //Missiles
   if (AnShip.BigBays.MissileBays > 0) then begin
      MissileFact := CalcMissileBigBayFact(AnShip.TechLevel);
      MissileBat := AnShip.BigBays.MissileBays;
   end
   else if (AnShip.LittleBays.MissileBays > 0) then begin
      MissileFact := CalcMissileLittleBayFact(AnShip.TechTevel);
      MissileBat := AnShip.LittleBays.MissileBays;
   end
   else begin
      if (AnShip.Turrets.MixedTurrets = 0) and (AnShip.Turrets.MixTurretMissiles > 0) then begin
         MissileFact := CalcMissileTurretFact(1, AnShip.Turrets.MixTurretMissiles,
               AnShip.TechTevel);
         MissileBat := (AnShip.Turrets.NumMixTurrets - AnShip.Turrets.EmptyMixTurrets);
      end
      else begin
         if (AnShip.Turrets.MissileBatteries > 0) then begin
            MissileFact := CalcMissileTurretFact((AnShip.Turrets.MissileTurrets div
                  AnShip.Turrets.MissileBatteries), AnShip.Turrets.MissileTurretStyle,
                  AnShip.TechTevel);
         end
         else begin
            MissileFact := '0';
         end;
         MissileBat := AnShip.Turrets.MissileBatteries;
      end;
   end;
   if (MissileBat > 0) then begin
      MissileBatBear := Max(1, Round(MissileBat * BatBear(AnShip.Tonnage)));
   end
   else begin
      MissileBatBear := 0;
   end;
   //Other stuff
   ShipCost := CalcShipCost(AnShip.Price, AnShip.CraftCost);
   Disp := CalcDisp(AnShip.Tonnage);
end;

function TAnalysis.BatBear(Size: Extended): Extended;
//work out how many batteries are bearing

begin
   case (FloatToIntDown(Size / 100)) of
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
      100000000..899999999: Result := '9';  //var overflow after here
(*      900000000..999999999: Result := '9';
      1000000000..9999999999: Result := 'A';
      10000000000..99999999999: Result := 'B';
      100000000000..999999999999: Result := 'C';
      1000000000000..9999999999999: Result := 'D';
      10000000000000..99999999999999: Result := 'E';
      100000000000000..999999999999999: Result := 'F;
      1000000000000000..9999999999999999: Result := 'G';*)
   end;
end;

function TAnalysis.CalcDisp(Size: Extended): String;
//work out how to report the ships displacement

begin
   if (Ship.Tonnage < 1000) then begin
      Result := FloatToStr(Ship.Tonnage) + ' Tons';
   end
   else if (Ship.Tonnage < 1000000) then begin
      Result := FloatToStr(Ship.Tonnage / 1000) + ' KTons';
   end
   else begin
      Result := FloatToStr(Ship.Tonnage / 1000000) + ' MTons';
   end;
end;

function TAnalysis.CalcEnergyBayFact(EnergyType, Tech: Integer): String;
//calculate the energy factor for bays

begin
   //plasma gund
   if (EnergyType = 0) then begin
      case (Tech) of
         0..9: Result := '0';
         10: Result := '4';
         11: Result := '5';
         else Result := '6';
      end;
   end
   //fusion guns
   else if (EnergyType = 1) then begin
      case (Tech) of
         0..11: Result := '0';
         12: Result := '7';
         13: Result := '8';
         else Result := '9';
      end;
   end;
end;

function TAnalysis.CalcEnergyTurretFact(Turrs, Wpns, EnergyType, Tech: Integer): String;
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
         if (Tech > 10) and (Fact > 0) then begin
            Inc(Fact);
         end;
         if (Tech > 11) and (Fact > 0) then begin
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
         if (Tech > 13) and (Fact > 0) then begin
            Inc(Fact);
         end;
         Result := IntToStr(Fact);
      end;
   except
      On EDivByZero do Result := '0';
   end;
end;

function TAnalysis.CalcLaserFact(Turrs, Wpns, LaserType, Tech: Integer): String;
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
         if (Tech > 12) and (Fact > 0) then begin
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
         if (Tech > 12) and (Fact > 0) then begin
            Inc(Fact);
         end;
         Result := IntToStr(Fact);
      end;
   except
      On EDivByZero do Result := '0';
   end;
end;

function TAnalysis.CalcMesonBigBayFact(Tech: Integer): String;
//calculate the factor for 100t meson bays

begin
   case (Tech) of
      0..12: Result := '0';
      13: Result := '3';
      14: Result := '5';
      else Result := '9';
   end;
end;

function TAnalysis.CalcMesonLittleBayFact(Tech: Integer): String;
//calculate the factor for 50t meson bays

begin
   case (Tech) of
      0..14: Result := '0';
      else Result := '4';
   end;
end;

function TAnalysis.CalcMesonSpinalFact: String;
//calculate the factor for spinal meson guns

var
   Data : TData;
begin
   Data := TData.Create;
   try
      Data.InitialiseData;
      Result := Data.GetSpnlMesData(1, Ship.SpinalMount.SpinalMount)[1];
   finally
      FreeAndNil(Data);
   end;
end;

function TAnalysis.CalcMissileBigBayFact(Tech: Integer): String;
//calculate the factor for 100t missile bays

begin
   case (Tech) of
      0..6: Result := '0';
      7..9: Result := '7';
      10..11: Result := '8';
      else Result := '9';
   end;
end;

function TAnalysis.CalcMissileLittleBayFact(Tech: Integer): String;
//calculate the factor for 50t missile bays

begin
   case (Tech) of
      0..9: Result := '0';
      10..11: Result := '7';
      12..13: Result := '8';
      else Result := '9';
   end;
end;

function TAnalysis.CalcMissileTurretFact(Turrs, Wpns, Tech: Integer): String;
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
      if (Tech > 12) and (Fact > 0) then begin
         Inc(Fact);
      end;
      Result := IntToStr(Fact);
   except
      On EDivByZero do Result := '0';
   end
end;

function TAnalysis.CalcPABigBayFact(Tech: Integer): String;
//calculate the factor for 100t pa bays

begin
   case (Tech) of
      0..7: Result := '0';
      8..9: Result := '6';
      10..11: Result := '7';
      12..13: Result := '8';
      else Result := '9';
   end;
end;

function TAnalysis.CalcPALittleBayFact(Tech: Integer): String;
//calculate the factor for 50t pa bays

begin
   case (Tech) of
      0..9: Result := '0';
      10..11: Result := '3';
      12..13: Result := '4';
      else Result := '5';
   end;
end;

function TAnalysis.CalcPASpinalFact: String;
//calculate the factor for spinal pa's

var
   Data : TData;
begin
   Data := TData.Create;
   try
      Data.InitialiseData;
      Result := Data.GetSpnlPAData(1, Ship.SpinalMount.SpinalMount)[1];
   finally
      FreeAndNil(Data);
   end;
end;

function TAnalysis.CalcPATurretFact(Turrs, Wpns, Tech: Integer): String;
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
      if (Tech > 14) and (Fact > 0) then begin
         Inc(Fact);
      end;
      Result := IntToStr(Fact);
   except
      On EDivByZero do Result := '0';
   end
end;

function TAnalysis.CalcShipCost(ThePrice, TheCraftCost: Extended): String;
//calculate how to report the ship's cost

var
   Cost : Extended;
begin
   Cost := ThePrice + TheCraftCost;
   if (Cost < 1000000) then begin
      Result := 'MCr ' + FloatToStrF(Cost, ffNumber, 18, 3);
   end
   else if (Cost < 1000000000) then begin
      Result := 'GCr ' + FloatToStrF(Cost / 1000, ffNumber, 18, 3);
   end
   else begin
      Result := 'TCr ' + FloatToStrF(Cost / 1000000, ffNumber, 18, 3);
   end;
end;

function TAnalysis.CalcRepulseFact(BigBays, LittleBays, Tech: Integer): String;
//calculate the repulsor factor

begin
   //if using 100t bays
   if (BigBays > 0) then begin
      case (Tech) of
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
   else if (LittleBays > 0) then begin
      case (Tech) of
         0..13: Result := '0';
         14: Result := '3';
         else Result := '5';
      end;
   end
   else begin
      Result := '0';
   end;
end;

function TAnalysis.CalcSandFact(Turrs, Wpns, Tech: Integer): String;
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
      if (Tech > 7) and (Fact > 0) then begin
         Inc(Fact);
      end;
      if (Tech > 9) and (Fact > 0) then begin
         Inc(Fact);
      end;
      Result := IntToStr(Fact);
   except
      On EDivByZero do Result := '0';
   end
end;

function TAnalysis.CalcSizeCode(Size: Extended): String;
//calculate the ship's size code

begin
   case (FloatToIntDown(Size / 100)) of
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

