unit SquadronPas;

{$mode delphi}

interface

uses
  Classes, SysUtils,

  ShipPas;

type

  { TSquadron }

  TSquadron = class
  private
    FDesignerName: String;
    FSaveFile: String;
    FSquadronBudget: Extended;
    FSquadronName: String;
    FSquadronTechLevel: Integer;
    FSquadronTonnage: Extended;
    procedure SetDesignerName(const AValue: String);
    procedure SetSaveFile(const AValue: String);
    procedure SetSquadronBudget(const AValue: Extended);
    procedure SetSquadronName(const AValue: String);
    procedure SetSquadronTechLevel(const AValue: Integer);
    procedure SetSquadronTonnage(const AValue: Extended);
    function CostOfCraft(TheShip: TShip): Extended;
    function MakePlural(TheString: String): String;

  public
    //fields
    ShipList: TList;
    //properties
    property SquadronName: String read FSquadronName write SetSquadronName;
    property DesignerName: String read FDesignerName write SetDesignerName;
    property SaveFile: String read FSaveFile write SetSaveFile;
    property SquadronBudget: Extended read FSquadronBudget write SetSquadronBudget;
    property SquadronTonnage: Extended read FSquadronTonnage write SetSquadronTonnage;
    property SquadronTechLevel: Integer read FSquadronTechLevel write SetSquadronTechLevel;
    //constructor/destructor
    constructor Create;
    destructor Destroy;
    //base methods
    function AddAShip(ShipFile: String; Quant: Integer; AllDiscounted, InOrd, CarriedCraft: Boolean): Boolean;
    procedure DeleteAShip(Ship: Integer);
    procedure WriteToFile(TheFile: String);
    procedure ReadFromFile(TheFile: String);
    procedure ExportSquadron(TheFile: String);
    procedure Clear;
    function GetSqdCost: Extended;
    function GetSqdMaint: Extended;
    function GetSqdTonnage: Extended;
    function GetSqdCrew: Integer;
    function GetSqdPilots: Integer;
    function GetSqdShipsBoat: Integer;
    function GetSqdFuel: Extended;
    function GetSqdGasGiantCap: Extended;
    function GetSqdOceanCap: Extended;
    function GetSqdSmallOceanCap: Extended;
    function GetSqdMarines: Integer;
    function GetSqdShipsTroops: Integer;
    function GetGasGiantRefueling: Extended;
    function GetOceanRefueling: Extended;
    function GetSmallOceanRefueling: Extended;
    function GetLowerTech: Extended;
    function GetDropTankage: Extended;
  end;

var
  Squadron : TSquadron;

implementation

{ TSquadron }

procedure TSquadron.SetSquadronName(const AValue: String);
begin
  if FSquadronName=AValue then exit;
  FSquadronName:=AValue;
end;

procedure TSquadron.SetSquadronTechLevel(const AValue: Integer);
begin
  if FSquadronTechLevel=AValue then exit;
  FSquadronTechLevel:=AValue;
end;

procedure TSquadron.SetSquadronTonnage(const AValue: Extended);
begin
  if FSquadronTonnage=AValue then exit;
  FSquadronTonnage:=AValue;
end;

function TSquadron.CostOfCraft(TheShip: TShip): Extended;
//works out the actual cost of the craft carried not the cost of the facilities
//that carry them
begin
  Result := 0;
  if not (TheShip.Craft.Cr1Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr1Num * TheShip.Craft.Cr1Price);
  end;
  if not (TheShip.Craft.Cr2Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr2Num * TheShip.Craft.Cr2Price);
  end;
  if not (TheShip.Craft.Cr3Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr3Num * TheShip.Craft.Cr3Price);
  end;
  if not (TheShip.Craft.Cr4Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr4Num * TheShip.Craft.Cr4Price);
  end;
  if not (TheShip.Craft.Cr5Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr5Num * TheShip.Craft.Cr5Price);
  end;
  if not (TheShip.Craft.Cr6Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr6Num * TheShip.Craft.Cr6Price);
  end;
  if not (TheShip.Craft.Cr7Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr7Num * TheShip.Craft.Cr7Price);
  end;
  if not (TheShip.Craft.Cr8Vehicle = 1) then
  begin
    Result := Result + (TheShip.Craft.Cr8Num * TheShip.Craft.Cr8Price);
  end;
end;

function TSquadron.MakePlural(TheString: String): String;
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

constructor TSquadron.Create;
begin
  inherited;
  ShipList := TList.Create;
end;

destructor TSquadron.Destroy;
begin
  FreeAndNil(ShipList);
  inherited;
end;

function TSquadron.AddAShip(ShipFile: String; Quant: Integer; AllDiscounted,
  InOrd, CarriedCraft: Boolean): Boolean;
var
  NewShip: TShip;
begin
  NewShip := TShip.Create;
  try
    if (NewShip.ValidFile(ShipFile)) then
    begin
      NewShip.ReadFromFile(ShipFile);
      //not get size code, crew code, weapons factors, battereis or bats bearing
      NewShip.GenerateUSP;
      NewShip.Num := Quant;
      NewShip.DiscountAll := AllDiscounted;
      NewShip.InOrdinary := InOrd;
      NewShip.CarriedCraft := CarriedCraft;
      NewShip.ShipFile := ShipFile;
      ShipList.Add(NewShip);
      Result := True;
    end;
  except
    FreeAndNil(NewShip);
    Result := False;
  end;
end;

procedure TSquadron.DeleteAShip(Ship: Integer);
begin
  TShip(ShipList[Ship]).Free;
  ShipList.Delete(Ship);
end;

procedure TSquadron.WriteToFile(TheFile: String);
var
  SqdSaveList: TStringList;
  iCount: Integer;
  SaveShip: TShip;
begin
  try
    //assign the savefile property
    SaveFile := TheFile;
    SqdSaveList := TStringList.Create;
    //add the squadron details
    SqdSaveList.Add('"' + SquadronName
        + '","' + DesignerName
        + '",' + FloatToStrF(SquadronBudget, ffFixed, 19, 4)
        + ',' + FloatToStrF(SquadronTonnage, ffFixed, 19, 4)
        + ',' + IntToStr(SquadronTechLevel)
        + ',' + '0'     //wiggle room
        + ',' + '0'     //wiggle room
        + ',' + '0'     //wiggle room
        + ',' + '0'     //wiggle room
        + ',' + '0');   //wiggle room
    //loop through all ships adding them one by one
    for iCount := 0  to ShipList.Count - 1 do
    begin
      SaveShip := ShipList[iCount];
      SqdSaveList.Add('"' + SaveShip.ShipFile
          + '",' + IntToStr(SaveShip.Num)
          + ',' + BoolToStr(SaveShip.DiscountAll)
          + ',' + BoolToStr(SaveShip.InOrdinary)
          + ',' + BoolToStr(SaveShip.CarriedCraft)
          + ',' + '0'     //wiggle room
          + ',' + '0'     //wiggle room
          + ',' + '0'     //wiggle room
          + ',' + '0'     //wiggle room
          + ',' + '0');   //wiggle room
    end;
    //write the file
    SqdSaveList.SaveToFile(SaveFile);
  finally
    FreeAndNil(SqdSaveList);
  end;
end;

procedure TSquadron.ReadFromFile(TheFile: String);
var
  SqdReadList, ShipReadList: TStringList;
  ReadShip: TShip;
  iCount: Integer;
begin
  try
    //load the file
    SqdReadList := TStringList.Create;
    ShipReadList := TStringList.Create;
    SqdReadList.LoadFromFile(TheFile);
    //clear any existing ships
    Clear;
    //set the savefile property. Only do this after the clear
    SaveFile := TheFile;
    //take the first line and get the squadron data
    ShipReadList.CommaText := SqdReadList[0];
    SquadronName := ShipReadList[0];
    DesignerName := ShipReadList[1];
    SquadronBudget := StrToFloat(ShipReadList[2]);
    SquadronTonnage := StrToFloat(ShipReadList[3]);
    SquadronTechLevel := StrToInt(ShipReadList[4]);
    //clear the shipreadlist
    ShipReadList.Clear;
    //loop through the file starting at the second line adding ships one by one
    for iCount := 1  to SqdReadList.Count - 1 do
    begin
      //assign the working line to the shipreadlist
      ShipReadList.CommaText := SqdReadList[iCount];
      //add the ship
      AddAShip(ShipReadList[0],
               StrToInt(ShipReadList[1]),
               StrToBool(ShipReadList[2]),
               StrToBool(ShipReadList[3]),
               StrToBool(ShipReadList[4]));
      //clear the shipreadlist
      ShipReadList.Clear;
    end;
  finally
    FreeAndNil(ShipReadList);
    FreeAndNil(SqdReadList);
  end;
end;

procedure TSquadron.ExportSquadron(TheFile: String);
var
  TheShip: TShip;
  ExportList: TStringList;
  sClassString, sShipCount: String;
  iCount, iStarship, iSpaceship, iSmallcraft: Integer;
begin
  try
    ExportList := TStringList.Create;
    //add the squadron identifiers
    ExportList.Add(SquadronName + ' Squadron');
    ExportList.Add('Designed by ' + DesignerName);
    ExportList.Add('Total Budget: ' + FloatToStrF(SquadronBudget, ffNumber, 18, 3));
    ExportList.Add('Total Designed Tonnage: ' + FloatToStrF(SquadronTonnage, ffNumber, 18, 3));
    ExportList.Add('Squadron Tech Level: ' + IntToStr(SquadronTechLevel));
    ExportList.Add('');
    ExportList.Add('CLASSES');
    //loop through the ships adding their usp
    iStarship := 0;
    iSpaceship := 0;
    iSmallcraft := 0;
    for iCount := 0 to ShipList.Count - 1 do
    begin
      TheShip := ShipList[iCount];
      if (TheShip.Tonnage < 100) then
      begin
        iSmallcraft := iSmallcraft + TheShip.Num;
      end
      else
      begin
        if (TheShip.Eng.JDrive > 0) then
        begin
          iStarship := iStarship + TheShip.Num;
        end
        else
        begin
          iSpaceship := iSpaceship + TheShip.Num
        end;
      end;
      sClassString := '';
      sClassString := IntToStr(TheShip.Num) + ' x ' + TheShip.ShipClass
          + ' Class ' + TheShip.ShipType;
      if (TheShip.Num > 1) then
      begin
        sClassString := MakePlural(sClassString);
      end;
      case (TheShip.AlternateCrewRules) of
        0: sClassString := sClassString + ' (using JTAS crew code)';
        1: sClassString := sClassString + ' (using Andrew crew code)';
        2: sClassString := sClassString + ' (using Log2 crew code)';
        4: sClassString := sClassString + ' (using Dean crew code)';
        5: sClassString := sClassString + ' (using Original crew code)';
      end;
      ExportList.Add(sClassString);
      //if the ships are set differently
      if (TheShip.InOrdinary) then
      begin
        ExportList.Add('(In Ordinary)');
      end;
      if (TheShip.DiscountAll) then
      begin
        ExportList.Add('(Class discount applies to all vessels)');
      end;
      if (TheShip.CarriedCraft) then
      begin
        ExportList.Add('(Carried craft)');
      end;
      ExportList.Add('');
      ExportList.AddStrings(TheShip.USP);
      ExportList.Add('');
    end;
    //add the final details
    ExportList.Add('Squadron Cost: MCr ' + FloatToStrF(GetSqdCost, ffNumber, 18, 3));
    if (GetSqdCost > SquadronBudget) then
    begin
      ExportList.Add('(Squadron is MCr '
          + FloatToStrF(GetSqdCost - SquadronBudget, ffNumber, 18, 3)
          + ' over budget)');
    end;
    ExportList.Add('Squadron Tonnage: ' + FloatToStrF(GetSqdTonnage, ffNumber, 18, 3) + ' Td');
        if (GetSqdTonnage > SquadronTonnage) then
    begin
      ExportList.Add('(Squadron is '
          + FloatToStrF(GetSqdTonnage - SquadronTonnage, ffNumber, 18, 3)
          + ' Td over design specifications)');
    end;
    ExportList.Add('Squadron Maintaince Cost: MCr ' + FloatToStrF(GetSqdMaint, ffNumber, 18, 3));
    //count the ships
    sShipCount := IntToStr(iStarship) + ' Starship';
    if (iStarship <> 1) then
    begin
      sShipCount := MakePlural(sShipCount);
    end;
    sShipCount := sShipCount + ', ' + IntToStr(iSpaceship) + ' Spaceship';
    if (iSpaceship <> 1) then
    begin
      sShipCount := MakePlural(sShipCount);
    end;
    sShipCount := sShipCount + ', ' + IntToStr(iSmallcraft) + ' Small Craft';
    sShipCount := sShipCount + ': ' + IntToStr(iStarship + iSpaceship + iSmallcraft) + ' Vessel';
    if ((iStarship + iSpaceship + iSmallcraft) <> 1) then
    begin
      SShipCount := MakePlural(sShipCount);
    end;
    ExportList.Add(sShipCount);
    ExportList.Add('Percentage Under Tech Level ' + IntToStr(SquadronTechLevel)
        + ': ' + FloatToStrF(GetLowerTech, ffNumber, 18, 3) + '%');
    ExportList.Add('Total Crew: ' + FloatToStrF(GetSqdCrew, ffNumber, 18, 0));
    ExportList.Add('Required Pilots: ' + FloatToStrF(GetSqdPilots, ffNumber, 18, 0));
    ExportList.Add('Required Ships Boat Pilots: ' + FloatToStrF(GetSqdShipsBoat, ffNumber, 18, 0));
    ExportList.Add('Marines: ' + FloatToStrF(GetSqdMarines, ffNumber, 18, 0));
    ExportList.Add('Ships Troops: ' + FloatToStrF(GetSqdShipsTroops, ffNumber, 18, 0));
    ExportList.Add('Total Fuel Tankage: ' + FloatToStrF(GetSqdFuel, ffNumber, 18, 3) + ' Td');
    ExportList.Add('Total Drop Tankage: ' + FloatToStrF(GetDropTankage, ffNumber, 18, 3) + ' Td');
    ExportList.Add('Percentage Gas Giant Refueling Capable: '
        + FloatToStrF(GetGasGiantRefueling, ffNumber, 18, 3) + '%');
    ExportList.Add('Percentage Ocean Refueling Capable: '
        + FloatToStrF(GetOceanRefueling, ffNumber, 18, 3) + '%');
    ExportList.Add('Percentage Ocean Refueling Capable (Under 5,000 Td): '
        + FloatToStrF(GetSmallOceanRefueling, ffNumber, 18, 3) + '%');
    ExportList.SaveToFile(TheFile);
  finally
    FreeAndNil(ExportList);
  end;
end;

procedure TSquadron.Clear;
var
  iCount: Integer;
begin
  inherited;
  for iCount := 1 to ShipList.Count do
  begin
    DeleteAShip(0);
  end;
  SquadronName := '';
  DesignerName := '';
  SquadronBudget := 0;
  SquadronTonnage := 0;
  SquadronTechLevel := 0;
  SaveFile := '';
end;

function TSquadron.GetSqdCost: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eCost, eTotCost, eShipCost: Extended;
begin
  iCount := 0;
  eCost := 0;
  eTotCost := 0;
  eShipCost := 0;
  //loop through the ships one by one working out their cost and summing it
  for iCount := 0 to ShipList.Count - 1 do
  begin
    eCost := 0;
    eShipCost := 0;
    TheShip := ShipList[iCount];
    eShipCost := TheShip.Price - CostOfCraft(TheShip); //NOTE: shipcost - cost of the actual carried craft
    if (TheShip.DiscountAll) then
    begin
      eCost := (eShipCost * 0.8) * TheShip.Num; //if all discounted
    end
    else
    begin
      eCost := eShipCost + ((eShipCost * 0.8) * (TheShip.Num - 1));
    end;
    eTotCost := eTotCost + eCost;
  end;
  Result := eTotCost;
end;

function TSquadron.GetSqdMaint: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eMaint, eTotMaint, eShipCost: Extended;
begin
  iCount := 0;
  eMaint := 0;
  eTotMaint := 0;
  eShipCost := 0;
  //loop through the ships one by one working out their cost and summing it
  for iCount := 0 to ShipList.Count - 1 do
  begin
    eMaint := 0;
    TheShip := ShipList[iCount];
    //work out the cost of ship less cost of craft in it
    eShipCost := TheShip.Price - CostOfCraft(TheShip); //NOTE: shipcost - cost of the actual carried craft
    if (TheShip.InOrdinary) then   //are the ships in ordinary
    begin
      if (TheShip.Num > 1) or (TheShip.DiscountAll) then  //is the ship NOT a one off
      begin
        //10% of (80% of 10% of the ship cost * number of ships)
        //yes a long way of doing it but helps to think of it that way
        eMaint := (((eShipCost * 0.1) * 0.8) * TheShip.Num) * 0.1;
      end
      else
      begin
        // multiply by number just in case the number of ships is zero
        eMaint := ((eShipCost * 0.1) * TheShip.Num) * 0.1;
      end;
    end
    else
    begin
      if (TheShip.Num > 1) or (TheShip.DiscountAll) then  //is the ship NOT a one off
      begin
        //80% of 10% of the ship cost * number of ships
        //yes a long way of doing it but helps to think of it that way
        eMaint := ((eShipCost * 0.1) * 0.8) * TheShip.Num;
      end
      else
      begin
        // multiply by number just in case the number of ships is zero
        eMaint := (eShipCost * 0.1) * TheShip.Num;
      end;
    end;
    eTotMaint := eTotMaint + eMaint;
  end;
  Result := eTotMaint;
end;

function TSquadron.GetSqdTonnage: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eTons, eTotTons: Extended;
begin
  iCount := 0;
  eTons := 0;
  eTotTons := 0;
  //loop through ships one by one adding up tonnage
  for iCount := 0 to ShipList.Count - 1 do
  begin
    eTons := 0;
    TheShip := ShipList[iCount];
    eTons := TheShip.Tonnage * TheShip.Num;
    eTotTons := eTotTons + eTons;
  end;
  Result := eTotTons;
end;

function TSquadron.GetSqdCrew: Integer;
var
  TheShip: TShip;
  iCount, iCrew, iTotCrew: Integer;
begin
  iCount := 0;
  iCrew := 0;
  iTotCrew := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    iCrew := 0;
    TheShip := ShipList[iCount];
    if (TheShip.Num > 0) and not (TheShip.CarriedCraft) then
    begin
      if not (TheShip.InOrdinary) then
      begin
        iCrew := (TheShip.GetTotalCmdCrew + TheShip.GetTotalCrew) * TheShip.Num;
      end
      else
      begin
        iCrew := 0;
      end;
    end
    else
    begin
      iCrew := 0;
    end;
    iTotCrew := iTotCrew + iCrew;
  end;
  Result := iTotCrew;
end;

function TSquadron.GetSqdPilots: Integer;
var
  TheShip: TShip;
  iCount, iPilots, iTotPilots: Integer;
begin
  iCount := 0;
  iPilots := 0;
  iTotPilots := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    iPilots := 0;
    TheShip := ShipList[iCount];
    //check that its not a ships boat and not in ordinary
    if (TheShip.Tonnage >= 100) and not (TheShip.InOrdinary) then
    begin
      if not (TheShip.InOrdinary) then
      begin
        //3 pilots if over 20,000T,  if over 500, 1 otherwise
        if (TheShip.Tonnage > 20000) then
        begin
          iPilots := 3 * TheShip.Num;
        end
        else if (TheShip.Tonnage >= 500) then
        begin
          iPilots := 2 * TheShip.Num;
        end
        else
        begin
          iPilots := 1 * TheShip.Num;
        end;
      end
      else
      begin
        iPilots := 0;
      end;
    end
    else
    begin
      iPilots := 0;
    end;
    iTotPilots := iTotPilots + iPilots;
  end;
  Result := iTotPilots;
end;

function TSquadron.GetSqdShipsBoat: Integer;
var
  TheShip: TShip;
  iCount, iSbPilots, iTotSbPilots: Integer;
begin
  iCount := 0;
  iSbPilots := 0;
  iTotSbPilots := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    iSbPilots := 0;
    TheShip := ShipList[iCount];
    //check that its a ships boat and not in ordinary
    if (TheShip.Tonnage < 100) then
    begin
      if not (TheShip.InOrdinary) then
      begin
        iSbPilots := 1 * TheShip.Num;
      end
      else
      begin
        iSbPilots := 0;
      end;
    end
    else
    begin
      iSbPilots := 0;
    end;
    iTotSbPilots := iTotSbPilots + iSbPilots;
  end;
  Result := iTotSbPilots;
end;

function TSquadron.GetSqdFuel: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eFuel, eTotFuel: Extended;
begin
  iCount := 0;
  eFuel := 0;
  eTotFuel := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    eFuel := 0;
    eFuel := TheShip.GetFuelTons * TheShip.Num;
    eTotFuel := eTotFuel + eFuel;
  end;
  Result := eTotFuel;
end;

function TSquadron.GetSqdGasGiantCap: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eGasGiantCap, eTotGasGiantCap: Extended;
begin
  iCount := 0;
  eGasGiantCap := 0;
  eTotGasGiantCap := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    eGasGiantCap := 0;
    //check to see if the ship is capable of gas giant refueling (config 6 or less)
    if (TheShip.Hull.Config < 7) then
    begin
      eGasGiantCap := TheShip.GetFuelTons * TheShip.Num;
    end
    else
    begin
      eGasGiantCap := 0;
    end;
    eTotGasGiantCap := eTotGasGiantCap + eGasGiantCap;
  end;
  Result := eTotGasGiantCap;
end;

function TSquadron.GetSqdOceanCap: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eOceanCap, eTotOceanCap: Extended;
begin
  iCount := 0;
  eOceanCap := 0;
  eTotOceanCap := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    eOceanCap := 0;
    //check if T20 ship
    if (TheShip.DesignRules = 0) then
    begin
      //check to see if the ship is capable of ocean refueling (config 1, 2, 6, streamlined or airframe)
      if (TheShip.Hull.Config < 3) or (TheShip.Hull.Config = 6)
          or (TheShip.Hull.StreamLining = 0) or (TheShip.Hull.Airframe = 0) then
      begin
        eOceanCap := TheShip.GetFuelTons * TheShip.Num;
      end
      else
      begin
        eOceanCap := 0;
      end;
      eTotOceanCap := eTotOceanCap + eOceanCap;
    end
    //do HG2 rules
    else
    begin
      //check to see if the ship is capable of ocean refueling (config 1, 2, or 6)
      if (TheShip.Hull.Config < 3) or (TheShip.Hull.Config = 6) then
      begin
        eOceanCap := TheShip.GetFuelTons * TheShip.Num;
      end
      else
      begin
        eOceanCap := 0;
      end;
      eTotOceanCap := eTotOceanCap + eOceanCap;
    end;
  end;
  Result := eTotOceanCap;
end;

function TSquadron.GetSqdSmallOceanCap: Extended;
var
  TheShip: TShip;
  iCount: Integer;
  eSmOceanCap, eTotSmOceanCap: Extended;
begin
  iCount := 0;
  eSmOceanCap := 0;
  eTotSmOceanCap := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    eSmOceanCap := 0;
    //see if the ship is 5000 tons or less
    if (TheShip.Tonnage <= 5000) then
    begin
      //check if T20 ship
      if (TheShip.DesignRules = 0) then
      begin
        //check to see if the ship is capable of ocean refueling (config 1, 2, 6, streamlined or airframe)
        if (TheShip.Hull.Config < 3) or (TheShip.Hull.Config = 6)
            or (TheShip.Hull.StreamLining = 0) or (TheShip.Hull.Airframe = 0) then
        begin
          eSmOceanCap := TheShip.GetFuelTons * TheShip.Num;
        end
        else
        begin
          eSmOceanCap := 0;
        end;
        eTotSmOceanCap := eTotSmOceanCap + eSmOceanCap;
      end
      //do HG2 rules
      else
      begin
        //check to see if the ship is capable of ocean refueling (config 1, 2, or 6)
        if (TheShip.Hull.Config < 3) or (TheShip.Hull.Config = 6) then
        begin
          eSmOceanCap := TheShip.GetFuelTons * TheShip.Num;
        end
        else
        begin
          eSmOceanCap := 0;
        end;
      end;
    end
    else
    begin
      eSmOceanCap := 0;
    end;
    eTotSmOceanCap := eTotSmOceanCap + eSmOceanCap;
  end;
  Result := eTotSmOceanCap;
end;

function TSquadron.GetSqdMarines: Integer;
var
  TheShip: TShip;
  iCount, iShipMarines, iTotMarines: Integer;
begin
  iCount := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    iShipMarines := 0;
    if (TheShip.Num > 0) and not (TheShip.InOrdinary) then
    begin
      iShipMarines := TheShip.Accom.Marines;
      iTotMarines := iTotMarines + (iShipMarines * TheShip.Num);
    end;
  end;
  Result := iTotMarines;
end;

function TSquadron.GetSqdShipsTroops: Integer;
var
  TheShip: TShip;
  iCount, iShipShipsTroops, iTotShipsTroops: Integer;
begin
  iCount := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    iShipShipsTroops := 0;
    if (TheShip.Num > 0) and not (TheShip.InOrdinary) then
    begin
      iShipShipsTroops := TheShip.Accom.ShipsTroops;
      iTotShipsTroops := iTotShipsTroops + (iShipShipsTroops * TheShip.Num);
    end;
  end;
  Result := iTotShipsTroops;
end;

function TSquadron.GetGasGiantRefueling: Extended;
var
  eTotFuel, eGasGiantCap, eGasGiantRefueling: Extended;
begin
  eTotFuel := GetSqdFuel;
  eGasGiantCap := GetSqdGasGiantCap;
  eGasGiantRefueling := 0;
  if (eTotFuel > 0) then
  begin
    eGasGiantRefueling := (eGasGiantCap / eTotFuel) * 100;
  end;
  Result := eGasGiantRefueling;
end;

function TSquadron.GetOceanRefueling: Extended;
var
  eTotFuel, eOceanCap, eOceanRefueling: Extended;
begin
  eTotFuel := GetSqdFuel;
  eOceanCap := GetSqdOceanCap;
  eOceanRefueling := 0;
  if (eTotFuel > 0) then
  begin
    eOceanRefueling := (eOceanCap / eTotFuel) * 100;
  end;
  Result := eOceanRefueling;
end;

function TSquadron.GetSmallOceanRefueling: Extended;
var
  eTotFuel, eSmOceanCap, eSmOceanRefueling: Extended;
begin
  eTotFuel := GetSqdFuel;
  eSmOceanCap := GetSqdSmallOceanCap;
  eSmOceanRefueling := 0;
  if (eTotFuel > 0) then
  begin
    eSmOceanRefueling := (eSmOceanCap / eTotFuel) * 100;
  end;
  Result := eSmOceanRefueling;
end;

function TSquadron.GetLowerTech: Extended;
var
  iCount: Integer;
  eSqdCost, eSqdLoTechCost, eShipCost, eLoTechPercent: Extended;
  TheShip: TShip;
begin
  eSqdCost := GetSqdCost;
  eSqdLoTechCost := 0;
  eLoTechPercent := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    eShipCost := 0;
    TheShip := ShipList[iCount];
    //work out base price of class
    eShipCost := TheShip.Price - CostOfCraft(TheShip); //NOTE: shipcost - cost of the actual carried craft
    if (TheShip.DiscountAll) then
    begin
      eShipCost := (eShipCost * 0.8) * TheShip.Num; //if all discounted
    end
    else
    begin
      eShipCost := eShipCost + ((eShipCost * 0.8) * (TheShip.Num - 1));
    end;
    //if the class is below max tech track it
    if (TheShip.TechLevel < SquadronTechLevel) then
    begin
      eSqdLoTechCost := eSqdLoTechCost + eShipCost;
    end;
  end;
  if (eSqdCost > 0) then
  begin
    eLoTechPercent := (eSqdLoTechCost / eSqdCost) * 100;
  end
  else
  begin
    eLoTechPercent := 0;
  end;
  Result := eLoTechPercent;
end;

function TSquadron.GetDropTankage: Extended;
var
  TheShip : TShip;
  iCount : Integer;
  eTankage, eTotTanks : Extended;
begin
  eTankage := 0;
  eTotTanks := 0;
  for iCount := 0 to ShipList.Count - 1 do
  begin
    TheShip := ShipList[iCount];
    //Jump fuel at 10% of tonnage per parsec
    eTankage := ((TheShip.Tonnage * 0.1) * TheShip.Fuel.LhydJFuel);
    //pp fuel at 1% of tonnage per PP num per 28 days
    eTankage := eTankage + (((TheShip.Tonnage * 0.01) * TheShip.Eng.PPlant)
        * (TheShip.Fuel.LhydPFuel / 28));
    if (eTankage > 0) then
    begin
      eTankage := eTankage * TheShip.Num;
      eTotTanks := eTotTanks + eTankage;
    end;
  end;
  Result := eTotTanks;
end;

procedure TSquadron.SetDesignerName(const AValue: String);
begin
  if FDesignerName=AValue then exit;
  FDesignerName:=AValue;
end;

procedure TSquadron.SetSaveFile(const AValue: String);
begin
  if FSaveFile=AValue then exit;
  FSaveFile:=AValue;
end;

procedure TSquadron.SetSquadronBudget(const AValue: Extended);
begin
  if FSquadronBudget=AValue then exit;
  FSquadronBudget:=AValue;
end;

end.

