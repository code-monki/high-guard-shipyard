unit SpinalMountPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas, DataPas;

type

   { TSpinalMount }

   TSpinalMount = class(TWpnShipModule)
   private
     FNewSpinalMount: Integer;
     FNewSpinalType: Integer;
     FRefitSpinalMount: Boolean;
     FSpinalMountRefitTech: Integer;
      fSpinalType : Integer;
      fSpinalmount : Integer;
      FUpgradeSpace: Extended;
      procedure CalcHardPoints(Race: Integer; Data: TData);
      function CalcRefitCost(Race: Integer; Data: TData): Extended;
      procedure SetNewSpinalMount(const AValue: Integer);
      procedure SetNewSpinalType(const AValue: Integer);
      procedure SetRefitSpinalMount(const AValue: Boolean);
      procedure SetSpinalMountRefitTech(const AValue: Integer);
      procedure SetUpgradeSpace(const AValue: Extended);
   public
      function SpinalMountCost(Race: Integer; Data: TData): Extended;
      function SpinalMountSpace(Race: Integer; Data: TData): Extended;
      function RefitSpinalMountCost(Race: Integer; Data: TData): Extended;
      function RefitSpinalMountSpace(Race: Integer; Data: TData): Extended;
      function SpinalMesonFactor: String;
      function SpinalPAFactor: String;
      procedure CalcCrew(Race: Integer; Data: TData);
      procedure CalcPower(Data: TData);
      property SpinalType : Integer read fSpinalType write fSpinalType;
      property SpinalMount : Integer read fSpinalMount write fSpinalMount;
      property UpgradeSpace: Extended read FUpgradeSpace write SetUpgradeSpace;
      property RefitSpinalMount: Boolean read FRefitSpinalMount write SetRefitSpinalMount;
      property SpinalMountRefitTech: Integer read FSpinalMountRefitTech write SetSpinalMountRefitTech;
      property NewSpinalType: Integer read FNewSpinalType write SetNewSpinalType;
      property NewSpinalMount: Integer read FNewSpinalMount write SetNewSpinalMount;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignSpinalMount(ShipData : String);
   end;

var
   SpinalMount : TSpinalMount;
   //Data : TData;

implementation

{ TSpinalMount }

procedure TSpinalMount.AssignDefaults(ShipData: String);
//assign default values

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
      SpinalType := StrToInt(Props[0]);
      SpinalMount := StrToInt(Props[1]);
      UpgradeSpace := StrToFloat(Props[2]);
      RefitSpinalMount := StrToBool(Props[3]);
      SpinalMountRefitTech := StrToInt(Props[4]);
      NewSpinalType := StrToInt(Props[5]);
      NewSpinalMount := StrToInt(Props[6]);
      HardPoints := 0;
   finally
      FreeAndNil(Props);
   end;
end;

procedure TSpinalMount.CalcCrew(Race: Integer; Data: TData);
//calculate crew

//var
  //Data : TData;
begin
  try
    //Data := TData.Create;
    //Data.InitialiseData;
    CmdCrew := 0;
    Crew := 0;
    if ((SpinalType > 0) and (SpinalMount > 0)) or ((NewSpinalType > 0) and (NewSpinalMount > 0)) then
    begin
      CmdCrew := 1;
      if (Race = 1) then
      begin
        if (RefitSpinalMount) then
        begin
          Crew := FloatToIntUp(RefitSpinalMountSpace(Race, Data) / 200);
        end
        else
        begin
          Crew := FloatToIntUp(SpinalMountSpace(Race, Data) / 200);
        end;
      end
      else
      begin
        if (RefitSpinalMount) then
        begin
          Crew := FloatToIntUp(RefitSpinalMountSpace(Race, Data) / 100);
        end
        else
        begin
          Crew := FloatToIntUp(SpinalMountSpace(Race, Data) / 100);
        end;
      end;
    end
    else
    begin
      CmdCrew := 0;
      Crew := 0;
    end;
  finally
    //FreeAndNil(Data);
  end;
end;

procedure TSpinalMount.CalcHardPoints(Race: Integer; Data: TData);
//calculate the hardpoints required

//var
  //Data : TData;
begin
  try
    //Data := TData.Create;
    //Data.InitialiseData;
    if (RefitSpinalMount) then
    begin
      HardPoints := FloatToIntUp(RefitSpinalMountSpace(Race, Data) / 100);
    end
    else
    begin
      HardPoints := FloatToIntUp(SpinalMountSpace(Race, Data) / 100);
    end;
  finally
    //FreeAndNil(Data);
  end;
end;

function TSpinalMount.CalcRefitCost(Race: Integer; Data: TData): Extended;
begin
  if (RefitSpinalMount) then
  begin
    if ((NewSpinalType = 0) or (NewSpinalMount = 0)) and ((SpinalType > 0) or (SpinalMount > 0)) then
    begin
      Result := SpinalMountCost(Race, Data) * 0.25;
    end
    else
    begin
      Result := RefitSpinalMountCost(Race, Data) * 1.1;
    end;
  end
  else
  begin
    Result := 0;
  end;
end;

procedure TSpinalMount.SetNewSpinalMount(const AValue: Integer);
begin
  if FNewSpinalMount=AValue then exit;
  FNewSpinalMount:=AValue;
end;

procedure TSpinalMount.SetNewSpinalType(const AValue: Integer);
begin
  if FNewSpinalType=AValue then exit;
  FNewSpinalType:=AValue;
end;

procedure TSpinalMount.SetRefitSpinalMount(const AValue: Boolean);
begin
  if FRefitSpinalMount=AValue then exit;
  FRefitSpinalMount:=AValue;
end;

procedure TSpinalMount.SetSpinalMountRefitTech(const AValue: Integer);
begin
  if FSpinalMountRefitTech=AValue then exit;
  FSpinalMountRefitTech:=AValue;
end;

procedure TSpinalMount.SetUpgradeSpace(const AValue: Extended);
begin
  if FUpgradeSpace=AValue then exit;
  FUpgradeSpace:=AValue;
end;

function TSpinalMount.SpinalPAFactor: String;
var
  Data: TData;
begin
  try
    Data := TData.Create;
    Data.InitialiseData;
    if (RefitSpinalMount) then
    begin
      case NewSpinalType of
        0: Result := '0';
        1: Result := '0';
        2: Result := Data.GetSpnlPAData(1, NewSpinalMount)[1];
        else Result := 'Error you should not see this';
      end;
    end
    else
    begin
      case SpinalType of
        0: Result := '0';
        1: Result := '0';
        2: Result := Data.GetSpnlPAData(1, SpinalMount)[1];
        else Result := 'Error you should not see this';
      end;
    end;
  finally
    FreeAndNil(Data);
  end;
end;

procedure TSpinalMount.CalcPower(Data: TData);
begin
  if (RefitSpinalMount) then
  begin
    Case (NewSpinalType) of
      0: Power := 0;
      1: Power := StrToFloat(Data.GetSpnlMesData(5, NewSpinalMount));
      2: Power := StrToFloat(Data.GetSpnlPAData(5, NewSpinalMount));
    end;
  end
  else
  begin
    Case (SpinalType) of
      0: Power := 0;
      1: Power := StrToFloat(Data.GetSpnlMesData(5, SpinalMount));
      2: Power := StrToFloat(Data.GetSpnlPAData(5, SpinalMount));
    end;
  end;
end;

procedure TSpinalMount.DesignSpinalMount(ShipData: String);
//calculate the power required

var
   ShipDetails : TStringList;
   ShipRace : Integer;
   Data: TData;
begin
   ShipDetails := TStringList.Create;
   Data := TData.Create;
   try
      ShipDetails.CommaText := ShipData;
      Power := 0;
      ShipRace := StrToInt(ShipDetails[2]);
      Data.InitialiseData;
      if (RefitSpinalMount) then
      begin
        Cost := RefitSpinalMountCost(ShipRace, Data);
      end
      else
      begin
        Cost := SpinalMountCost(ShipRace, Data);
      end;
      if (RefitSpinalMount) then
      begin
        Space := RefitSpinalMountSpace(ShipRace, Data);
      end
      else
      begin
        Space := SpinalMountSpace(ShipRace, Data);
      end;
      RefitCost := CalcRefitCost(ShipRace, Data);
      CalcHardPoints(ShipRace, Data);
      CalcCrew(ShipRace, Data);
      CalcPower(Data);
   finally
      FreeAndNil(ShipDetails);
      FreeAndNil(Data);
   end;
end;

function TSpinalMount.SpinalMountCost(Race: Integer; Data: TData): Extended;
//calculate the cost

begin
  if (Race = 1) then
  begin
    Case (SpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(4, SpinalMount)) * 2;
      2: Result := StrToFloat(Data.GetSpnlPAData(4, SpinalMount)) * 2;
    end;
  end
  else
  begin
    Case (SpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(4, SpinalMount));
      2: Result := StrToFloat(Data.GetSpnlPAData(4, SpinalMount));
    end;
  end;
end;

function TSpinalMount.SpinalMountSpace(Race: Integer; Data: TData): Extended;
//calculate the space required

begin
  if (Race = 1) then
  begin
    Case (SpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(2, SpinalMount)) * 2;
      2: Result := StrToFloat(Data.GetSpnlPAData(2, SpinalMount)) * 2;
    end;
  end
  else
  begin
    Case (SpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(2, SpinalMount));
      2: Result := StrToFloat(Data.GetSpnlPAData(2, SpinalMount));
    end;
  end;
end;

function TSpinalMount.RefitSpinalMountCost(Race: Integer; Data: TData
  ): Extended;
begin
  if (Race = 1) then
  begin
    Case (NewSpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(4, NewSpinalMount)) * 2;
      2: Result := StrToFloat(Data.GetSpnlPAData(4, NewSpinalMount)) * 2;
    end;
  end
  else
  begin
    Case (NewSpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(4, NewSpinalMount));
      2: Result := StrToFloat(Data.GetSpnlPAData(4, NewSpinalMount));
    end;
  end;
end;

function TSpinalMount.RefitSpinalMountSpace(Race: Integer; Data: TData
  ): Extended;
begin
  if (Race = 1) then
  begin
    Case (NewSpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(2, NewSpinalMount)) * 2;
      2: Result := StrToFloat(Data.GetSpnlPAData(2, NewSpinalMount)) * 2;
    end;
  end
  else
  begin
    Case (NewSpinalType) of
      0: Result := 0;
      1: Result := StrToFloat(Data.GetSpnlMesData(2, NewSpinalMount));
      2: Result := StrToFloat(Data.GetSpnlPAData(2, NewSpinalMount));
    end;
  end;
end;

function TSpinalMount.SpinalMesonFactor: String;
var
  Data: TData;
begin
  try
    Data := TData.Create;
    Data.InitialiseData;
    if (RefitSpinalMount) then
    begin
      case NewSpinalType of
        0: Result := '0';
        1: Result := Data.GetSpnlMesData(1, NewSpinalMount)[1];
        2: Result := '0';
        else Result := 'Error you should not see this';
      end;
    end
    else
    begin
      case SpinalType of
        0: Result := '0';
        1: Result := Data.GetSpnlMesData(1, SpinalMount)[1];
        2: Result := '0';
        else Result := 'Error you should not see this';
      end;
    end;
  finally
    FreeAndNil(Data);
  end;
end;

end.
