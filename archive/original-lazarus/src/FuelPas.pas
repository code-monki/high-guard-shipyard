unit FuelPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas, Math;

type

   { TFuel }

   TFuel = class(TShipModule)
   private
     FBaseJFuel: Integer;
     FBasePFuel: Integer;
     FBaseEFuel: Extended;
     FLhydExtraFuel: Extended;
      fPFuel : Integer;
      fJFuel : Integer;
      FPurifyLHyd: Boolean;
      FRefitPurif: Boolean;
      FRefitPurifTech: Integer;
      fScoops : Integer;
      fPurif : Integer;
      fLhydPFuel : Integer;
      fLhydJFuel : Integer;
      fExtraFuel : Extended;

      fTestDesign : Boolean;
      procedure SetBaseJFuel(const AValue: Integer);
      procedure SetBaseEFuel(const AValue: Extended);
      procedure SetBasePFuel(const AValue: Integer);
      procedure SetLhydExtraFuel(const AValue: Extended);
      procedure SetPurifyLHyd(const AValue: Boolean);
      procedure SetRefitPurif(const AValue: Boolean);
      procedure SetRefitPurifTech(const AValue: Integer);

   public
      function PFuelSpace(Size, PowTons : Extended; PP, TL, Race, DesSys : Integer) : Extended;
      function JFuelSpace(Size : Extended) : Extended;
      function ScoopsCost(Size : Extended) : Extended;
      function PurifCost(Size, PowTons : Extended; TL, PowTL, Race, PP, DesSys : Integer) : Extended;
      function PurifSpace(Size, PowTons : Extended; TL, PowTL, Race, PP, DesSys : Integer) : Extended;
      function LhydFuelCost(Size : Extended; PP : Integer) : Extended;
      function FuelSpace(Size, PowTons : Extended; PP, TL, Race, DesSys : Integer) : Extended;
      property PFuel : Integer read fPFuel write fPFuel;
      property JFuel : Integer read fJFuel write fJFuel;
      property Scoops : Integer read fScoops write fScoops;
      property Purif : Integer read fPurif write fPurif;
      property LhydPFuel : Integer read fLhydPFuel write fLhydPFuel;
      property LhydJFuel : Integer read fLhydJFuel write fLhydJFuel;
      property LhydExtraFuel: Extended read FLhydExtraFuel write SetLhydExtraFuel;
      property ExtraFuel : Extended read fExtraFuel write fExtraFuel;
      property PurifyLHyd: Boolean read FPurifyLHyd write SetPurifyLHyd;
      property RefitPurif: Boolean read FRefitPurif write SetRefitPurif;
      property RefitPurifTech: Integer read FRefitPurifTech write SetRefitPurifTech;
      property BasePFuel: Integer read FBasePFuel write SetBasePFuel;
      property BaseJFuel: Integer read FBaseJFuel write SetBaseJFuel;
      property BaseEFuel: Extended read FBaseEFuel write SetBaseEFuel;

      property TestDesign : Boolean read fTestDesign write fTestDesign;
      function CalcLhydFuel(Size, PowTons : Extended; PP, TL, Race, DesSys: Integer): Extended;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignFuel(ShipData : String);
   end;

var
   Fuel : TFuel;

implementation

{ TFuel }

procedure TFuel.AssignDefaults(ShipData: String);
//assign the default values on creation

var
  Props : TStringList;
begin
  Props := TStringList.Create;
  try
    Props.CommaText := ShipData;
    Space := 0;
    Cost := 0;
    PFuel := StrToInt(Props[0]);
    JFuel := StrToInt(Props[1]);
    Scoops := StrToInt(Props[2]);
    Purif := StrToInt(Props[3]);
    LhydPFuel := StrToInt(Props[4]);
    LHydJFuel := StrToInt(Props[5]);
    ExtraFuel := StrToFloat(Props[6]);
    LHydExtraFuel := StrToFloat(Props[7]);
    PurifyLHyd := StrToBool(Props[8]);
    RefitPurif := StrToBool(Props[9]);
    RefitPurifTech := StrToInt(Props[10]);
    BasePFuel := StrToInt(Props[11]);
    BaseJFuel := StrToInt(Props[12]);
    BaseEFuel := StrToFloat(Props[13]);
  finally
    FreeAndNil(Props);
  end;
end;

procedure TFuel.DesignFuel(ShipData: String);
//design the module

var
  ShipDetails : TStringList;
  Tonnage, PowerTons, PFuelCost, ePureCost : Extended;
  Techlevel, ShipRace, PwrPlnt, DesignRules, PowerTech : Integer;
//   TestDesign : Boolean;
begin
  ShipDetails := TStringList.Create;
  try
    ShipDetails.CommaText := ShipData;
    TechLevel := StrToInt(ShipDetails[0]);
    Tonnage := StrToFloat(ShipDetails[1]);
    ShipRace := StrToInt(ShipDetails[2]);
    PwrPlnt := StrToInt(ShipDetails[4]);
    DesignRules := StrToInt(ShipDetails[7]);
    PowerTons := StrToFloat(ShipDetails[8]);
    //TestDesign := StrToBool(ShipDetails[11]);
    PowerTech := StrToInt(ShipDetails[15]);
    if (RefitPurif) then
    begin
      Cost := ScoopsCost(Tonnage)
          + PurifCost(Tonnage, PowerTons, RefitPurifTech, PowerTech, ShipRace, PwrPlnt, DesignRules)
          + LhydFuelCost(Tonnage, PwrPlnt);
      ePureCost := PurifCost(Tonnage, PowerTons, RefitPurifTech, PowerTech, ShipRace, PwrPlnt, DesignRules);
      Space := FuelSpace(Tonnage, PowerTons, PwrPlnt, PowerTech, ShipRace, DesignRules)
          + PurifSpace(Tonnage, PowerTons, RefitPurifTech, PowerTech, ShipRace, PwrPlnt, DesignRules);
    end
    else
    begin
      Cost := ScoopsCost(Tonnage)
          + PurifCost(Tonnage, PowerTons, TechLevel, PowerTech, ShipRace, PwrPlnt, DesignRules)
          + LhydFuelCost(Tonnage, PwrPlnt);
      ePureCost := PurifCost(Tonnage, PowerTons, TechLevel, PowerTech, ShipRace, PwrPlnt, DesignRules);
      Space := FuelSpace(Tonnage, PowerTons, PwrPlnt, PowerTech, ShipRace, DesignRules)
          + PurifSpace(Tonnage, PowerTons, TechLevel, PowerTech, ShipRace, PwrPlnt, DesignRules);
    end;
    if (RefitPurif) then
    begin
      if (ePureCost > 0) then
      begin
        RefitCost := ePureCost * 1.1;
      end
      else
      begin
        RefitCost := PurifCost(Tonnage, PowerTons, TechLevel, PowerTech, ShipRace, PwrPlnt, DesignRules) * 0.25;
      end;
    end
    else
    begin
      RefitCost := 0;
    end;
    //if (TestDesign) then
    //begin
    //  PFuelCost := PFuelSpace(Tonnage, PowerTons, PwrPlnt, TechLevel, ShipRace, DesignRules) * 3;
    //  Cost := Cost + PFuelCost;
    //end;
  finally
    FreeAndNil(ShipDetails);
  end;
end;

function TFuel.FuelSpace(Size, PowTons: Extended; PP, TL, Race, DesSys: Integer): Extended;
//calculate the space required for the fuel

var
  TotFuel : Extended;
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
  TotFuel := PFuelSpace(Size, PowTons, PP, TL, Race, DesSys) + JFuelSpace(Size) + ExtraFuel;
  if (TotFuel > 0) then
  begin
    Result := Max(TotFuel, iMinSize)
  end
  else
  begin
    Result := 0;
  end;
end;

function TFuel.CalcLhydFuel(Size, PowTons: Extended; PP, TL, Race, DesSys: Integer): Extended;
var
  JFuelSpace, PFuelSpace, EFuelSpace: Extended;
begin
  if (DesSys = 0) then
  begin
    if Race = 1 then
    begin
      case (TL) of
        7..10 : PFuelSpace := ((PowTons / 2) * LhydPFuel) / 28;
        11..12 : PFuelSpace := ((PowTons / 1.5) * LhydPFuel) / 28;
        13..16 : PFuelSpace := ((PowTons / 1) * LhydPFuel) / 28;
        else Result := (((PowTons / 1) * LhydPFuel) / 28) / 10;
      end;
    end
    else
    begin
      case (TL) of
        7..8 : PFuelSpace := ((PowTons / 2) * LhydPFuel) / 28;
        9..12 : PFuelSpace := ((PowTons / 1.5) * LhydPFuel) / 28;
        13..16 : PFuelSpace := ((PowTons / 1) * LhydPFuel) / 28;
        else PFuelSpace := (((PowTons / 1) * LhydPFuel) / 28) / 10;
      end;
    end;
  end
  else
  begin
    PFuelSpace := ((Size * (PP/100)) * LhydPFuel) / 28;
  end;
  JFuelSpace := Size * (LhydJFuel/10);
  EFuelSpace := LHydExtraFuel;
  Result := JFuelSpace + PFuelSpace + EFuelSpace;
end;

function TFuel.JFuelSpace(Size: Extended): Extended;
//calculate the space required for J fuel

begin
  Result := Size * (JFuel/10);
end;

function TFuel.LhydFuelCost(Size: Extended; PP: Integer): Extended;
//calculate the cost of the ship fittings for any drop tanks
//NOTE: this does not calculate the cost of the tanks themselves

var
  LPFuel, LJFuel, LEFuel : Extended;
begin
  LPFuel := 0;
  LJFuel := 0;
  if (LhydPFuel > 0) or (LhydJFuel > 0) or (LHydExtraFuel > 0) then
  begin
    LPFuel := ((Size * (PP/100)) * LhydPFuel) / 28;
    LJFuel := Size * (LhydJFuel/10);
    LEFuel := LHydExtraFuel;
    Result := (0.001 *(LPFuel + LJFuel + LEFuel)) + 0.01;
  end
  else
  begin
    Result := 0;
  end;
end;

procedure TFuel.SetLhydExtraFuel(const AValue: Extended);
begin
  if FLhydExtraFuel=AValue then exit;
  FLhydExtraFuel:=AValue;
end;

procedure TFuel.SetBaseJFuel(const AValue: Integer);
begin
  if FBaseJFuel=AValue then exit;
  FBaseJFuel:=AValue;
end;

procedure TFuel.SetBaseEFuel(const AValue: Extended);
begin
  if FBaseEFuel=AValue then exit;
  FBaseEFuel:=AValue;
end;

procedure TFuel.SetBasePFuel(const AValue: Integer);
begin
  if FBasePFuel=AValue then exit;
  FBasePFuel:=AValue;
end;

procedure TFuel.SetPurifyLHyd(const AValue: Boolean);
begin
  if FPurifyLHyd=AValue then exit;
  FPurifyLHyd:=AValue;
end;

procedure TFuel.SetRefitPurif(const AValue: Boolean);
begin
  if FRefitPurif=AValue then exit;
  FRefitPurif:=AValue;
end;

procedure TFuel.SetRefitPurifTech(const AValue: Integer);
begin
  if FRefitPurifTech=AValue then exit;
  FRefitPurifTech:=AValue;
end;

function TFuel.PFuelSpace(Size, PowTons: Extended; PP, TL, Race, DesSys: Integer): Extended;
//calculate the space required for the power plant fuel
{ TODO : Update T20 power fuel to account for K'kree }

begin
  if (DesSys = 0) then
  begin
    if Race = 1 then
    begin
      case (TL) of
        7..10 : Result := ((PowTons / 2) * PFuel) / 28;
        11..12 : Result := ((PowTons / 1.5) * PFuel) / 28;
        13..16 : Result := ((PowTons / 1) * PFuel) / 28;
        else Result := (((PowTons / 1) * PFuel) / 28) / 10;
      end;
    end
    else
    begin
      case (TL) of
        7..8 : Result := ((PowTons / 2) * PFuel) / 28;
        9..12 : Result := ((PowTons / 1.5) * PFuel) / 28;
        13..16 : Result := ((PowTons / 1) * PFuel) / 28;
        else Result := (((PowTons / 1) * PFuel) / 28) / 10;
      end;
    end;
  end
  else
  begin
    Result := ((Size * (PP/100)) * PFuel) / 28;
  end;
end;

function TFuel.PurifCost(Size, PowTons: Extended; TL, PowTL, Race, PP, DesSys: Integer): Extended;
//calculate the cost of the fuel purification plant

begin
  //27-03-2012 modified to reflect TCS formula, T20 still uses old formula
  if (Purif = 0) then
  begin
    if (DesSys = 0) then
    begin
      case (TL) of
        7 : Result := 0;
        8 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/50) * 0.2;
        9 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/45) * 0.19;
        10 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/40) * 0.18;
        11 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/35) * 0.17;
        12 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/30) * 0.16;
        13 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/25) * 0.15;
        14 : Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/20) * 0.14;
        else Result := (PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys)/15) * 0.15;
      end;
    end
    else
    begin
      case (TL) of
        7 : Result := 0;
        8 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.004;
        9 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.004222;
        10 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.0045;
        11 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.004857;
        12 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.005333;
        13 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.006;
        14 : Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.007;
        else Result := PurifSpace(Size, PowTons, TL, PowTL, Race, PP, DesSys) * 0.01;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TFuel.PurifSpace(Size, PowTons: Extended; TL, PowTL, Race, PP, DesSys: Integer): Extended;
//calculate the space required by the fuel purification plant
var
  FuelTankage, DropTankage: Extended;
begin
  FuelTankage := FuelSpace(Size, PowTons, PP, PowTL, Race, DesSys);
  DropTankage := CalcLhydFuel(Size, PowTons, PP, PowTL, Race, DesSys);
  if (Purif = 0) then
  begin
    //27-03-2012 modified plant tonnage to reflect TCS (reduced all to 10% of previous)
    //T20 still uses old formula
    if (PurifyLhyd) then
    begin
      if (DesSys = 0) then
      begin
        case (TL) of
          7 : Result := 0;
          8 : Result := Max(10, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 50));
          9 : Result := Max(9, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 45));
          10 : Result := Max(8, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 40));
          11 : Result := Max(7, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 35));
          12 : Result := Max(6, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 30));
          13 : Result := Max(5, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 25));
          14 : Result := Max(4, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 20));
          else Result := Max(3, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 15));
        end;
      end
      else
      begin
        case (TL) of
          7 : Result := 0;
          8 : Result := Max(10, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 5.0));
          9 : Result := Max(9, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 4.5));
          10 : Result := Max(8, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 4.0));
          11 : Result := Max(7, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 3.5));
          12 : Result := Max(6, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 3.0));
          13 : Result := Max(5, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 2.5));
          14 : Result := Max(4, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 2.0));
          else Result := Max(3, FloatToIntUp(((FuelTankage + DropTankage) / 1000) * 1.5));
        end;
      end;
    end
    else
    begin
      if (DesSys = 0) then
      begin
        case (TL) of
          7 : Result := 0;
          8 : Result := Max(10, FloatToIntUp((FuelTankage / 1000) * 50));
          9 : Result := Max(9, FloatToIntUp((FuelTankage / 1000) * 45));
          10 : Result := Max(8, FloatToIntUp((FuelTankage / 1000) * 40));
          11 : Result := Max(7, FloatToIntUp((FuelTankage / 1000) * 35));
          12 : Result := Max(6, FloatToIntUp((FuelTankage / 1000) * 30));
          13 : Result := Max(5, FloatToIntUp((FuelTankage / 1000) * 25));
          14 : Result := Max(4, FloatToIntUp((FuelTankage / 1000) * 20));
          else Result := Max(3, FloatToIntUp((FuelTankage / 1000) * 15));
        end;
      end
      else
      begin
        case (TL) of
          7 : Result := 0;
          8 : Result := Max(10, FloatToIntUp((FuelTankage / 1000) * 5.0));
          9 : Result := Max(9, FloatToIntUp((FuelTankage / 1000) * 4.5));
          10 : Result := Max(8, FloatToIntUp((FuelTankage / 1000) * 4.0));
          11 : Result := Max(7, FloatToIntUp((FuelTankage / 1000) * 3.5));
          12 : Result := Max(6, FloatToIntUp((FuelTankage / 1000) * 3.0));
          13 : Result := Max(5, FloatToIntUp((FuelTankage / 1000) * 2.5));
          14 : Result := Max(4, FloatToIntUp((FuelTankage / 1000) * 2.0));
          else Result := Max(3, FloatToIntUp((FuelTankage / 1000) * 1.5));
        end;
      end;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TFuel.ScoopsCost(Size: Extended): Extended;
//calculate the cost of the fuel scoops if fitted

begin
   if (Scoops = 0) and (Size >= 100) then begin
      Result := Size/1000;
   end
   else begin
      Result := 0;
   end;
end;

end.
