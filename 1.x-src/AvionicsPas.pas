unit AvionicsPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas, DataPas, Math;

type
   TComputerSet = set of 0..20;

   { TAvionics }

   TAvionics = class(TExtShipModule)
   private
     FBakCommsRefitTech: Integer;
     FBakCompRefitTech: Integer;
     FBakFltAvionicsRefitTech: Integer;
     FBakSensorsRefitTech: Integer;
     FCommsRefitTech: Integer;
     FCompRefitTech: Integer;
     FFlagBridge: Boolean;
     FFlagComp: Integer;
     FFlagCompRefitTech: Integer;
     FFltAvionicsRefitTech: Integer;
      fMainComp : Integer;
      fBakComp : Integer;
      fBakCompNum : Integer;
      fBridge : Integer;
      fBakBridge : Integer;
      fBakBridgeNum : Integer;
      fFltAvionics : Integer;
      fBakFltAvionics : Integer;
      fBakFltAvionicsNum : Integer;
      FNewBakBridgeNum: Integer;
      FNewBakComms: Integer;
      FNewBakCommsNum: Integer;
      FNewBakComp: Integer;
      FNewBakCompNum: Integer;
      FNewBakFltAvionics: Integer;
      FNewBakFltAvionicsNum: Integer;
      FNewBakSensors: Integer;
      FNewBakSensorsNum: Integer;
      FNewComms: Integer;
      FNewCommsType: Integer;
      FNewComp: Integer;
      FNewFlagComp: Integer;
      FNewFltAvionics: Integer;
      FNewSensors: Integer;
      FRefitBakBridge: Boolean;
      FRefitBakComms: Boolean;
      FRefitBakComp: Boolean;
      FRefitBakFltAvionics: Boolean;
      FRefitBakSensors: Boolean;
      FRefitBridge: Boolean;
      FRefitComms: Boolean;
      FRefitCommsType: Boolean;
      FCommsTypeRefitTech: Integer;
      FRefitComp: Boolean;
      FRefitFlagBridge: Boolean;
      FRefitFlagComp: Boolean;
      FRefitFltAvionics: Boolean;
      FRefitSensors: Boolean;
      fSensors : Integer;
      fBakSensors : Integer;
      fBakSensorsNum : Integer;
      fComms : Integer;
      fBakComms : Integer;
      fBakCommsNum : Integer;
      fCommsType : Integer;
      FSensorsRefitTech: Integer;
      function IsFib(Computer : Integer) : Boolean;
      function CompModel(Computer : Integer) : Integer;
      function CalcRefitCost(Size: Extended; Race, DesSys, FibMain, FibBak, FibFlag: Integer; Data: TData): Extended;
      function CalcRefitCompCost(Race: Integer; Data: TData): Extended;
      function CalcRefitBridgeCost(Size: Extended; Race: Integer): Extended;
      function CalcRefitFltAvionicsCost(Race: Integer): Extended;
      function CalcRefitBakFltAvionicsCost(Race: Integer): Extended;
      function CalcRefitSensorsCost(Race: Integer): Extended;
      function CalcRefitBakSensorsCost(Race: Integer): Extended;
      function CalcRefitCommsCost(Race: Integer): Extended;
      function CalcReftBakCommsCost(Race: Integer): Extended;
      function CalcR20Cost(Size: Extended; Race: Integer): Extended;
      function CalcR20Space(Size: Extended; Race: Integer): Extended;
      function CalcCost(Size: Extended; Race: Integer; Data: TData): Extended;
      function CalcSpace(Size: Extended; Data: TData): Extended;
      procedure SetBakCommsRefitTech(const AValue: Integer);
      procedure SetBakCompRefitTech(const AValue: Integer);
      procedure SetBakFltAvionicsRefitTech(const AValue: Integer);
      procedure SetBakSensorsRefitTech(const AValue: Integer);
      procedure SetCommsRefitTech(const AValue: Integer);
      procedure SetCompRefitTech(const AValue: Integer);
      procedure SetFlagBridge(const AValue: Boolean);
      procedure SetFlagComp(const AValue: Integer);
      procedure SetFlagCompRefitTech(const AValue: Integer);
      procedure SetFltAvionicsRefitTech(const AValue: Integer);
      procedure SetNewBakBridgeNum(const AValue: Integer);
      procedure SetNewBakComms(const AValue: Integer);
      procedure SetNewBakCommsNum(const AValue: Integer);
      procedure SetNewBakComp(const AValue: Integer);
      procedure SetNewBakCompNum(const AValue: Integer);
      procedure SetNewBakFltAvionics(const AValue: Integer);
      procedure SetNewBakFltAvionicsNum(const AValue: Integer);
      procedure SetNewBakSensors(const AValue: Integer);
      procedure SetNewBakSensorsNum(const AValue: Integer);
      procedure SetNewComms(const AValue: Integer);
      procedure SetNewCommsType(const AValue: Integer);
      procedure SetNewComp(const AValue: Integer);
      procedure SetNewFlagComp(const AValue: Integer);
      procedure SetNewFltAvionics(const AValue: Integer);
      procedure SetNewSensors(const AValue: Integer);
      procedure SetRefitBakBridge(const AValue: Boolean);
      procedure SetRefitBakComms(const AValue: Boolean);
      procedure SetRefitBakComp(const AValue: Boolean);
      procedure SetRefitBakFltAvionics(const AValue: Boolean);
      procedure SetRefitBakSensors(const AValue: Boolean);
      procedure SetRefitBridge(const AValue: Boolean);
      procedure SetRefitComms(const AValue: Boolean);
      procedure SetRefitCommsType(const AValue: Boolean);
      procedure SetCommsTypeRefitTech(const AValue: Integer);
      procedure SetRefitComp(const AValue: Boolean);
      procedure SetRefitFlagBridge(const AValue: Boolean);
      procedure SetRefitFlagComp(const AValue: Boolean);
      procedure SetRefitFltAvionics(const AValue: Boolean);
      procedure SetRefitSensors(const AValue: Boolean);
      procedure SetSensorsRefitTech(const AValue: Integer);
   public
      function MainCompCost(Race: Integer; Data: TData): Extended;
      function MainCompSpace(Data: TData): Extended;
      function RefitCompCost(Race: Integer; Data: TData): Extended;
      function RefitCompSpace(Data: TData): Extended;
      function BakCompCost(Race: Integer; Data: TData): Extended;
      function BakCompSpace(Data: TData): Extended;
      function RefitBakCompCost(Race: Integer; Data: TData): Extended;
      function RefitBakCompSpace(Data: TData): Extended;
      function FlagCompCost(Race: Integer; Data: TData): Extended;
      function FlagCompSpace(Data: TData): Extended;
      function RefitFlagCompCost(Race: Integer; Data: TData): Extended;
      function RefitFlagCompSpace(Data: TData): Extended;
      function BridgeCost(Size: Extended; Race: Integer): Extended;
      function BridgeSpace(Size: Extended): Extended;
      function BakBridgeCost(Size: Extended; Race: Integer): Extended;
      function BakBridgeSpace(Size: Extended): Extended;
      function RefitBakBridgeCost(Size: Extended; Race: Integer): Extended;
      function RefitBakBridgeSpace(Size: Extended): Extended;
      function FlagBridgeCost(Size: Extended; Race: Integer): Extended;
      function FlagBridgeSpace(Size: Extended): Extended;
      function FltAvionicsCost(Race: Integer): Extended;
      function FltAvionicsSpace: Extended;
      function RefitFltAvionicsCost(Race: Integer): Extended;
      function RefitFltAvionicsSpace: Extended;
      function BakFltAvionicsCost(Race: Integer): Extended;
      function BakFltAvionicsSpace: Extended;
      function RefitBakFltAvionicsCost(Race: Integer): Extended;
      function RefitBakFltAvionicsSpace: Extended;
      function SensorsCost(Race: Integer): Extended;
      function SensorsSpace: Extended;
      function RefitSensorsCost(Race: Integer): Extended;
      function RefitSensorsSpace: Extended;
      function BakSensorsCost(Race: Integer): Extended;
      function BakSensorsSpace: Extended;
      function RefitBakSensorsCost(Race: Integer): Extended;
      function RefitBakSensorsSpace: Extended;
      function CommsCost(Race: Integer): Extended;
      function CommsSpace: Extended;
      function RefitCommsCost(Race: Integer): Extended;
      function RefitCommsSpace: Extended;
      function BakCommsCost(Race: Integer): Extended;
      function BakCommsSpace: Extended;
      function RefitBakCommsCost(Race: Integer): Extended;
      function RefitBakCommsSpace: Extended;
      function R20CompSpace: Extended;
      function R20BakCompSpace: Extended;
      function R20FlagCompSpace: Extended;
      procedure CalcCrew(Size: Extended; CrewType, JDrive: Integer);
      procedure CalcPower;
      property MainComp : Integer read fMainComp write fMainComp;
      property BakComp : Integer read fBakComp write fBakComp;
      property BakCompNum : Integer read fBakCompNum write fBakCompNum;
      property Bridge : Integer read fBridge write fBridge;
      property BakBridge : Integer read fBakBridge write fBakBridge;
      property BakBridgeNum : Integer read fBakBridgeNum write fBakBridgeNum;
      property FltAvionics : Integer read fFltAvionics write fFltAvionics;
      property BakFltAvionics : Integer read fBakFltAvionics write fBakFltAvionics;
      property BakFltAvionicsNum : Integer read fBakFltAvionicsNum write fBakFltAvionicsNum;
      property Sensors : Integer read fSensors write fSensors;
      property BakSensors : Integer read fBakSensors write fBakSensors;
      property BakSensorsNum : Integer read fBakSensorsNum write fBakSensorsNum;
      property Comms : Integer read fComms write fComms;
      property BakComms : Integer read fBakComms write fBakComms;
      property BakCommsNum : Integer read fBakCommsNum write fBakCommsNum;
      property CommsType : Integer read fCommsType write fCommsType;
      //refit values
      property FlagBridge: Boolean read FFlagBridge write SetFlagBridge;
      property FlagComp: Integer read FFlagComp write SetFlagComp;
      property RefitBridge: Boolean read FRefitBridge write SetRefitBridge;
      property RefitBakBridge: Boolean read FRefitBakBridge write SetRefitBakBridge;
      property RefitComp: Boolean read FRefitComp write SetRefitComp;
      property RefitBakComp: Boolean read FRefitBakComp write SetRefitBakComp;
      property RefitFlagComp: Boolean read FRefitFlagComp write SetRefitFlagComp;
      property RefitFltAvionics: Boolean read FRefitFltAvionics write SetRefitFltAvionics;
      property RefitBakFltAvionics: Boolean read FRefitBakFltAvionics write SetRefitBakFltAvionics;
      property RefitSensors: Boolean read FRefitSensors write SetRefitSensors;
      property RefitBakSensors: Boolean read FRefitBakSensors write SetRefitBakSensors;
      property RefitComms: Boolean read FRefitComms write SetRefitComms;
      property RefitBakComms: Boolean read FRefitBakComms write SetRefitBakComms;
      property CompRefitTech: Integer read FCompRefitTech write SetCompRefitTech;
      property BakCompRefitTech: Integer read FBakCompRefitTech write SetBakCompRefitTech;
      property FlagCompRefitTech: Integer read FFlagCompRefitTech write SetFlagCompRefitTech;
      property FltAvionicsRefitTech: Integer read FFltAvionicsRefitTech write SetFltAvionicsRefitTech;
      property BakFltAvionicsRefitTech: Integer read FBakFltAvionicsRefitTech write SetBakFltAvionicsRefitTech;
      property SensorsRefitTech: Integer read FSensorsRefitTech write SetSensorsRefitTech;
      property BakSensorsRefitTech: Integer read FBakSensorsRefitTech write SetBakSensorsRefitTech;
      property CommsRefitTech: Integer read FCommsRefitTech write SetCommsRefitTech;
      property BakCommsRefitTech: Integer read FBakCommsRefitTech write SetBakCommsRefitTech;
      property NewComp: Integer read FNewComp write SetNewComp;
      property NewBakComp: Integer read FNewBakComp write SetNewBakComp;
      property NewFlagComp: Integer read FNewFlagComp write SetNewFlagComp;
      property NewFltAvionics: Integer read FNewFltAvionics write SetNewFltAvionics;
      property NewBakFltAvionics: Integer read FNewBakFltAvionics write SetNewBakFltAvionics;
      property NewSensors: Integer read FNewSensors write SetNewSensors;
      property NewBakSensors: Integer read FNewBakSensors write SetNewBakSensors;
      property NewComms: Integer read FNewComms write SetNewComms;
      property NewBakComms: Integer read FNewBakComms write SetNewBakComms;
      property NewBakCompNum: Integer read FNewBakCompNum write SetNewBakCompNum;
      property NewBakBridgeNum: Integer read FNewBakBridgeNum write SetNewBakBridgeNum;
      property NewBakFltAvionicsNum: Integer read FNewBakFltAvionicsNum write SetNewBakFltAvionicsNum;
      property NewBakSensorsNum: Integer read FNewBakSensorsNum write SetNewBakSensorsNum;
      property NewBakCommsNum: Integer read FNewBakCommsNum write SetNewBakCommsNum;
      property NewCommsType: Integer read FNewCommsType write SetNewCommsType;
      property RefitCommsType: Boolean read FRefitCommsType write SetRefitCommsType;
      property CommsTypeRefitTech: Integer read FCommsTypeRefitTech write SetCommsTypeRefitTech;
      property RefitFlagBridge: Boolean read FRefitFlagBridge write SetRefitFlagBridge;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignAvionics(ShipData : String);
   end;

var
   Avionics : TAvionics;
   Data : TData;

implementation

{ TAvionics }

procedure TAvionics.AssignDefaults(ShipData: String);
//assign the defaults to the avionics

var
   Props : TStringList;
begin
   Props := TStringList.Create;
   try
      Props.CommaText := ShipData;
      Space := 0;
      Cost := 0;
      MainComp := StrToInt(Props[0]);
      BakComp := StrToInt(Props[1]);
      BakCompNum := StrToInt(Props[2]);
      Bridge := StrToInt(Props[3]);
      BakBridge := StrToInt(Props[4]);
      BakBridgeNum := StrToInt(Props[5]);
      FltAvionics := StrToInt(Props[6]);
      BakFltAvionics := StrToInt(Props[7]);
      BakFltAvionicsNum := StrToInt(Props[8]);
      Sensors := StrToInt(Props[9]);
      BakSensors := StrToInt(Props[10]);
      BakSensorsNum := StrToInt(Props[11]);
      Comms := StrToInt(Props[12]);
      BakComms := StrToInt(Props[13]);
      BakCommsNum := StrToInt(Props[14]);
      CommsType := StrToInt(Props[15]);
      FlagBridge := StrToBool(Props[16]);
      FlagComp := StrToInt(Props[17]);
      RefitBridge := StrToBool(Props[18]);
      RefitBakBridge := StrToBool(Props[19]);
      RefitComp := StrToBool(Props[20]);
      RefitBakComp := StrToBool(Props[21]);
      RefitFlagComp := StrToBool(Props[22]);
      RefitFltAvionics := StrToBool(Props[23]);
      RefitBakFltAvionics := StrToBool(Props[24]);
      RefitSensors := StrToBool(Props[25]);
      RefitBakSensors := StrToBool(Props[26]);
      RefitComms := StrToBool(Props[27]);
      RefitBakComms := StrToBool(Props[28]);
      CompRefitTech := StrToInt(Props[29]);
      BakCompRefitTech := StrToInt(Props[30]);
      FlagCompRefitTech := StrToInt(Props[31]);
      FltAvionicsRefitTech := StrToInt(Props[32]);
      BakFltAvionicsRefitTech := StrToInt(Props[33]);
      SensorsRefitTech := StrToInt(Props[34]);
      BakSensorsRefitTech := StrToInt(Props[35]);
      CommsRefitTech := StrToInt(Props[36]);
      BakCommsRefitTech := StrToInt(Props[37]);
      NewComp := StrToInt(Props[38]);
      NewBakComp := StrToInt(Props[39]);
      NewFlagComp := StrToInt(Props[40]);
      NewFltAvionics := StrToInt(Props[41]);
      NewBakFltAvionics := StrToInt(Props[42]);
      NewSensors := StrToInt(Props[43]);
      NewBakSensors := StrToInt(Props[44]);
      NewComms := StrToInt(Props[45]);
      NewBakComms := StrToInt(Props[46]);
      NewBakBridgeNum := StrToInt(Props[47]);
      NewBakCompNum := StrToInt(Props[48]);
      NewBakFltAvionicsNum := StrToInt(Props[49]);
      NewBakSensorsNum := StrToInt(Props[50]);
      NewBakCommsNum := StrToInt(Props[51]);
      NewCommsType := StrToInt(Props[52]);
      RefitCommsType := StrToBool(Props[53]);
      CommsTypeRefitTech := StrToInt(Props[54]);
      RefitFlagBridge := StrToBool(Props[55]);
   finally
      FreeAndNil(Props);
   end;
end;

function TAvionics.BakBridgeCost(Size: Extended; Race: Integer): Extended;
//calculate the cost of backup bridges

begin
  //small craft
  if (Size < 100) and (BakBridge = 0) then
  begin
    //if a hiver single race ship
    if (Race = 4) then
    begin
      Result := (Max(Size * 0.2 , 4) * 0.02) * BakBridgeNum;
    end
    else
    begin
      Result := (Max(Size * 0.2 , 4) * 0.025) * BakBridgeNum;
    end;
  end
  //a ship
  else if (Size >= 100) and (BakBridge = 0) then
  begin
    //if a hiver single race ship
    if (Race = 4) then
    begin
      Result := (Size * 0.004) * BakBridgeNum;
    end
    else
    begin
      Result := (Size * 0.005) * BakBridgeNum;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.BakBridgeSpace(Size: Extended): Extended;
//calculate the space required by backup bridges

begin
  //small craft
  if (Size < 100) and (BakBridge = 0) then
  begin
    Result := Max(Size * 0.2, 4) * BakBridgeNum;
  end
  //a ship
  else if (Size >= 100) and (BakBridge = 0) then
  begin
    Result := Max(Size * 0.02, 20) * BakBridgeNum;
  end
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.RefitBakBridgeCost(Size: Extended; Race: Integer): Extended;
begin
  //small craft
  if (Size < 100) and (BakBridge = 0) then
  begin
    //if a hiver single race ship
    if (Race = 4) then
    begin
      Result := (Max(Size * 0.2 , 4) * 0.02) * NewBakBridgeNum;
    end
    else
    begin
      Result := (Max(Size * 0.2 , 4) * 0.025) * NewBakBridgeNum;
    end;
  end
  //a ship
  else if (Size >= 100) and (BakBridge = 0) then
  begin
    //if a hiver single race ship
    if (Race = 4) then
    begin
      Result := (Size * 0.004) * NewBakBridgeNum;
    end
    else
    begin
      Result := (Size * 0.005) * NewBakBridgeNum;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.RefitBakBridgeSpace(Size: Extended): Extended;
begin
  //small craft
  if (Size < 100) and (BakBridge = 0) then
  begin
    Result := Max(Size * 0.2, 4) * NewBakBridgeNum;
  end
  //a ship
  else if (Size >= 100) and (BakBridge = 0) then
  begin
    Result := Max(Size * 0.02, 20) * NewBakBridgeNum;
  end
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.FlagBridgeCost(Size: Extended; Race: Integer): Extended;
begin
  //small craft
  if (Size < 100) and (FlagBridge) then
  begin
    //if a hiver single race ship
    if (Race = 4) then
    begin
      Result := (Min(Max(Size * 0.2 , 4), 40) * 0.02);
    end
    else
    begin
      Result := (Min(Max(Size * 0.2 , 4), 40) * 0.025);
    end;
  end
  //a ship
  else if (Size >= 100) and (FlagBridge) then
  begin
    //if a hiver single race ship
    if (Race = 4) then
    begin
      Result := Min((Size * 0.004), 40);
    end
    else
    begin
      Result := Min((Size * 0.005), 50);
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.FlagBridgeSpace(Size: Extended): Extended;
begin
  //small craft with a bridge
  if (Size < 100) and (FlagBridge) then
  begin
    Result := Min(Max(Size * 0.2, 4), 40);
  end
  //a ship
  else if (Size >= 100) and (FlagBridge) then
  begin
    Result := Min(Max(Size * 0.02, 20), 200);
  end
  //small craft without a bridge
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.BakCommsCost(Race: Integer): Extended;
//calculate the cost of the backup communications

begin
  if (CommsType = 2) then
  begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := (((BakComms * 0.5) * BakCommsNum) * 0.5) * 5;
    end
    else
    begin
      Result := ((BakComms * 0.5) * BakCommsNum) * 5;
    end;
  end
  else
  begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := ((BakComms * 0.5) * BakCommsNum) * 0.5;
    end
    else
    begin
      Result := (BakComms * 0.5) * BakCommsNum;
    end;
  end;
end;

function TAvionics.BakCommsSpace: Extended;
//calculate the space required by the backup communications

begin
  Result := (BakComms * 0.2) * BakCommsNum;
end;

function TAvionics.RefitBakCommsCost(Race: Integer): Extended;
begin
  if (CommsType = 2) then
  begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := (((NewBakComms * 0.5) * NewBakCommsNum) * 0.5) * 5;
    end
    else
    begin
      Result := ((NewBakComms * 0.5) * NewBakCommsNum) * 5;
    end;
  end
  else
  begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := ((NewBakComms * 0.5) * NewBakCommsNum) * 0.5;
    end
    else
    begin
      Result := (NewBakComms * 0.5) * NewBakCommsNum;
    end;
  end;
end;

function TAvionics.RefitBakCommsSpace: Extended;
begin
  Result := (NewBakComms * 0.2) * NewBakCommsNum;
end;

function TAvionics.BakCompCost(Race: Integer; Data: TData): Extended;
//calculate the cost of backup computers

begin
  //if hiver
  if (Race = 2) or (Race = 4) then
  begin
    Result := (StrToFloat(Data.GetComputerData(2, BakComp)) * 0.5) * BakCompNum;
  end
  else
  begin
    Result := (StrToFloat(Data.GetComputerData(2, BakComp)) * BakCompNum);
  end;
end;

function TAvionics.BakCompSpace(Data: TData): Extended;
//calculate the space required by backup computers

begin
  Result := StrToFloat(Data.GetComputerData(3, BakComp)) * BakCompNum;
end;

function TAvionics.RefitBakCompCost(Race: Integer; Data: TData): Extended;
begin
  //if hiver
  if (Race = 2) or (Race = 4) then
  begin
    Result := (StrToFloat(Data.GetComputerData(2, NewBakComp)) * 0.5) * NewBakCompNum;
  end
  else
  begin
    Result := (StrToFloat(Data.GetComputerData(2, NewBakComp)) * NewBakCompNum);
  end;
end;

function TAvionics.RefitBakCompSpace(Data: TData): Extended;
begin
  Result := StrToFloat(Data.GetComputerData(3, NewBakComp)) * NewBakCompNum;
end;

function TAvionics.FlagCompCost(Race: Integer; Data: TData): Extended;
begin
  //if hiver
  if (Race = 2) or (Race = 4) then
  begin
    Result := StrToFloat(Data.GetComputerData(2, FlagComp)) * 0.5;
  end
  else
  begin
    Result := StrToFloat(Data.GetComputerData(2, FlagComp));
  end;
end;

function TAvionics.FlagCompSpace(Data: TData): Extended;
begin
  Result := StrToFloat(Data.GetComputerData(3, FlagComp));
end;

function TAvionics.RefitFlagCompCost(Race: Integer; Data: TData): Extended;
begin
  //if hiver
  if (Race = 2) or (Race = 4) then
  begin
    Result := StrToFloat(Data.GetComputerData(2, NewFlagComp)) * 0.5;
  end
  else
  begin
    Result := StrToFloat(Data.GetComputerData(2, NewFlagComp));
  end;
end;

function TAvionics.RefitFlagCompSpace(Data: TData): Extended;
begin
  Result := StrToFloat(Data.GetComputerData(3, NewFlagComp));
end;

function TAvionics.BakFltAvionicsCost(Race: Integer): Extended;
//cost of the backup flight avionics

begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := ((BakFltAvionics * 0.9) * 0.5) * BakFltAvionicsNum;
  end
  else
  begin
    Result := (BakFltAvionics * 0.9) * BakFltAvionicsNum;
  end;
end;

function TAvionics.BakFltAvionicsSpace: Extended;
//space of the backup flight avionics

begin
  Result := (BakFltAvionics * 0.4) * BakFltAvionicsNum;
end;

function TAvionics.RefitBakFltAvionicsCost(Race: Integer): Extended;
begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := ((NewBakFltAvionics * 0.9) * 0.5) * NewBakFltAvionicsNum;
  end
  else
  begin
    Result := (NewBakFltAvionics * 0.9) * NewBakFltAvionicsNum;
  end;
end;

function TAvionics.RefitBakFltAvionicsSpace: Extended;
begin
  Result := (NewBakFltAvionics * 0.4) * NewBakFltAvionicsNum;
end;


function TAvionics.BakSensorsCost(Race: Integer): Extended;
//calculate the cost of the backup sensors

begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := ((BakSensors * 0.6) * BakSensorsNum) * 0.5;
  end
  else
  begin
    Result := (BakSensors * 0.6) * BakSensorsNum;
  end;
end;

function TAvionics.BakSensorsSpace: Extended;
//calculate the space required by the backup sensors

begin
  Result := (BakSensors * 0.3) * BakSensorsNum;
end;

function TAvionics.RefitBakSensorsCost(Race: Integer): Extended;
begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := ((NewBakSensors * 0.6) * NewBakSensorsNum) * 0.5;
  end
  else
  begin
    Result := (NewBakSensors * 0.6) * NewBakSensorsNum;
  end;
end;

function TAvionics.RefitBakSensorsSpace: Extended;
begin
  Result := (NewBakSensors * 0.3) * NewBakSensorsNum;
end;

function TAvionics.BridgeCost(Size: Extended; Race: Integer): Extended;
//calculate the cost of the bridge

begin
  //small craft with a bridge
  if (Size < 100) and (Bridge = 0) then
  begin
    //if hiver single race
    if (Race = 4) then
    begin
      Result := Max(Size * 0.2 , 4) * 0.02;
    end
    else
    begin
      Result := Max(Size * 0.2 , 4) * 0.025;
    end;
  end
  //a ship
  else if (Size >= 100) and (Bridge = 0) then
  begin
    //if hiver single race
    if (Race = 4) then
    begin
      Result := Size * 0.004;
    end
    else
    begin
      Result := Size * 0.005;
    end;
  end
  //small craft without a bridge
  else
  begin
    Result := 0;
  end;
end;

function TAvionics.BridgeSpace(Size: Extended): Extended;
//calculate the space required by the bridge

begin
  //small craft with a bridge
  if (Size < 100) and (Bridge = 0) then
  begin
    Result := Max(Size * 0.2, 4);
  end
  //a ship
  else if (Size >= 100) and (Bridge = 0) then
  begin
    Result := Max(Size * 0.02, 20);
  end
  //small craft without a bridge
  else
  begin
    Result := 0;
  end;
end;

procedure TAvionics.CalcCrew(Size: Extended; CrewType, JDrive: Integer);
//calculate the crew for this module (command crew)

begin
  CmdCrew := 0;
  Crew := 0;
  if (CrewType = 0) or (Size < 100) then
  begin
    if (Size <= 200) or (JDrive = 0) then
    begin
      Crew := 1;  //pilot
    end
    else
    begin
      Crew := 2;  //pilot and navigator
    end;
  end
  else
  begin
    CmdCrew := 1;
    Crew := Max(10, FloatToIntUp((Size/10000) * 5) - 1);
  end;
end;

procedure TAvionics.CalcPower;
//calulate the power required by the avionics

begin
  if (RefitComp) then
  begin
    Power := StrToFloat(Data.GetComputerData(6, NewComp));
    if (FlagComp > 0) then
    begin
      if (RefitFlagComp) then
      begin
        Power := Power + StrToFloat(Data.GetComputerData(6, NewFlagComp));
      end
      else
      begin
        Power := Power + StrToFloat(Data.GetComputerData(6, FlagComp));
      end;
    end;
  end
  else
  begin
    Power := StrToFloat(Data.GetComputerData(6, MainComp));
    if (FlagComp > 0) then
    begin
      if (RefitFlagComp) then
      begin
        Power := Power + StrToFloat(Data.GetComputerData(6, NewFlagComp));
      end
      else
      begin
        Power := Power + StrToFloat(Data.GetComputerData(6, FlagComp));
      end;
    end;
  end;
end;

function TAvionics.CommsCost(Race: Integer): Extended;
//calculate the cost of the communications

begin
  if (CommsType = 2) then
  begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := ((Comms * 0.5) * 0.5) * 5;
    end
    else
    begin
      Result := (Comms * 0.5) * 5;
    end;
  end
  else begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := (Comms * 0.5) * 0.5;
    end
    else
    begin
      Result := Comms * 0.5;
    end;
  end;
end;

function TAvionics.CommsSpace: Extended;
//calculate the space required by the communications

begin
  Result := Comms * 0.2;
end;

function TAvionics.RefitCommsCost(Race: Integer): Extended;
begin
  if (NewCommsType = 2) then
  begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := ((NewComms * 0.5) * 0.5) * 5;
    end
    else
    begin
      Result := (NewComms * 0.5) * 5;
    end;
  end
  else begin
    if (Race = 2) or (Race = 4) then
    begin
      Result := (NewComms * 0.5) * 0.5;
    end
    else
    begin
      Result := NewComms * 0.5;
    end;
  end;
end;

function TAvionics.RefitCommsSpace: Extended;
begin
  Result := NewComms * 0.2;
end;

function TAvionics.CompModel(Computer: Integer): Integer;
//Get the computer model number

begin
  case (Computer) of
    0 : Result := 0;
    1..3 : Result := 1;
    4..6 : Result := 2;
    7..8 : Result := 3;
    9..10 : Result := 4;
    11..12 : Result := 5;
    13..14 : Result := 6;
    15..16 : Result := 7;
    17..18 : Result := 8;
    19..20 : Result := 9;
    else Result := 10;
  end;
  (*
  //modified for full bis
  case (Computer) of
    0 : Result := 0;
    1..3 : Result := 1;
    4..6 : Result := 2;
    7..9 : Result := 3;
    10..12 : Result := 4;
    13..15 : Result := 5;
    16..18 : Result := 6;
    19..21 : Result := 7;
    22..24 : Result := 8;
    25..27 : Result := 9;
    else Result := 10;
  end;
  *)
end;

function TAvionics.CalcRefitCost(Size: Extended; Race, DesSys, FibMain, FibBak,
  FibFlag: Integer; Data: TData): Extended;
var
  PrimeCost, BakCost, BasePrimeCost, BaseBakCost,
  RefitPrimeCost, RefitBakCost,
  NewAviCost, NewBakAviCost,
  NewSensCost, NewBakSensCost,
  NewCommsCost, NewBakCommsCost: Extended;
begin
  if (DesSys = 0) then
  begin
    if (RefitFltAvionics) then NewAviCost := RefitFltAvionicsCost(Race)
        else NewAviCost := FltAvionicsCost(Race);
    if (RefitBakFltAvionics) then NewBakAviCost := RefitBakFltAvionicsCost(Race)
        else NewBakAviCost := BakFltAvionicsCost(Race);
    if (RefitSensors) then NewSensCost := RefitSensorsCost(Race)
        else NewSensCost := SensorsCost(Race);
    if (RefitBakSensors) then NewBakSensCost := RefitBakSensorsCost(Race)
        else NewBakSensCost := BakSensorsCost(Race);
    if (RefitComms) then NewCommsCost := RefitCommsCost(Race)
        else NewCommsCost := CommsCost(Race);
    if (RefitBakComms) then NewBakCommsCost := RefitBakCommsCost(Race)
        else NewBakCommsCost := BakCommsCost(Race);

    //work out cost of currently installed computer system
    PrimeCost := NewAviCost + NewSensCost + NewCommsCost;
    if (RefitComp) then
    begin
      PrimeCost := (PrimeCost * CompModel(NewComp)) * FibMain;
    end
    else
    begin
      PrimeCost := (PrimeCost * CompModel(MainComp)) * FibMain;
    end;
    //work out cost of design installed computer system
    BasePrimeCost := FltAvionicsCost(Race) + SensorsCost(Race) + CommsCost(Race);
    BasePrimeCost := (BasePrimeCost * CompModel(MainComp)) * FibMain;
    //refit cost = Absolute value(Current Cost - Designed Cost) * 1.1
    RefitPrimeCost := abs(PrimeCost - BasePrimeCost) * 1.1;

    //backups
    BakCost := NewBakAviCost + NewBakSensCost + NewBakCommsCost;
    if (RefitBakComp) then
    begin
      BakCost := (BakCost * CompModel(NewBakComp)) * FibBak;
    end
    else
    begin
      BakCost := (BakCost * CompModel(BakComp)) * FibBak;
    end;
    //work out cost of design installed computer system
    BaseBakCost := BakFltAvionicsCost(Race) + BakSensorsCost(Race) + BakCommsCost(Race);
    BaseBakCost := (BaseBakCost * CompModel(BakComp)) * FibBak;
    //refit cost = Absolute value(Current Cost - Designed Cost) * 1.1
    RefitBakCost := abs(BakCost - BaseBakCost) * 1.1;
    eTest := CalcRefitBridgeCost(Size, Race);
    Result := RefitPrimeCost + RefitBakCost + CalcRefitBridgeCost(Size, Race);
  end
  else
  begin
    Result := CalcRefitCompCost(Race, Data) + CalcRefitBridgeCost(Size, Race);
  end;
end;

function TAvionics.CalcRefitCompCost(Race: Integer; Data: TData): Extended;
begin
  Result := 0;
  if (RefitComp) then
  begin
    if (NewComp > 0) then
    begin
      Result := Result + (RefitCompCost(Race, Data) * 1.1);
    end
    else
    begin
      Result := Result + (MainCompCost(Race, Data) * 0.25);
    end;
  end;
  if (RefitBakComp) then
  begin
    if (NewBakComp > 0) then
    begin
      Result := Result + (RefitBakCompCost(Race, Data) * 1.1);
    end
    else
    begin
      Result := Result + (BakCompCost(Race, Data) * 0.25);
    end;
  end;
  if (RefitFlagComp) then
  begin
    if (NewFlagComp > 0) then
    begin
      Result := Result + (RefitFlagCompCost(Race, Data) * 1.1);
    end
    else
    begin
      Result := Result + (FlagCompCost(Race, Data) * 0.25);
    end;
  end;
end;

function TAvionics.CalcRefitFltAvionicsCost(Race: Integer): Extended;
begin
  Result := 0;
  if (RefitFltAvionics) then
  begin
    if (NewFltAvionics > 1) then
    begin
      Result := Result + (RefitFltAvionicsCost(Race) * 1.1);
    end
    else
    begin
      Result := Result + (FltAvionicsCost(Race) * 0.25);
    end;
  end
  else
  begin
    Result := FltAvionicsCost(Race);
  end;
end;

function TAvionics.CalcRefitBakFltAvionicsCost(Race: Integer): Extended;
begin
  if (RefitBakFltAvionics) then
  begin
    if (NewBakFltAvionics > 1) then
    begin
      Result := Result + (RefitBakFltAvionicsCost(Race) * 1.1);
    end
    else
    begin
      Result := Result + (BakFltAvionicsCost(Race) * 0.25);
    end;
  end
  else
  begin
    Result := BakFltAvionicsCost(Race);
  end;
end;

function TAvionics.CalcRefitSensorsCost(Race: Integer): Extended;
begin
  Result := 0;
  if (RefitSensors) then
  begin
    if (NewSensors > 1) then
    begin
      Result := Result + (RefitSensorsCost(Race) * 1.1);
    end
    else
    begin
      Result := Result + (SensorsCost(Race) * 0.25);
    end;
  end
  else
  begin
    Result := SensorsCost(Race);
  end;
end;

function TAvionics.CalcRefitBakSensorsCost(Race: Integer): Extended;
begin
  Result := 0;
  if (RefitBakSensors) then
  begin
    if (NewBakSensors > 1) then
    begin
      Result := Result + (RefitBakSensorsCost(Race) * 1.1);
    end
    else
    begin
      Result := Result + (BakSensorsCost(Race) * 0.25);
    end;
  end
  else
  begin
    Result := BakSensorsCost(Race);
  end;
end;

function TAvionics.CalcRefitCommsCost(Race: Integer): Extended;
begin
  Result := 0;
  if (RefitComms) then
  begin
    if (NewComms > 1) then
    begin
      Result := Result + (RefitCommsCost(Race) * 1.1);
    end
    else
    begin
      Result := Result + (CommsCost(Race) * 0.25);
    end;
  end
  else
  begin
    Result := CommsCost(Race);
  end;
end;

function TAvionics.CalcReftBakCommsCost(Race: Integer): Extended;
begin
  Result := 0;
  if (RefitBakComms) then
  begin
    if (NewBakComms > 1) then
    begin
      Result := Result + (RefitBakCommsCost(Race) * 1.1);
    end
    else
    begin
      Result := Result + (BakCommsCost(Race) * 0.25);
    end;
  end
  else
  begin
    Result := BakCommsCost(Race);
  end;
end;

function TAvionics.CalcR20Cost(Size: Extended; Race: Integer): Extended;
var
  PrimeCost, BakCost,
  FltAviCost, BakFltAviCost,
  SenCost, BakSenCost,
  CommoCost, BakCommoCost,  //NOTE use of Commo not Comms
  BakBridgeCosting: Extended;
  PrimeComputer, BakComputer, FibMain, FibBak: Integer;
begin
  //set the variables
  if (RefitFltAvionics) then FltAviCost := RefitFltAvionicsCost(Race)
      else FltAviCost := FltAvionicsCost(Race);
  if (RefitBakFltAvionics) then BakFltAviCost := RefitBakFltAvionicsCost(Race)
      else BakFltAviCost := BakFltAvionicsCost(Race);
  if (RefitSensors) then SenCost := RefitSensorsCost(Race)
      else SenCost := SensorsCost(Race);
  if (RefitBakSensors) then BakSenCost := RefitBakSensorsCost(Race)
      else BakSenCost := BakSensorsCost(Race);
  if (RefitComms) then CommoCost := RefitCommsCost(Race)
      else CommoCost := CommsCost(Race);
  if (RefitBakComms) then BakCommoCost := RefitBakCommsCost(Race)
      else BakCommoCost := BakCommsCost(Race);
  if (RefitComp) then PrimeComputer := NewComp else PrimeComputer := MainComp;
  if (RefitBakComp) then BakComputer := NewBakComp else BakComputer := BakComp;
  if (IsFib(PrimeComputer)) then FibMain := 2 else FibMain := 1;
  if (IsFib(BakComputer)) then FibBak := 2 else FibBak := 1;
  //BakBridgeCosting
  if (RefitBakBridge) then BakBridgeCosting := RefitBakBridgeCost(Size, Race)
      else BakBridgeCosting := BakBridgeCost(Size, Race);

  //costs
  PrimeCost := FltAviCost + SenCost + CommoCost;
  PrimeCost := (PrimeCost * CompModel(PrimeComputer)) * FibMain;
  BakCost := BakFltAviCost + BakSenCost + BakCommoCost;
  BakCost := (BakCost * CompModel(BakComputer)) * FibBak;

  Result := PrimeCost + BakCost + BridgeCost(Size, Race) + BakBridgeCosting + FlagBridgeCost(Size, Race);
end;

function TAvionics.CalcR20Space(Size: Extended; Race: Integer): Extended;
var
  PrimeSpace, BakSpace,
  FltAviSpace, BakFltAviSpace,
  SenSpace, BakSenSpace,
  CommsSpace, BakCommsSpace,
  BakBridgeRoom: Extended;
  PrimeComputer, BakComputer, FibMain, FibBak: Integer;
begin
  //set the variables
  if (RefitFltAvionics) then FltAviSpace := RefitFltAvionicsSpace
      else FltAviSpace := FltAvionicsSpace;
  if (RefitBakFltAvionics) then BakFltAviSpace := RefitBakFltAvionicsSpace
      else BakFltAviSpace := BakFltAvionicsSpace;
  if (RefitSensors) then SenSpace := RefitSensorsSpace
      else SenSpace := SensorsSpace;
  if (RefitBakSensors) then BakSenSpace := RefitBakSensorsSpace
      else BakSenSpace := BakSensorsSpace;
  if (RefitComms) then CommsSpace := RefitCommsSpace
      else CommsSpace := CommsSpace;
  if (RefitBakComms) then BakCommsSpace := RefitBakCommsSpace
      else BakCommsSpace := BakCommsSpace;
  if (RefitComp) then PrimeComputer := NewComp else PrimeComputer := MainComp;
  if (RefitBakComp) then BakComputer := NewBakComp else BakComputer := BakComp;
  if (IsFib(PrimeComputer)) then FibMain := 2 else FibMain := 1;
  if (IsFib(BakComputer)) then FibBak := 2 else FibBak := 1;
  if (RefitBakBridge) then BakBridgeRoom := RefitBakBridgeSpace(Size)
      else BakBridgeRoom := BakBridgeSpace(Size);

  //space
  PrimeSpace := (R20CompSpace + FltAviSpace + SenSpace + CommsSpace) * FibMain;
  BakSpace := (R20BakCompSpace + BakFltAviSpace + BakSenSpace + BakCommsSpace) * FibBak;
  Result := PrimeSpace + BakSpace + BridgeSpace(Size) + BakBridgeRoom + FlagBridgeSpace(Size);
end;

function TAvionics.CalcCost(Size: Extended; Race: Integer; Data: TData
  ): Extended;
begin
  Result := 0;
  if (RefitComp) then Result := Result + RefitCompCost(Race, Data)
      else Result := Result + MainCompCost(Race, Data);
  if (RefitBakComp) then Result := Result + RefitBakCompCost(Race, Data)
      else Result := Result + BakCompCost(Race, Data);
  if (RefitFlagComp) then Result := Result + RefitFlagCompCost(Race, Data)
      else Result := Result + FlagCompCost(Race, Data);
  if (RefitBridge) then Result := Result + BridgeCost(Size, Race)
      else Result := Result + BridgeCost(Size, Race);
  if (RefitBakBridge) then Result := Result + RefitBakBridgeCost(Size, Race)
      else Result := Result + BakBridgeCost(Size, Race);
  if (RefitFlagBridge) then Result := Result + FlagBridgeCost(Size, Race)
      else Result := Result + FlagBridgeCost(Size, Race);
end;

function TAvionics.CalcSpace(Size: Extended; Data: TData): Extended;
begin
  Result := 0;
  if (RefitComp) then Result := Result + RefitCompSpace(Data)
      else Result := Result + MainCompSpace(Data);
  if (RefitBakComp) then Result := Result + RefitBakCompSpace(Data)
      else Result := Result + BakCompSpace(Data);
  if (RefitFlagComp) then Result := Result + RefitFlagCompSpace(Data)
      else Result := Result + FlagCompSpace(Data);
  if (RefitBridge) then Result := Result + BridgeSpace(Size)
      else Result := Result + BridgeSpace(Size);
  if (RefitBakBridge) then Result := Result + RefitBakBridgeSpace(Size)
      else Result := Result + BakBridgeSpace(Size);
  if (RefitFlagBridge) then Result := Result + FlagBridgeSpace(Size)
      else Result := Result + FlagBridgeSpace(Size);
end;

function TAvionics.CalcRefitBridgeCost(Size: Extended; Race: Integer
  ): Extended;
begin
  Result := 0;
  if (RefitBridge) then
  begin
    if (BridgeCost(Size, Race) > 0) then
    begin
      Result := Result + (BridgeCost(Size, Race) * 1.1);
    end
    else
    begin
      Result := Result + (BridgeCost(Size, Race) * 0.25);
    end;
  end;
  if (RefitBakBridge) then
  begin
    if (RefitBakBridgeCost(Size, Race) > 0) then
    begin
      Result := Result + (RefitBakBridgeCost(Size, Race) * 1.1);
    end
    else
    begin
      Result := Result + (BakBridgeCost(Size, Race) * 0.25);
    end;
  end;
  if (RefitFlagBridge) then
  begin
    if (FlagBridgeCost(Size, Race) > 0) then
    begin
      Result := Result + (FlagBridgeCost(Size, Race) * 1.1);
    end
    else
    begin
      Result := Result + (FlagBridgeCost(Size, Race) * 0.25);
    end;
  end;
end;

procedure TAvionics.SetBakCommsRefitTech(const AValue: Integer);
begin
  if FBakCommsRefitTech=AValue then exit;
  FBakCommsRefitTech:=AValue;
end;

procedure TAvionics.SetBakCompRefitTech(const AValue: Integer);
begin
  if FBakCompRefitTech=AValue then exit;
  FBakCompRefitTech:=AValue;
end;

procedure TAvionics.SetBakFltAvionicsRefitTech(const AValue: Integer);
begin
  if FBakFltAvionicsRefitTech=AValue then exit;
  FBakFltAvionicsRefitTech:=AValue;
end;

procedure TAvionics.SetBakSensorsRefitTech(const AValue: Integer);
begin
  if FBakSensorsRefitTech=AValue then exit;
  FBakSensorsRefitTech:=AValue;
end;

procedure TAvionics.SetCommsRefitTech(const AValue: Integer);
begin
  if FCommsRefitTech=AValue then exit;
  FCommsRefitTech:=AValue;
end;

procedure TAvionics.SetCompRefitTech(const AValue: Integer);
begin
  if FCompRefitTech=AValue then exit;
  FCompRefitTech:=AValue;
end;

procedure TAvionics.SetFlagBridge(const AValue: Boolean);
begin
  if FFlagBridge=AValue then exit;
  FFlagBridge:=AValue;
end;

procedure TAvionics.SetFlagComp(const AValue: Integer);
begin
  if FFlagComp=AValue then exit;
  FFlagComp:=AValue;
end;

procedure TAvionics.SetFlagCompRefitTech(const AValue: Integer);
begin
  if FFlagCompRefitTech=AValue then exit;
  FFlagCompRefitTech:=AValue;
end;

procedure TAvionics.SetFltAvionicsRefitTech(const AValue: Integer);
begin
  if FFltAvionicsRefitTech=AValue then exit;
  FFltAvionicsRefitTech:=AValue;
end;

procedure TAvionics.SetNewBakBridgeNum(const AValue: Integer);
begin
  if FNewBakBridgeNum=AValue then exit;
  FNewBakBridgeNum:=AValue;
end;

procedure TAvionics.SetNewBakComms(const AValue: Integer);
begin
  if FNewBakComms=AValue then exit;
  FNewBakComms:=AValue;
end;

procedure TAvionics.SetNewBakCommsNum(const AValue: Integer);
begin
  if FNewBakCommsNum=AValue then exit;
  FNewBakCommsNum:=AValue;
end;

procedure TAvionics.SetNewBakComp(const AValue: Integer);
begin
  if FNewBakComp=AValue then exit;
  FNewBakComp:=AValue;
end;

procedure TAvionics.SetNewBakCompNum(const AValue: Integer);
begin
  if FNewBakCompNum=AValue then exit;
  FNewBakCompNum:=AValue;
end;

procedure TAvionics.SetNewBakFltAvionics(const AValue: Integer);
begin
  if FNewBakFltAvionics=AValue then exit;
  FNewBakFltAvionics:=AValue;
end;

procedure TAvionics.SetNewBakFltAvionicsNum(const AValue: Integer);
begin
  if FNewBakFltAvionicsNum=AValue then exit;
  FNewBakFltAvionicsNum:=AValue;
end;

procedure TAvionics.SetNewBakSensors(const AValue: Integer);
begin
  if FNewBakSensors=AValue then exit;
  FNewBakSensors:=AValue;
end;

procedure TAvionics.SetNewBakSensorsNum(const AValue: Integer);
begin
  if FNewBakSensorsNum=AValue then exit;
  FNewBakSensorsNum:=AValue;
end;

procedure TAvionics.SetNewComms(const AValue: Integer);
begin
  if FNewComms=AValue then exit;
  FNewComms:=AValue;
end;

procedure TAvionics.SetNewCommsType(const AValue: Integer);
begin
  if FNewCommsType=AValue then exit;
  FNewCommsType:=AValue;
end;

procedure TAvionics.SetNewComp(const AValue: Integer);
begin
  if FNewComp=AValue then exit;
  FNewComp:=AValue;
end;

procedure TAvionics.SetNewFlagComp(const AValue: Integer);
begin
  if FNewFlagComp=AValue then exit;
  FNewFlagComp:=AValue;
end;

procedure TAvionics.SetNewFltAvionics(const AValue: Integer);
begin
  if FNewFltAvionics=AValue then exit;
  FNewFltAvionics:=AValue;
end;

procedure TAvionics.SetNewSensors(const AValue: Integer);
begin
  if FNewSensors=AValue then exit;
  FNewSensors:=AValue;
end;

procedure TAvionics.SetRefitBakBridge(const AValue: Boolean);
begin
  if FRefitBakBridge=AValue then exit;
  FRefitBakBridge:=AValue;
end;

procedure TAvionics.SetRefitBakComms(const AValue: Boolean);
begin
  if FRefitBakComms=AValue then exit;
  FRefitBakComms:=AValue;
end;

procedure TAvionics.SetRefitBakComp(const AValue: Boolean);
begin
  if FRefitBakComp=AValue then exit;
  FRefitBakComp:=AValue;
end;

procedure TAvionics.SetRefitBakFltAvionics(const AValue: Boolean);
begin
  if FRefitBakFltAvionics=AValue then exit;
  FRefitBakFltAvionics:=AValue;
end;

procedure TAvionics.SetRefitBakSensors(const AValue: Boolean);
begin
  if FRefitBakSensors=AValue then exit;
  FRefitBakSensors:=AValue;
end;

procedure TAvionics.SetRefitBridge(const AValue: Boolean);
begin
  if FRefitBridge=AValue then exit;
  FRefitBridge:=AValue;
end;

procedure TAvionics.SetRefitComms(const AValue: Boolean);
begin
  if FRefitComms=AValue then exit;
  FRefitComms:=AValue;
end;

procedure TAvionics.SetRefitCommsType(const AValue: Boolean);
begin
  if FRefitCommsType=AValue then exit;
  FRefitCommsType:=AValue;
end;

procedure TAvionics.SetCommsTypeRefitTech(const AValue: Integer);
begin
  if FCommsTypeRefitTech=AValue then exit;
  FCommsTypeRefitTech:=AValue;
end;

procedure TAvionics.SetRefitComp(const AValue: Boolean);
begin
  if FRefitComp=AValue then exit;
  FRefitComp:=AValue;
end;

procedure TAvionics.SetRefitFlagBridge(const AValue: Boolean);
begin
  if FRefitFlagBridge=AValue then exit;
  FRefitFlagBridge:=AValue;
end;

procedure TAvionics.SetRefitFlagComp(const AValue: Boolean);
begin
  if FRefitFlagComp=AValue then exit;
  FRefitFlagComp:=AValue;
end;

procedure TAvionics.SetRefitFltAvionics(const AValue: Boolean);
begin
  if FRefitFltAvionics=AValue then exit;
  FRefitFltAvionics:=AValue;
end;

procedure TAvionics.SetRefitSensors(const AValue: Boolean);
begin
  if FRefitSensors=AValue then exit;
  FRefitSensors:=AValue;
end;

procedure TAvionics.SetSensorsRefitTech(const AValue: Integer);
begin
  if FSensorsRefitTech=AValue then exit;
  FSensorsRefitTech:=AValue;
end;

procedure TAvionics.DesignAvionics(ShipData: String);
//design the module

var
  ShipDetails: TStringList;
  Tonnage: Extended;
  PrimeCost, PrimeSpace, BakCost, BakSpace: Extended;
  Race, CrewType, DesignRules, JDrive: Integer;
  FibMain, FibBak, FibFlag: Integer;
begin
  ShipDetails := TStringList.Create;
  Data := TData.Create;
  try
    ShipDetails.CommaText := ShipData;
    Tonnage := StrToFloat(ShipDetails[1]);
    Race := StrToInt(ShipDetails[2]);
    CrewType := StrToInt(ShipDetails[3]);
    DesignRules := StrToInt(ShipDetails[7]);
    JDrive := StrToInt(ShipDetails[12]);
    Data.InitialiseData;
    RefitCost := 0;
    //T20 multipliers for fib computer space
    if (IsFib(MainComp)) then FibMain := 2 else FibMain := 1;
    if (IsFib(BakComp)) then FibBak := 2 else FibBak := 1;
    if (IsFib(FlagComp)) then FibFlag := 2 else FibFlag := 1;
    if (DesignRules = 0) then
    begin
      //T20 rules
      (*
      Cost := MainCompCost(Race) + BakCompCost(Race) + BridgeCost(Tonnage, Race)
          + BakBridgeCost(Tonnage, Race);
      Space := MainCompSpace + BakCompSpace + BridgeSpace(Tonnage)
          + BakBridgeSpace(Tonnage);
      *)
      (*
      PrimeCost := FltAvionicsCost(Race) + SensorsCost(Race) + CommsCost(Race);
      PrimeCost := (PrimeCost * CompModel(MainComp)) * FibMain;
      BakCost := BakFltAvionicsCost(Race) + BakSensorsCost(Race) + BakCommsCost(Race);
      BakCost := (BakCost * CompModel(BakComp)) * FibBak;
      PrimeSpace := (R20CompSpace + FltAvionicsSpace + SensorsSpace
          + CommsSpace) * FibMain;
      BakSpace := (R20BakCompSpace + BakFltAvionicsSpace + BakSensorsSpace
          + BakCommsSpace) * FibBak;
      Cost := PrimeCost + BakCost
          + BridgeCost(Tonnage, Race) + BakBridgeCost(Tonnage, Race);
      Space := PrimeSpace + BakSpace
          + BridgeSpace(Tonnage) + BakBridgeSpace(Tonnage);
      *)
      Cost := CalcR20Cost(Tonnage, Race);
      Space := CalcR20Space(Tonnage, Race);
      CalcCrew(Tonnage, CrewType, JDrive);
      CalcPower;
    end
    else
    begin
      (*
      Cost := MainCompCost(Race, Data) + BakCompCost(Race, Data) + BridgeCost(Tonnage, Race)
          + BakBridgeCost(Tonnage, Race);
      Space := MainCompSpace(Data) + BakCompSpace(Data) + BridgeSpace(Tonnage)
          + BakBridgeSpace(Tonnage);
      *)
      Cost := CalcCost(Tonnage, Race, Data);
      Space := CalcSpace(Tonnage, Data);
      CalcCrew(Tonnage, CrewType, JDrive);
      CalcPower;
    end;
    RefitCost := CalcRefitCost(Tonnage, Race, DesignRules, FibMain, FibBak, FibFlag, Data);
  finally
    FreeAndNil(ShipDetails);
    FreeAndNil(Data);
  end;
end;

function TAvionics.FltAvionicsCost(Race: Integer): Extended;
//cost of the flight avionics

begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := (FltAvionics * 0.9) * 0.5;
  end
  else
  begin
    Result := FltAvionics * 0.9;
  end;
end;

function TAvionics.FltAvionicsSpace: Extended;
//space required by flight avionics

begin
  Result := FltAvionics * 0.4;
end;

function TAvionics.RefitFltAvionicsCost(Race: Integer): Extended;
begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := (NewFltAvionics * 0.9) * 0.5;
  end
  else
  begin
    Result := NewFltAvionics * 0.9;
  end;
end;

function TAvionics.RefitFltAvionicsSpace: Extended;
begin
  Result := NewFltAvionics * 0.4;
end;

function TAvionics.IsFib(Computer: Integer): Boolean;
//does the computer use fibre optics

var
   FibComp : TComputerSet;
begin
   FibComp := [2, 5, 8, 10, 12, 14, 16, 18, 20];
   //for full bis models FibComp := [2, 5, 8, 11, 14, 17, 20, 23, 26];
   Result := False;
   if (Computer in FibComp) then begin
      Result := True;
   end;
end;

function TAvionics.MainCompCost(Race: Integer; Data: TData): Extended;
//calculate the cost of the main computer

begin
  //if hiver
  if (Race = 2) or (Race = 4) then
  begin
    Result := StrToFloat(Data.GetComputerData(2, MainComp)) * 0.5;
  end
  else
  begin
    Result := StrToFloat(Data.GetComputerData(2, MainComp));
  end;
end;

function TAvionics.MainCompSpace(Data: TData): Extended;
//calculate the space required by the main computer

begin
  Result := StrToFloat(Data.GetComputerData(3, MainComp));
end;

function TAvionics.RefitCompCost(Race: Integer; Data: TData): Extended;
begin
  //if hiver
  if (Race = 2) or (Race = 4) then
  begin
    Result := StrToFloat(Data.GetComputerData(2, NewComp)) * 0.5;
  end
  else
  begin
    Result := StrToFloat(Data.GetComputerData(2, NewComp));
  end;
end;

function TAvionics.RefitCompSpace(Data: TData): Extended;
begin
  Result := StrToFloat(Data.GetComputerData(3, NewComp));
end;

function TAvionics.R20BakCompSpace: Extended;
begin
  if (RefitBakComp) then
  begin
    Result := (CompModel(NewBakComp) * 0.1) * NewBakCompNum;
  end
  else
  begin
    Result := (CompModel(BakComp) * 0.1) * BakCompNum;
  end;
end;

function TAvionics.R20FlagCompSpace: Extended;
begin
  if (RefitFlagComp) then
  begin
    Result := CompModel(NewFlagComp) * 0.1;
  end
  else
  begin
    Result := CompModel(FlagComp) *0.1;
  end;
end;

function TAvionics.R20CompSpace: Extended;
begin
  if (RefitComp) then
  begin
    Result := CompModel(NewComp) * 0.1;
  end
  else
  begin
    Result := CompModel(MainComp) *0.1;
  end;
end;

function TAvionics.SensorsCost(Race: Integer): Extended;
//calculate the cost of the sensors

begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := (Sensors * 0.6) * 0.5;
  end
  else
  begin
    Result := Sensors * 0.6;
  end;
end;

function TAvionics.SensorsSpace: Extended;
//calculate the space required by the sensors

begin
  Result := Sensors * 0.3;
end;

function TAvionics.RefitSensorsCost(Race: Integer): Extended;
begin
  if (Race = 2) or (Race = 4) then
  begin
    Result := (NewSensors * 0.6) * 0.5;
  end
  else
  begin
    Result := NewSensors * 0.6;
  end;
end;

function TAvionics.RefitSensorsSpace: Extended;
begin
  Result := NewSensors * 0.3;
end;

end.
