unit ShipPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math,

  ShipModulePas, HullPas, EngPas, FuelPas, AvionicsPas, SpinalMountPas, DataPas,
  BigBaysPas, LittleBaysPas, TurretsPas, ScreensPas, CraftPas, AccomPas,
  OptionsPas, AnalysisPas, DescExpPas, UserDefPas, CompExpPas;

type
  TComputerSet = set of 0..20;

  { TShip }

  TShip = class
  private
    FAlternateCrewRules: Integer;
    FFlagship: Boolean;
    FRefitPrice: Extended;
    { Private declarations }
     fShipName : String;
     fShipClass : String;
     fShipType : String;
     fArchitect : String;
     fShipCode : String;
     fTechLevel : Integer;
     fTonnage : Extended;
     fBudget : Extended;
     fShipRace : Integer;
     fCrewRules : Integer;
     fHardPoints : Integer;
     fHasChanged : Boolean;
     fRefitTechLevel : Integer;
     fRefitBudget : Extended;
     fIsRefitted : Boolean;
     fShipFile : String;
     fPrice : Extended;
     fUSP : TStringList;
     fFuelTons : Extended;
     fDesignRules : Integer;
     fMedicalCmdCrew : Integer;
     fMedicalCrew : Integer;
     fTotMedicalCrew : Integer;

     //tcs variables
     fNum : Integer;
     fDiscountAll : Boolean;
     fInOrdinary : Boolean;
     fCarriedCraft : Boolean;

     fTestDesign : Boolean;

     function CalcStRoom : Extended;
     function CalcCouches : Integer;
     function CalcLowBerth : Integer;
     function CalcArmour : Integer;
     procedure SetAlternateCrewRules(const AValue: Integer);
     procedure SetFlagship(const AValue: Boolean);
     procedure SetRefitPrice(const AValue: Extended);
     function StrToFloatDef(const S: string; Default: Extended): Extended;
     function IntToTrav(Value : Integer) : String;
     function IntToTravBat(Value : Integer) : String;
     function FloatToIntDown(TheFloat: Extended): Integer;
     function FloatToIntUp(TheFloat: Extended): Integer;
     function UseHighValues(Value : Integer) : String;
     function NotInt(TheString : String) : Boolean;
     function IsSmallCraftComp(CompValue : Integer) : Boolean;
     function MakePlural(TheString: String): String;
     function TravToInt (TheNum: String): Integer;
     function GetCompValue(TheComp: Integer): Integer;

     //USP stuff
     function USPLineOne(var Data : TData; var Analysis : TAnalysis) : String;
     function USPLineTwo(Var Analysis : TAnalysis) : String;
     function USPLineThree(Var Analysis : TAnalysis) : String;
     function WithTankUspLineOne(var Data: TData; var Analysis: TAnalysis): String;
     function USPComputer(var Data : TData) : String;
     function USPGeneral(Data: TData): String;
     function USPCraft : String;
     function USPFuel : String;
     function USPBackups(var Data : TData) : String;
     function USPSubs : String;
     function T20PowerCode : Integer;
     function CalcDropTankMan: Integer;
     function CalcDropTankJump: Integer;
     function CalcDropTankPower: Integer;
     function ReportDropTankDisplacement: String;
     function CalcTd100Number: Integer;
     function CalcLog2Number: Integer;

     procedure ZeroHull;
     procedure ZeroEng;
     procedure ZeroFuel;
     procedure ZeroAvionics;
     procedure ZeroSpinal;
     procedure ZeroBigBays;
     procedure ZeroLittleBays;
     procedure ZeroTurrets;
     procedure ZeroMagazines;
     procedure ZeroScreens;
     procedure ZeroCraft;
     procedure ZeroAccom;
     procedure ZeroUserDef;


     procedure HardCodedDefaults;
  public
    { Public declarations }
     Hull : THull;
     Eng : TEng;
     Fuel : TFuel;
     Avionics : TAvionics;
     SpinalMount : TSpinalMount;
     BigBays : TBigBays;
     LittleBays : TLittleBays;
     Turrets : TTurrets;
     Screens : TScreens;
     Craft : TCraft;
     Accom : TAccom;
     Options : TOptions;
     UserDef : TUserDef;
     HomeDir : String;
     ShipComments : TStringList;
//     Analysis : TAnalysis;
     Constructor Create;
     Destructor Destroy;
     property ShipName : String read fShipName write fShipName;
     property ShipClass : String read fShipClass write fShipClass;
     property ShipType : String read fShipType write fShipType;
     property Architect : String read fArchitect write fArchitect;
     property ShipCode : String read fShipCode write fShipCode;
     property TechLevel : Integer read fTechLevel write fTechLevel;
     property Tonnage : Extended read fTonnage write fTonnage;
     property Budget : Extended read fBudget write fBudget;
     property ShipRace : Integer read fShipRace write fShipRace;
     property CrewRules : Integer read fCrewRules write fCrewRules;
     property HardPoints : Integer read fHardPoints write fHardPoints;
     property HasChanged : Boolean read fHasChanged write fHasChanged;
     property RefitTechLevel : Integer read fRefitTechlevel write fRefitTechLevel;
     property RefitBudget : Extended read fRefitBudget write fRefitBudget;
     property IsRefitted : Boolean read fIsRefitted write fIsRefitted;
     property ShipFile : String read fShipFile write fShipFile;
     property Price : Extended read fPrice write fPrice;
     property RefitPrice: Extended read FRefitPrice write SetRefitPrice;
     property USP : TStringList read fUSP;
     property FuelTons : Extended read fFuelTons;
     property DesignRules : Integer read fDesignRules write fDesignRules;
     property MedicalCmdCrew : Integer read fMedicalCmdCrew write fMedicalCmdCrew;
     property MedicalCrew : Integer read fMedicalCrew write fMedicalCrew;
     property TotMedicalCrew : Integer read fTotMedicalCrew write fTotMedicalCrew;

     property AlternateCrewRules: Integer read FAlternateCrewRules write SetAlternateCrewRules;

     property TestDesign : Boolean read fTestDesign write fTestDesign;

     //tcs values
     property Num : Integer read fNum write fNum;
     property DiscountAll : Boolean read fDiscountAll write fDiscountAll;
     property InOrdinary : Boolean read fInOrdinary write fInOrdinary;
     property CarriedCraft : Boolean read fCarriedCraft write fCarriedCraft;

     //optional
     property Flagship: Boolean read FFlagship write SetFlagship;

     function ValidFile(TheFile : String) : Boolean;
     function DesignIsValid(CurrentError : Integer) : Integer;
     function GetRemBudget : Extended;
     function GetRemRefitBudget: Extended;
     function GetRemPower : Extended;
     function GetRemTonnage : Extended;
     function GetRemHardPoints : Integer;
     function GetTotalCmdCrew : Integer;
     function GetTotalCrew : Integer;
     function TotalBigBays : Integer;
     function TotalLittleBays : Integer;
     function Agility : Integer;
     function WithTankAgility: Integer;
     function CraftCost : Extended;
     function GetFuelTons : Extended;
     procedure AssignDefaults(ShipDefs : String);
     procedure ReadDefaults;
     procedure DesignShip;
     procedure ReadFromFile(TheFile : String);
     procedure WriteToFile(TheFile : String);
     procedure ResetAllCrew;
     procedure GenerateUSP;
     procedure TextExport(TheFile : String);
     procedure ReadFromForm(var ShipData : TStringList);

     //usp stuff
     function BatsBear: Extended;
     function CalcSizeCode: String;
     function CalcCrewCode: Integer;
     function CalcNumCrewSections: Integer;
     function CalcSizeCrewSections: Integer;
     function CalcOldCrewCode: Integer;
     function ReportShipCost: String;
     function ReportShipDisplacement: String;
     function CalcBatteryBearing(NumBat: Integer): Integer;
     //sand, repulsors, laser, energy, Pa, Meson, missiles
     function CalcSandBattery: Integer;
     function CalcRepulsorFactor: Integer;
     function CalcRepulsorBattery: Integer;
     function CalcLaserBattery: Integer;
     function CalcEnergyFactor: Integer;
     function CalcEnergyBattery: Integer;
     function CalcPaFactor: String;
     function CalcPaBattery: Integer;
     function CalcMesonFactor: String;
     function CalcMesonBattery: Integer;
     function CalcMissileFactor: Integer;
     function CalcMissileBattery: Integer;

     //generate details for design assistant
     function GetCurver : String;
     function GenShipDetails : String;
     function GenHullDetails : String;
     function GenEngDetails : String;
     function GenFuelDetails : String;
     function GenAvionicsDetails : String;
     function GenSpinalMountDetails : String;
     function GenBigBaysDetails : String;
     function GenLittleBaysDetails : String;
     function GenTurretDetails : String;
     function GenScreenDetails : String;
     function GenCraftDetails : String;
     function GenAccomDetails : String;
     function GenOptionsDetails : String;
     function GenUserDefDetails : String;

     //Component export
     function ComponentExport(TheFile : String; DoWrite : Boolean) : TStringList;

     //refit items
     procedure SetEngRefitTech(iTech: Integer);
     procedure SetFuelRefitTech(iTech: Integer);
     procedure SetAvionicsRefitTech(iTech: Integer);
     procedure SetSpinalRefitTech(iTech: Integer);
     procedure SetBigBaysRefitTech(iTech: Integer);
     procedure SetLittleBaysRefitTech(iTech: Integer);
  end;

const
   SEP = Char(',');
   TEXTMARK = Char('"');
   CURVER = String('20000'); //current version main.minor.release.build(two digets)
var
  Ship: TShip;
  iTest: Integer;
  eTest: Extended;
  sTest: String;
  bTest: Boolean;

  //CAUTION GLOBAL VARIABLES. BE VERY CAREFULL WITH THESE
  //these are the high value substitution variables
  //ONLY TO BE USED FOR IntToTrav AND IntToTravBat

  sVal, tVal, uVal, vVal, wVal, xVal, yVal, zVal : Integer; //GLOBAL VARIABBLES

  //these are the high value substitution variables
  //ONLY TO BE USED FOR IntToTrav AND IntToTravBat
  //CAUTION GLOBAL VARIABLES. BE VERY CAREFULL WITH THESE

implementation

uses MainPas;

constructor TShip.Create;
//create the ship modules, set the home dir and design the default

begin
   inherited;
   Hull := THull.Create;
   Eng := TEng.Create;
   Fuel := TFuel.Create;
   Avionics := TAvionics.Create;
   SpinalMount := TSpinalMount.Create;
   BigBays := TBigBays.Create;
   LittleBays := TLittleBays.Create;
   Turrets := TTurrets.Create;
   Screens := TScreens.Create;
   Craft := TCraft.Create;
   Accom := TAccom.Create;
   UserDef := TUserDef.Create;
   Options := TOptions.Create;
//   Analysis := TAnalysis.Create;
   ShipComments := TStringList.Create;
   HomeDir := ExtractFilePath(Application.ExeName);
   ReadDefaults;
   fUSP := TStringList.Create;
   sVal := 0;
   tVal := 0;
   uVal := 0;
   vVal := 0;
   wVal := 0;
   xVal := 0;
   yVal := 0;
   zVal := 0;
   WriteToFile(HomeDir + 'Hg.bak');
   DesignShip;

   TestDesign := False;
end;

destructor TShip.Destroy;
//clean everything up

begin
   FreeAndNil(Hull);
   FreeAndNil(Eng);
   FreeAndNil(Fuel);
   FreeAndNil(Avionics);
   FreeAndNil(SpinalMount);
   FreeAndNil(BigBays);
   FreeAndNil(LittleBays);
   FreeAndNil(Turrets);
   FreeAndNil(Screens);
   FreeAndNil(Craft);
   FreeAndNil(Accom);
   FreeAndNil(UserDef);
   FreeAndNil(Options);
//   FreeAndNil(Analysis);
   FreeAndNil(fUSP);
   FreeAndNil(ShipComments);
   inherited;
end;

procedure TShip.AssignDefaults(ShipDefs: String);
//assign the defaults to the modules

var
   Props : TStringList;
begin
   Props := TStringList.Create;
   try
      Props.CommaText := ShipDefs;
      ShipName := Props[0];
      ShipClass := Props[1];
      ShipType := Props[2];
      Architect := Props[3];
      ShipCode := Props[4];
      TechLevel := StrToInt(Props[5]);
      Tonnage := StrToFloat(Props[6]);
      Budget := StrToFloat(Props[7]);
      ShipRace := StrToInt(Props[8]);
      CrewRules := StrToInt(Props[9]);
      DesignRules := StrToInt(Props[10]);
      IsRefitted := StrToBool(Props[11]);
      RefitTechLevel := StrToInt(Props[12]);
      RefitBudget := StrToFloat(Props[13]);
      AlternateCrewRules := StrToInt(Props[14]);
      Flagship := StrToBool(Props[15]);
      HardPoints := 0;
      HasChanged := False;
   finally
      FreeAndNil(Props);
   end;
end;

procedure TShip.ReadDefaults;
//check to see if the default files exist and are valid, then read and backup

begin
   if (FileExists(HomeDir + 'Hg') { *Converted from FileExists*  }) and (ValidFile(HomeDir + 'Hg')) then begin
      ReadFromFile(HomeDir + 'Hg');
   end
   else if (FileExists(HomeDir + 'Hg.bak') { *Converted from FileExists*  }) and (ValidFile(HomeDir + 'Hg.bak')) then begin
      ReadFromFile(HomeDir + 'Hg.bak');
      WriteToFile(HomeDir + 'Hg');
   end
   else begin
      HardCodedDefaults;
      WriteToFile(HomeDir + 'Hg');
      WriteToFile(HomeDir + 'Hg.bak');
   end;
end;

procedure TShip.DesignShip;
//design the ship
//NOTE this is slighlty different from TCS ship

var
  ShipDetails : String;
  iPPlant, iJDrive, iPowTech: Integer;
  ePowerTons: Extended;
begin
  if (Eng.PPlantIsRefitted) then iPPlant := Eng.NewPPlant else iPPlant := Eng.PPlant;
  if (Eng.PowerTonsIsRefitted) then ePowerTons := Eng.NewPowerTons else ePowerTons := Eng.PowerTons;
  if (Eng.JDriveIsRefitted) then iJDrive := Eng.NewJDrive else iJDrive := Eng.JDrive;
  if (Eng.PowerTonsIsRefitted) then iPowTech := Eng.PowerTonsRefitTech else iPowTech := TechLevel;
  //0 to 15 based array
  ShipDetails := IntToStr(TechLevel)                      //0
      + SEP + FloatToStr(Tonnage)                         //1
      + SEP + IntToStr(ShipRace)                          //2
      + SEP + IntToStr(CrewRules)                         //3
      + SEP + IntToStr(iPPlant)                           //4
      + SEP + IntToStr(Hull.Config)                       //5
      + SEP + IntToStr(Options.ChargeForHardpoints)       //6
      + SEP + IntToStr(DesignRules)                       //7
      + SEP + FloatToStr(ePowerTons)                      //8
      + SEP + BoolToStr(IsRefitted)                       //9
      + SEP + IntToStr(RefitTechLevel)                    //10
      + SEP + BoolToStr(TestDesign)                       //11
      + SEP + IntToStr(iJDrive)                           //12
      + SEP + BoolToStr(Options.MilStdJump)               //13
      + SEP + FloatToStr(Options.MilStdMod)               //14
      + SEP + IntToStr(iPowTech)                          //15 special tech level of T20 PP
      ; //terminator
  HardPoints := Max(1, StrToInt(FloatToStr(Int(Tonnage/100))));
  Hull.DesignHull(ShipDetails);
  Eng.DesignEng(ShipDetails);
  Fuel.DesignFuel(ShipDetails);
  Avionics.DesignAvionics(ShipDetails);
  SpinalMount.DesignSpinalMount(ShipDetails);
  BigBays.DesignBigBays(ShipDetails);
  LittleBays.DesignLittleBays(ShipDetails);
  Turrets.DesignTurrets(ShipDetails);
  Screens.DesignScreens(ShipDetails);
  Craft.DesignCraft(ShipDetails);
  Accom.DesignAccom(ShipDetails);
  UserDef.DesignUserDef(ShipDetails);
  Price := Hull.Cost + Eng.Cost + Fuel.Cost + Avionics.Cost + SpinalMount.Cost
      + BigBays.Cost + LittleBays.Cost + Turrets.Cost + Screens.Cost
      + Craft.Cost + Accom.Cost + UserDef.Cost;
  eTest := Hull.RefitCost;
  eTest := Eng.RefitCost;
  eTest := Fuel.RefitCost;
  eTest := Avionics.RefitCost;
  eTest := SpinalMount.RefitCost;
  eTest := BigBays.RefitCost;
  eTest := LittleBays.RefitCost;
  RefitPrice := Hull.RefitCost + Eng.RefitCost + Fuel.RefitCost + Avionics.RefitCost
      + SpinalMount.RefitCost + BigBays.RefitCost + LittleBays.RefitCost;
  //fUSP.Clear;
  //GenerateUSP;   //TCS ship only
//  SetFuel;       //TCS ship only
end;

function TShip.GetTotalCmdCrew: Integer;
//get the total command crew

var
  iCmdCrew : Integer;

begin
  //set Medical Command Crew to 1 if book 5 crew rules and not small craft
  MedicalCmdCrew := 0;
  if (CrewRules = 1) and (Tonnage >= 100) then
  begin
    MedicalCmdCrew := 1;
  end
  else
  begin
    MedicalCmdCrew := 0;
  end;
  iCmdCrew := Eng.CmdCrew + Avionics.CmdCrew + Min(1, SpinalMount.CmdCrew
      + BigBays.CmdCrew + LittleBays.CmdCrew + Turrets.CmdCrew
      + Screens.CmdCrew) + Craft.CmdCrew + Accom.CmdCrew
      + Min(1, Accom.Marines) + UserDef.CmdCrew + MedicalCmdCrew;
  result := iCmdCrew;
end;

function TShip.GetTotalCrew: Integer;
//get the total non command crew

var
  iCrew : Integer;

begin
  MedicalCrew := 0;
  iCrew := Eng.Crew + Avionics.Crew + SpinalMount.Crew + BigBays.Crew
      + LittleBays.Crew + Turrets.Crew + Screens.Crew + Craft.Crew
      + Accom.Crew + Accom.ShipsTroops + Max(0, Accom.Marines - 1)
      + Accom.OtherCrew + UserDef.Crew + GetTotalCmdCrew
      + Accom.HighPass + Accom.MidPass + Accom.LowBerth;
  //medical crew = 1 per 240 other persons aboard
  if (CrewRules = 1) and (Tonnage >= 100) then
  begin
    MedicalCrew := iCrew div 240;
    //add an extra if you've gone over another 240
    repeat
      if (((iCrew + MedicalCrew) div 240) > MedicalCrew) then
      begin
        MedicalCrew := (iCrew + MedicalCrew) div 240
      end;
    until (((iCrew + MedicalCrew) div 240) = MedicalCrew);
  end
  else
  begin
    MedicalCrew := 0;
  end;
  Result := Eng.Crew + Avionics.Crew + SpinalMount.Crew + BigBays.Crew
      + LittleBays.Crew + Turrets.Crew + Screens.Crew + Craft.Crew
      + Accom.Crew + Accom.ShipsTroops + Max(0, Accom.Marines - 1)
      + Accom.OtherCrew + UserDef.Crew + MedicalCrew;
end;

function TShip.GetRemBudget: Extended;
//get the remaining budget (ship price plus craft cost)

begin
  Result := Budget - (Price + CraftCost);
end;

function TShip.GetRemRefitBudget: Extended;
begin
  Result := RefitBudget - RefitPrice;
end;

function TShip.GetRemPower: Extended;
//get the remaining energy points

begin
  Result := Eng.Power
      - (Eng.MPowerUsed + Avionics.Power + SpinalMount.Power + BigBays.Power
          + LittleBays.Power + Turrets.Power + Screens.Power + Craft.Power
          + Accom.Power + UserDef.Power);
end;

function TShip.GetRemTonnage: Extended;
//get the space left in the design

begin
  Result := Tonnage
      - (Hull.Space + Eng.Space + Fuel.Space + Avionics.Space
      + SpinalMount.Space + BigBays.Space + LittleBays.Space
      + Turrets.Space + Screens.Space + Craft.Space + Accom.Space
      + UserDef.Space);
end;

function TShip.GetRemHardPoints: Integer;
//get the number of remaining hardpoints

begin
  Result := HardPoints
      - (SpinalMount.HardPoints + BigBays.HardPoints + LittleBays.HardPoints
      + Turrets.HardPoints + UserDef.HardPoints);
end;

function TShip.DesignIsValid(CurrentError: Integer): Integer;
//check to see if the design is valid
//added version 1.1 autocalculate accommodations

var
   Data : TData;
   //Begin Changed Section
   MinStRoom : Extended;
   MinCouches, MinLowBerth : Integer;
   //End Changed Section
begin
   //Begin Changed Section
   MinStRoom := CalcStRoom;
   MinCouches := CalcCouches;
   MinLowBerth := CalcLowBerth;
   if (Options.AutoCalcAccom = 1) then begin
      if (Accom.StRoom <> MinStRoom) and (Tonnage >= 100) then begin
         Accom.StRoom := MinStRoom;
         DesignShip;
         MainFrm.RefreshForm;
      end;
      if (Accom.Couches <> MinCouches) and (Tonnage < 100) then begin
         Accom.Couches := MinCouches;
         DesignShip;
         MainFrm.RefreshForm;
      end;
      if (Accom.LowBerth < MinLowBerth) then begin
         Accom.LowBerth := MinLowBerth;
         DesignShip;
         MainFrm.RefreshForm;
      end;
   end;
   //End Changed Section
   Data := TData.Create;
   try
      Data.InitialiseData;
      Result := 0; //Valid Design
      if (GetRemTonnage < 0) then begin
         Result := 1;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (GetRemBudget < 0) and (not IsRefitted) then begin
         Result := 2;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (CrewRules = 0) and (Tonnage > 1000) then begin
         Result := 3;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel > TechLevel) then begin
         Result := 4;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (GetRemPower < 0) then begin
         Result := 5;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Hull.Config > 7) and (Tonnage < 100) then begin
         Result := 6;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Hull.Armour > TechLevel) then begin
         Result := 7;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage < 100) and (Eng.JDrive > 0) then begin
         Result := 8;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.MDrive > 2) and (TechLevel < 8) then begin
         Result := 9;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.MDrive > 5) and (TechLevel < 9) then begin
         Result := 10;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakMDrive > 2) and (TechLevel < 8) then begin
         Result := 11;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakMDrive > 5) and (TechLevel < 9) then begin
         Result := 12;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive > 0) and (TechLevel < 9) then begin
         Result := 13;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive > 1) and (TechLevel < 11) then begin
         Result := 14;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive > 2) and (TechLevel < 12) then begin
         Result := 15;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive > 3) and (TechLevel < 13) then begin
         Result := 16;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive > 4) and (TechLevel < 14) then begin
         Result := 17;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive > 5) and (TechLevel < 15) then begin
         Result := 18;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakJDrive > 0) and (TechLevel < 9) then begin
         Result := 19;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakJDrive > 1) and (TechLevel < 11) then begin
         Result := 20;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakJDrive > 2) and (TechLevel < 12) then begin
         Result := 21;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakJDrive > 3) and (TechLevel < 13) then begin
         Result := 22;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakJDrive > 4) and (TechLevel < 14) then begin
         Result := 23;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.BakJDrive > 5) and (TechLevel < 15) then begin
         Result := 24;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.PPlant < Eng.MDrive) then begin
         Result := 25;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.PPlant < Eng.JDrive) then begin
         Result := 26;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Fuel.Scoops = 0) and (Hull.Config > 6) then begin
         Result := 27;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Fuel.Purif = 0) and (TechLevel < 8) then begin
         Result := 28;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      //error surppressed for small craft
      if (Fuel.PFuel < 28) and (Fuel.PFuel > 0) and not (Tonnage < 100) then begin
         Result := 29;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if ((Fuel.PFuel mod 28) <> 0) and (Fuel.PFuel > 0) and not (Tonnage < 100) then begin
         Result := 30;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Fuel.LhydPFuel < 28) and (Fuel.LhydPFuel > 0) and not (Tonnage < 100) then begin
         Result := 31;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if ((Fuel.LhydPFuel mod 28) <> 0) and (Fuel.LhydPFuel > 0) and not (Tonnage < 100) then begin
         Result := 32;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive = 1) and (Avionics.MainComp < 1) then begin
         Result := 33;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive = 2) and (Avionics.MainComp < 3) then begin
         Result := 34;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive = 3) and (Avionics.MainComp < 6) then begin
         Result := 35;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive = 4) and (Avionics.MainComp < 9) then begin
         Result := 36;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive = 5) and (Avionics.MainComp < 11) then begin
         Result := 37;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Eng.JDrive = 6) and (Avionics.MainComp < 13) then begin
         Result := 38;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage < 100) and (Avionics.Bridge = 1) and (Avionics.MainComp < 1) then begin
         Result := 39;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 100) and (Avionics.Bridge = 1) then begin
         Result := 40;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 100) and (Avionics.MainComp < 1) then begin
         Result := 41;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 600) and (Avionics.MainComp < 1) then begin
         Result := 42;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 1000) and (Avionics.MainComp < 4) then begin
         Result := 43;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 4000) and (Avionics.MainComp < 7) then begin
         Result := 44;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 10000) and (Avionics.MainComp < 9) then begin
         Result := 45;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 50000) and (Avionics.MainComp < 11) then begin
         Result := 46;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 100000) and (Avionics.MainComp < 13) then begin
         Result := 47;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage >= 1000000) and (Avionics.MainComp < 15) then begin
         Result := 48;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (StrToInt(Data.GetComputerData(5, Avionics.MainComp)) > TechLevel) then begin
         Result := 49;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (StrToInt(Data.GetComputerData(5, Avionics.BakComp)) > TechLevel) then begin
         Result := 50;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (GetRemHardPoints < 0) then begin
         Result := 51;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < 11) and (SpinalMount.SpinalType = 1) then begin
         Result := 52;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < 8) and (SpinalMount.SpinalType = 2) then begin
         Result := 53;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (SpinalMount.SpinalType = 1) and (TechLevel < StrToInt(Data.GetSpnlMesData(3, SpinalMount.SpinalMount))) then begin
         Result := 54;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (SpinalMount.SpinalType = 2) and (TechLevel < StrToInt(Data.GetSpnlPAData(3, SpinalMount.SpinalMount))) then begin
         Result := 55;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TotalBigBays > 0) and (Tonnage < 1000) then begin
         Result := 56;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.MesonBays > 0) and (TechLevel < 13) then begin
         Result := 57;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.PABays > 0) and (TechLevel < 8) then begin
         Result := 58;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.RepulsorBays > 0) and (TechLevel < 10) then begin
         Result := 59;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TotalLittleBays > 0) and (Tonnage < 1000) then begin
         Result := 60;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      (* error disabled to allow for 50T bays to be installed below TL 10
      if (TotalLittleBays > 0) and (TechLevel < 10) then begin
         Result := 61;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      *)
      if (LittleBays.MesonBays > 0) and (TechLevel < 15) then begin
         Result := 62;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.PABays > 0) and (TechLevel < 10) then begin
         Result := 63;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.RepulsorBays > 0) and (TechLevel < 14) then begin
         Result := 64;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.MissileBays > 0) and (TechLevel < 10) then begin
         Result := 65;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.EnergyBays > 0) and (LittleBays.EnergyType = 0) and (TechLevel < 10) then begin
         Result := 66;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.EnergyBays > 0) and (LittleBays.EnergyType = 1) and (TechLevel < 12) then begin
         Result := 67;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Turrets.LaserTurrets > 0) and (Turrets.LaserType = 0) and (TechLevel < 9) then begin
         Result := 68;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Turrets.EnergyTurrets > 0) and (Turrets.EnergyType = 0) and (TechLevel < 10) then begin
         Result := 69;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Turrets.EnergyTurrets > 0) and (Turrets.EnergyType = 1) and (TechLevel < 12) then begin
         Result := 70;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Turrets.PATurrets > 0) and(TechLevel < 14) then begin
         Result := 71;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      //if (Turrets.MixTurretLasers > 0) and (Turrets.MixLaserType = 0) and( TechLevel < 9) then begin
      if (Turrets.MixTurretLasers > 0) and (Turrets.LaserType = 0) and( TechLevel < 9) then begin
         Result := 72;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Turrets.MixedTurrets = 0) and (Tonnage > 1000) then begin
         Result := 73;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (SpinalMount.SpinalType = 1) and (BigBays.MesonBays > 0) then begin
         Result := 74;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (SpinalMount.SpinalType = 1) and (LittleBays.MesonBays > 0) then begin
         Result := 75;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (SpinalMount.SpinalType = 2) and (BigBays.PABays > 0) then begin
         Result := 76;
         if (CurrentError < Result) then begin
            Exit;
         end;
     end;
      if (SpinalMount.SpinalType = 2) and (LittleBays.PABays > 0) then begin
         Result := 77;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (SpinalMount.SpinalType = 2) and (Turrets.PATurrets > 0) then begin
         Result := 78;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.MesonBays > 0) and (LittleBays.MesonBays > 0) then begin
         Result := 79;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.PABays > 0) and (LittleBays.PABays > 0) then begin
         Result := 80;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.RepulsorBays > 0) and (LittleBays.RepulsorBays > 0) then begin
         Result := 81;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.MissileBays > 0) and (LittleBays.MissileBays > 0) then begin
         Result := 82;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.PABays > 0) and (Turrets.PATurrets > 0) then begin
         Result := 83;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.MissileBays > 0) and (Turrets.MissileTurrets > 0) then begin
         Result := 84;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.MissileBays > 0) and (Turrets.MixTurretMissiles > 0) then begin
         Result := 85;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.PABays > 0) and (Turrets.PATurrets > 0) then begin
         Result := 86;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.MissileBays > 0) and (Turrets.MissileTurrets > 0) then begin
         Result := 87;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (BigBays.MissileBays > 0) and (Turrets.MixTurretMissiles > 0) then begin
         Result := 88;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (LittleBays.EnergyBays > 0) and (Turrets.EnergyTurrets > 0) then begin
         Result := 89;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < StrToInt(Data.GetNucDampData(2, Screens.NucDamp))) then begin
         Result := 90;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < StrToInt(Data.GetMesScrnData(2, Screens.MesScrn))) then begin
         Result := 91;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < StrToInt(Data.GetBlkGlbData(2, Screens.BlkGlb))) then begin
         Result := 92;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < StrToInt(Data.GetNucDampData(2, Screens.BakNucDamp))) then begin
         Result := 93;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < StrToInt(Data.GetMesScrnData(2, Screens.BakMesScrn))) then begin
         Result := 94;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < StrToInt(Data.GetBlkGlbData(2, Screens.BakBlkGlb))) then begin
         Result := 95;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < 9) and (Accom.LowBerth > 0) then begin
         Result := 96;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < 9) and (Accom.EmLowBerth > 0) then begin
         Result := 97;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (TechLevel < 10) and ((Accom.DropCaps + Accom.ReadyDropCaps + Accom.StoredDropCaps) > 0) then begin
         Result := 98;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.StRoom < CalcStRoom) and (Tonnage >= 100) then begin
         Result := 99;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.Couches < CalcCouches) and (Tonnage < 100) then begin
         Result := 100;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.LowBerth < CalcLowBerth) then begin
         Result := 101;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.DropCaps < 1) and (Accom.ReadyDropCaps > 0) then begin
         Result := 102;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.DropCaps < 1) and (Accom.StoredDropCaps > 0) then begin
         Result := 103;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.SmStRoom > 0) and (Tonnage >= 100) then begin
         Result := 104;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      (* Errors disabled to allow for couches and small staterooms in all vessels
      if (Accom.Couches > 0) and (Tonnage >= 100) then begin
         Result := 105;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Accom.StRoom > 0) and (Tonnage < 100) then begin
         Result := 106;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      *)
      if (Tonnage < 100) and not (IsSmallCraftComp(Avionics.MainComp)) then begin
         Result := 107;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
      if (Tonnage < 100) and not (IsSmallCraftComp(Avionics.BakComp)) then begin
         Result := 108;
         if (CurrentError < Result) then begin
            Exit;
         end;
      end;
   finally
      FreeAndNil(Data);
   end;
end;

function TShip.TotalBigBays: Integer;
//get the total number of 100t bays

begin
  Result := 0;
  with (Ship.BigBays) do
  begin
    if (RefitEmptyBays) then Result := Result + NewEmptyBays else Result := Result + EmptyBays;
    if (RefitMesonBays) then Result := Result + NewMesonBays else Result := Result + MesonBays;
    if (RefitPaBays) then Result := Result + NewPaBays else Result := Result + PaBays;
    if (RefitRepulsorBays) then Result := Result + NewRepulsorBays else Result := Result + RepulsorBays;
    if (RefitMissileBays) then Result := Result + NewMissileBays else Result := Result + MissileBays;
  end;
//  Result := BigBays.EmptyBays + BigBays.MesonBays + BigBays.PABays
//        + BigBays.RepulsorBays + BigBays.MissileBays;
end;

function TShip.TotalLittleBays: Integer;
//get the number of 50t bays

begin
  Result := 0;
  with (Ship.LittleBays) do
  begin
    if (RefitEmptyBays) then Result := Result + NewEmptyBays else Result := Result + EmptyBays;
    if (RefitMesonBays) then Result := Result + NewMesonBays else Result := Result + MesonBays;
    if (RefitPaBays) then Result := Result + NewPaBays else Result := Result + PaBays;
    if (RefitRepulsorBays) then Result := Result + NewRepulsorBays else Result := Result + RepulsorBays;
    if (RefitMissileBays) then Result := Result + NewMissileBays else Result := Result + MissileBays;
    if (RefitEnergyBays) then Result := Result + NewEnergyBays else Result := Result + EnergyBays;
  end;
  //Result := LittleBays.EmptyBays + LittleBays.MesonBays + LittleBays.PABays
  //    + LittleBays.RepulsorBays + LittleBays.MissileBays + LittleBays.EnergyBays;
end;

function TShip.CalcStRoom: Extended;
//calculate the number of staterooms required

var
   TotCmdCrew, TotCrew : Extended;
begin
   if (CrewRules = 0) then begin
      TotCmdCrew := 0;
      TotCrew := Eng.Crew + Avionics.Crew + SpinalMount.Crew + BigBays.Crew
            + LittleBays.Crew + Turrets.Crew + Screens.Crew + Craft.Crew
            + Accom.Crew + Accom.ShipsTroops + Max(0, Accom.Marines)
            + UserDef.Crew;
   end
   else begin
      TotCmdCrew := Eng.CmdCrew + Avionics.CmdCrew + Min(1, SpinalMount.CmdCrew
            + BigBays.CmdCrew + LittleBays.CmdCrew + Turrets.CmdCrew
            + Screens.CmdCrew) + Craft.CmdCrew + Accom.CmdCrew
            + Min(1, Accom.Marines) + MedicalCmdCrew + UserDef.CmdCrew;
      TotCrew := Eng.Crew + Avionics.Crew + SpinalMount.Crew + BigBays.Crew
            + LittleBays.Crew + Turrets.Crew + Screens.Crew + Craft.Crew
            + Accom.Crew + Accom.ShipsTroops + Max(0, Accom.Marines - 1)
            + MedicalCrew + UserDef.Crew;
   end;
   if (Accom.DblOccMark = 0) then begin
      Result := TotCmdCrew + (TotCrew / 2) + Accom.HighPass + Accom.MidPass;
   end
   else begin
      Result := TotCmdCrew + TotCrew + Accom.HighPass + Accom.MidPass;
   end;
   //if flagship add staterooms for admiral and staff
   if (Flagship) then
   begin
     if (Accom.DblOccMark = 0) then
     begin
        Result := Result + 6;
     end
     else
     begin
        Result := Result + 11;
     end;
   end;
end;

function TShip.CalcCouches: Integer;
//calculate the number of couches required

var
   TotCmdCrew, TotCrew : Integer;
begin
   TotCmdCrew := Eng.CmdCrew + Avionics.CmdCrew + Min(1, SpinalMount.CmdCrew
         + BigBays.CmdCrew + LittleBays.CmdCrew + Turrets.CmdCrew
         + Screens.CmdCrew) + Craft.CmdCrew + Accom.CmdCrew
         + Min(1, Accom.Marines) + UserDef.CmdCrew;
   TotCrew := Eng.Crew + Avionics.Crew + SpinalMount.Crew + BigBays.Crew
         + LittleBays.Crew + Turrets.Crew + Screens.Crew + Craft.Crew
         + Accom.Crew + Accom.ShipsTroops + Max(0, Accom.Marines - 1)
         + UserDef.Crew;
   if (Avionics.Bridge = 0) then begin
      Result :=  Max(0, TotCmdCrew + TotCrew + Accom.HighPass + Accom.MidPass - 2);
   end
   else begin
      Result :=  TotCmdCrew + TotCrew + Accom.HighPass + Accom.MidPass;
   end;
end;

function TShip.CalcLowBerth: Integer;
//calculate the number of low berths required

var
   TotCrew, FrozWatch : Integer;
begin
   TotCrew := GetTotalCmdCrew + GetTotalCrew;
   FrozWatch := Accom.FrozWatch;
   if (AlternateCrewRules > 1) then
   begin
     Result := Accom.LowPass + FloatToIntUp((TotCrew * FrozWatch) / 2);
   end
   else
   begin
     Result := Accom.LowPass + FloatToIntUp(CalcSizeCrewSections * FrozWatch);
   end;
end;

procedure TShip.HardCodedDefaults;
//hardcoded ship defaults, to be used if the default files are missing or corrupt

var
  ShipData, SubList : TStringList;
  iCount : Integer;
begin
  ShipData := TStringList.Create;
  SubList := TStringList.Create;
  try
    ShipData.Add(CURVER);
    ShipData.Add('"Fatima al-Fihri","Kuniko Inoguchi","Ketch","Andrea Vallance","AK",9,100.0000,39.0000,0,0,1,0,8,0.0000,0,0,0,0,0,0,0');
    ShipData.Add('6,0,1,1,0.0000,0,0');
    ShipData.Add('1,1,1,0,0,0,0,0,0,3.0000,0.0000,0,0,1,8,0,1,8,0,1,8,0,0,8,0,0,8,0,0,8,0,0,0,0,1.000,8,0,0.000,8,0,0.000,0,0,0,0,0,0,0,0,0');
    ShipData.Add('28,2,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0');
    ShipData.Add('4,0,0,0,1,0,2,0,0,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0');
    ShipData.Add('0,0,0.0000,0,0,0,0,0,0,0,0,0,0,0,0,0,0');
    ShipData.Add('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0');
    ShipData.Add('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0');
    ShipData.Add('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-42,0,0,0,0,0,0,0,0');
    ShipData.Add('0,0,0,0,0,0,0,0,0,0.0000');
    ShipData.Add('0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0,0.0000,0,0.0000');
    ShipData.Add('1,1,0,0,0,1.0,0.0,0,0,0,0.0000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0000,0,0');
    ShipData.Add('0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,' +'0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0');
    ShipData.Add('0,0,0,0,0.0000,0,0,0,0');
    ShipData.Add('Reserved for future expansion');
    ShipData.Add('Reserved for future expansion');
    ShipData.Add('Reserved for future expansion');
    ShipComments.Clear;
    AssignDefaults(ShipData[1]);
    Hull.AssignDefaults(ShipData[2]);
    Eng.AssignDefaults(ShipData[3]);
    Fuel.AssignDefaults(ShipData[4]);
    Avionics.AssignDefaults(ShipData[5]);
    SpinalMount.AssignDefaults(ShipData[6]);
    BigBays.AssignDefaults(ShipData[7]);
    LittleBays.AssignDefaults(ShipData[8]);
    Turrets.AssignDefaults(ShipData[9]);
    Screens.AssignDefaults(ShipData[10]);
    Craft.AssignDefaults(ShipData[11]);
    Accom.AssignDefaults(ShipData[12]);
    UserDef.AssignDefaults(ShipData[13]);

    //Options
    SubList.CommaText := ShipData[14];
    Options.ChargeForHardpoints := StrToInt(SubList[0]);
    Options.AutoCalcAccom := StrToInt(SubList[1]);
    Options.OptPowerTon := StrToInt(SubList[2]);
    Options.MilStdJump := StrToBool(SubList[3]);
    Options.MilStdMod := StrToFloat(SubList[4]);
    //lines 15, 16 and 17 reserved for expansion

    for iCount := 0 to 17 do
    begin
      ShipData.Delete(0);
    end;
    ShipComments.AddStrings(ShipData);

    DesignShip;
  finally
    FreeAndNil(ShipData);
    FreeAndNil(SubList);
  end;
end;

procedure TShip.ReadFromFile(TheFile: String);
//read a ship from a hgs file

var
   ShipData, SubList : TStringList;
   iCount : Integer;
begin
   ShipData := TStringList.Create;
   SubList := TStringList.Create;
   try
      ShipComments.Clear;
      ShipData.LoadFromFile(TheFile);
      AssignDefaults(ShipData[1]);
      Hull.AssignDefaults(ShipData[2]);
      Eng.AssignDefaults(ShipData[3]);
      Fuel.AssignDefaults(ShipData[4]);
      Avionics.AssignDefaults(ShipData[5]);
      SpinalMount.AssignDefaults(ShipData[6]);
      BigBays.AssignDefaults(ShipData[7]);
      LittleBays.AssignDefaults(ShipData[8]);
      Turrets.AssignDefaults(ShipData[9]);
      Screens.AssignDefaults(ShipData[10]);
      Craft.AssignDefaults(ShipData[11]);
      Accom.AssignDefaults(ShipData[12]);
      UserDef.AssignDefaults(ShipData[13]);

      //Options
      SubList.CommaText := ShipData[14];
      Options.ChargeForHardpoints := StrToInt(SubList[0]);
      Options.AutoCalcAccom := StrToInt(SubList[1]);
      Options.OptPowerTon := StrToInt(SubList[2]);
      Options.MilStdJump := StrToBool(SubList[3]);;
      Options.MilStdMod := StrToFloat(SubList[4]);
      //lines 14, 15 and 16 reserved for expansion

      for iCount := 0 to 17 do begin
         ShipData.Delete(0);
      end;
      ShipComments.AddStrings(ShipData);

      DesignShip;
   finally
      FreeAndNil(ShipData);
      FreeAndNil(SubList);
   end;
end;

procedure TShip.WriteToFile(TheFile: String);
//write a ship to a hgs file

var
   FileData : TStringList;
begin
   FileData := TStringList.Create;
   try
      FileData.Add(CURVER);
      FileData.Add(GenShipDetails);
      FileData.Add(GenHullDetails);
      FileData.Add(GenEngDetails);
      FileData.Add(GenFuelDetails);
      FileData.Add(GenAvionicsDetails);
      FileData.Add(GenSpinalMountDetails);
      FileData.Add(GenBigBaysDetails);
      FileData.Add(GenLittleBaysDetails);
      FileData.Add(GenTurretDetails);
      FileData.Add(GenScreenDetails);
      FileData.Add(GenCraftDetails);
      FileData.Add(GenAccomDetails);
      FileData.Add(GenUserDefDetails);
      FileData.Add(GenOptionsDetails);

      //reserved space
      FileData.Add('Reserved for future expansion');
      FileData.Add('Reserved for future expansion');
      FileData.Add('Reserved for future expansion');

      //comments
      FileData.AddStrings(ShipComments);
      FileData.SaveToFile(TheFile);
      //FileData.SaveToFile(ExtractFileDir(TheFile) + ExtractFileName(TheFile) + '_alpha.hgs');
   finally
      FreeAndNil(FileData);
   end;
end;

function TShip.ValidFile(TheFile: String): Boolean;
//check file is valid and update old versions

var
   MasterTestList, SubTestList, BakList : TStringList;
   iCount, rCount, iTest : Integer;
   UpdatedFuel : Integer;
   ReplaceFuel : String;
   StringOne, StringTwo, StringThree, StringFour, StringFive, StringSix,
         StringSeven, StringEight, StringNine, StringTen,
         StringEleven, StringTwelve, StringThirteen, StringFourteen,
         StringFifteen, StringSixteen: String;
   TestString : String;
   EarlyVersion : Boolean;
begin
   Result := True;
   EarlyVersion := False;
   MasterTestList := TStringList.Create;
   SubTestList := TStringList.Create;
   BakList := TStringList.Create;
   try
      MasterTestList.LoadFromFile(TheFile);
      BakList.LoadFromFile(TheFile);

      //update files earlier than 1.0.5.9
      if (NotInt(MasterTestList[0])) then begin
         EarlyVersion := True;
         MasterTestList.Insert(0, '10509');
         for iCount := 14 to 16 do begin
            MasterTestList.Insert(iCount, 'Reserved for future expansion');
         end;
         MasterTestList.SaveToFile(TheFile);
      end;

      //check if the file is the current version
      if (StrToInt(MasterTestList[0]) < StrToInt(CURVER)) then begin

         //update to version 1.0.5.12
         if (StrToInt(MasterTestList[0]) < 10512) then begin
            MasterTestList[0] := '10512';
            //add in fuel details
            SubTestList.CommaText := MasterTestList[4];
            SubTestList.Add('0.0000');
            for iCount := 1 to 3 do begin
               SubTestList.Add('0');
            end;
            StringFour := SubTestList[0];
            for iCount := 1 to SubTestList.Count - 1 do begin
               StringFour := StringFour + SEP + SubTestList[iCount];
            end;
            MasterTestList[4] := StringFour;
            SubTestList.Clear;
            //add accom details for t20 and frozen watches
            SubTestList.CommaText := MasterTestList[12];
            for iCount := 1 to 11 do begin
               SubTestList.Add('0');
            end;
            StringTwelve := SubTestList[0];
            for iCount := 1 to SubTestList.Count - 1 do begin
               StringTwelve := StringTwelve + SEP + SubTestList[iCount];
            end;
            MasterTestList[12] := StringTwelve;
            MasterTestList.SaveToFile(TheFile);
         end;

         //update to version 1.0.5.14
         if (StrToInt(MasterTestList[0]) < 10514) then begin
            MasterTestList[0] := '10514';
            MasterTestList.Insert(13, '0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,' + '0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0,0');
            MasterTestList.SaveToFile(TheFile);
         end;

         //update to version 2.0.0.0
         if (StrToInt(MasterTestList[0]) < 20000) then begin
            MasterTestList[0] := '20000';
            StringFive := MasterTestList[5];
            StringFive := StringFive + ',0,0,0,0,0,0,0,0,0,0,0,0,0';
            MasterTestList[5] := StringFive;
            MasterTestList.SaveToFile(TheFile);
         end;
      end;

      if (MasterTestList.Count < 16) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;

      //general ship details
      SubTestList.CommaText := MasterTestList[1];
      if (SubTestList.Count < 10) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count = 10) then begin
         SubTestList.Add('1');
         for iCount := 1 to 4 do begin
            SubTestList.Add('0')
         end;
         StringOne := TEXTMARK + SubTestList[0] + TEXTMARK;
         for iCount := 1 to 4 do begin
            StringOne := StringOne + ',' + TEXTMARK + SubTestList[iCount] + TEXTMARK;
         end;
         for iCount := 5 to SubTestList.Count - 1 do begin
            StringOne := StringOne + ',' + SubTestList[iCount];
         end;
         MasterTestList[1] := StringOne;
         MasterTestList.SaveToFile(TheFile);
      end;
      if (MasterTestList[0] = '10509') and (SubTestList[10] = '0')
            and (UpperCase(ParamStr(1)) <> 'T20') then begin
         SubTestList[11] := '1';
         StringOne := '';
         StringOne := TEXTMARK + SubTestList[0] + TEXTMARK;
         for iCount := 1 to 4 do begin
            StringOne := StringOne + ',' + TEXTMARK + SubTestList[iCount] + TEXTMARK;
         end;
         for iCount := 5 to SubTestList.Count - 1 do begin
            StringOne := StringOne + ',' + SubTestList[iCount];
         end;
         MasterTestList[1] := StringOne;
         MasterTestList.SaveToFile(TheFile);
      end;
      if (SubTestList.Count < 21) then
      begin
         StringOne := MasterTestList[1] + ',0,0,0,0,0,0';  //50
         MasterTestList[1] := StringOne;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[1];
      end;
      if (StrToIntDef(SubTestList[5], 3) = 3) and
            (StrToIntDef(SubTestList[5], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToFloatDef(SubTestList[6], 3) = 3) and
            (StrToFloatDef(SubTestList[6], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToFloatDef(SubTestList[7], 3) = 3) and
            (StrToFloatDef(SubTestList[7], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 8 to 12 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      for iCount := 13 to 13 do begin
         if (StrToFloatDef(SubTestList[iCount], 3) = 3) and
               (StrToFloatDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      for iCount := 14 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //hull details
      SubTestList.CommaText := MasterTestList[2];
      if (SubTestList.Count < 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count = 2) then begin
         for iCount := 1 to 2 do begin
            SubTestList.Add('1');
         end;
         for iCount := 3 to 5 do begin
            SubTestList.Add('0');
         end;
         StringTwo := SubTestList[0];
         for iCount := 1 to SubTestList.Count - 1 do begin
            StringTwo := StringTwo + ',' + SubTestList[iCount];
         end;
         MasterTestList[2] := StringTwo;
         MasterTestList.SaveToFile(TheFile);
      end;
      if (SubTestList.Count = 4) then begin
         for iCount := 1 to 3 do begin
            SubTestList.Add('0');
         end;
         StringTwo := SubTestList[0];
         for iCount := 1 to SubTestList.Count - 1 do begin
            StringTwo := StringTwo + ',' + SubTestList[iCount];
         end;
         MasterTestList[2] := StringTwo;
         MasterTestList.SaveToFile(TheFile);
      end;
      for iCount := 0 to 3 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[4], 3) = 3) and
            (StrToFloatDef(SubTestList[4], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 5 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //engineering details
      SubTestList.CommaText := MasterTestList[3];
      if (SubTestList.Count = 9) then begin
         SubTestList.Add('0.0000');
         SubTestList.Add('0.0000');
         SubTestList.Add('0');
         SubTestList.Add('0');
         SubTestList.Add('0');
         StringThree := MasterTestList[3] + ',0.0000,0.0000,0,0,0';
         MasterTestList[3] := StringThree;
         MasterTestList.SaveToFile(TheFile);
      end;
      if (SubTestList.Count < 14) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count < 50) then
      begin
         StringThree := MasterTestList[3] + ',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'   //30
                                          + ',0,0,0,0.0000,0,0,0.0000,0,0,0,0,0,0,0,0'  //45
                                          + ',0,0,0,0,0';  //50
         MasterTestList[3] := StringThree;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[3];
      end;
      for iCount := 0 to 8 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      for iCount := 9 to 10 do begin
         if (StrToFloatDef(SubTestList[iCount], 3) = 3) and
               (StrToFloatDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      for iCount := 11 to 33 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[34], 3) = 3) and
            (StrToFloatDef(SubTestList[34], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 35 to 36 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[37], 3) = 3) and
            (StrToFloatDef(SubTestList[37], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 38 to 39 do begin
         sTest := SubTestList[iCount];
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[40], 3) = 3) and
            (StrToFloatDef(SubTestList[40], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 41 to SubTestList.Count - 1 do begin
         sTest := SubTestList[iCount];
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //fuel details
      SubTestList.CommaText := MasterTestList[4];
      if (SubTestList.Count < 6) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count < 16) then begin
         StringFour := MasterTestList[4] + ',0,0,0,0,0,0';  //16
         MasterTestList[4] := StringFour;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[4];
      end;
      for iCount := 0 to 5 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[6], 3) = 3) and
            (StrToFloatDef(SubTestList[6], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToFloatDef(SubTestList[7], 3) = 3) and
            (StrToFloatDef(SubTestList[7], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 8 to 12 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[13], 3) = 3) and
            (StrToFloatDef(SubTestList[13], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      //14 15
      //update versions earlier than 10509 to account for 28 days fuel
      if (EarlyVersion) and (Result) then begin
         UpdatedFuel := Round((StrToInt(SubTestList[0]) / 30) * 28);
         ReplaceFuel := IntToStr(UpdatedFuel);
         for iCount := 1 to SubTestList.Count - 1 do begin
            ReplaceFuel := ReplaceFuel + SEP + SubTestList[iCount];
         end;
         MasterTestList[4] := ReplaceFuel;
         MasterTestList.SaveToFile(TheFile);
      end;

      //avionics details
      if (SubTestList.Count < 62) then begin
         StringFive := MasterTestList[5] + ',0,0,0,0,0,0,0,0,0,0,0,0' //30
                                         + ',0,0,0,0,0,0,0,0,0,0'     //40
                                         + ',0,0,0,0,0,0,0,0,0,0'     //50
                                         + ',0,0,0,0,0,0,0,0,0,0,0,0';//62
         MasterTestList[5] := StringFive;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[5];
      end;
      SubTestList.CommaText := MasterTestList[5];
      if (SubTestList.Count < 6) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 0 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //spinal mount details
      SubTestList.CommaText := MasterTestList[6];
      if (SubTestList.Count < 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count < 17) then begin
         StringSix := MasterTestList[6] + ',0.0000,0,0,0,0,0,0,0,0,0,0,0,0,0,0'; //16
         MasterTestList[6] := StringSix;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[6];
      end;
      if (StrToFloatDef(SubTestList[2], 3) = 3) and
            (StrToFloatDef(SubTestList[2], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 3 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //100 ton bay details
      SubTestList.CommaText := MasterTestList[7];
      if (SubTestList.Count < 5) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count < 27) then begin
         StringSeven := MasterTestList[7] + ',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'; //28
         MasterTestList[7] := StringSeven;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[7];
      end;
      for iCount := 0 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //50 ton bay details
      SubTestList.CommaText := MasterTestList[8];
      if (SubTestList.Count < 7) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count < 35) then begin
         StringEight := MasterTestList[8] + ',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'; //34
         MasterTestList[8] := StringEight;
         MasterTestList.SaveToFile(TheFile);
         SubTestList.Clear;
         SubTestList.CommaText := MasterTestList[8];
      end;
      for iCount := 0 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //turret details
      SubTestList.CommaText := MasterTestList[9];
      if (SubTestList.Count < 34) then
      begin
        StringNine := MasterTestList[9] + ',0,0,0,0,0,0,0';
        MasterTestList[9] := StringNine;
        MasterTestList.SaveToFile(TheFile);
        SubTestList.Clear;
        SubTestList.CommaText := MasterTestList[9];
      end;
      itest := SubTestList.count;
      if (SubTestList.Count < 34) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 0 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //screen details
      SubTestList.CommaText := MasterTestList[10];
      if (SubTestList.Count < 9) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count = 9) then begin
         for iCount := 0 to SubTestList.Count - 1 do begin
            if (StrToIntDef(SubTestList[iCount], 3) = 3) and
                  (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
               Result := False;
               BakList.SaveToFile(TheFile);
               Exit;
            end;
         end;
         SubTestList.Add('0.000');
         StringTen := SubTestList[0];
         for iCount := 1 to SubTestList.Count - 1 do begin
            StringTen := StringTen + ',' + SubTestList[iCount];
         end;
         MasterTestList[10] := StringTen;
         MasterTestList.SaveToFile(TheFile);
      end
      else begin
         for iCount := 0 to 8 do begin
            if (StrToIntDef(SubTestList[iCount], 3) = 3) and
                  (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
               Result := False;
               BakList.SaveToFile(TheFile);
               Exit;
            end;
         end;
         if (StrToFloatDef(SubTestList[9], 3) = 3) and
               (StrToFloatDef(SubTestList[10], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //craft details
      SubTestList.CommaText := MasterTestList[11];
      if (SubTestList.Count < 45) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (SubTestList.Count = 45) then begin
         for iCount := 0 to 7 do begin
            SubTestList.Insert((iCount * 6) + 5, '0.0000');
         end;
         for iCount := 1 to 3 do begin
            SubTestList.Add('0');
         end;
         StringEleven := SubTestList[0] + ',' + SubTestList[1] + ',' + TEXTMARK
               + SubTestList[2] + TEXTMARK + ',' + SubTestList[3] + ','
               + SubTestList[4] + ',' + SubTestList[5];
         for rCount := 1 to 7 do begin
            for iCount := 0 to 1 do begin
               StringEleven := StringEleven + ',' + SubTestList[(rCount * 6) + iCount];
            end;
            StringEleven := StringEleven + ',' + TEXTMARK + SubTestList[(rCount * 6) + 2] + TEXTMARK;
            for iCount := 3 to 5 do begin
               StringEleven := StringEleven + ',' + SubTestList[(rCount * 6) + iCount];
            end;
         end;
         for iCount := 48 to SubTestList.Count - 1 do begin
            StringEleven := StringEleven + ',' + SubTestList[iCount];
         end;
         MasterTestList[11] := StringEleven;
         MasterTestList.SaveToFile(TheFile);
      end;
      for rCount := 0 to 7 do begin
         if (StrToIntDef(SubTestList[rCount * 6], 3) = 3) and
               (StrToIntDef(SubTestList[rCount * 6], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
         if (StrToFloatDef(SubTestList[(rCount * 6) + 1], 3) = 3) and
               (StrToFloatDef(SubTestList[(rCount * 6) + 1], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
         for iCount := 3 to 4 do begin
            if (StrToIntDef(SubTestList[(rCount * 6) + iCount], 3) = 3) and
                  (StrToIntDef(SubTestList[(rCount * 6) + iCount], 2) = 2) then begin
               Result := False;
               BakList.SaveToFile(TheFile);
               Exit;
            end;
         end;
         if (StrToFloatDef(SubTestList[(rCount * 6) + 6], 3) = 3) and
               (StrToFloatDef(SubTestList[(rCount * 6) + 6], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToIntDef(SubTestList[48], 3) = 3) and
            (StrToIntDef(SubTestList[48], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToIntDef(SubTestList[49], 3) = 3) and
            (StrToIntDef(SubTestList[49], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToFloatDef(SubTestList[50], 3) = 3) and
            (StrToFloatDef(SubTestList[50], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToIntDef(SubTestList[51], 3) = 3) and
            (StrToIntDef(SubTestList[51], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      if (StrToFloatDef(SubTestList[52], 3) = 3) and
            (StrToFloatDef(SubTestList[52], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 1 to 3 do begin
         if (StrToIntDef(SubTestList[52 + iCount], 3) = 3) and
               (StrToIntDef(SubTestList[52 + iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //accommodations details
      SubTestList.CommaText := MasterTestList[12];
      if (SubTestList.Count < 28) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 0 to 4 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      for iCount := 5 to 6 do begin
         if (StrToFloatDef(SubTestList[iCount], 3) = 3) and
               (StrToFloatDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      for iCount := 7 to 9 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[10], 3) = 3) and
            (StrToFloatDef(SubTestList[10], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 11 to 24 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;
      if (StrToFloatDef(SubTestList[25], 3) = 3) and
            (StrToFloatDef(SubTestList[25], 2) = 2) then begin
         Result := False;
         BakList.SaveToFile(TheFile);
         Exit;
      end;
      for iCount := 26 to SubTestList.Count - 1 do begin
         if (StrToIntDef(SubTestList[iCount], 3) = 3) and
               (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //user defined
      SubTestList.CommaText := MasterTestList[13];
      for rCount := 0 to 7 do begin
         if (StrToIntDef(SubTestList[rCount * 10], 2) = 2) and
               (StrToIntDef(SubTestList[rCount * 10], 3) = 3) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
         if (StrToFloatDef(SubTestList[(rCount * 10) + 1], 2) = 2) and
               (StrToFloatDef(SubTestList[(rCount * 10) + 1], 3) = 3) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
         if (StrToIntDef(SubTestList[(rCount * 10) + 3], 2) = 2) and
               (StrToIntDef(SubTestList[(rCount * 10) + 3], 3) = 3) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
         for iCount := 4 to 5 do begin
            if (StrToFloatDef(SubTestList[(rCount * 10) + iCount], 2) = 2) and
                  (StrToFloatDef(SubTestList[(rCount * 10) + iCount], 3) = 3) then begin
               Result := False;
               BakList.SaveToFile(TheFile);
               Exit;
            end;
         end;
         if (StrToIntDef(SubTestList[(rCount * 10) + 6], 2) = 2) and
               (StrToIntDef(SubTestList[(rCount * 10) + 6], 3) = 3) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
      end;

      //options details
      if (MasterTestList.Count < 17) then begin
         MasterTestList.Add('0,0,0,0,0,0,0,0,0');
         MasterTestList.SaveToFile(TheFile);
      end
      else begin
         SubTestList.CommaText := MasterTestList[14];
         if (SubTestList.Count < 4) then
         begin
           StringFourteen := MasterTestList[14] + '0,0,0,0,0,0';
           MasterTestList[14] := StringFourteen;
           MasterTestList.SaveToFile(TheFile);
           SubTestList.Clear;
           SubTestList.CommaText := MasterTestList[14];
         end;
         for iCount := 0 to 3 do begin
            if (StrToIntDef(SubTestList[iCount], 3) = 3) and
                  (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
               Result := False;
               BakList.SaveToFile(TheFile);
               Exit;
            end;
         end;
         if (StrToFloatDef(SubTestList[4], 3) = 3) and
               (StrToFloatDef(SubTestList[4], 2) = 2) then begin
            Result := False;
            BakList.SaveToFile(TheFile);
            Exit;
         end;
         for iCount := 6 to SubTestList.Count - 1 do begin
            if (StrToIntDef(SubTestList[iCount], 3) = 3) and
                  (StrToIntDef(SubTestList[iCount], 2) = 2) then begin
               Result := False;
               BakList.SaveToFile(TheFile);
               Exit;
            end;
         end;
      end;
      //test lines 15, 16 and 17 here when neccessary
   finally
      FreeAndNil(MasterTestList);
      FreeAndNil(SubTestList);
      FreeAndNil(BakList);
   end;
end;

procedure TShip.ResetAllCrew;
//reset all the crew

begin
   Eng.CmdCrew := 0;
   Eng.Crew := 0;
   Avionics.CmdCrew := 0;
   Avionics.Crew := 0;
   SpinalMount.CmdCrew := 0;
   SpinalMount.Crew := 0;
   BigBays.CmdCrew := 0;
   BigBays.Crew := 0;
   LittleBays.CmdCrew := 0;
   LittleBays.Crew := 0;
   Turrets.CmdCrew := 0;
   Turrets.Crew := 0;
   Screens.CmdCrew := 0;
   Screens.Crew := 0;
   Craft.CmdCrew := 0;
   Craft.Crew := 0;
   Accom.CmdCrew := 0;
   Accom.Crew := 0;
   Accom.ShipsTroops := 0;
   Accom.Marines := 0;
   Accom.OtherCrew := 0;
   UserDef.CmdCrew := 0;
   UserDef.Crew := 0;
end;

function TShip.Agility: Integer;
//calculate the ship's agility

begin
   Result := Min(Eng.MDrive, StrToInt(FloatToStr(Int(GetRemPower / (Tonnage * 0.01)))));
end;

function TShip.WithTankAgility: Integer;
var
  WithTankTonnage: Extended;
begin
  WithTankTonnage := Tonnage + Fuel.CalcLhydFuel(Tonnage, Eng.PowerTons, Eng.PPlant,
                     TechLevel, ShipRace, DesignRules);
  Result := Min(Min(CalcDropTankMan, CalcDropTankPower),
            StrToInt(FloatToStr(Int(GetRemPower / (WithTankTonnage * 0.01)))));
end;

function TShip.StrToFloatDef(const S: string; Default: Extended): Extended;
//like StrToInfDef but with floating point values

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

procedure TShip.TextExport(TheFile: String);
//export the ship in descriptive format

var
   DescExp : TDescExp;
begin
   DescExp := TDescExp.Create;
   try
      GenerateUSP;
      DescExp.ExportShip(TheFile);
   finally
      FreeAndNil(DescExp);
   end;
end;

function TShip.IntToTrav(Value: Integer): String;
//convert a number to its traveller value

begin
  case (Value) of
    0..9: Result := IntToStr(Value);
    10: Result := 'A';
    11: Result := 'B';
    12: Result := 'C';
    13: Result := 'D';
    14: Result := 'E';
    15: Result := 'F';
    16: Result := 'G';
    17: Result := 'H';
    18: Result := 'J';
    19: Result := 'K';
    20: Result := 'L';
    21: Result := 'M';
    22: Result := 'N';
    23: Result := 'P';
    24: Result := 'Q';
    25: Result := 'R';

    //if the number is bigger than 25 its a high value
    else Result := UseHighValues(Value);
  end;
end;

function TShip.UseHighValues(Value: Integer): String;
//assign the high values to letters in sequence

begin
   if (zVal = 0) or (Value = zVal) then begin
      zVal := Value;
      Result := 'Z';
   end
   else if (yVal = 0) or (Value = yVal) then begin
      yVal := Value;
      Result := 'Y';
   end
   else if (xVal = 0) or (Value = xVal) then begin
      xVal := Value;
      Result := 'X';
   end
   else if (wVal = 0) or (Value = wVal) then begin
      wVal := Value;
      Result := 'W';
   end
   else if (vVal = 0) or (Value = vVal) then begin
      vVal := Value;
      Result := 'V';
   end
   else if (uVal = 0) or (Value = uVal) then begin
      uVal := Value;
      Result := 'U';
   end
   else if (tVal = 0) or (Value = tVal) then begin
      tVal := Value;
      Result := 'T';
   end
   else if (sVal = 0) or (Value = sVal) then begin
      sVal := Value;
      Result := 'S';
   end
   else begin
      Result := IntToStr(Value);
   end;
end;

function TShip.IntToTravBat(Value: Integer): String;
//Like IntToTrav, but returns an empty value for 0
//Use this for batteries and batteries bearing

begin
   case (Value) of
      0: Result := ' ';
      1..9: Result := IntToStr(Value);
      10: Result := 'A';
      11: Result := 'B';
      12: Result := 'C';
      13: Result := 'D';
      14: Result := 'E';
      15: Result := 'F';
      16: Result := 'G';
      17: Result := 'H';
      18: Result := 'J';
      19: Result := 'K';
      20: Result := 'L';
      21: Result := 'M';
      22: Result := 'N';
      23: Result := 'P';
      24: Result := 'Q';
      25: Result := 'R';
      else Result := UseHighValues(Value);
   end;
end;

function TShip.CalcArmour: Integer;
//calculate the armour for the USP. Take into account planetoid hulls

begin
   if (Hull.Config < 8) then begin
      Result := Hull.Armour;
   end
   else if (Hull.Config = 8) then begin
      Result := Hull.Armour + 3;
   end
   else begin
      Result := Hull.Armour + 6;
   end;
end;

procedure TShip.SetAlternateCrewRules(const AValue: Integer);
begin
  if FAlternateCrewRules=AValue then exit;
  FAlternateCrewRules:=AValue;
end;

procedure TShip.SetFlagship(const AValue: Boolean);
begin
  if FFlagship=AValue then exit;
  FFlagship:=AValue;
end;

procedure TShip.SetRefitPrice(const AValue: Extended);
begin
  if FRefitPrice=AValue then exit;
  FRefitPrice:=AValue;
end;

procedure TShip.GenerateUSP;
//this fills the usp string

var
   Analysis : TAnalysis;
   Data : TData;
   TempHolder, ArchFee : String;
   TankTonnage: Extended;
begin
   Analysis := TAnalysis.Create;
   Data := TData.Create;
   try
      Analysis.Analyise(-1);         //search here
      Data.InitialiseData;
      fUSP.Clear;
      //Header
      fUSP.Add('Ship: ' + ShipName);
      fUSP.Add('Class: ' + ShipClass);
      fUSP.Add('Type: ' + ShipType);
      fUSP.Add('Architect: ' + Architect);
      fUSP.Add('Tech Level: ' + IntToStr(TechLevel));
      if (IsRefitted) then
      begin
         fUSP.Add('Refit Tech Level: ' + IntToStr(RefitTechLevel));
      end;
      fUSP.Add('');
      fUSP.Add('USP');
      //The actual USP
      fUSP.Add(USPLineOne(Data, Analysis));
      //fUSP.Add(USPLineTwo(Analysis));
      fUSP.Add(USPLineThree(Analysis));
      fUSP.Add(USPLineTwo(Analysis));
      //switch lines 2 and 3
      //TempHolder := fUSP[8];
      //fUSP.Add(TempHolder);
      //fUSP.Delete(8);
      //Add the details
      fUSP.Add('');
      fUSP.Add(USPGeneral(Data));
      if (USPCraft <> '') then fUSP.Add(USPCraft);
      if (USPFuel <> '') then fUSP.Add(USPFuel);
      if (USPBackups(Data) <> '') then fUSP.Add(USPBackups(Data));
      if (USPSubs <> '') then fUSP.Add(USPSubs);
      //Add costs and architects fees
      fUSP.Add('');
      ArchFee := 'Architects Fee: MCr ';
      ArchFee := ArchFee + FloatToStrF((Price * 0.01), ffNumber, 18, 3);
      ArchFee := ArchFee + '   Cost in Quantity: MCr ';
      ArchFee := ArchFee + FloatToStrF((Price * 0.8) + CraftCost, ffNumber, 18, 3);
      fUSP.Add(ArchFee);
      if (Fuel.LhydJFuel > 0) or (Fuel.LhydPFuel > 0) then
      begin
         fUSP.Add('');
         fUSP.Add('With Drop Tanks');
         fUSP.Add('');
         fUSP.Add(WithTankUspLineOne(Data, Analysis));
         fUSP.Add(USPLineTwo(Analysis));
         fUSP.Add(USPLineThree(Analysis));
         //switch lines 2 and 3
         //TempHolder := fUSP[fUSP.Count - 1];
         //fUSP.Add(TempHolder);
         //fUSP.Delete(fUSP.Count - 2);
         //fUSP.Add('Agility: ' + IntToStr(WithTankAgility));
         TankTonnage := Fuel.CalcLhydFuel(Tonnage, Eng.PowerTons, Eng.PPlant,
                                         TechLevel, ShipRace, DesignRules);
         fUSP.Add('Drop Tanks Cost: MCr ' + FloatToStrF((TankTonnage / 1000), ffNumber, 18, 3))
      end;
   finally
      FreeAndNil(Analysis);
      FreeAndNil(Data)
   end;
end;

function TShip.USPLineOne(var Data: TData; var Analysis: TAnalysis): String;
//first line of the usp

var
  sMDrive, sJDrive, sPPlant: String;
begin
  if (Eng.MDriveIsRefitted) then sMDrive := IntToTrav(Eng.NewMDrive)
      else sMDrive := IntToTrav(Eng.MDrive);
  if (Eng.JDriveIsRefitted) then sJDrive := IntToTrav(Eng.NewJDrive)
      else sJDrive := IntToTrav(Eng.JDrive);
  if (Eng.PPlantIsRefitted) then sPPlant := IntToTrav(Eng.NewPPlant)
      else sPPlant := IntToTrav(Eng.PPlant);
  if DesignRules = 0 then
  begin
    Result := ('         ' + ShipCode + '-'
        + CalcSizeCode
        + IntToTrav(Hull.Config)
        + sJDrive
        + sMDrive
        + IntToTrav(T20PowerCode)
        + USPComputer(Data)
        + IntToTrav(CalcCrewCode) + '-'
        + IntToTrav(CalcArmour)
        + IntToTrav(Turrets.SandFact(TechLevel))
        + IntToTrav(Screens.MesScrn)
        + IntToTrav(Screens.NucDamp)
        + IntToTrav(Screens.BlkGlb)
        + IntToTrav(CalcRepulsorFactor) + '-'
        + IntToTrav(Turrets.LaserFact(TechLevel))
        + IntToTrav(CalcEnergyFactor)
        + CalcPaFactor
        + CalcMesonFactor
        + IntToTrav(CalcMissileFactor) + '-'
        + IntToTrav(Craft.FtrSqd) + ' '
        + ReportShipCost + ' '
        + ReportShipDisplacement);
  end
  else
  begin
    Result := ('         ' + ShipCode + '-'
        + CalcSizeCode
        + IntToTrav(Hull.Config)
        + sJDrive
        + sMDrive
        + sPPlant
        + USPComputer(Data)
        + IntToTrav(CalcCrewCode) + '-'
        + IntToTrav(CalcArmour)
        + IntToTrav(Turrets.SandFact(TechLevel))
        + IntToTrav(Screens.MesScrn)
        + IntToTrav(Screens.NucDamp)
        + IntToTrav(Screens.BlkGlb)
        + IntToTrav(CalcRepulsorFactor) + '-'
        + IntToTrav(Turrets.LaserFact(TechLevel))
        + IntToTrav(CalcEnergyFactor)
        + CalcPaFactor
        + CalcMesonFactor
        + IntToTrav(CalcMissileFactor) + '-'
        + IntToTrav(Craft.FtrSqd) + ' '
        + ReportShipCost + ' '
        + ReportShipDisplacement);
  end;
end;

function TShip.USPLineTwo(var Analysis: TAnalysis): String;
//second line of the usp
var
  sShipCodeSpacer: String;
  iCount: Integer;
begin
  sShipCodeSpacer := '';
  for iCount := 1 to Length(ShipCode) do
  begin
    sShipCodeSpacer := sShipCodeSpacer + ' ';
  end;
  Result := 'Bat                ' + sShipCodeSpacer
      + IntToTravBat(CalcSandBattery) + '   '
      + IntToTravBat(CalcRepulsorBattery) + ' '
      + IntToTravBat(CalcLaserBattery)
      + IntToTravBat(CalcEnergyBattery)
      + IntToTravBat(CalcPaBattery)
      + IntToTravBat(CalcMesonBattery)
      + IntToTravBat(CalcMissileBattery)
      + '   ' + 'TL: ' + IntToStr(TechLevel);
  if (IsRefitted) then
  begin
    Result := Result + '/' + IntToStr(RefitTechLevel);
  end;
end;

function TShip.USPLineThree(var Analysis: TAnalysis): String;
//third line of the usp
var
  sShipCodeSpacer: String;
  iCount: Integer;
begin
  sShipCodeSpacer := '';
  for iCount := 1 to Length(ShipCode) do
  begin
    sShipCodeSpacer := sShipCodeSpacer + ' ';
  end;
  Result := 'Bat Bear           ' + sShipCodeSpacer
      + IntToTravBat(CalcBatteryBearing(CalcSandBattery)) + '   '
      + IntToTravBat(CalcBatteryBearing(CalcRepulsorBattery)) + ' '
      + IntToTravBat(CalcBatteryBearing(CalcLaserBattery))
      + IntToTravBat(CalcBatteryBearing(CalcEnergyBattery))
      + IntToTravBat(CalcBatteryBearing(CalcPaBattery))
      + IntToTravBat(CalcBatteryBearing(CalcMesonBattery))
      + IntToTravBat(CalcBatteryBearing(CalcMissileBattery))
      + '   ' + 'Crew: ' + IntToStr(GetTotalCmdCrew + GetTotalCrew);
end;

function TShip.WithTankUspLineOne(var Data: TData; var Analysis: TAnalysis
  ): String;
begin
  if DesignRules = 0 then
  begin
    Result := ('         ' + ShipCode + '-'
        + CalcSizeCode
        + IntToTrav(Hull.Config)
        + IntToTrav(CalcDropTankJump)
        + IntToTrav(CalcDropTankMan)
        + IntToTrav(CalcDropTankPower)
        + USPComputer(Data)
        + IntToTrav(CalcCrewCode) + '-'
        + IntToTrav(CalcArmour)
        + IntToTrav(Turrets.SandFact(TechLevel))
        + IntToTrav(Screens.MesScrn)
        + IntToTrav(Screens.NucDamp)
        + IntToTrav(Screens.BlkGlb)
        + IntToTrav(CalcRepulsorFactor) + '-'
        + IntToTrav(Turrets.LaserFact(TechLevel))
        + IntToTrav(CalcEnergyFactor)
        + CalcPaFactor
        + CalcMesonFactor
        + IntToTrav(CalcMissileFactor) + '-'
        + IntToTrav(Craft.FtrSqd) + ' '
        + ReportShipCost + ' '
        + ReportDropTankDisplacement);
  end
  else
  begin
    Result := ('         ' + ShipCode + '-'
        + CalcSizeCode
        + IntToTrav(Hull.Config)
        + IntToTrav(CalcDropTankJump)
        + IntToTrav(CalcDropTankMan)
        + IntToTrav(CalcDropTankPower)
        + USPComputer(Data)
        + IntToTrav(CalcCrewCode) + '-'
        + IntToTrav(CalcArmour)
        + IntToTrav(Turrets.SandFact(TechLevel))
        + IntToTrav(Screens.MesScrn)
        + IntToTrav(Screens.NucDamp)
        + IntToTrav(Screens.BlkGlb)
        + IntToTrav(CalcRepulsorFactor) + '-'
        + IntToTrav(Turrets.LaserFact(TechLevel))
        + IntToTrav(CalcEnergyFactor)
        + CalcPaFactor
        + CalcMesonFactor
        + IntToTrav(CalcMissileFactor) + '-'
        + IntToTrav(Craft.FtrSqd) + ' '
        + ReportShipCost + ' '
        + ReportDropTankDisplacement);
  end;
end;

function TShip.USPComputer(var Data: TData): String;
//get the computer code for the usp

begin
  if (Avionics.RefitComp) then
  begin
    if (Tonnage < 100) and (Avionics.Bridge = 1) then
    begin
      if (Avionics.NewComp = 1) then
      begin
        Result := '0';
      end
      else if (Avionics.NewComp > 2) and (Avionics.NewComp < 9) then
      begin
        Result := Data.GetComputerData(1, (Avionics.NewComp - 3));
      end
      else
      begin
        Result := Data.GetComputerData(1, (Avionics.NewComp - 2));
      end;
    end
    else
    begin
      Result := Data.GetComputerData(1, Avionics.NewComp);
    end;
  end
  else
  begin
    if (Tonnage < 100) and (Avionics.Bridge = 1) then
    begin
      if (Avionics.MainComp = 1) then
      begin
        Result := '0';
      end
      else if (Avionics.MainComp > 2) and (Avionics.MainComp < 9) then
      begin
        Result := Data.GetComputerData(1, (Avionics.MainComp - 3));
      end
      else
      begin
        Result := Data.GetComputerData(1, (Avionics.MainComp - 2));
      end;
    end
    else
    begin
      Result := Data.GetComputerData(1, Avionics.MainComp);
    end;
  end;
end;

function TShip.USPCraft: String;
//get the craft details for the usp

var
   Carried : String;
begin
   Carried := '';
   if (Craft.Cr1Num > 0) or (Craft.Cr2Num > 0) or (Craft.Cr3Num > 0) or
         (Craft.Cr4Num > 0) or (Craft.Cr5Num > 0) or (Craft.Cr6Num > 0) or
         (Craft.Cr7Num > 0) or (Craft.Cr8Num > 0) then begin
      Carried := Carried + 'Craft:';
      if (Craft.Cr1Num > 0) then begin
         Carried := Carried + ' ' + IntToStr(Craft.Cr1Num) + ' x '
               + FloatToStr(Craft.Cr1Tonnage) + 'T ' + Craft.Cr1Desc;
         if (Craft.Cr1Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr2Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr2Num) + ' x '
               + FloatToStr(Craft.Cr2Tonnage) + 'T ' + Craft.Cr2Desc;
         if (Craft.Cr2Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr3Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr3Num) + ' x '
               + FloatToStr(Craft.Cr3Tonnage) + 'T ' + Craft.Cr3Desc;
         if (Craft.Cr3Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr4Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr4Num) + ' x '
               + FloatToStr(Craft.Cr4Tonnage) + 'T ' + Craft.Cr4Desc;
         if (Craft.Cr4Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr5Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr5Num) + ' x '
               + FloatToStr(Craft.Cr5Tonnage) + 'T ' + Craft.Cr5Desc;
         if (Craft.Cr5Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr6Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr6Num) + ' x '
               + FloatToStr(Craft.Cr6Tonnage) + 'T ' + Craft.Cr6Desc;
         if (Craft.Cr6Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr7Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr7Num) + ' x '
               + FloatToStr(Craft.Cr7Tonnage) + 'T ' + Craft.Cr7Desc;
         if (Craft.Cr7Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.Cr8Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.Cr8Num) + ' x '
               + FloatToStr(Craft.Cr8Tonnage) + 'T ' + Craft.Cr8Desc;
         if (Craft.Cr8Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.LF1Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.LF1Num) + ' '
               + FloatToStr(Craft.LF1Size) + 'T Launch Tube';
         if (Craft.LF1Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
      if (Craft.LF2Num > 0) then begin
         Carried := Carried + ', ' + IntToStr(Craft.LF2Num) + ' '
               + FloatToStr(Craft.LF2Size) + 'T Launch Tube';
         if (Craft.LF2Num > 1) then begin
            Carried := MakePlural(Carried);
         end;
      end;
   end;
   Result := Carried;
end;

function TShip.USPFuel: String;
//get the fuel details for the usp

var
   FuelData : String;
begin
   FuelData := '';
   if (Fuel.Scoops = 0) or (Fuel.Purif = 0) then begin
      FuelData := 'Fuel Treatment:';
      if (Fuel.Scoops = 0) then begin
         FuelData := FuelData + ' Fuel Scoops';
      end;
      if (Fuel.Scoops = 0) and (Fuel.Purif = 0) then begin
         FuelData := FuelData + ' and'
      end;
      if (Fuel.Purif = 0) then begin
         FuelData := FuelData + ' On Board Fuel Purification';
      end;
   end;
   Result := FuelData;
end;

function TShip.USPBackups(var Data: TData): String;
//get the backup details for the usp

var
  Bak : String;
  sBakMDrive, sNumBakMDrive, sBakJDrive, sNumBakJDrive,
  sBakPPlant, sNumBakPPlant, sBakPowerTons, sNumBakPowerTons: String;
begin
  Bak := '';
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

  if (StrToInt(sBakMDrive) > 0) or (StrToInt(sBakJDrive) > 0) or (StrToInt(sBakPPlant) > 0) or
      (StrToFloat(sBakPowerTons) > 0) or (Avionics.BakComp > 0) or (Avionics.BakBridge = 0) or
      (Screens.BakNucDamp > 0) or (Screens.BakMesScrn > 0) or (Screens.BakBlkGlb > 0) then
  begin
    Bak := 'Backups:';
    if (StrToInt(sBakMDrive) > 0) then
    begin
      Bak := Bak + ' ' + sNumBakMDrive + ' x ' + sBakMDrive
          + 'G Maneuver Drive';
      if (StrToInt(sNumBakMDrive) > 1) then Bak := MakePlural(Bak);
    end;
    if (StrToInt(sBakJDrive) > 0) then
    begin
      Bak := Bak + ' ' + sNumBakJDrive + ' x Jump ' + sBakJDrive
          + ' Drive';
      if (StrToInt(sNumBakJDrive) > 1) then Bak := MakePlural(Bak);
    end;
    if (StrToInt(sBakPPlant) > 0) and (DesignRules = 1) then
    begin
      Bak := Bak + ' ' + sNumBakPPlant + ' x Factor ' + sBakPPlant
          + ' Power Plant';
      if (StrToInt(sNumBakPPlant) > 1) then Bak := MakePlural(Bak);
    end;
    if (StrToFloat(sBakPowerTons) > 0) and (DesignRules = 0) then
    begin
      Bak := Bak + ' ' + sNumBakPowerTons + ' x ' + sBakPowerTons
          + ' Ton Power Plant';
      if (StrToInt(sNumBakPPlant) > 1) then Bak := MakePlural(Bak);
    end;
    if (Avionics.RefitBakComp) then
    begin
      if (Avionics.NewBakComp > 0) then
      begin
        Bak := Bak + ' ' + IntToStr(Avionics.NewBakCompNum) + ' x '
           + Copy(Data.GetComputerData(7, Avionics.NewBakComp), 3,
           Length(Data.GetComputerData(7, Avionics.NewBakComp))) + ' Computer';
        if (Avionics.NewBakCompNum > 1) then Bak := MakePlural(Bak);
      end;
    end
    else
    begin
      if (Avionics.BakComp > 0) then
      begin
        Bak := Bak + ' ' + IntToStr(Avionics.BakCompNum) + ' x '
           + Copy(Data.GetComputerData(7, Avionics.BakComp), 3,
           Length(Data.GetComputerData(7, Avionics.BakComp))) + ' Computer';
        if (Avionics.BakCompNum > 1) then Bak := MakePlural(Bak);
      end;
    end;
    if (Avionics.RefitBakBridge) then
    begin
      if (Avionics.BakBridge = 0) then
      begin
        Bak := Bak + ' ' + IntToStr(Avionics.NewBakBridgeNum) + ' x Bridge';
        if (Avionics.NewBakBridgeNum > 1) then Bak := MakePlural(Bak);
      end;
    end
    else
    begin
      if (Avionics.BakBridge = 0) then
      begin
        Bak := Bak + ' ' + IntToStr(Avionics.BakBridgeNum) + ' x Bridge';
        if (Avionics.BakBridgeNum > 1) then Bak := MakePlural(Bak);
      end;
    end;
    //screens
    if (Screens.BakNucDamp > 0) then
    begin
      Bak := Bak + ' ' + IntToStr(Screens.BakNucDampNum) + ' x Factor '
          + IntToStr(Screens.BakNucDamp) + ' Nuclear Damper';
      if (Screens.BakNucDampNum > 1) then Bak := MakePlural(Bak);
    end;
    if (Screens.BakMesScrn > 0) then
    begin
      Bak := Bak + ' ' + IntToStr(Screens.BakMesScrnNum) + ' x Factor '
         + IntToStr(Screens.BakMesScrn) + ' Meson Screen';
      if (Screens.BakMesScrnNum > 1) then Bak := MakePlural(Bak);
    end;
    if (Screens.BakBlkGlb > 0) then
    begin
      Bak := Bak + ' ' + IntToStr(Screens.BakBlkGlbNum) + ' x Factor '
          + IntToStr(Screens.BakBlkGlb) + ' Black Globe';
      if (Screens.BakBlkGlbNum > 1) then Bak := MakePlural(Bak);
    end;
  end;
  Result := Bak;
end;

function TShip.USPSubs: String;
//get the subsitution values for high values (those bigger than 25)

var
   Subs : String;
begin
   Subs := '';
   if (zVal > 0) then begin
      Subs := 'Substitutions:';
      if (sVal > 0) then begin
         Subs := Subs + ' ' + 'S = ' + IntToStr(sVal);
      end;
      if (tVal > 0) then begin
         Subs := Subs + ' ' + 'T = ' + IntToStr(tVal);
      end;
      if (uVal > 0) then begin
         Subs := Subs + ' ' + 'U = ' + IntToStr(uVal);
      end;
      if (vVal > 0) then begin
         Subs := Subs + ' ' + 'V = ' + IntToStr(vVal);
      end;
      if (wVal > 0) then begin
         Subs := Subs + ' ' + 'W = ' + IntToStr(wVal);
      end;
      if (xVal > 0) then begin
         Subs := Subs + ' ' + 'X = ' + IntToStr(xVal);
      end;
      if (yVal > 0) then begin
         Subs := Subs + ' ' + 'Y = ' + IntToStr(yVal);
      end;
      if (zVal > 0) then begin
         Subs := Subs + ' ' + 'Z = ' + IntToStr(zVal);
      end;
   end;
   Result := Subs;
end;

function TShip.CalcSizeCode: String;
begin
  case (FloatToIntDown(Tonnage / 100)) of
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

function TShip.CalcCrewCode: Integer;
var
  iTest: Integer;
begin
  iTest := AlternateCrewRules;
  case (AlternateCrewRules) of
    0..3: Result := CalcNumCrewSections;
    4..5: Result := CalcOldCrewCode;
  end;
  (*if (Options.UseOldCrewRules) then
  begin
    Result := CalcOldCrewCode;
  end
  else
  begin
    //Result := CalcSizeCrewSections;
    //Result := CalcNumCrewSections;
    case AlternateCrewRules of
      0: Result := CalcNumCrewSections;
      1: Result := CalcNumCrewSections;
      2: Result := CalcOldCrewCode;
    end;
  end;*)
end;

function TShip.CalcNumCrewSections: Integer;
var
  iSize: Integer;
begin
  case (AlternateCrewRules) of
    0: Result := FloatToIntUp(Tonnage / 1000);
    1: Result := CalcTd100Number;
    2: Result := CalcLog2Number;
  end;
end;

function TShip.CalcSizeCrewSections: Integer;
begin
  Result := FloatToIntUp((GetTotalCmdCrew + GetTotalCrew) / CalcNumCrewSections)
end;

function TShip.CalcOldCrewCode: Integer;
begin
  if (AlternateCrewRules = 4) then
  begin
    Case (GetTotalCmdCrew + GetTotalCrew) of
      0: Result := 0;
      1: Result := 1;
      2..10: Result := 2;
      11..100: Result := 3;
      101..1000: Result := 4;
      1001..2000: Result := 5;
      2001..3000: Result := 6;
      3001..4000: Result := 7;
      4001..5000: Result := 8;
      5001..6000: Result := 9;
      6001..7000: Result := 10;
      7001..8000: Result := 11;
      8001..9000: Result := 12;
      9001..10000: Result := 13;
      10001..11000: Result := 13;
      11001..12000: Result := 14;
      12001..13000: Result := 15;
      13001..14000: Result := 16;
      14001..15000: Result := 17;
      15001..16000: Result := 18;
      16001..17000: Result := 19;
      17001..18000: Result := 20;
      18001..19000: Result := 21;
      19001..20000: Result := 22;
      20001..21000: Result := 23;
      21001..22000: Result := 24;
      22001..23000: Result := 25;
      else Result := 26;
    end;
  end
  else
  begin
    case (GetTotalCmdCrew + GetTotalCrew) of
      0: Result := 0;
      1..9: Result := 1;
      10..99: Result := 2;
      100..999: Result := 3;
      1000..9999: Result := 4;
      10000..99999: Result := 5;
      100000..999999: Result := 6;
      1000000..9999999: Result := 7;
      10000000..99999999: Result := 8;
      100000000..899999999: Result := 9;  //var overflow after here
  (*    900000000..999999999: Result := '9';
      1000000000..9999999999: Result := 'A';
      10000000000..99999999999: Result := 'B';
      100000000000..999999999999: Result := 'C';
      1000000000000..9999999999999: Result := 'D';
      10000000000000..99999999999999: Result := 'E';
      100000000000000..999999999999999: Result := 'F;
      1000000000000000..9999999999999999: Result := 'G';*)
    end;
  end;
  (*if (Options.UseOldCrewRules) then
  begin
    case (GetTotalCmdCrew + GetTotalCrew) of
      0: Result := 0;
      1..9: Result := 1;
      10..99: Result := 2;
      100..999: Result := 3;
      1000..9999: Result := 4;
      10000..99999: Result := 5;
      100000..999999: Result := 6;
      1000000..9999999: Result := 7;
      10000000..99999999: Result := 8;
      100000000..899999999: Result := 9;  //var overflow after here
  (*    900000000..999999999: Result := '9';
      1000000000..9999999999: Result := 'A';
      10000000000..99999999999: Result := 'B';
      100000000000..999999999999: Result := 'C';
      1000000000000..9999999999999: Result := 'D';
      10000000000000..99999999999999: Result := 'E';
      100000000000000..999999999999999: Result := 'F;
      1000000000000000..9999999999999999: Result := 'G';*)(*
    end;
  end
  else
  begin
    Case (GetTotalCmdCrew + GetTotalCrew) of
      0: Result := 0;
      1: Result := 1;
      2..10: Result := 2;
      11..100: Result := 3;
      101..1000: Result := 4;
      1001..2000: Result := 5;
      2001..3000: Result := 6;
      3001..4000: Result := 7;
      4001..5000: Result := 8;
      5001..6000: Result := 9;
      6001..7000: Result := 10;
      7001..8000: Result := 11;
      8001..9000: Result := 12;
      9001..10000: Result := 13;
      10001..11000: Result := 13;
      11001..12000: Result := 14;
      12001..13000: Result := 15;
      13001..14000: Result := 16;
      14001..15000: Result := 17;
      15001..16000: Result := 18;
      16001..17000: Result := 19;
      17001..18000: Result := 20;
      18001..19000: Result := 21;
      19001..20000: Result := 22;
      20001..21000: Result := 23;
      21001..22000: Result := 24;
      22001..23000: Result := 25;
      else Result := 26;
    end;
  end;   *)
end;

function TShip.ReportShipCost: String;
var
  eCost : Extended;
begin
  eCost := Price + CraftCost;
  if (eCost < 1000000) then
  begin
    Result := 'MCr ' + FloatToStrF(eCost, ffNumber, 18, 3);
  end
  else if (eCost < 1000000000) then
  begin
    Result := 'GCr ' + FloatToStrF(eCost / 1000, ffNumber, 18, 3);
  end
  else
  begin
    Result := 'TCr ' + FloatToStrF(eCost / 1000000, ffNumber, 18, 3);
  end;
end;

function TShip.ReportShipDisplacement: String;
begin
  if (Tonnage < 1000) then
  begin
    Result := FloatToStr(Tonnage) + ' Tons';
  end
  else if (Ship.Tonnage < 1000000) then
  begin
    Result := FloatToStr(Tonnage / 1000) + ' KTons';
  end
  else
  begin
    Result := FloatToStr(Tonnage / 1000000) + ' MTons';
  end;
end;

function TShip.CalcBatteryBearing(NumBat: Integer): Integer;
begin
  if (NumBat = 0) then
  begin
    Result := 0;
  end
  else
  begin
    Result := Max(FloatToIntDown(NumBat * BatsBear), 1);
  end;
end;

function TShip.CalcSandBattery: Integer;
begin
  if (Turrets.SandFact(TechLevel) > 0) then
  begin
    if (Turrets.MixedTurrets = 0) then
    begin
      Result := Turrets.MixBatteries(Turrets.MixTurretSand);
    end
    else
    begin
      Result := Turrets.SandBatteries;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcRepulsorFactor: Integer;
var
  iBigTech, iLittleTech, iBigRep, iLittleRep: Integer;
begin
  with (BigBays) do
  begin
    if (RefitRepulsorBays) then
    begin
      iBigTech := RepulsorBaysRefitTech;
      iBigRep := NewRepulsorBays;
    end
    else
    begin
      iBigTech := TechLevel;
      iBigRep := RepulsorBays;
    end;
  end;
  with (LittleBays) do
  begin
    iLittleTech := TechLevel;
    iLittleRep := RepulsorBays;
  end;
  if (iBigRep > 0) or (iLittleRep > 0) then
  begin
    Result := Max(BigBays.RepulsorFactor(iBigTech), LittleBays.RepulsorFactor(iLittleTech));
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcRepulsorBattery: Integer;
var
  iBigRep, iLittleRep: Integer;
begin
  Result := 0;
  if BigBays.RefitRepulsorBays then iBigRep := BigBays.NewRepulsorBays
      else iBigRep := BigBays.RepulsorBays;
  if LittleBays.RefitRepulsorBays then iLittleRep := LittleBays.NewRepulsorBays
      else iLittleRep := LittleBays.RepulsorBays;
  //iLittleRep := LittleBays.RepulsorBays;
  if (iBigRep > 0) or (iLittleRep > 0) then
  begin
    Result := Max(iBigRep, iLittleRep);
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcLaserBattery: Integer;
begin
  Result := 0;
  if (Turrets.LaserFact(TechLevel) > 0) then
  begin
    if (Turrets.MixedTurrets = 0) then
    begin
      Result := Turrets.MixBatteries(Turrets.MixTurretLasers);
    end
    else
    begin
      Result := Turrets.LaserBatteries;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcEnergyFactor: Integer;
var
  iBayTech, iTurretTech: Integer;
begin
  if (LittleBays.RefitEnergyBays) then iBayTech := LittleBays.EnergyBaysRefitTech
      else iBayTech := TechLevel;
  if (LittleBays.EnergyFactor(iBayTech) > 0) or (Turrets.EnergyFact(TechLevel) > 0) then
  begin
    Result := Max(LittleBays.EnergyFactor(iBayTech), Turrets.EnergyFact(TechLevel));
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcEnergyBattery: Integer;
var
  iBays, iTurrets, iMixedTurrets: Integer;
begin
  Result := 0;
  if (LittleBays.RefitEnergyBays) then iBays := LittleBays.NewEnergyBays
      else iBays := LittleBays.EnergyBays;
  if (CalcEnergyFactor > 0) then
  begin
    if (Turrets.MixedTurrets = 0) and (Turrets.MixTurretEnergy > 0) then
    begin
      Result := Turrets.MixBatteries(Turrets.MixTurretEnergy);
    end
    else
    begin
      Result := Max(iBays,(Turrets.EnergyBatteries));
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcPaFactor: String;
var
  iBigTech, iLittleTech, iTurretTech, iBigPa, iLittlePa, iTurretPa: Integer;
begin
  with (BigBays) do
  begin
    if (RefitPaBays) then
    begin
      iBigTech := PaBaysRefitTech;
      iBigPa := NewPaBays;
    end
    else
    begin
      iBigTech := TechLevel;
      iBigPa := PaBays;
    end;
  end;
  with (LittleBays) do
  begin
    if (RefitPaBays) then
    begin
      iLittleTech := PaBaysRefitTech;
      iLittlePa := NewPaBays;
    end
    else
    begin
      iLittleTech := TechLevel;
      iLittlePa := PaBays;
    end;
  end;
  with (Turrets) do
  begin
    iTurretTech := TechLevel;
    iTurretPa := PaBatteries;
  end;

  if ((SpinalMount.SpinalType = 2) and (not IsRefitted))
      or ((SpinalMount.NewSpinalType = 2) and IsRefitted) then
  begin
    Result := SpinalMount.SpinalPAFactor;
  end
  else
  if (iBigPa > 0) or (iLittlePa > 0) then
  begin
    Result := IntToTrav(Max(BigBays.PaFactor(iBigTech), LittleBays.PaFactor(iLittleTech)));
  end
  else
  if (iTurretPa > 0) then
  begin
    Result := IntToTrav(Turrets.PaFact(iTurretTech));
  end
  else
  begin
    Result := '0';
  end;
end;

function TShip.CalcPaBattery: Integer;
var
  iBigPa, iLittlePa, iTurretPa: Integer;
begin
  Result := 0;
  if (BigBays.RefitPaBays) then iBigPa := BigBays.NewPaBays else iBigPa := BigBays.PABays;
  if (LittleBays.RefitPaBays) then iLittlePa := LittleBays.NewPaBays else iLittlePa := LittleBays.PABays;
  iTurretPa := Turrets.PABatteries;

  if ((SpinalMount.SpinalType = 2) and (not SpinalMount.RefitSpinalMount))
      or ((SpinalMount.NewSpinalType = 2) and (SpinalMount.RefitSpinalMount)) then
  begin
    Result := 1;
  end
  else
  begin
    if (iBigPa > 0) or (iLittlePa > 0) or (iTurretPa > 0) then
    begin
      Result := MaxValue([iBigPa, iLittlePa, iTurretPa]);
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TShip.CalcMesonFactor: String;
var
  iBigTech, iLittleTech, iBigMeson, iLittleMeson: Integer;
begin
  with (BigBays) do begin
    if (RefitMesonBays) then
    begin
      iBigTech := MesonBaysRefitTech;
      iBigMeson := NewMesonBays;
    end
    else
    begin
      iBigTech := TechLevel;
      iBigMeson := MesonBays;
    end;
  end;
  with (LittleBays) do
  begin
    if (RefitMesonBays) then
    begin
      iLittleTech := MesonBaysRefitTech;
      iLittleMeson := NewMesonBays;
    end
    else
    begin
      iLittleTech := TechLevel;
      iLittleMeson := MesonBays;
    end;
  end;

  if ((SpinalMount.SpinalType = 1) and (not SpinalMount.RefitSpinalMount))
      or ((SpinalMount.NewSpinalType = 1) and (SpinalMount.RefitSpinalMount)) then
  begin
    Result := SpinalMount.SpinalMesonFactor;
  end
  else
  if (iBigMeson > 0) or (iLittleMeson > 0) then
  begin
    Result := IntToTrav(Max(BigBays.MesonFactor(iBigTech), LittleBays.MesonFactor(iLittleTech)));
  end
  else
  begin
    Result := '0';
  end;
end;

function TShip.CalcMesonBattery: Integer;
var
  iBigMeson, iLittleMeson: Integer;
begin
  Result := 0;
  if (SpinalMount.SpinalType = 1) or (SpinalMount.NewSpinalType = 1) then
  begin
    Result := 1;
  end
  else
  begin
    if (BigBays.RefitMesonBays) then iBigMeson := BigBays.NewMesonBays
        else iBigMeson := BigBays.MesonBays;
    if (LittleBays.RefitMesonBays) then iLittleMeson := LittleBays.NewMesonBays
        else iLittleMeson := LittleBays.MesonBays;
    if (iBigMeson > 0) or (iLittleMeson > 0) then
    begin
      Result := Max(iBigMeson, iLittleMeson);
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TShip.CalcMissileFactor: Integer;
var
  iBigTech, iLittleTech, iTurretTech, iBigMissile, iLittleMissile, iTurretMissile: Integer;
begin
  with (BigBays) do
  begin
    if (RefitMissileBays) then
    begin
      iBigTech := MissileBaysRefitTech;
      iBigMissile := NewMissileBays;
    end
    else
    begin
      iBigTech := TechLevel;
      iBigMissile := MissileBays;
    end;
  end;
  with (LittleBays) do
  begin
    if (RefitMissileBays) then
    begin
      iLittleTech := MissileBaysRefitTech;
      iLittleMissile := NewMissileBays;
    end
    else
    begin
      iLittleTech := TechLevel;
      iLittleMissile := MissileBays;
    end;
  end;
  with (Turrets) do
  begin
    iTurretTech := TechLevel;
    iTurretMissile := MissileBatteries;
  end;

  if (BigBays.MissileFactor(iBigTech) > 0)
      or (LittleBays.MissileFactor(iLittleTech) > 0)
      or (Turrets.MissileFact(iTurretTech) > 0) then
  begin
    Result := MaxValue([BigBays.MissileFactor(iBigTech), LittleBays.MissileFactor(iLittleTech),
                  Turrets.MissileFact(iTurretTech)]);
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.CalcMissileBattery: Integer;
var
  iBigTech, iLittleTech, iTurretTech, iBigMissile, iLittleMissile, iTurretMissile,
  iMixedMissile: Integer;
begin
  Result := 0;
  iBigMissile := 0;
  iLittleMissile := 0;
  iTurretMissile := 0;
  with (BigBays) do
  begin
    if (RefitMissileBays) then
    begin
      iBigTech := MissileBaysRefitTech;
      iBigMissile := NewMissileBays;
    end
    else
    begin
      iBigTech := TechLevel;
      iBigMissile := MissileBays;
    end;
  end;
  with (LittleBays) do
  begin
    if (RefitMissileBays) then
    begin
      iLittleTech := MissileBaysRefitTech;
      iLittleMissile := NewMissileBays;
    end
    else
    begin
      iLittleTech := TechLevel;
      iLittleMissile := MissileBays;
    end;
  end;
  with (Turrets) do
  begin
    iTurretTech := TechLevel;
    iTurretMissile := MissileBatteries;
    iMixedMissile := MixBatteries(MixTurretMissiles);
  end;

  if (CalcMissileFactor > 0) then
  begin
    Result := MaxValue([iBigMissile, iLittleMissile, iTurretMissile, iMixedMissile]);
  end
  else
  begin
    Result := 0;
  end;
end;

function TShip.BatsBear: Extended;
begin
  case (FloatToIntDown(Tonnage / 100)) of
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

function TShip.USPGeneral(Data: TData): String;
//get the general details for the ups (fuel, passengers, cargo, troops etc)

var
  Gen : String;
  FuelTons : Extended;
  ePowerTons: Extended;
  iPPlant, PowerTonsTech: Integer;
begin
  if (Ship.Eng.PowerTonsIsRefitted) then ePowerTons := Ship.Eng.NewPowerTons
      else ePowerTons := Ship.Eng.PowerTons;
  if (Ship.Eng.PPlantIsRefitted) then iPPlant := Ship.Eng.NewPPlant
      else iPPlant := Ship.Eng.PPlant;
  Gen := '';
  //
  //cargo
  if (Accom.AutoCargoMark = 0) then
  begin
    if (Frac(Accom.Cargo) <> 0) then
    begin
      Gen := 'Cargo: ' + FloatToStrF(Accom.Cargo + Eng.UpgradeSpaceAvailable, ffNumber, 18, 3);
    end
    else
    begin
      Gen := 'Cargo: ' + FloatToStrF(Accom.Cargo + Eng.UpgradeSpaceAvailable, ffNumber, 18, 0);
    end;
  end
  else
  begin
    if (Frac(GetRemTonnage) <> 0) then
    begin
      Gen := 'Cargo: ' + FloatToStrF(GetRemTonnage + Eng.UpgradeSpaceAvailable, ffNumber, 18, 3);
    end
    else
    begin
      Gen := 'Cargo: ' + FloatToStrF(GetRemTonnage + Eng.UpgradeSpaceAvailable, ffNumber, 18, 0);
    end;
  end;

  //passengers
  if ((Accom.HighPass + Accom.MidPass) > 0) then
  begin
    Gen := Gen + ' Passengers: ' + IntToStr(Accom.HighPass + Accom.MidPass);
  end;

  //crew sections
  if  (AlternateCrewRules < 2) then
  begin
    Gen := Gen + ' Crew Sections: ' + IntToStr(CalcNumCrewSections)
        + ' of ' + IntToStr(CalcSizeCrewSections);
  end;
  (*  if  not (Options.UseOldCrewRules) then
    begin
      if (AlternateCrewRules < 2) then
      begin
        Gen := Gen + ' Crew Sections: ' + IntToStr(CalcNumCrewSections)
            + ' of ' + IntToStr(CalcSizeCrewSections);
      end;
    end;   *)
  //frozen watch
  if (Accom.FrozWatch > 0) then
  begin
    Gen := Gen + ' Frozen Watch';
    if (Accom.FrozWatch > 1) then
    begin
      Gen := Gen + ' (x' + IntToStr(Accom.FrozWatch) + ')';
    end;
  end;

  //low passengers
  if (Accom.LowPass > 0) then
  begin
    Gen := Gen + ' Low: ' + IntToStr(Accom.LowPass);
  end;
  if (Accom.EmLowBerth > 0) then
  begin
    Gen := Gen + ' Emergency Low: ' + IntToStr(Accom.EmLowBerth);
  end;

  //fuel
  //FuelTons := Max((Tonnage * (((Fuel.PFuel / 28)  * Eng.PPlant) * 0.01))
  //   + (Tonnage * (Fuel.JFuel * 0.1)) + Fuel.ExtraFuel, 1);
  if (Eng.PowerTonsIsRefitted) then
  begin
    PowerTonsTech := Eng.PowerTonsRefitTech;
  end
  else
  begin
    PowerTonsTech := TechLevel;
  end;
  FuelTons := Fuel.FuelSpace(Tonnage, ePowerTons, iPPlant, PowerTonsTech, ShipRace, DesignRules);
  if (Frac(FuelTons) <> 0) then
  begin
    Gen := Gen + ' Fuel: ' + FloatToStrF(FuelTons, ffNumber, 18, 3);
  end
  else
  begin
    Gen := Gen + ' Fuel: ' + FloatToStrF(FuelTons, ffNumber, 18, 0);
  end;

  //ep, agility
  if (Frac(Eng.Power) <> 0) then
  begin
    Gen := Gen + ' EP: ' + FloatToStrF(Eng.Power, ffNumber, 18, 3);
  end
  else
  begin
    Gen := Gen + ' EP: ' + FloatToStrF(Eng.Power, ffNumber, 18, 0);
  end;
  Gen := Gen + ' Agility: ' + IntToStr(Agility);

  //troops and security details
  if (Accom.ShipsTroops > 0) then
  begin
    Gen := Gen + ' Shipboard Security Detail: ' + IntToStr(Accom.ShipsTroops);
  end;
  if (Accom.Marines > 0) then
  begin
    Gen := Gen + ' Marines: ' + IntToStr(Accom.Marines);
  end;

  //drop capsules
  if (Accom.DropCaps > 0) then
  begin
    Gen := Gen + ' Drop Capsules: ' + IntToStr(Accom.DropCaps);
    if (Accom.ReadyDropCaps > 0) or (Accom.StoredDropCaps > 0) then
    begin
      Gen := Gen + ' (plus';
      if (Accom.ReadyDropCaps > 0) then
      begin
        Gen := Gen + ' ' + IntToStr(Accom.ReadyDropCaps) + ' Ready';
      end;
      if (Accom.StoredDropCaps > 0) then
      begin
        Gen := Gen + ' ' + IntToStr(Accom.StoredDropCaps) + ' Stored';
      end;
      Gen := Gen + ')';
    end;
  end;

  //pulse lasers
  if (Turrets.LaserTurrets > 0) or (Turrets.MixTurretLasers > 0) then
  begin
    if (Turrets.MixedTurrets = 1) and (Turrets.LaserType = 1) then
    begin
      Gen := Gen + ' Pulse Lasers';
    end
    //else if (Turrets.MixedTurrets = 0) and (Turrets.MixLaserType = 1) then
    else if (Turrets.MixedTurrets = 0) and (Turrets.LaserType = 1) then
    begin
      Gen := Gen + ' Pulse Lasers';
    end;
  end;

  //flag items
  if (FlagShip) then
  begin
    Gen := Gen + '  Fitted as Flagship: Accomodation for Admiral and ten staff';
    if (Avionics.FlagBridge) and ((Avionics.NewFlagComp > 0) or (Avionics.FlagComp > 0)) then
    begin
      if (Avionics.RefitFlagComp) then
      begin
        Gen := Gen + ' with Flag Bridge and ' + Copy(Data.GetComputerData(7, Avionics.NewFlagComp), 3,
            Length(Data.GetComputerData(7, Avionics.NewFlagComp))) + ' Flag Computer';
      end
      else
      begin
        Gen := Gen + ' with Flag Bridge and ' + Copy(Data.GetComputerData(7, Avionics.FlagComp), 3,
            Length(Data.GetComputerData(7, Avionics.FlagComp))) + ' Flag Computer';
      end;
    end
    else if (Avionics.FlagBridge) and ((Avionics.NewFlagComp = 0) and (Avionics.FlagComp = 0)) then
    begin
      Gen := Gen + ' with Flag Bridge';
    end
    else if (not (Avionics.FlagBridge)) and ((Avionics.NewFlagComp > 0) or (Avionics.FlagComp > 0)) then
    begin
      if (Avionics.RefitFlagComp) then
      begin
        Gen := Gen + ' with ' + Copy(Data.GetComputerData(7, Avionics.NewFlagComp), 3,
            Length(Data.GetComputerData(7, Avionics.NewFlagComp))) + ' Flag Computer';
      end
      else
      begin
        Gen := Gen + ' with ' + Copy(Data.GetComputerData(7, Avionics.FlagComp), 3,
            Length(Data.GetComputerData(7, Avionics.FlagComp))) + ' Flag Computer';
      end;
    end;
  end;

  Result := Gen;
end;

function TShip.CraftCost: Extended;
//calculate the cost of carried craft

begin
   Result := (Craft.Cr1Num * Craft.Cr1Price)
         + (Craft.Cr2Num * Craft.Cr2Price)
         + (Craft.Cr3Num * Craft.Cr3Price)
         + (Craft.Cr4Num * Craft.Cr4Price)
         + (Craft.Cr5Num * Craft.Cr5Price)
         + (Craft.Cr6Num * Craft.Cr6Price)
         + (Craft.Cr7Num * Craft.Cr7Price)
         + (Craft.Cr8Num * Craft.Cr8Price);
end;

function TShip.GetFuelTons: Extended;
var
  ePowerTons: Extended;
  iPPlant: Integer;
begin
  if (Eng.PowerTonsIsRefitted) then ePowerTons := Eng.NewPowerTons
      else ePowerTons := Eng.PowerTons;
  if (Eng.PPlantIsRefitted) then iPPlant := Eng.NewPPlant
      else iPPlant := Eng.PPlant;
  Result := Fuel.FuelSpace(Tonnage, ePowerTons, iPPlant, TechLevel,
                           ShipRace, DesignRules);
end;

function TShip.NotInt(TheString: String): Boolean;
//see if a string is NOT an integer

begin
   Result := False;
   if (StrToIntDef(TheString, 2) = 2)
         and (StrToIntDef(TheString, 3) = 3) then begin
      Result := True;
   end;
end;

function TShip.FloatToIntDown(TheFloat: Extended): Integer;
//convert a float to an int rounding down
//replace with trunc?

begin
   Result := StrToInt(FloatToStr(Int(TheFloat)));
end;

function TShip.FloatToIntUp(TheFloat: Extended): Integer;
//convert a float to an int rounding up

begin
   if ((TheFloat - Int(TheFloat)) <> 0) then begin
      Result := FloatToIntDown(TheFloat) + 1;
   end
   else begin
      Result := FloatToIntDown(TheFloat);
   end;
end;

procedure TShip.ReadFromForm(var ShipData: TStringList);
//read from a form for design assistant

var
   SubList : TStringList;
   iCount : Integer;
begin
   SubList := TStringList.Create;
   try
      ShipComments.Clear;
      AssignDefaults(ShipData[1]);
      Hull.AssignDefaults(ShipData[2]);
      Eng.AssignDefaults(ShipData[3]);
      Fuel.AssignDefaults(ShipData[4]);
      Avionics.AssignDefaults(ShipData[5]);
      SpinalMount.AssignDefaults(ShipData[6]);
      BigBays.AssignDefaults(ShipData[7]);
      LittleBays.AssignDefaults(ShipData[8]);
      Turrets.AssignDefaults(ShipData[9]);
      Screens.AssignDefaults(ShipData[10]);
      Craft.AssignDefaults(ShipData[11]);
      Accom.AssignDefaults(ShipData[12]);
      UserDef.AssignDefaults(ShipData[13]);

      //Options
      SubList.CommaText := ShipData[14];
      Options.ChargeForHardpoints := StrToInt(SubList[0]);
//      Options.AutoCalcAccom := StrToInt(SubList[1]);
      Options.OptPowerTon := StrToInt(SubList[2]);
      Options.MilStdJump := StrToBool(SubList[3]);
      Options.MilStdMod := StrToFloat(SubList[4]);
      //lines 15, 16 and 17 reserved for expansion
(*
      for iCount := 0 to 17 do begin
         ShipData.Delete(0);
      end;
      ShipComments.AddStrings(ShipData);
*)
      DesignShip;
   finally
      FreeAndNil(SubList);
   end;
end;

function TShip.GetCurver: String;
//get the current file version

begin
   Result := CURVER;
end;

function TShip.GenShipDetails: String;
//generate ship file details

begin
   Result := TEXTMARK + ShipName + TEXTMARK
         + SEP + TEXTMARK + ShipClass + TEXTMARK
         + SEP + TEXTMARK + ShipType + TEXTMARK
         + SEP + TEXTMARK + Architect + TEXTMARK
         + SEP + TEXTMARK + ShipCode + TEXTMARK
         + SEP + IntToStr(TechLevel)
         + SEP + FloatToStrF(Tonnage, ffFixed, 19, 4)
         + SEP + FloatToStrF(Budget, ffFixed, 19, 4)
         + SEP + IntToStr(ShipRace)
         + SEP + IntToStr(CrewRules)
         + SEP + IntToStr(DesignRules)
         + SEP + BoolToStr(IsRefitted)
         + SEP + IntToStr(RefitTechLevel)
         + SEP + FloatToStrF(RefitBudget, ffFixed, 19, 4)
         + SEP + IntToStr(AlternateCrewRules)
         + SEP + BoolToStr(Flagship)
         + SEP + '0'     //wiggle room
         + SEP + '0'     //wiggle room
         + SEP + '0'     //wiggle room
         + SEP + '0'     //wiggle room
         + SEP + '0';     //wiggle room   20
end;

function TShip.GenHullDetails: String;
//generate hull file details

begin
   Result := IntToStr(Hull.Config)
         + SEP + IntToStr(Hull.Armour)
         + SEP + IntToStr(Hull.Streamlining)
         + SEP + IntToStr(Hull.Airframe)
         + SEP + FloatToStrF(Hull.Structure, ffFixed, 19, 4)
         + SEP + '0'      //wiggle room
         + SEP + '0';     //wiggle room
end;

function TShip.GenEngDetails: String;
//generate engineering file details

begin
   Result := IntToStr(Eng.MDrive)
         + SEP + IntToStr(Eng.JDrive)
         + SEP + IntToStr(Eng.PPlant)
         + SEP + IntToStr(Eng.BakMDrive)
         + SEP + IntToStr(Eng.BakJDrive)
         + SEP + IntToStr(Eng.BakPPlant)
         + SEP + IntToStr(Eng.BakMDNum)
         + SEP + IntToStr(Eng.BakJDNum)
         + SEP + IntToStr(Eng.BakPPNum)
         + SEP + FloatToStrF(Eng.PowerTons, ffFixed, 19, 4)
         + SEP + FloatToStrF(Eng.BakPowerTons, ffFixed, 19, 4)

         + SEP + IntToStr(Eng.BakPowerTonsNum)                     //11
         + SEP + BoolToStr(Eng.MDriveIsRefitted)                   //12
         + SEP + IntToStr(Eng.NewMDrive)                           //13
         + SEP + IntToStr(Eng.MDriveRefitTech)                     //14
         + SEP + BoolToStr(Eng.JDriveIsRefitted)                   //15
         + SEP + IntToStr(Eng.NewJDrive)                           //16
         + SEP + IntToStr(Eng.JDriveRefitTech)                     //17
         + SEP + BoolToStr(Eng.PPlantIsRefitted)                   //18
         + SEP + IntToStr(Eng.NewPPlant)                           //19
         + SEP + IntToStr(Eng.PPlantRefitTech)                     //20
         + SEP + BoolToStr(Eng.BakMDriveIsRefitted)                //21
         + SEP + IntToStr(Eng.BakNewMDrive)                        //22
         + SEP + IntToStr(Eng.BakMDriveRefitTech)                  //23
         + SEP + BoolToStr(Eng.BakJDriveIsRefitted)                //24
         + SEP + IntToStr(Eng.BakNewJDrive)                        //25
         + SEP + IntToStr(Eng.BakJDriveRefitTech)                  //26
         + SEP + BoolToStr(Eng.BakPPlantIsRefitted)                //27
         + SEP + IntToStr(Eng.BakNewPPlant)                        //28
         + SEP + IntToStr(Eng.BakPPlantRefitTech)                  //29
         + SEP + IntToStr(Eng.BakNewMDNumb)                        //30
         + SEP + IntToStr(Eng.BakNewJDNumb)                        //31
         + SEP + IntToStr(Eng.BakNewPPNumb)                        //32
         + SEP + BoolToStr(Eng.PowerTonsIsRefitted)                //33
         + SEP + FloatToStrF(Eng.NewPowerTons, ffFixed, 19, 3)     //34 float
         + SEP + IntToStr(Eng.PowerTonsRefitTech)                  //35
         + SEP + BoolToStr(Eng.BakPowerTonsIsRefitted)             //36
         + SEP + FloatToStrF(Eng.BakNewPowerTons, ffFixed, 19, 3)  //37 float
         + SEP + IntToStr(Eng.BakPowerTonsRefitTech)               //38
         + SEP + IntToStr(Eng.BakNewPowerTonsNum)                  //39

         + SEP + FloatToStrF(Eng.UpgradeSpace, ffFixed, 19, 3)     //40 float
         + SEP + BoolToStr(Eng.SingleEngSpace)                     //41
         + SEP + BoolToStr(Eng.DriveUpgradesAllowed)               //42
         + SEP + '0'      //wiggle room
         + SEP + '0'      //wiggle room
         + SEP + '0'      //wiggle room
         + SEP + '0'      //wiggle room
         + SEP + '0'      //wiggle room
         + SEP + '0'      //wiggle room
         + SEP + '0';     //wiggle room
end;

function TShip.GenFuelDetails: String;
//generate fuel file details

begin
   Result := IntToStr(Fuel.PFuel)
         + SEP + IntToStr(Fuel.JFuel)
         + SEP + IntToStr(Fuel.Scoops)
         + SEP + IntToStr(Fuel.Purif)
         + SEP + IntToStr(Fuel.LhydPFuel)
         + SEP + IntToStr(Fuel.LhydJFuel)
         + SEP + FloatToStrF(Fuel.ExtraFuel, ffFixed, 19, 4)
         + SEP + FloatToStrF(Fuel.LhydExtraFuel, ffFixed, 19, 4)
         + SEP + BoolToStr(Fuel.PurifyLHyd)
         + SEP + BoolToStr(Fuel.RefitPurif)
         + SEP + IntToStr(Fuel.RefitPurifTech)                        //10
         + SEP + IntToStr(Fuel.BasePFuel)                             //11
         + SEP + IntToStr(Fuel.BaseJFuel)                             //12
         + SEP + FloatToStrF(Fuel.BaseEFuel, ffFixed, 19, 4)          //13
         + SEP + '0'                 //wiggle room 14
         + SEP + '0'                 //wiggle room 15
         ;  //terminator
end;

function TShip.GenAvionicsDetails: String;
//generate avionics file details

begin
   Result := IntToStr(Avionics.MainComp)
         + SEP + IntToStr(Avionics.BakComp)
         + SEP + IntToStr(Avionics.BakCompNum)
         + SEP + IntToStr(Avionics.Bridge)
         + SEP + IntToStr(Avionics.BakBridge)
         + SEP + IntToStr(Avionics.BakBridgeNum)
         + SEP + IntToStr(Avionics.FltAvionics)
         + SEP + IntToStr(Avionics.BakFltAvionics)
         + SEP + IntToStr(Avionics.BakFltAvionicsNum)
         + SEP + IntToStr(Avionics.Sensors)
         + SEP + IntToStr(Avionics.BakSensors)
         + SEP + IntToStr(Avionics.BakSensorsNum)
         + SEP + IntToStr(Avionics.Comms)
         + SEP + IntToStr(Avionics.BakComms)
         + SEP + IntToStr(Avionics.BakCommsNum)
         + SEP + IntToStr(Avionics.CommsType)
         + SEP + BoolToStr(Avionics.FlagBridge)
         + SEP + IntToStr(Avionics.FlagComp)
         + SEP + BoolToStr(Avionics.RefitBridge)
         + SEP + BoolToStr(Avionics.RefitBakBridge)         //19
         + SEP + BoolToStr(Avionics.RefitComp)              //20
         + SEP + BoolToStr(Avionics.RefitBakComp)           //21
         + SEP + BoolToStr(Avionics.RefitFlagComp)          //22
         + SEP + BoolToStr(Avionics.RefitFltAvionics)       //23
         + SEP + BoolToStr(Avionics.RefitBakFltAvionics)    //24
         + SEP + BoolToStr(Avionics.RefitSensors)           //25
         + SEP + BoolToStr(Avionics.RefitBakSensors)        //26
         + SEP + BoolToStr(Avionics.RefitComms)             //27
         + SEP + BoolToStr(Avionics.RefitBakComms)          //28
         + SEP + IntToStr(Avionics.CompRefitTech)           //29
         + SEP + IntToStr(Avionics.BakCompRefitTech)        //30
         + SEP + IntToStr(Avionics.FlagCompRefitTech)       //31
         + SEP + IntToStr(Avionics.FltAvionicsRefitTech)    //32
         + SEP + IntToStr(Avionics.BakFltAvionicsRefitTech) //33
         + SEP + IntToStr(Avionics.SensorsRefitTech)        //34
         + SEP + IntToStr(Avionics.BakSensorsRefitTech)     //35
         + SEP + IntToStr(Avionics.CommsRefitTech)          //36
         + SEP + IntToStr(Avionics.BakCommsRefitTech)       //37
         + SEP + IntToStr(Avionics.NewComp)                 //38
         + SEP + IntToStr(Avionics.NewBakComp)              //39
         + SEP + IntToStr(Avionics.NewFlagComp)             //40
         + SEP + IntToStr(Avionics.NewFltAvionics)          //41
         + SEP + IntToStr(Avionics.NewBakFltAvionics)       //42
         + SEP + IntToStr(Avionics.NewSensors)              //43
         + SEP + IntToStr(Avionics.NewBakSensors)           //44
         + SEP + IntToStr(Avionics.NewComms)                //45
         + SEP + IntToStr(Avionics.NewBakComms)             //46
         + SEP + IntToStr(Avionics.NewBakBridgeNum)         //47
         + SEP + IntToStr(Avionics.NewBakCompNum)           //48
         + SEP + IntToStr(Avionics.NewBakFltAvionicsNum)    //49
         + SEP + IntToStr(Avionics.NewBakSensorsNum)        //50
         + SEP + IntToStr(Avionics.NewBakCommsNum)          //51
         + SEP + IntToStr(Avionics.NewCommsType)            //52
         + SEP + BoolToStr(Avionics.RefitCommsType)         //53
         + SEP + IntToStr(Avionics.CommsTypeRefitTech)      //54
         + SEP + BoolToStr(Avionics.RefitFlagBridge)        //55
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         ;  //terminator
end;

function TShip.GenSpinalMountDetails: String;
//generate spinal mount file details

begin
   Result := IntToStr(SpinalMount.SpinalType)
         + SEP + IntToStr(SpinalMount.SpinalMount)
         + SEP + FloatToStrF(SpinalMount.UpgradeSpace , ffFixed, 19, 4)    //2
         + SEP + BoolToStr(SpinalMount.RefitSpinalMount)                   //3
         + SEP + IntToStr(SpinalMount.SpinalMountRefitTech)                //4
         + SEP + IntToStr(SpinalMount.NewSpinalType)                       //5
         + SEP + IntToStr(SpinalMount.NewSpinalMount)                      //6
         + SEP + '0'                                                       //7
         + SEP + '0'                                                       //8
         + SEP + '0'                                                       //9
         + SEP + '0'                                                       //10
         + SEP + '0'                                                       //11
         + SEP + '0'                                                       //12
         + SEP + '0'                                                       //13
         + SEP + '0'                                                       //14
         + SEP + '0'                                                       //15
         + SEP + '0'                                                       //16
         ; //terminator
end;

function TShip.GenBigBaysDetails: String;
//generate 100 ton bay file details

begin
   Result := IntToStr(BigBays.EmptyBays)
         + SEP + IntToStr(BigBays.MesonBays)
         + SEP + IntToStr(BigBays.PABays)
         + SEP + IntToStr(BigBays.RepulsorBays)
         + SEP + IntToStr(BigBays.MissileBays)
         + SEP + BoolToStr(BigBays.RefitEmptyBays)       //5
         + SEP + BoolToStr(BigBays.RefitMesonBays)       //6
         + SEP + BoolToStr(BigBays.RefitPaBays)          //7
         + SEP + BoolToStr(BigBays.RefitRepulsorBays)    //8
         + SEP + BoolToStr(BigBays.RefitMissileBays)     //9
         + SEP + IntToStr(BigBays.MesonBaysRefitTech)    //10
         + SEP + IntToStr(BigBays.PaBaysRefitTech)       //11
         + SEP + IntToStr(BigBays.RepulsorBaysRefitTech) //12
         + SEP + IntToStr(BigBays.MissileBaysRefitTech)  //13
         + SEP + IntToStr(BigBays.NewEmptyBays)          //14
         + SEP + IntToStr(BigBays.NewMesonBays)          //15
         + SEP + IntToStr(BigBays.NewPaBays)             //16
         + SEP + IntToStr(BigBays.NewRepulsorBays)       //17
         + SEP + IntToStr(BigBays.NewMissileBays)        //18
         + SEP + '0'                                     //19
         + SEP + '0'                                     //20
         + SEP + '0'                                     //21
         + SEP + '0'                                     //22
         + SEP + '0'                                     //23
         + SEP + '0'                                     //24
         + SEP + '0'                                     //25
         + SEP + '0'                                     //26
         + SEP + '0'                                     //27
         + SEP + '0'                                     //28
         ;  //terminator
end;

function TShip.GenLittleBaysDetails: String;
//generate 50 ton bay file details

begin
   Result := IntToStr(LittleBays.EmptyBays)
         + SEP + IntToStr(LittleBays.MesonBays)
         + SEP + IntToStr(LittleBays.PABays)
         + SEP + IntToStr(LittleBays.RepulsorBays)
         + SEP + IntToStr(LittleBays.MissileBays)
         + SEP + IntToStr(LittleBays.EnergyBays)
         + SEP + IntToStr(LittleBays.EnergyType)
         + SEP + BoolToStr(LittleBays.RefitEmptyBays)       //7
         + SEP + BoolToStr(LittleBays.RefitMesonBays)       //8
         + SEP + BoolToStr(LittleBays.RefitPaBays)          //9
         + SEP + BoolToStr(LittleBays.RefitRepulsorBays)    //10
         + SEP + BoolToStr(LittleBays.RefitMissileBays)     //11
         + SEP + BoolToStr(LittleBays.RefitEnergyBays)      //12
         + SEP + IntToStr(LittleBays.MesonBaysRefitTech)    //13
         + SEP + IntToStr(LittleBays.PaBaysRefitTech)       //14
         + SEP + IntToStr(LittleBays.RepulsorBaysRefitTech) //15
         + SEP + IntToStr(LittleBays.MissileBaysRefitTech)  //16
         + SEP + IntToStr(LittleBays.EnergyBaysRefitTech)   //17
         + SEP + IntToStr(LittleBays.NewEmptyBays)          //18
         + SEP + IntToStr(LittleBays.NewMesonBays)          //19
         + SEP + IntToStr(LittleBays.NewPaBays)             //20
         + SEP + IntToStr(LittleBays.NewRepulsorBays)       //21
         + SEP + IntToStr(LittleBays.NewMissileBays)        //22
         + SEP + IntToStr(LittleBays.NewEnergyBays)         //23
         + SEP + IntToStr(LittleBays.NewEnergyType)         //24
         + SEP + '0'                                        //25
         + SEP + '0'                                        //26
         + SEP + '0'                                        //27
         + SEP + '0'                                        //28
         + SEP + '0'                                        //29
         + SEP + '0'                                        //30
         + SEP + '0'                                        //31
         + SEP + '0'                                        //32
         + SEP + '0'                                        //33
         + SEP + '0'                                        //34
         ;  //terminator
end;

function TShip.GenTurretDetails: String;
//generate turret file details

begin
   Result := IntToStr(Turrets.EmptyTurrets)
         + SEP + IntToStr(Turrets.EmptyTurretStyle)
         + SEP + IntToStr(Turrets.MissileTurrets)
         + SEP + IntToStr(Turrets.MissileTurretStyle)
         + SEP + IntToStr(Turrets.MissileBatteries)
         + SEP + IntToStr(Turrets.LaserTurrets)
         + SEP + IntToStr(Turrets.LaserTurretStyle)
         + SEP + IntToStr(Turrets.LaserBatteries)
         + SEP + IntToStr(Turrets.LaserType)
         + SEP + IntToStr(Turrets.EnergyTurrets)
         + SEP + IntToStr(Turrets.EnergyTurretStyle)
         + SEP + IntToStr(Turrets.EnergyBatteries)
         + SEP + IntToStr(Turrets.EnergyType)
         + SEP + IntToStr(Turrets.SandTurrets)
         + SEP + IntToStr(Turrets.SandTurretStyle)
         + SEP + IntToStr(Turrets.SandBatteries)
         + SEP + IntToStr(Turrets.PATurrets)
         + SEP + IntToStr(Turrets.PATurretStyle)
         + SEP + IntToStr(Turrets.PABatteries)

         //mixed turrets info
         + SEP + IntToStr(Turrets.MixedTurrets)
         + SEP + IntToStr(Turrets.NumMixTurrets)
         + SEP + IntToStr(Turrets.EmptyMixTurrets)
         + SEP + IntToStr(Turrets.MixTurretStyle)
         + SEP + IntToStr(Turrets.MixTurretMissiles)
         + SEP + IntToStr(Turrets.MixTurretLasers)
         //+ SEP + IntToStr(Turrets.MixLaserType)
         + SEP + '-42'
         + SEP + IntToStr(Turrets.MixTurretSand)
         + SEP + IntToStr(Turrets.MixTurretEnergy)
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0';
end;

function TShip.GenScreenDetails: String;
//generate screen file details

begin
   Result := IntToStr(Screens.NucDamp)
         + SEP + IntToStr(Screens.MesScrn)
         + SEP + IntToStr(Screens.BlkGlb)
         + SEP + IntToStr(Screens.BakNucDamp)
         + SEP + IntToStr(Screens.BakMesScrn)
         + SEP + IntToStr(Screens.BakBlkGlb)
         + SEP + IntToStr(Screens.BakNucDampNum)
         + SEP + IntToStr(Screens.BakMesScrnNum)
         + SEP + IntToStr(Screens.BakBlkGlbNum)
         + SEP + FloatToStrF(Screens.ExtraCaps, ffFixed, 19, 4);
end;

function TShip.GenCraftDetails: String;
//generate craft file details

begin
   Result := IntToStr(Craft.Cr1Num)
            + SEP + FloatToStrF(Craft.Cr1Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr1Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr1Crew)
            + SEP + IntToStr(Craft.Cr1Vehicle)
            + SEP + FloatToStrF(Craft.Cr1Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr2Num)
            + SEP + FloatToStrF(Craft.Cr2Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr2Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr2Crew)
            + SEP + IntToStr(Craft.Cr2Vehicle)
            + SEP + FloatToStrF(Craft.Cr2Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr3Num)
            + SEP + FloatToStrF(Craft.Cr3Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr3Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr3Crew)
            + SEP + IntToStr(Craft.Cr3Vehicle)
            + SEP + FloatToStrF(Craft.Cr3Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr4Num)
            + SEP + FloatToStrF(Craft.Cr4Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr4Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr4Crew)
            + SEP + IntToStr(Craft.Cr4Vehicle)
            + SEP + FloatToStrF(Craft.Cr4Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr5Num)
            + SEP + FloatToStrF(Craft.Cr5Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr5Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr5Crew)
            + SEP + IntToStr(Craft.Cr5Vehicle)
            + SEP + FloatToStrF(Craft.Cr5Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr6Num)
            + SEP + FloatToStrF(Craft.Cr6Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr6Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr6Crew)
            + SEP + IntToStr(Craft.Cr6Vehicle)
            + SEP + FloatToStrF(Craft.Cr6Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr7Num)
            + SEP + FloatToStrF(Craft.Cr7Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr7Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr7Crew)
            + SEP + IntToStr(Craft.Cr7Vehicle)
            + SEP + FloatToStrF(Craft.Cr7Price, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.Cr8Num)
            + SEP + FloatToStrF(Craft.Cr8Tonnage, ffFixed, 19, 4)
            + SEP + TEXTMARK + Craft.Cr8Desc + TEXTMARK
            + SEP + IntToStr(Craft.Cr8Crew)
            + SEP + IntToStr(Craft.Cr8Vehicle)
            + SEP + FloatToStrF(Craft.Cr8Price, ffFixed, 19, 4)

         //fighter squadrons and launch facilities info
         + SEP + IntToStr(Craft.FtrSqd)
         + SEP + IntToStr(Craft.LF1Num)
            + SEP + FloatToStrF(Craft.LF1Size, ffFixed, 19, 4)
         + SEP + IntToStr(Craft.LF2Num)
            + SEP + FloatToStrF(Craft.LF2Size, ffFixed, 19, 4)
         + SEP + '0'     //wiggle room
         + SEP + '0'     //wiggle room
         + SEP + '0';    //wiggle room
end;

function TShip.GenAccomDetails: String;
//generate accommodation and misc file details

begin
   Result := IntToStr(Accom.DblOccMark)
         + SEP + IntToStr(Accom.ShpTrpMark)
         + SEP + IntToStr(Accom.HighPass)
         + SEP + IntToStr(Accom.MidPass)
         + SEP + IntToStr(Accom.LowPass)
         + SEP + FloatToStrF(Accom.StRoom, ffFixed, 19, 1)
         + SEP + FloatToStrF(Accom.SmStRoom, ffFixed, 19, 1)
         + SEP + IntToStr(Accom.Couches)
         + SEP + IntToStr(Accom.LowBerth)
         + SEP + IntToStr(Accom.EmLowBerth)
         + SEP + FloatToStrF(Accom.Cargo, ffFixed, 19, 4)
         + SEP + IntToStr(Accom.AutoCargoMark)
         + SEP + IntToStr(Accom.Marines)
         + SEP + IntToStr(Accom.OtherCrew)
         + SEP + IntToStr(Accom.DropCaps)
         + SEP + IntToStr(Accom.ReadyDropCaps)
         + SEP + IntToStr(Accom.StoredDropCaps)
         + SEP + IntToStr(Accom.FrozWatch)
         + SEP + IntToStr(Accom.EngShop)
         + SEP + IntToStr(Accom.VehicleShop)
         + SEP + IntToStr(Accom.Labs)
         + SEP + IntToStr(Accom.SickBay)
         + SEP + IntToStr(Accom.AutoDoc)
         + SEP + IntToStr(Accom.Airlock)
         + SEP + IntToStr(Accom.Fresher)
         + SEP + FloatToStrF(Accom.MissileMag, ffFixed, 19, 4)
         + SEP + '0'      //wiggle room
         + SEP + '0';     //wiggle room
end;

function TShip.GenOptionsDetails: String;
//generate options file details

begin
   Result := IntToStr(Options.ChargeForHardpoints)
         + SEP + IntToStr(Options.AutoCalcAccom)
         + SEP + IntToStr(Options.OptPowerTon)
         + SEP + BoolToStr(Options.MilStdJump)
         + SEP + FloatToStrF(Options.MilStdMod, ffFixed, 19, 4)
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0';
end;

function TShip.GenUserDefDetails: String;
//generate user defaults file details

begin
   Result := IntToStr(UserDef.Item1Num)
            + SEP + FloatToStrF(UserDef.Item1Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item1Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item1Crew)
            + SEP + FloatToStrF(UserDef.Item1Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item1Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item1Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item2Num)
            + SEP + FloatToStrF(UserDef.Item2Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item2Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item2Crew)
            + SEP + FloatToStrF(UserDef.Item2Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item2Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item2Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item3Num)
            + SEP + FloatToStrF(UserDef.Item3Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item3Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item3Crew)
            + SEP + FloatToStrF(UserDef.Item3Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item3Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item3Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item4Num)
            + SEP + FloatToStrF(UserDef.Item4Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item4Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item4Crew)
            + SEP + FloatToStrF(UserDef.Item4Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item4Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item4Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item5Num)
            + SEP + FloatToStrF(UserDef.Item5Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item5Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item5Crew)
            + SEP + FloatToStrF(UserDef.Item5Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item5Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item5Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item6Num)
            + SEP + FloatToStrF(UserDef.Item6Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item6Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item6Crew)
            + SEP + FloatToStrF(UserDef.Item6Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item6Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item6Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item7Num)
            + SEP + FloatToStrF(UserDef.Item7Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item7Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item7Crew)
            + SEP + FloatToStrF(UserDef.Item7Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item7Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item7Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + IntToStr(UserDef.Item8Num)
            + SEP + FloatToStrf(UserDef.Item8Size, ffFixed, 19, 4)
            + SEP + TEXTMARK + UserDef.Item8Desc + TEXTMARK
            + SEP + IntToStr(UserDef.Item8Crew)
            + SEP + FloatToStrF(UserDef.Item8Ep, ffFixed, 19, 4)
            + SEP + FloatToStrF(UserDef.Item8Cost, ffFixed, 19, 4)
            + SEP + IntToStr(UserDef.Item8Hp)
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + '0'        //general wiggle room
         + SEP + '0'        //general wiggle room
         + SEP + '0';       //general wiggle room
end;

function TShip.ComponentExport(TheFile : String; DoWrite : Boolean) : TStringList;
var
  CompExp : TCompExp;
  ExportData : TStringList;
begin
  CompExp := TCompExp.Create;
  ExportData := TStringList.Create;
  try
    CompExp.ComponentExportShip(TheFile, DoWrite, ExportData);
  finally
    FreeAndNil(CompExp);
    FreeAndNil(ExportData)
  end;
end;

procedure TShip.SetEngRefitTech(iTech: Integer);
begin
  Eng.MDriveRefitTech := iTech;
  Eng.JDriveRefitTech := iTech;
  Eng.PPlantRefitTech := iTech;
  Eng.PowerTonsRefitTech := iTech;
  Eng.BakMDriveRefitTech := iTech;
  Eng.BakJDriveRefitTech := iTech;
  Eng.BakPPlantRefitTech := iTech;
  Eng.BakPowerTonsRefitTech := iTech;
end;

procedure TShip.SetFuelRefitTech(iTech: Integer);
begin
  Fuel.RefitPurifTech := iTech;
end;

procedure TShip.SetAvionicsRefitTech(iTech: Integer);
begin
  Avionics.CompRefitTech := iTech;
  Avionics.BakCompRefitTech := iTech;
  Avionics.FlagCompRefitTech := iTech;
  Avionics.FltAvionicsRefitTech := iTech;
  Avionics.BakFltAvionicsRefitTech := iTech;
  Avionics.SensorsRefitTech := iTech;
  Avionics.BakSensorsRefitTech := iTech;
  Avionics.CommsRefitTech := iTech;
  Avionics.BakCommsRefitTech := iTech;
end;

procedure TShip.SetSpinalRefitTech(iTech: Integer);
begin
  SpinalMount.SpinalMountRefitTech := iTech;
end;

procedure TShip.SetBigBaysRefitTech(iTech: Integer);
begin
  BigBays.MesonBaysRefitTech := iTech;
  BigBays.PaBaysRefitTech := iTech;
  BigBays.RepulsorBaysRefitTech := iTech;
  BigBays.MissileBaysRefitTech := iTech;
end;

procedure TShip.SetLittleBaysRefitTech(iTech: Integer);
begin
  LittleBays.MesonBaysRefitTech := iTech;
  LittleBays.PaBaysRefitTech := iTech;
  LittleBays.RepulsorBaysRefitTech := iTech;
  LittleBays.MissileBaysRefitTech := iTech;
  LittleBays.EnergyBaysRefitTech := iTech;
end;

function TShip.IsSmallCraftComp(CompValue: Integer): Boolean;
//checks to see if the computer is a valid small craft computer

var
   SmallCraftComp : TComputerSet;
begin
   SmallCraftComp := [0, 1, 4, 7, 9, 11, 13, 15, 17, 19];
   //full bis version SmallCraftComp := [0, 1, 4, 7, 10, 13, 16, 19, 22, 25];
   Result := False;
   if (CompValue in SmallCraftComp) then begin
      Result := True;
   end;
end;

function TShip.MakePlural(TheString: String): String;
begin
  //if the last character is a H, S or X use es otherwise use s
   if (UpperCase(TheString[Length(TheString)]) = 'H')
       or (UpperCase(TheString[Length(TheString)]) = 'S')
       or (UpperCase(TheString[Length(TheString)]) = 'X') then
   begin
     Result := TheString + 'es';
   end
   else
   begin
     Result := TheString + 's';
   end;
end;

function TShip.TravToInt(TheNum: String): Integer;
begin
  TheNum := UpperCase(TheNum);
  if (StrToIntDef(TheNum, 300) <> 300) and (StrToIntDef(TheNum, 200) <> 200) then
  begin
    Result := StrToInt(TheNum);
  end
  else
  begin
    if (TheNum = 'A') then Result := 10;
    if (TheNum = 'B') then Result := 11;
    if (TheNum = 'C') then Result := 12;
    if (TheNum = 'D') then Result := 13;
    if (TheNum = 'E') then Result := 14;
    if (TheNum = 'F') then Result := 15;
    if (TheNum = 'G') then Result := 16;
    if (TheNum = 'H') then Result := 17;
    if (TheNum = 'I') then Result := 18;
    if (TheNum = 'J') then Result := 18;
    if (TheNum = 'K') then Result := 19;
    if (TheNum = 'L') then Result := 20;
    if (TheNum = 'M') then Result := 21;
    if (TheNum = 'N') then Result := 22;
    if (TheNum = 'O') then Result := 23;
    if (TheNum = 'P') then Result := 23;
    if (TheNum = 'Q') then Result := 24;
    if (TheNum = 'R') then Result := 25;
    if (TheNum = 'S') then Result := 26;
    if (TheNum = 'T') then Result := 27;
    if (TheNum = 'U') then Result := 28;
    if (TheNum = 'V') then Result := 29;
    if (TheNum = 'W') then Result := 30;
    if (TheNum = 'X') then Result := 31;
    if (TheNum = 'Y') then Result := 32;
    if (TheNum = 'Z') then Result := 33;
    if (TheNum = '@') then Result := CalcNumCrewSections;
  end;
end;

function TShip.GetCompValue(TheComp: Integer): Integer;
begin
  case (TheComp) of
    0: Result := 0;
    1..3: Result := 1;
    4..6: Result := 2;
    7..8: Result := 3;
    9..10: Result := 4;
    11..12: Result := 5;
    13..14: Result := 6;
    15..16: Result := 7;
    17..18: Result := 8;
    19..20: Result := 9;
    else Result := 10;
  end;
end;

function TShip.T20PowerCode: Integer;
//T20 METHOD
//returns a rough power plant value

begin
  Result := Trunc((Eng.Power / 2) / (Tonnage / 100));
end;

function TShip.CalcDropTankMan: Integer;
var
  WithTankTonnage: Extended;
  ManPercent: Integer;
  ePowerTons, eMDriveSpace: Extended;
  iPPlant, iPowTech: Integer;
begin
  if (Eng.PowerTonsIsRefitted) then ePowerTons := Eng.NewPowerTons else ePowerTons := Eng.PowerTons;
  if (Eng.PPlantIsRefitted) then iPPlant := Eng.NewPPlant else iPPlant := Eng.PPlant;
  if (Eng.PowerTonsIsRefitted) then iPowTech := Eng.PowerTonsRefitTech else iPowTech := TechLevel;
  if (Eng.MDriveIsRefitted) then
  begin
    eMDriveSpace := Eng.RefittedMDriveSpace(Tonnage, DesignRules);
  end
  else
  begin
    eMDriveSpace := Eng.MDriveSpace(Tonnage, DesignRules)
  end;
  WithTankTonnage := Tonnage + Fuel.CalcLhydFuel(Tonnage, ePowerTons, iPPlant,
                                                 iPowTech, ShipRace, DesignRules);
  ManPercent := FloatToIntDown((eMDriveSpace / WithTankTonnage) * 100);
  Result := Max(FloatToIntDown((ManPercent + 1) / 3), 0);
end;

function TShip.CalcDropTankJump: Integer;
var
  WithTankTonnage: Extended;
  JumpPercent: Integer;
  ePowerTons, eJDriveSpace: Extended;
  iPPlant, iPowTech: Integer;
begin
  if (Eng.PowerTonsIsRefitted) then ePowerTons := Eng.NewPowerTons
      else ePowerTons := Eng.PowerTons;
  if (Eng.PPlantIsRefitted) then iPPlant := Eng.NewPPlant else iPPlant := Eng.PPlant;
  if (Eng.PowerTonsIsRefitted) then iPowTech := Eng.PowerTonsRefitTech
      else iPowTech := TechLevel;
  if (Eng.JDriveIsRefitted) then
  begin
    eJDriveSpace := Eng.RefittedJDriveSpace(Tonnage, DesignRules);
  end
  else
  begin
    eJDriveSpace := Eng.JDriveSpace(Tonnage, DesignRules)
  end;
  WithTankTonnage := Tonnage + Fuel.CalcLhydFuel(Tonnage, ePowerTons, iPPlant,
                                                 iPowTech, ShipRace, DesignRules);
  JumpPercent := FloatToIntDown((eJDriveSpace / WithTankTonnage) * 100);
  Result := Max(JumpPercent - 1, 0);
end;

function TShip.CalcDropTankPower: Integer;
var
  WithTankTonnage: Extended;
  //PowPercent: Integer;
  ePowerTons, ePPlantSpace: Extended;
  iPPlant, iPowTech: Integer;
begin
  if (Eng.PowerTonsIsRefitted) then ePowerTons := Eng.NewPowerTons else ePowerTons := Eng.PowerTons;
  if (Eng.PPlantIsRefitted) then iPPlant := Eng.NewPPlant else iPPlant := Eng.PPlant;
  if (Eng.PowerTonsIsRefitted) then iPowTech := Eng.PowerTonsRefitTech else iPowTech := TechLevel;
  (*if (Eng.PPlantIsRefitted) then
  begin
    ePPlantSpace := Eng.RefittedPPlantSpace(Tonnage, Eng.PPlantRefitTech, ShipRace, DesignRules);
  end
  else
  begin
    ePPlantSpace := Eng.PPlantSpace(Tonnage, TechLevel, ShipRace, DesignRules)
  end;  *)
  WithTankTonnage := Tonnage + Fuel.CalcLhydFuel(Tonnage, ePowerTons, iPPlant,
                                                 iPowTech, ShipRace, DesignRules);
  //PowPercent := FloatToIntDown((ePPlantSpace / WithTankTonnage) * 100);
  if (DesignRules = 0) then
  begin
    Result := Max(Trunc(Eng.Power / (WithTankTonnage / 100)), 0);
  end
  else
  begin
    Result := Max(Trunc((Eng.Power / 2) / (WithTankTonnage / 100)), 0);
  end;
end;

function TShip.ReportDropTankDisplacement: String;
var
  WithTankTonnage: Extended;
begin
  WithTankTonnage := Tonnage + Fuel.CalcLhydFuel(Tonnage, Eng.PowerTons, Eng.PPlant,
                    TechLevel, ShipRace, DesignRules);
  if (WithTankTonnage < 1000) then
  begin
    Result := FloatToStr(WithTankTonnage) + ' Tons';
  end
  else if (WithTankTonnage < 1000000) then
  begin
    Result := FloatToStr(WithTankTonnage / 1000) + ' KTons';
  end
  else
  begin
    Result := FloatToStr(WithTankTonnage / 1000000) + ' MTons';
  end;
end;

function TShip.CalcTd100Number: Integer;
//number of crew sections tonnage / (size code * 100)
var
  iSize: Integer;
begin
  case (FloatToIntDown(Tonnage / 100)) of
    0: iSize := 0;
    1: iSize := 1;
    2: iSize := 2;
    3: iSize := 3;
    4: iSize := 4;
    5: iSize := 5;
    6: iSize := 6;
    7: iSize := 7;
    8: iSize := 8;
    9: iSize := 9;
    10..19: iSize := 10;
    20..29: iSize := 11;
    30..39: iSize := 12;
    40..49: iSize := 13;
    50..59: iSize := 14;
    60..69: iSize := 15;
    70..79: iSize := 16;
    80..89: iSize := 17;
    90..99: iSize := 18;
    100..199: iSize := 19;
    200..299: iSize := 20;
    300..399: iSize := 21;
    400..499: iSize := 22;
    500..749: iSize := 23;
    750..999: iSize := 24;
    1000..1999: iSize := 25;
    2000..2999: iSize := 26;
    3000..3999: iSize := 27;
    4000..4999: iSize := 28;
    5000..6999: iSize := 29;
    7000..8999: iSize := 30;
    9000..9999: iSize := 31;
    10000..19999: iSize := 32;
    else iSize := 33;
  end;
  if (iSize > 0) then
  begin
    Result := Max(1, FloatToIntUp(Tonnage / (iSize * 100)));
  end
  else
  begin
    Result := 1;
  end;
end;

function TShip.CalcLog2Number: Integer;
begin
  case (GetTotalCmdCrew + GetTotalCrew) of
    0: Result := 0;
    1..2: Result := 1;
    3..4: Result := 2;
    5..8: Result := 3;
    9..16: Result := 4;
    17..32: Result := 5;
    33..64: Result := 6;
    65..125: Result := 7;
    126..250: Result := 8;
    251..500: Result := 9;
    501..1000: Result := 10;
    1001..2000: Result := 11;
    2001..4000: Result := 12;
    4001..8000: Result := 13;
    8001..16000: Result := 14;
    else Result := 15;
  end;
end;

procedure TShip.ZeroHull;
begin
  Hull.Armour := 0;
  Hull.Config := 0;
  Hull.Airframe := 0;
  Hull.Config := 0;
  Hull.Structure := 0;
end;

procedure TShip.ZeroEng;
begin
  Eng.MDrive := 0;
  Eng.JDrive := 0;
  Eng.PPlant := 0;
  Eng.PowerTons := 0;
  Eng.BakMDrive := 0;
  Eng.BakMDNum := 0;
  Eng.BakJDrive := 0;
  Eng.BakJDNum := 0;
  Eng.BakPPlant := 0;
  Eng.BakPPNum := 0;
  Eng.BakPowerTons := 0;
  Eng.BakPowerTonsNum := 0;
  Eng.UpgradeSpace := 0;
  Eng.NewMDrive := 0;
  Eng.NewJDrive := 0;
  Eng.NewPPlant := 0;
  Eng.NewPowerTons := 0;
  //more stuff
end;

procedure TShip.ZeroFuel;
begin

end;

procedure TShip.ZeroAvionics;
begin

end;

procedure TShip.ZeroSpinal;
begin

end;

procedure TShip.ZeroBigBays;
begin

end;

procedure TShip.ZeroLittleBays;
begin

end;

procedure TShip.ZeroTurrets;
begin

end;

procedure TShip.ZeroMagazines;
begin

end;

procedure TShip.ZeroScreens;
begin

end;

procedure TShip.ZeroCraft;
begin

end;

procedure TShip.ZeroAccom;
begin

end;

procedure TShip.ZeroUserDef;
begin

end;

end.

