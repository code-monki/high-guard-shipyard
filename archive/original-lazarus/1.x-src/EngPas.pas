unit EngPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, Math, ShipModulePas;

type

   { TEng }

   TEng = class(TExtShipModule)
   private
     FDriveUpgradesAllowed: Boolean;
      fMDrive : Integer;
      fMDriveIsRefitted : Boolean;      //1
      fNewMDrive : Integer;             //2
      fMDriveRefitTech : Integer;       //3
      fJDrive : Integer;
      fJDriveIsRefitted : Boolean;      //4
      fNewJDrive : Integer;             //5
      fJDriveRefitTech : Integer;       //6
      fPPlant : Integer;
      fPPlantIsRefitted : Boolean;      //7
      fNewPPlant : Integer;             //8
      fPPlantRefitTech : Integer;       //9
      fBakMDrive : Integer;
      fBakMDriveIsRefitted : Boolean;    //10
      fBakNewMDrive : Integer;          //11
      fBakMDriveRefitTech : Integer;    //12
      fBakJDrive : Integer;
      fBakJDriveIsRefitted : Boolean;   //13
      fBakNewJDrive : Integer;          //14
      fBakJDriveRefitTech : Integer;    //15
      fBakPPlant : Integer;
      fBakPPlantIsRefitted : Boolean;   //16
      fBakNewPPlant : Integer;          //17
      fBakPPlantRefitTech : Integer;    //18
      fBakMDNum : Integer;
      fBakNewMDNum : Integer;           //19
      fBakJDNum : Integer;
      fBakNewJDNum : Integer;           //20
      fBakPPNum : Integer;
      fBakNewPPNum : Integer;           //21
      fPowerTons : Extended;
      fPowerTonsIsRefitted : Boolean;   //22
      fNewPowerTons : Extended;         //23
      fPowerTonsRefitTech : Integer;    //24
      fBakPowerTons : Extended;         //25
      fBakPowerTonsNum: Integer;        //26
      fBakPowerTonsIsRefitted : Boolean;//27
      fBakNewPowerTons : Extended;      //28
      fBakPowerTonsRefitTech : Integer; //29
      fBakNewPowerTonsNum : Integer;    //30
      fMPowerUsed : Extended;
      FSingleEngSpace: Boolean;
      FUpgradeSpace: Extended;
      FUpgradeSpaceAvailable: Extended;
      function CalcBaseEngSpace(Size: Extended; TL, Race, DesSys: Integer):Extended;
      function CalcBaseBakEngSpace(Size: Extended; TL, Race, DesSys: Integer):Extended;
      function CalcEngSpace(Size: Extended; TL, Race, DesSys: Integer):Extended;
      function CalcBakEngSpace(Size: Extended; TL, Race, DesSys: Integer):Extended;
      function CalcEngCost(Size: Extended; TL, Race, DesSys: Integer; MilStdJump: Boolean):Extended;
      function CalcBakEngCost(Size: Extended; TL, Race, DesSys: Integer; MilStdJump: Boolean):Extended;
      function CalcRefitCost(Size: Extended; TL, Race, DesSys: Integer; MilStdJump: Boolean):Extended;
      procedure SetDriveUpgradesAllowed(const AValue: Boolean);
      procedure SetSingleEngSpace(const AValue: Boolean);
      procedure SetUpgradeSpace(const AValue: Extended);
      procedure SetUpgradeSpaceAvailable(const AValue: Extended);
   public
      function MDriveCost(Size : Extended; DesSys : Integer) : Extended;
      function MDriveSpace(Size : Extended; DesSys : Integer) : Extended;
      function RefittedMDriveCost(Size: Extended; DesSys: Integer): Extended;
      function RefittedMDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function JDriveCost(Size: Extended; DesSys: Integer; MilStdJump: Boolean): Extended;
      function JDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function RefittedJDriveCost(Size: Extended; DesSys: Integer; MilStdJump: Boolean): Extended;
      function RefittedJDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function PPlantCost(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function PPlantSpace(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function RefittedPPlantCost(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function RefittedPPlantSpace(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function BakMDriveCost(Size: Extended; DesSys: Integer): Extended;
      function BakMDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function RefittedBakMDriveCost(Size: Extended; DesSys: Integer): Extended;
      function RefittedBakMDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function BakJDriveCost(Size: Extended; DesSys: Integer; MilStdJump: Boolean): Extended;
      function BakJDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function RefittedBakJDriveCost(Size: Extended; DesSys: Integer; MilStdJump: Boolean): Extended;
      function RefittedBakJDriveSpace(Size: Extended; DesSys: Integer): Extended;
      function BakPPlantCost(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function BakPPlantSpace(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function RefittedBakPPlantCost(Size: Extended; TL, Race, DesSys: Integer): Extended;
      function RefittedBakPPlantSpace(Size: Extended; TL, Race, DesSys: Integer): Extended;
      procedure CalcCrew(Size: Extended; TL, Race, CrewType, DesSys: Integer);
      procedure CalcPower(Size: Extended; DesSys, Race, TL: Integer);
      property MDrive : Integer read fMDrive write fMDrive;
      property MDriveIsRefitted : Boolean read fMDriveIsRefitted write fMDriveIsRefitted;
      property NewMDrive : Integer read fNewMDrive write fNewMDrive;
      property MDriveRefitTech : Integer read fMDriveRefitTech write fMDriveRefitTech;
      property JDrive : Integer read fJDrive write fJDrive;
      property JDriveIsRefitted : Boolean read fJDriveIsRefitted write fJDriveIsRefitted;
      property NewJDrive : Integer read fNewJDrive write fNewJDrive;
      property JDriveRefitTech : Integer read fJDriveRefitTech write fJDriveRefitTech;
      property PPlant : Integer read fPPlant write fPPlant;
      property PPlantIsRefitted : Boolean read fPPlantIsRefitted write fPPlantIsRefitted;
      property NewPPlant : Integer read fNewPPlant write fNewPPlant;
      property PPlantRefitTech : Integer read fPPlantRefitTech write fPPlantRefitTech;
      property BakMDrive : Integer read fBakMDrive write fBakMDrive;
      property BakMDriveIsRefitted : Boolean read fBakMDriveIsRefitted write fBakMDriveIsRefitted;
      property BakNewMDrive : Integer read fBakNewMDrive write fBakNewMDrive;
      property BakMDriveRefitTech : Integer read fBakMDriveRefitTech write fBakMDriveRefitTech;
      property BakJDrive : Integer read fBakJDrive write fBakJDrive;
      property BakJDriveIsRefitted : Boolean read fBakJDriveIsRefitted write fBakJDriveIsRefitted;
      property BakNewJDrive : Integer read fBakNewJDrive write fBakNewJDrive;
      property BakJDriveRefitTech : Integer read fBakJDriveRefitTech write fBakJDriveRefitTech;
      property BakPPlant : Integer read fBakPPlant write fBakPPlant;
      property BakPPlantIsRefitted : Boolean read fBakPPlantIsRefitted write fBakPPlantIsRefitted;
      property BakNewPPlant : Integer read fBakNewPPlant write fBakNewPPlant;
      property BakPPlantRefitTech : Integer read fBakPPlantRefitTech write fBakPPlantRefitTech;
      property BakMDNum : Integer read fBakMDNum write fBakMDNum;
      property BakNewMDNumb : Integer read fBakNewMDNum write fBakNewMDNum;
      property BakJDNum : Integer read fBakJDNum write fBakJDNum;
      property BakNewJDNumb : Integer read fBakNewJDNum write fBakNewJDNum;
      property BakPPNum : Integer read fBakPPNum write fBakPPNum;
      property BakNewPPNumb : Integer read fBakNewPPNum write fBakNewPPNum;
      property PowerTons : Extended read fPowerTons write fPowerTons;
      property PowerTonsIsRefitted : Boolean read fPowerTonsIsRefitted write fPowerTonsIsRefitted;
      property NewPowerTons : Extended read fNewPowerTons write fNewPowerTons;
      property PowerTonsRefitTech : Integer read fPowerTonsRefitTech write fPowerTonsRefitTech;
      property BakPowerTons : Extended read fBakPowerTons write fBakPowerTons;
      property BakPowerTonsNum: Integer read fBakPowerTonsNum write fBakPowerTonsNum;
      property BakPowerTonsIsRefitted : Boolean read fBakPowerTonsIsRefitted write fBakPowerTonsIsRefitted;
      property BakNewPowerTons : Extended read fBakNewPowerTons write fBakNewPowerTons;
      property BakPowerTonsRefitTech : Integer read fBakPowerTonsRefitTech write fBakPowerTonsRefitTech;
      property BakNewPowerTonsNum : Integer read fBakNewPowerTonsNum write fBakNewPowerTonsNum;
      property UpgradeSpace: Extended read FUpgradeSpace write SetUpgradeSpace;
      property SingleEngSpace: Boolean read FSingleEngSpace write SetSingleEngSpace;
      property DriveUpgradesAllowed: Boolean read FDriveUpgradesAllowed write SetDriveUpgradesAllowed;
      property MPowerUsed : Extended read fMPowerUsed write fMPowerUsed;

      //special property not written to file
      property UpgradeSpaceAvailable: Extended read FUpgradeSpaceAvailable write SetUpgradeSpaceAvailable;

      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignEng(ShipData : String);
   end;

var
   Eng : TEng;

implementation

{ TEng }

procedure TEng.AssignDefaults(ShipData: String);
//assign the defaults for the module

var
  Props : TStringList;
begin
  Props := TStringList.Create;
  try
    Props.CommaText := ShipData;
    Space := 0;
    Cost := 0;
    Power := 0;
    CmdCrew := 0;
    Crew := 0;
    MDrive := StrToInt(Props[0]);
    JDrive := StrToInt(Props[1]);
    PPlant := StrToInt(Props[2]);
    BakMDrive := StrToInt(Props[3]);
    BakJDrive := StrToInt(Props[4]);
    BakPPlant := StrToInt(Props[5]);
    BakMDNum := StrToInt(Props[6]);
    BakJDNum := StrToInt(Props[7]);
    BakPPNum := StrToInt(Props[8]);
    PowerTons := StrToFloat(Props[9]);
    BakPowerTons := StrToFloat(Props[10]);
    BakPowerTonsNum := StrToInt(Props[11]);
    MDriveIsRefitted := StrToBool(Props[12]);
    NewMDrive := StrToInt(Props[13]);
    MDriveRefitTech := StrToInt(Props[14]);
    JDriveIsRefitted := StrToBool(Props[15]);
    NewJDrive := StrToInt(Props[16]);
    JDriveRefitTech := StrToInt(Props[17]);
    PPlantIsRefitted := StrToBool(Props[18]);
    NewPPlant := StrToInt(Props[19]);
    PPlantRefitTech := StrToInt(Props[20]);
    BakMDriveIsRefitted := StrToBool(Props[21]);
    BakNewMDrive := StrToInt(Props[22]);
    BakMDriveRefitTech := StrToInt(Props[23]);
    BakJDriveIsRefitted := StrToBool(Props[24]);
    BakNewJDrive := StrToInt(Props[25]);
    BakJDriveRefitTech := StrToInt(Props[26]);
    BakPPlantIsRefitted := StrToBool(Props[27]);
    BakNewPPlant := StrToInt(Props[28]);
    BakPPlantRefitTech := StrToInt(Props[29]);
    BakNewMDNumb := StrToInt(Props[30]);
    BakNewJDNumb := StrToInt(Props[31]);
    BakNewPPNumb := StrToInt(Props[32]);
    PowerTonsIsRefitted := StrToBool(Props[33]);
    NewPowerTons := StrToFloat(Props[34]);
    PowerTonsRefitTech := StrToInt(Props[35]);
    BakPowerTonsIsRefitted := StrToBool(Props[36]);
    BakNewPowerTons := StrToFloat(Props[37]);
    BakPowerTonsRefitTech := StrToInt(Props[38]);
    BakNewPowerTonsNum := StrToInt(Props[39]);
    UpgradeSpace := StrToFloat(Props[40]);
    SingleEngSpace := StrToBool(Props[41]);
    DriveUpgradesAllowed := StrToBool(Props[42]);
  finally
    FreeAndNil(Props);
  end;
end;

function TEng.BakJDriveCost(Size : Extended; DesSys: Integer; MilStdJump: Boolean): Extended;
//calculate the cost of the backup j drive

begin
  if (BakJDrive > 0) then
  begin
    Result := BakJDriveSpace(Size, DesSys) * 4;
  end
  else
  begin
    Result := 0;
  end;
  (*
  if (MilStdJump) then
  begin
    Result := Result * 10;
  end;
  *)
end;

function TEng.BakJDriveSpace(Size: Extended; DesSys: Integer): Extended;
//calculate the space required by the backup j drive
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if (BakJDrive > 0) then
  begin
    Result := Max(Size * ((BakJDrive + 1)/100), iMinSize) * BakJDNum;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedBakJDriveCost(Size: Extended; DesSys: Integer;
  MilStdJump: Boolean): Extended;
begin
  if (BakJDriveIsRefitted) then
  begin
    if (BakNewJDrive > 0) then
    begin
      Result := RefittedBakJDriveSpace(Size, DesSys) * 4;
    end
    else
    begin
      Result := 0;
    end;
    (*
    if (MilStdJump) then
    begin
      Result := Result * 10;
    end;
    *)
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedBakJDriveSpace(Size: Extended; DesSys: Integer
  ): Extended;
var
  iMinSize: Integer;
begin
  if (BakJDriveIsRefitted) then
  begin
    if (DesSys = 1) then
    begin
      iMinSize := 1;
    end
    else
    begin
      iMinSize := 0;
    end;
    if (BakNewJDrive > 0) then
    begin
      Result := Max(Size * ((BakNewJDrive + 1)/100), iMinSize) * BakNewJDNumb;
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0
  end;
end;

function TEng.BakMDriveCost(Size: Extended; DesSys: Integer): Extended;
//calculate the cost of the backup m drive

begin
  if (BakMDrive > 0) then
  begin
    Case (BakMDrive) of
      1 : Result := BakMDriveSpace(Size, DesSys) * 1.5;
      2 : Result := BakMDriveSpace(Size, DesSys) * 0.7;
      else Result := BakMDriveSpace(Size, DesSys) * 0.5;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.BakMDriveSpace(Size: Extended; DesSys: Integer): Extended;
//calculate the space required by the backup m drive
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if (BakMDrive > 0) then
  begin
    Result := Max(Size * (((3 * (BakMDrive - 1)) + 2)/100), iMinSize) * BakMDNum;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedBakMDriveCost(Size: Extended; DesSys: Integer): Extended;
begin
  if (BakMDriveIsRefitted) then
  begin
    if (BakNewMDrive > 0) then
    begin
      Case (BakNewMDrive) of
        1 : Result := RefittedBakMDriveSpace(Size, DesSys) * 1.5;
        2 : Result := RefittedBakMDriveSpace(Size, DesSys) * 0.7;
        else Result := RefittedBakMDriveSpace(Size, DesSys) * 0.5;
      end;
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedBakMDriveSpace(Size: Extended; DesSys: Integer
  ): Extended;
var
  iMinSize: Integer;
begin
  if (BakMDriveIsRefitted) then
  begin
    if (DesSys = 1) then
    begin
      iMinSize := 1;
    end
    else
    begin
      iMinSize := 0;
    end;
    if (BakNewMDrive > 0) then
    begin
      Result := Max(Size * (((3 * (BakNewMDrive - 1)) + 2)/100), iMinSize) * BakNewMDNumb;
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.BakPPlantCost(Size: Extended; TL, Race, DesSys: Integer): Extended;
//calculate the cost of the backup pp

begin
  if (DesSys = 0) then  //add optional rule for general use gohere00x01
  begin
    if (TL < 17) then
    begin
      Result := BakPowerTons * 3;
    end
    else
    begin
      Result := BakPowerTons * 1;
    end;
  end
  else
  begin
    if (BakPPlant > 0) then
    begin
      Result := BakPPlantSpace(Size, BakPPlantRefitTech, Race, DesSys) * 3;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TEng.BakPPlantSpace(Size: Extended; TL, Race, DesSys: Integer): Extended;
//calculate the space required by the backup pp
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if (DesSys = 0) then
  begin
    Result := BakPowerTons;        //add optional rule for general use gohere00x02
  end
  else
  begin
    if (BakPPlant > 0) then
    begin
      if (Race = 1) then
      begin
        Case (TL) of
          7..10 : Result := Max(Size * ((BakPPlant * 4)/100), iMinSize);
          11..12 : Result := Max(Size * ((BakPPlant * 3)/100), iMinSize);
          13..14 : Result := Max(Size * ((BakPPlant * 2)/100), iMinSize);
          else Result := Max(Size * ((BakPPlant * 1)/100), iMinSize);
        end;
      end
      else
      begin
        Case (TL) of
          7..8 : Result := Max(Size * ((BakPPlant * 4)/100), iMinSize);
          9..12 : Result := Max(Size * ((BakPPlant * 3)/100), iMinSize);
          13..14 : Result := Max(Size * ((BakPPlant * 2)/100), iMinSize);
          else Result := Max(Size * ((BakPPlant * 1)/100), iMinSize);
        end;
      end;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TEng.RefittedBakPPlantCost(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
begin
  if ((BakPPlantIsRefitted) and (DesSys = 1)) or ((BakPowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    if (DesSys = 0) then  //add optional rule for general use gohere00x01
    begin
      if (BakPowerTonsRefitTech < 17) then
      begin
        Result := BakNewPowerTons * 3;
      end
      else
      begin
        Result := BakNewPowerTons * 1;
      end;
    end
    else
    begin
      if (BakNewPPlant > 0) then
      begin
        Result := RefittedBakPPlantSpace(Size, BakPPlantRefitTech, Race, DesSys) * 3;
      end
      else
      begin
        Result := 0;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedBakPPlantSpace(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if ((BakPPlantIsRefitted) and (DesSys = 1)) or ((BakPowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    if (DesSys = 0) then
    begin
      Result := BakNewPowerTons;        //add optional rule for general use gohere00x02
    end
    else
    begin
      if (BakNewPPlant > 0) then
      begin
        if (Race = 1) then
        begin
          Case (BakPPlantRefitTech) of
            7..10 : Result := Max(Size * ((BakNewPPlant * 4)/100), iMinSize);
            11..12 : Result := Max(Size * ((BakNewPPlant * 3)/100), iMinSize);
            13..14 : Result := Max(Size * ((BakNewPPlant * 2)/100), iMinSize);
            else Result := Max(Size * ((BakNewPPlant * 1)/100), iMinSize);
          end;
        end
        else
        begin
          Case (BakPPlantRefitTech) of
            7..8 : Result := Max(Size * ((BakNewPPlant * 4)/100), iMinSize);
            9..12 : Result := Max(Size * ((BakNewPPlant * 3)/100), iMinSize);
            13..14 : Result := Max(Size * ((BakNewPPlant * 2)/100), iMinSize);
            else Result := Max(Size * ((BakNewPPlant * 1)/100), iMinSize);
          end;
        end;
      end
      else
      begin
        Result := 0;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

procedure TEng.CalcCrew(Size: Extended; TL, Race, CrewType, DesSys: Integer);
//calculate the crew required
var
  eEngSpace: Extended;

begin
  CmdCrew := 0;
  Crew := 0;
  eEngSpace := CalcEngSpace(Size, TL, Race, DesSys) + CalcBakEngSpace(Size, TL, Race, DesSys);
  if (CrewType = 0) and (Size >= 200) then
  begin
    //Crew := FloatToIntUp((MDriveSpace(Size, DesSys) + JDriveSpace(Size, DesSys)
    //    + PPlantSpace(Size, TL, Race, DesSys))/35);
    Crew := FloatToIntUp(eEngSpace / 35);
  end
  else if (CrewType = 0) and (Size < 200) then
  begin
    CmdCrew := 0;
    Crew := 0;
  end
  else if (CrewType = 1) and (Size >= 100) then
  begin
    CmdCrew := 1;
    //Crew := FloatToIntUp((MDriveSpace(Size, DesSys) + JDriveSpace(Size, DesSys)
    //    + PPlantSpace(Size, TL, Race, DesSys))/100) - 1;
    Crew := FloatToIntUp((eEngSpace / 100) - 1);
  end;
end;

procedure TEng.CalcPower(Size: Extended; DesSys, Race, TL: Integer);
//calculate the power generated
var
  ePowT: Extended;
  iPowP: Integer;
begin
  //
  if (PPlantIsRefitted) then
  begin
    iPowP := NewPPlant;
  end
  else
  begin
    iPowP := PPlant;
  end;
  if (PowerTonsIsRefitted) then
  begin
    ePowT := NewPowerTons;
  end
  else
  begin
    ePowT := PowerTons;
  end;
  if (DesSys = 0) then        //add optional rule for general use gohere00x03
  begin
    if (Race = 1) then
    begin
      case (TL) of
        7..10 : Power := (ePowT / 2) * 1;
        11..12 : Power := (ePowT / 1.5) * 1;
        13..14 : Power := (ePowT / 1) * 1;
        15 : Power := (ePowT / 1) * 2;
        16 : Power := (ePowT / 1) * 3;
        else Power := (ePowT / 1) * 8;
      end;
    end
    else
    begin
      case (TL) of
        7..8 : Power := (ePowT / 2) * 1;
        9..12 : Power := (ePowT / 1.5) * 1;
        13..14 : Power := (ePowT / 1) * 1;
        15 : Power := (ePowT / 1) * 2;
        16 : Power := (ePowT / 1) * 3;
        else Power := (ePowT / 1) * 8;
      end;
    end;
  end
  else
  begin
    Power := iPowP * (Size/100)
  end;
end;

procedure TEng.DesignEng(ShipData: String);
//design the engineering module

var
  ShipDetails : TStringList;
  Tonnage : Extended;
  Techlevel, Race, CrewRules, DesignRules, RefitTechLevel : Integer;
  ShipRefitted, MilStdJump: Boolean;
begin
  ShipDetails := TStringList.Create;
  try
    ShipDetails.CommaText := ShipData;
    TechLevel := StrToInt(ShipDetails[0]);
    Tonnage := StrToFloat(ShipDetails[1]);
    Race := StrToInt(ShipDetails[2]);
    CrewRules := StrToInt(ShipDetails[3]);
    DesignRules := StrToInt(ShipDetails[7]);
    ShipRefitted := StrToBool(ShipDetails[9]);
    RefitTechLevel := StrToInt(ShipDetails[10]);
    MilStdJump := StrToBool(ShipDetails[13]);
    Power := 0;
    (*Cost := MDriveCost(Tonnage, DesignRules) + JDriveCost(Tonnage, DesignRules, MilStdJump)
        + BakMDriveCost(Tonnage, DesignRules) + BakJDriveCost(Tonnage, DesignRules, MilStdJump)
        + PPlantCost(Tonnage, Techlevel, Race, DesignRules)
        + BakPPlantCost(Tonnage, TechLevel, Race, DesignRules);     *)
    Cost := CalcEngCost(Tonnage, TechLevel, Race, DesignRules, MilStdJump)
        + CalcBakEngCost(Tonnage, TechLevel, Race, DesignRules, MilStdJump);
    (*Space := MDriveSpace(Tonnage, DesignRules) + JDriveSpace(Tonnage, DesignRules)
        + BakMDriveSpace(Tonnage, DesignRules) + BakJDriveSpace(Tonnage, DesignRules)
        + PPlantSpace(Tonnage, Techlevel, Race, DesignRules)
        + BakPPlantSpace(Tonnage, TechLevel, Race, DesignRules)
        + UpgradeSpace;    *)
    Space := CalcEngSpace(Tonnage, TechLevel, Race, DesignRules)
        + CalcBakEngSpace(Tonnage, TechLevel, Race, DesignRules)
        + UpgradeSpace;
    CalcCrew(Tonnage, TechLevel, Race, CrewRules, DesignRules);
    CalcPower(Tonnage, DesignRules, Race, TechLevel);
    if (DesignRules = 0) then
    begin
      if (MDriveIsRefitted) then
      begin
        MPowerUsed := RefittedMDriveSpace(Tonnage, DesignRules) * 0.5;
      end
      else
      begin
        MPowerUsed := MDriveSpace(Tonnage, DesignRules) * 0.5;
      end;
    end
    else
    begin
      MPowerUsed := 0;
    end;
    RefitCost := CalcRefitCost(Tonnage, TechLevel, Race, DesignRules, MilStdJump);
    //calculate upgrade space available follow comments and watch out for this bit
    UpgradeSpaceAvailable := UpgradeSpace
        -  //subtract
            ( //start bracket
                //current eng space
                (CalcEngSpace(Tonnage, TechLevel, Race, DesignRules)
                   + CalcBakEngSpace(Tonnage, TechLevel, Race, DesignRules))
                - //subtract
                //base eng space
                (CalcBaseEngSpace(Tonnage, TechLevel, Race, DesignRules)
                    + CalcBaseBakEngSpace(Tonnage, TechLevel, Race, DesignRules))
            ); //closebracket and end calculation
  finally
    FreeAndNil(ShipDetails);
  end;
end;

function TEng.JDriveCost(Size: Extended; DesSys: Integer; MilStdJump: Boolean): Extended;
//calculate the cost of the j drive

begin
  if (JDrive > 0) then
  begin
    Result := JDriveSpace(Size, DesSys) * 4;
  end
  else
  begin
    Result := 0;
  end;
  if (MilStdJump) then
  begin
    Result := Result * 10;
  end;
end;

function TEng.JDriveSpace(Size: Extended; DesSys: Integer): Extended;
//calculate the space required by the j drive
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if (JDrive > 0) then
  begin
    Result := Max(Size * ((JDrive + 1) / 100), iMinSize);
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedJDriveCost(Size: Extended; DesSys: Integer;
  MilStdJump: Boolean): Extended;
begin
  if (JDriveIsRefitted) then
  begin
    if (NewJDrive > 0) then
    begin
      Result := RefittedJDriveSpace(Size, DesSys) * 4;
    end
    else
    begin
      Result := 0;
    end;
    if (MilStdJump) then
    begin
      Result := Result * 10;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedJDriveSpace(Size: Extended; DesSys: Integer): Extended;
var
  iMinSize: Integer;
begin
  if (JDriveIsRefitted) then
  begin
    if (DesSys = 1) then
    begin
      iMinSize := 1;
    end
    else
    begin
      iMinSize := 0;
    end;
    if (NewJDrive > 0) then
    begin
      Result := Max(Size * ((NewJDrive + 1) / 100), iMinSize);
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.CalcBaseEngSpace(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
begin
  Result := 0;
  Result := Result + MDriveSpace(Size, DesSys);
  Result := Result + JDriveSpace(Size, DesSys);
  Result := Result + PPlantSpace(Size, TL, Race, DesSys)
end;

function TEng.CalcBaseBakEngSpace(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
begin
  Result := 0;
  Result := Result + BakMDriveSpace(Size, DesSys);
  Result := Result + BakJDriveSpace(Size, DesSys);
  Result := Result + BakPPlantSpace(Size, TL, Race, DesSys)
end;

function TEng.CalcEngSpace(Size: Extended; TL, Race, DesSys: Integer): Extended;
begin
  Result := 0;
  //mdrive size dessys
  if (MDriveIsRefitted) then
  begin
    Result := Result + RefittedMDriveSpace(Size, DesSys);
  end
  else
  begin
    Result := Result + MDriveSpace(Size, DesSys);
  end;
  //jdrive size dessys milstdjump
  if (JDriveIsRefitted) then
  begin
    Result := Result + RefittedJDriveSpace(Size, DesSys);
  end
  else
  begin
    Result := Result + JDriveSpace(Size, DesSys);
  end;
  //pplant size tl race dessys
  if ((PPlantIsRefitted) and (DesSys = 1)) or ((PowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    Result := Result + RefittedPPlantSpace(Size, PPlantRefitTech, Race, DesSys);
  end
  else
  begin
    Result := Result + PPlantSpace(Size, TL, Race, DesSys)
  end;
end;

function TEng.CalcBakEngSpace(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
begin
  Result := 0;
  //mdrive size dessys
  if (BakMDriveIsRefitted) then
  begin
    Result := Result + RefittedBakMDriveSpace(Size, DesSys);
  end
  else
  begin
    Result := Result + BakMDriveSpace(Size, DesSys);
  end;
  //jdrive size dessys milstdjump
  if (BakJDriveIsRefitted) then
  begin
    Result := Result + RefittedBakJDriveSpace(Size, DesSys);
  end
  else
  begin
    Result := Result + BakJDriveSpace(Size, DesSys);
  end;
  //pplant size tl race dessys
  if ((PPlantIsRefitted) and (DesSys = 1)) or ((PowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    Result := Result + RefittedBakPPlantSpace(Size, PPlantRefitTech, Race, DesSys);
  end
  else
  begin
    Result := Result + BakPPlantSpace(Size, TL, Race, DesSys)
  end;
end;

function TEng.CalcEngCost(Size: Extended; TL, Race, DesSys: Integer;
  MilStdJump: Boolean): Extended;
begin
  Result := 0;
  //mdrive
  if (MDriveIsRefitted) then
  begin
    Result := Result + RefittedMDriveCost(Size, DesSys);
  end
  else
  begin
    Result := Result + MDriveCost(Size, DesSys);
  end;
  //jdrive
  if (JDriveIsRefitted) then
  begin
    Result := Result + RefittedJDriveCost(Size, DesSys, MilStdJump);
  end
  else
  begin
    Result := Result + JDriveCost(Size, DesSys, MilStdJump);
  end;
  //pplant
  if ((PPlantIsRefitted) and (DesSys = 1)) or ((PowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    Result := Result + RefittedPPlantCost(Size, TL, Race, DesSys);
  end
  else
  begin
    Result := Result + PPlantCost(Size, TL, Race, DesSys);
  end;
end;

function TEng.CalcBakEngCost(Size: Extended; TL, Race, DesSys: Integer;
  MilStdJump: Boolean): Extended;
begin
  Result := 0;
  //mdrive
  if (BakMDriveIsRefitted) then
  begin
    Result := Result + RefittedBakMDriveCost(Size, DesSys);
  end
  else
  begin
    Result := Result + BakMDriveCost(Size, DesSys);
  end;
  //jdrive
  if (BakJDriveIsRefitted) then
  begin
    Result := Result + RefittedBakJDriveCost(Size, DesSys, MilStdJump);
  end
  else
  begin
    Result := Result + BakJDriveCost(Size, DesSys, MilStdJump);
  end;
  //pplant
  if ((BakPPlantIsRefitted) and (DesSys = 1)) or ((BakPowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    Result := Result + RefittedBakPPlantCost(Size, TL, Race, DesSys);
  end
  else
  begin
    Result := Result + BakPPlantCost(Size, TL, Race, DesSys);
  end;
end;

function TEng.CalcRefitCost(Size: Extended; TL, Race, DesSys: Integer;
  MilStdJump: Boolean): Extended;
begin
  Result := 0;
  //mdrive
  if (MDriveIsRefitted) then
  begin
    if (NewMDrive > 0) then
    begin
      Result := Result + (RefittedMDriveCost(Size, DesSys) * 1.5);
    end
    else
    begin
      Result := Result + (MDriveCost(Size, DesSys) * 0.25);
    end;
  end;
  //jdrive
  if (JDriveIsRefitted) then
  begin
    if (NewJDrive > 0) then
    begin
      Result := Result + (RefittedJDriveCost(Size, DesSys, MilStdJump) * 1.5);
    end
    else
    begin
      Result := Result + (JDriveCost(Size, DesSys, MilStdJump) * 0.25);
    end;
  end;
  //pplant
  if ((PPlantIsRefitted) and (DesSys = 1)) or ((PowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    if ((NewPPlant > 0) and (DesSys = 1)) or ((NewPowerTons > 0) and (DesSys = 0)) then
    begin
      Result := Result + (RefittedPPlantCost(Size, TL, Race, DesSys) * 1.5);
    end
    else
    begin
      Result := Result + (PPlantCost(Size, TL, Race, DesSys) * 0.25);
    end;
  end;
  //bakmdrive
  if (BakMDriveIsRefitted) then
  begin
    if (BakNewMDrive > 0) then
    begin
      Result := Result + (RefittedBakMDriveCost(Size, DesSys) * 1.5);
    end
    else
    begin
      Result := Result + (BakMDriveCost(Size, DesSys) * 0.25);
    end;
  end;
  //bakjdrive
  if (BakJDriveIsRefitted) then
  begin
    if (BakNewJDrive > 0) then
    begin
      Result := Result + (RefittedBakJDriveCost(Size, DesSys, MilStdJump) * 1.5);
    end
    else
    begin
      Result := Result + (BakJDriveCost(Size, DesSys, MilStdJump) * 0.25);
    end;
  end;
  //bakpplant
  if ((BakPPlantIsRefitted) and (DesSys = 1)) or ((BakPowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    if ((BakNewPPlant > 0) and (DesSys = 1)) or ((BakNewPowerTons > 0) and (DesSys = 0)) then
    begin
      Result := Result + (RefittedBakPPlantCost(Size, TL, Race, DesSys) * 1.5);
    end
    else
    begin
      Result := Result + (BakPPlantCost(Size, TL, Race, DesSys) * 0.25);
    end;
  end;
end;

procedure TEng.SetDriveUpgradesAllowed(const AValue: Boolean);
begin
  if FDriveUpgradesAllowed=AValue then exit;
  FDriveUpgradesAllowed:=AValue;
end;

procedure TEng.SetSingleEngSpace(const AValue: Boolean);
begin
  if FSingleEngSpace=AValue then exit;
  FSingleEngSpace:=AValue;
end;

procedure TEng.SetUpgradeSpace(const AValue: Extended);
begin
  if FUpgradeSpace=AValue then exit;
  FUpgradeSpace:=AValue;
end;

procedure TEng.SetUpgradeSpaceAvailable(const AValue: Extended);
begin
  if FUpgradeSpaceAvailable=AValue then exit;
  FUpgradeSpaceAvailable:=AValue;
end;

function TEng.MDriveCost(Size: Extended; DesSys: Integer): Extended;
//calculate the cost of the m drive

begin
  if (MDrive > 0) then
  begin
    Case (MDrive) of
      1 : Result := MDriveSpace(Size, DesSys) * 1.5;
      2 : Result := MDriveSpace(Size, DesSys) * 0.7;
      else Result := MDriveSpace(Size, DesSys) * 0.5;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.MDriveSpace(Size: Extended; DesSys: Integer): Extended;
//calculate the space required by the m drive
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if (MDrive > 0) then
  begin
    Result := Max(Size * (((3 * MDrive) - 1) / 100), iMinSize);
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedMDriveCost(Size: Extended; DesSys: Integer): Extended;
begin
  if (MDriveIsRefitted) then
  begin
    if (NewMDrive > 0) then
    begin
      Case (NewMDrive) of
        1 : Result := RefittedMDriveSpace(Size, DesSys) * 1.5;
        2 : Result := RefittedMDriveSpace(Size, DesSys) * 0.7;
        else Result := RefittedMDriveSpace(Size, DesSys) * 0.5;
      end;
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedMDriveSpace(Size: Extended; DesSys: Integer): Extended;
var
  iMinSize: Integer;
begin
  if (MDriveIsRefitted) then
  begin
    if (DesSys = 1) then
    begin
      iMinSize := 1;
    end
    else
    begin
      iMinSize := 0;
    end;
    if (NewMDrive > 0) then
    begin
      Result := Max(Size * (((3 * NewMDrive) - 1) / 100), iMinSize);
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.PPlantCost(Size: Extended; TL, Race, DesSys: Integer): Extended;
//calculate the cost of the pp

begin
  if (DesSys = 0) then        //add optional rule to allow general use gohere00x04
  begin
    if (TL < 17) then
    begin
      Result := PowerTons * 3;
    end
    else
    begin
      Result := PowerTons * 1;
    end;
  end
  else
  begin
    if (PPlant > 0) then
    begin
      Result := PPlantSpace(Size, TL, Race, DesSys) * 3;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

function TEng.RefittedPPlantSpace(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if ((PPlantIsRefitted) and (DesSys = 1)) or ((PowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    if (DesSys = 0) then       //add optional rule to allow general use gohere00x05
    begin
      Result := NewPowerTons;
    end
    else
    begin
      if (NewPPlant > 0) then
      begin
        if (Race = 1) then
        begin
          Case (PPlantRefitTech) of
            7..10 : Result := Max(Size * ((NewPPlant * 4)/100), iMinSize);
            11..12 : Result := Max(Size * ((NewPPlant * 3)/100), iMinSize);
            13..14 : Result := Max(Size * ((NewPPlant * 2)/100), iMinSize);
            else Result := Max(Size * ((NewPPlant * 1)/100), iMinSize);
          end;
        end
        else
        begin
          Case (PPlantRefitTech) of
            7..8 : Result := Max(Size * ((NewPPlant * 4)/100), iMinSize);
            9..12 : Result := Max(Size * ((NewPPlant * 3)/100), iMinSize);
            13..14 : Result := Max(Size * ((NewPPlant * 2)/100), iMinSize);
            else Result := Max(Size * ((NewPPlant * 1)/100), iMinSize);
          end;
        end;
      end
      else
      begin
        Result := 0;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.RefittedPPlantCost(Size: Extended; TL, Race, DesSys: Integer
  ): Extended;
begin
  if ((PPlantIsRefitted) and (DesSys = 1)) or ((PowerTonsIsRefitted) and (DesSys = 0)) then
  begin
    if (DesSys = 0) then        //add optional rule to allow general use gohere00x04
    begin
      if (PowerTonsRefitTech < 17) then
      begin
        Result := NewPowerTons * 3;
      end
      else
      begin
        Result := NewPowerTons * 1;
      end;
    end
    else
    begin
      if (NewPPlant > 0) then
      begin
        Result := RefittedPPlantSpace(Size, PPlantRefitTech, Race, DesSys) * 3;
      end
      else
      begin
        Result := 0;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TEng.PPlantSpace(Size: Extended; TL, Race, DesSys : Integer): Extended;
//calculate the space required by the pp
var
  iMinSize: Integer;
begin
  if (DesSys = 1) then
  begin
    iMinSize := 1;
  end
  else
  begin
    iMinSize := 0;
  end;
  if (DesSys = 0) then       //add optional rule to allow general use gohere00x05
  begin
    Result := PowerTons;
  end
  else
  begin
    if (PPlant > 0) then
    begin
      if (Race = 1) then
      begin
        Case (TL) of
          7..10 : Result := Max(Size * ((PPlant * 4)/100), iMinSize);
          11..12 : Result := Max(Size * ((PPlant * 3)/100), iMinSize);
          13..14 : Result := Max(Size * ((PPlant * 2)/100), iMinSize);
          else Result := Max(Size * ((PPlant * 1)/100), iMinSize);
        end;
      end
      else
      begin
        Case (TL) of
          7..8 : Result := Max(Size * ((PPlant * 4)/100), iMinSize);
          9..12 : Result := Max(Size * ((PPlant * 3)/100), iMinSize);
          13..14 : Result := Max(Size * ((PPlant * 2)/100), iMinSize);
          else Result := Max(Size * ((PPlant * 1)/100), iMinSize);
        end;
      end;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

end.
