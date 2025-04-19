unit HullPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas;

type
   THull = class(TShipModule)
   private
      fConfig : Integer;
      fArmour : Integer;
      fStreamLining : Integer;
      fAirframe : Integer;
      fStructure : Extended;
   public
      function ConfigCost(Size : Extended) : Extended;
      function ArmourCost(Size : Extended; TL : Integer) : Extended;
      function ConfigSpace(Size : Extended) : Extended;
      function ArmourSpace(Size : Extended; TL : Integer) : Extended;
      function ControlsSpace(Size : Extended) : Extended;
      property Config : Integer read fConfig write fConfig;
      property Armour : Integer read fArmour write fArmour;
      property StreamLining : Integer read fStreamLining write fStreamLining;
      property Airframe : Integer read fAirframe write fAirframe;
      property Structure : Extended read fStructure write fStructure;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignHull(ShipData : String);
   end;

var
   Hull : THull;

implementation

{ THull }

function THull.ArmourCost(Size: Extended; TL: Integer): Extended;
//calculate the cost of armour

begin
  Result := 0;
  if (Armour > 0) then
  begin
    Case (TL) of
      7..9 : Result := (Size * (0.04 + ((4 * Armour)/100))) * (0.3 + (Armour/10));
      10..11 : Result := (Size * (0.03 + ((3 * Armour)/100))) * (0.3 + (Armour/10));
      12..13 : Result := (Size * (0.02 + ((2 * Armour)/100))) * (0.3 + (Armour/10));
      else Result := (Size * (0.01 + ((1 * Armour)/100))) * (0.3 + (Armour/10));
    end;
  end;
end;

function THull.ArmourSpace(Size: Extended; TL: Integer): Extended;
//calculate size of armour

begin
  Result := 0;
  if (Armour > 0) then
  begin
    Case (TL) of
      7..9 : Result := Size * (0.04 + ((4 * Armour)/100));
      10..11 : Result := Size * (0.03 + ((3 * Armour)/100));
      12..13 : Result := Size * (0.02 + ((2 * Armour)/100));
      else Result := Size * (0.01 + ((1 * Armour)/100));
    end;
  end;
end;

procedure THull.AssignDefaults(ShipData: String);
//assign the default values

var
  Props : TStringList;
begin
  Props := TStringList.Create;
  try
    Props.CommaText := ShipData;
    Space := 0;
    Cost := 0;
    Config := StrToInt(Props[0]);
    Armour := StrToInt(Props[1]);
    StreamLining := StrToInt(Props[2]);
    Airframe := StrToInt(Props[3]);
    Structure := StrToFloat(Props[4]);
  finally
    FreeAndNil(Props);
  end;
end;

function THull.ConfigCost(Size: Extended): Extended;
//calculate hull cost

var
   HullCost : Extended;
begin
   HullCost := 0;
   Case (Config) of
      1 : HullCost := (Size/10) * 1.2;
      2 : HullCost := (Size/10) * 1.1;
      3 : HullCost := (Size/10);
      4 : HullCost := (Size/10) * 0.6;
      5 : HullCost := (Size/10) * 0.7;
      6 : HullCost := (Size/10) * 0.8;
      7 : HullCost := (Size/10) * 0.5;
      8 : HullCost := (Size/10000) + ((Size * 0.8)/1000);
      9 : HullCost := (Size/10000) + ((Size * 0.65)/1000);
   end;
   if (StreamLining = 0) then begin
      HullCost := HullCost + (Size * 0.005);
   end;
   Result := HullCost;
end;

function THull.ConfigSpace(Size: Extended): Extended;
//planetoid hull requirements

begin
   Result := 0;
   Case (Config) of
      8 : Result := Size * 0.2;
      9 : Result := Size * 0.35;
      else Result := 0;
   end;
end;

function THull.ControlsSpace(Size: Extended): Extended;
//airframe controls requirements

begin
  Result := 0;
  if (Airframe = 0) then
  begin
    Result := Size * 0.05;
  end;
end;

procedure THull.DesignHull(ShipData : String);
//Design the hull

var
  ShipDetails : TStringList;
  Tonnage : Extended;
  Techlevel : Integer;
begin
  ShipDetails := TStringList.Create;
  try
    ShipDetails.CommaText := ShipData;
    TechLevel := StrToInt(ShipDetails[0]);
    Tonnage := StrToFloat(ShipDetails[1]);
    Cost := ConfigCost(Tonnage) + ArmourCost(Tonnage, TechLevel)
        + 0;
    Space := ConfigSpace(Tonnage) + ArmourSpace(Tonnage, TechLevel)
        + ControlsSpace(Tonnage) + Structure;
    RefitCost := 0;
  finally
    FreeAndNil(ShipDetails);
  end;
end;

end.
