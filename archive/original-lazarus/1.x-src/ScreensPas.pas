unit ScreensPas;

{$MODE Delphi}

interface

uses
   SysUtils, Classes, ShipModulePas, DataPas;

type
   TScreens = class(TExtShipModule)
   private
      fNucDamp : Integer;
      fMesScrn : Integer;
      fBlkGlb : Integer;
      fBakNucDamp : Integer;
      fBakMesScrn : Integer;
      fBakBlkGlb : Integer;
      fBakNucDampNum : Integer;
      fBakMesScrnNum : Integer;
      fBakBlkGlbNum : Integer;
      fExtraCaps : Extended;
   public
      function NucDampSpace(Data : TData) : Extended;
      function NucDampCost(Data : TData) : Extended;
      function MesScrnSpace(Data : TData) : Extended;
      function MesScrnCost(Data : TData) : Extended;
      function BlkGlbSpace(Data : TData) : Extended;
      function BlkGlbCost(Data : TData) : Extended;
      function BakNucDampSpace(Data : TData) : Extended;
      function BakNucDampCost(Data : TData) : Extended;
      function BakMesScrnSpace(Data : TData) : Extended;
      function BakMesScrnCost(Data : TData) : Extended;
      function BakBlkGlbSpace(Data : TData) : Extended;
      function BakBlkGlbCost(Data : TData) : Extended;
      function ExtraCapsSpace : Extended;
      function ExtraCapsCost : Extended;
      procedure CalcCrew(Size: Extended; Rules: Integer);
      procedure CalcPower(Size : Extended);
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignScreens(ShipData : String);
      property NucDamp : Integer read fNucDamp write fNucDamp;
      property MesScrn : Integer read fMesScrn write fMesScrn;
      property BlkGlb : Integer read fBlkGlb write fBlkGlb;
      property BakNucDamp : Integer read fBakNucDamp write fBakNucDamp;
      property BakMesScrn : Integer read fBakMesScrn write fBakMesScrn;
      property BakBlkGlb : Integer read fBakBlkGlb write fBakBlkGlb;
      property BakNucDampNum : Integer read fBakNucDampNum write fBakNucDampNum;
      property BakMesScrnNum : Integer read fBakMesScrnNum write fBakMesScrnNum;
      property BakBlkGlbNum : Integer read fBakBlkGlbNum write fBakBlkGlbNum;
      property ExtraCaps : Extended read fExtraCaps write fExtraCaps;
   end;

var
   Screens : TScreens;
   Data : TData;

implementation

{ TScreens }

procedure TScreens.AssignDefaults(ShipData: String);
//assign default values

var
   Props : TStringList;
begin
   Props := TStringList.Create;
   try
      Props.CommaText := ShipData;
      Space := 0;
      Cost := 0;
      NucDamp := StrToInt(Props[0]);
      MesScrn := StrToInt(Props[1]);
      BlkGlb := StrToInt(Props[2]);
      BakNucDamp := StrToInt(Props[3]);
      BakMesScrn := StrToInt(Props[4]);
      BAkBlkGlb := StrToInt(Props[5]);
      BakNucDampNum := StrToInt(Props[6]);
      BakMesScrnNum := StrToInt(Props[7]);
      BakBlkGlbNum := StrToInt(Props[8]);
      ExtraCaps := StrToFloat(Props[9]);
   finally
      FreeAndNil(Props);
   end;
end;

function TScreens.BakBlkGlbCost(Data: TData): Extended;
//calculate the cost of backup black globes

begin
   Result := StrToFloat(Data.GetBlkGlbData(4, BakBlkGlb)) * BakBlkGlbNum;
end;

function TScreens.BakBlkGlbSpace(Data: TData): Extended;
//calculate the size of backup black globes

begin
   Result := StrToFloat(Data.GetBlkGlbData(3, BakBlkGlb)) * BakBlkGlbNum;
end;

function TScreens.BakMesScrnCost(Data: TData): Extended;
//calculate the cost of backup meson screens

begin
   Result := StrToFloat(Data.GetMesScrnData(4, BakMesScrn)) * BakMesScrnNum;
end;

function TScreens.BakMesScrnSpace(Data: TData): Extended;
//calculate the size of backup meson screens

begin
   Result := StrToFloat(Data.GetMesScrnData(3, BakMesScrn)) * BakMesScrnNum;
end;

function TScreens.BakNucDampCost(Data: TData): Extended;
//calculate the cost of backup nuclear dampers

begin
   Result := StrToFloat(Data.GetNucDampData(4, BakNucDamp)) * BakNucDampNum;
end;

function TScreens.BakNucDampSpace(Data: TData): Extended;
//calculate the size of backup nuclear dampers

begin
   Result := StrToFloat(Data.GetNucDampData(3, BakNucDamp)) * BakNucDampNum;
end;

function TScreens.BlkGlbCost(Data: TData): Extended;
//calculate the cost of the black globe

begin
   Result := StrToFloat(Data.GetBlkGlbData(4, BlkGlb));
end;

function TScreens.BlkGlbSpace(Data: TData): Extended;
//calculate the size of the black globe

begin
   Result := StrToFloat(Data.GetBlkGlbData(3, BlkGlb));
end;

procedure TScreens.CalcCrew(Size: Extended; Rules: Integer);
//calculate the crew required

begin
  CmdCrew := 0;
  Crew := 0;
  if (Rules = 0) or (Size < 100) then
  begin
    if (NucDamp > 0) then Crew := Crew + 4;
    if (MesScrn > 0) then Crew := Crew + 4;
    if (BlkGlb > 0) then Crew := Crew + 4;
  end
  else
  begin
    if (NucDamp > 0) or (MesScrn > 0) or (BlkGlb > 0) then
    begin
      CmdCrew := 1;
    end;
    if (NucDamp > 0) then Crew := Crew + 4;
    if (MesScrn > 0) then Crew := Crew + 4;
    if (BlkGlb > 0) then Crew := Crew + 4;
  end;
end;

procedure TScreens.CalcPower(Size: Extended);
//calculate the power uses

begin
   Power := StrToFloat(Data.GetNucDampData(5, NucDamp)) + (StrToFloat(Data.GetMesScrnData(5, MesScrn)) * (Size/100));
end;

procedure TScreens.DesignScreens(ShipData: String);
//design the module

var
  ShipDetails: TStringList;
  Tonnage: Extended;
  DesignRules: Integer;
begin
  Data := TData.Create;
  ShipDetails := TStringList.Create;
  try
    Data.InitialiseData;
    ShipDetails.CommaText := ShipData;
    Tonnage := StrToFloat(ShipDetails[1]);
    DesignRules := StrToInt(ShipDetails[7]);
    Power := 0;
    Cost := NucDampCost(Data) + MesScrnCost(Data) + BlkGlbCost(Data)
        + BakNucDampCost(Data) + BakMesScrnCost(Data) + BakBlkGlbCost(Data)
        + ExtraCapsCost;
    Space := NucDampSpace(Data) + MesScrnSpace(Data) + BlkGlbSpace(Data)
        + BakNucDampSpace(Data) + BakMesScrnSpace(Data) + BakBlkGlbSpace(Data)
        + ExtraCapsSpace;
    CalcCrew(Tonnage, DesignRules);
    CalcPower(Tonnage);
  finally
    FreeAndNil(Data);
    FreeAndNil(ShipDetails);
  end;
end;

function TScreens.ExtraCapsCost: Extended;
//calculate the cost of extra capacitors

begin
   Result := ExtraCaps * 4;
end;

function TScreens.ExtraCapsSpace: Extended;
//calculate the size of extra capacitors

begin
   Result := ExtraCaps;
end;

function TScreens.MesScrnCost(Data: TData): Extended;
//calculate the cost of the meson screen

begin
   Result := StrToFloat(Data.GetMesScrnData(4, MesScrn));
end;

function TScreens.MesScrnSpace(Data: TData): Extended;
//calculate the size of the meson screen

begin
   Result := StrToFloat(Data.GetMesScrnData(3, MesScrn));
end;

function TScreens.NucDampCost(Data: TData): Extended;
//calculate the cost of the nuclear damper

begin
   Result := StrToFloat(Data.GetNucDampData(4, NucDamp));
end;

function TScreens.NucDampSpace(Data: TData): Extended;
//calculate the size of the nuclear damper

begin
   Result := StrToFloat(Data.GetNucDampData(3, NucDamp));
end;

end.
