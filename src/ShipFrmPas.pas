unit ShipFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ToolWin, ShipPas, DataPas, Math,
  AnalysisPas;

type

  { TShipFrm }

  TShipFrm = class(TForm)
    USPLbl: TLabel;
    CodeUSPLbl: TLabel;
    SizeLbl: TLabel;
    ConfigLbl: TLabel;
    JumpLbl: TLabel;
    ManLbl: TLabel;
    PowerLbl: TLabel;
    CompLbl: TLabel;
    CrewUSPLbl: TLabel;
    ArmourLbl: TLabel;
    SandLbl: TLabel;
    MesScrnLbl: TLabel;
    NucDampLbl: TLabel;
    BlkGlbLbl: TLabel;
    RepulsorLbl: TLabel;
    LaserLbl: TLabel;
    EnergyLbl: TLabel;
    PALbl: TLabel;
    MesGunLbl: TLabel;
    MissilesLbl: TLabel;
    BatLbl: TLabel;
    BatBearLbl: TLabel;
    SandBatLbl: TLabel;
    SandBatBearLbl: TLabel;
    RepulsorBatLbl: TLabel;
    RepulsorBatBearLbl: TLabel;
    LaserBatLbl: TLabel;
    LaserBatBearLbl: TLabel;
    EnergyBatLbl: TLabel;
    EnergyBatBearLbl: TLabel;
    PABatLbl: TLabel;
    PABatBearLbl: TLabel;
    MesGunBatLbl: TLabel;
    MesGunBatBearLbl: TLabel;
    MissileBatLbl: TLabel;
    MissileBatBearLbl: TLabel;
    FtrSqdLbl: TLabel;
    CostLbl: TLabel;
    TonnageLbl: TLabel;
    CrewLbl: TLabel;
    CrewNoLbl: TLabel;
    TLLbl: TLabel;
    TLUSPLbl: TLabel;
    ArchLbl: TLabel;
    ClassLbl: TLabel;
    TypeLbl: TLabel;
    ShipLbl: TLabel;
    ArchStatLbl: TLabel;
    ClassStatLbl: TLabel;
    TypeStatLbl: TLabel;
    ShipStatLbl: TLabel;
    CloseBtn: TButton;
    DetailsMemo: TMemo;
    //PrintDialog: TPrintDialog;
    StaticText1: TLabel;
    StaticText2: TLabel;
    StaticText3: TLabel;
    StaticText4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function FloatToIntDown(TheFloat: Extended): Integer;
    function FloatToIntUp(TheFloat: Extended): Integer;
    function IntToTrav(Value : Integer) : String;
    function UseHighValues(Value : Integer) : String;
    procedure GenerateDetails;

    function GetCargoDetails: String;
    function GetPassengerDetails(Data: TData): String;
  public
    { Public declarations }
  end;

var
  ShipFrm: TShipFrm;

  //CAUTION GLOBAL VARIABLES. BE VERY CAREFULL WITH THESE
  //these are the high value substitution variables
  //ONLY TO BE USED FOR IntToTrav AND IntToTravBat

  sVal, tVal, uVal, vVal, wVal, xVal, yVal, zVal : Integer; //GLOBAL VARIABBLES

  //these are the high value substitution variables
  //ONLY TO BE USED FOR IntToTrav AND IntToTravBat
  //CAUTION GLOBAL VARIABLES. BE VERY CAREFULL WITH THESE

implementation

{$R *.lfm}

procedure TShipFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
   Action := caFree;
end;

procedure TShipFrm.CloseBtnClick(Sender: TObject);
//close the form

begin
   Close;
end;

procedure TShipFrm.FormCreate(Sender: TObject);
//create the form and analysis the ship
//TOO BIG break up

var
  Data : TData;
  Analysis : TAnalysis;
  iTest : Integer;
  sMDrive, sJDrive, sPPlant: String;
begin
  if (Ship.Eng.MDriveIsRefitted) then sMDrive := IntToTrav(Ship.Eng.NewMDrive)
      else sMDrive := IntToTrav(Ship.Eng.MDrive);
  if (Ship.Eng.JDriveIsRefitted) then sJDrive := IntToTrav(Ship.Eng.NewJDrive)
      else sJDrive := IntToTrav(Ship.Eng.JDrive);
  if (Ship.Eng.PPlantIsRefitted) then sPPlant := IntToTrav(Ship.Eng.NewPPlant)
      else sPPlant := IntToTrav(Ship.Eng.PPlant);
  Data := TData.Create;
  Analysis := TAnalysis.Create;
  try
    sVal := 0;
    tVal := 0;
    uVal := 0;
    vVal := 0;
    wVal := 0;
    xVal := 0;
    yVal := 0;
    zVal := 0;
    Data.InitialiseData;
    Analysis.Analyise(-1);           //search here

    //general
    ShipLbl.Caption := Ship.ShipName;
    ClassLbl.Caption := Ship.ShipClass;
    ArchLbl.Caption := Ship.Architect;
    TypeLbl.Caption := Ship.ShipType;
    CodeUSPLbl.Caption := Ship.ShipCode;

    //hull
    SizeLbl.Caption := Analysis.SizeCode;
    ConfigLbl.Caption := IntToTrav(Ship.Hull.Config);

    //engineering
    JumpLbl.Caption := sJDrive;
    ManLbl.Caption := sMDrive;
    if (Ship.DesignRules = 0) then
    begin
      PowerLbl.Caption := IntToTrav(Trunc((Ship.Eng.Power / 2) / (Ship.Tonnage / 100)));
    end
    else
    begin
      PowerLbl.Caption := sPPlant;
    end;

    //avionics
    if (Ship.Avionics.RefitComp) then
    begin
      if (Ship.Tonnage < 100) and (Ship.Avionics.Bridge = 1) then
      begin
        if (Ship.Avionics.NewComp = 1) then
        begin
          CompLbl.Caption := '0';
        end
        else if (Ship.Avionics.NewComp > 2) and (Ship.Avionics.NewComp < 9) then
        begin
          CompLbl.Caption := Data.GetComputerData(1, (Ship.Avionics.NewComp - 3));
        end
        else
        begin
          CompLbl.Caption := Data.GetComputerData(1, (Ship.Avionics.NewComp - 2));
        end;
      end
      else
      begin
        CompLbl.Caption := Data.GetComputerData(1, Ship.Avionics.NewComp);
      end;
    end
    else
    begin
      if (Ship.Tonnage < 100) and (Ship.Avionics.Bridge = 1) then
      begin
        if (Ship.Avionics.MainComp = 1) then
        begin
          CompLbl.Caption := '0';
        end
        else if (Ship.Avionics.MainComp > 2) and (Ship.Avionics.MainComp < 9) then
        begin
          CompLbl.Caption := Data.GetComputerData(1, (Ship.Avionics.MainComp - 3));
        end
        else
        begin
          CompLbl.Caption := Data.GetComputerData(1, (Ship.Avionics.MainComp - 2));
        end;
      end
      else
      begin
        CompLbl.Caption := Data.GetComputerData(1, Ship.Avionics.MainComp);
      end;
    end;

    //crew
    iTest := Ship.CalcCrewCode;
    CrewUSPLbl.Caption := IntToTrav(Ship.CalcCrewCode);

    //defences
    if (Ship.Hull.Config < 8) then
    begin
      ArmourLbl.Caption := IntToTrav(Ship.Hull.Armour);
    end
    else if (Ship.Hull.Config = 8) then
    begin
      ArmourLbl.Caption := IntToTrav(Ship.Hull.Armour + 3);
    end
    else
    begin
      ArmourLbl.Caption := IntToTrav(Ship.Hull.Armour + 6);
    end;
    SandLbl.Caption := IntToStr(Ship.Turrets.SandFact(Ship.TechLevel));
    MesScrnLbl.Caption := IntToTrav(Ship.Screens.MesScrn);
    NucDampLbl.Caption := IntToTrav(Ship.Screens.NucDamp);
    BlkGlbLbl.Caption := IntToTrav(Ship.Screens.BlkGlb);
    RepulsorLbl.Caption := Analysis.RepulseFact;
    FtrSqdLbl.Caption := IntToTrav(Ship.Craft.FtrSqd);
    if (Ship.Turrets.SandFact(Ship.TechLevel) > 0) then
    begin
      SandBatLbl.Caption := IntToTrav(Ship.CalcSandBattery);
      SandBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.CalcSandBattery));
    end
    else
    begin
      SandBatLbl.Visible := False;
      SandBatBearLbl.Visible := False;
    end;
    if (StrToInt(Analysis.RepulseFact) > 0) then
    begin
      RepulsorBatLbl.Caption := IntToTrav(Analysis.RepulseBat);
      RepulsorBatBearLbl.Caption := IntToTrav(Analysis.RepulseBatBear);
    end
    else
    begin
      RepulsorBatLbl.Visible := False;
      RepulsorBatBearLbl.Visible := False;
    end;

    //offensive
    LaserLbl.Caption := IntToStr(Ship.Turrets.LaserFact(Ship.TechLevel));
    if (Ship.Turrets.LaserFact(Ship.TechLevel) > 0) then
    begin
      LaserBatLbl.Caption := IntToTrav(Ship.CalcLaserBattery);
      LaserBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.CalclaserBattery));
    end
    else
    begin
      LaserBatLbl.Visible := False;
      LaserBatBearLbl.Visible := False;
    end;   (*
    //energy batteries
    //check for bays
    if (Ship.LittleBays.EnergyBays > 0) and (not Ship.LittleBays.RefitEnergyBays) then
    begin
      EnergyLbl.Caption := IntToStr(Ship.LittleBays.EnergyFactor(Ship.TechLevel));
      EnergyBatLbl.Caption := IntToTrav(Ship.LittleBays.EnergyBays);
      EnergyBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.LittleBays.EnergyBays));
    end
    else
    if (Ship.LittleBays.NewEnergyBays > 0) and (Ship.LittleBays.RefitEnergyBays) then
    begin
      EnergyLbl.Caption := IntToStr(Ship.LittleBays.EnergyFactor(Ship.LittleBays.EnergyBaysRefitTech));
      EnergyBatLbl.Caption := IntToTrav(Ship.LittleBays.NewEnergyBays);
      EnergyBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.LittleBays.NewEnergyBays));
    end
    //check for turrets
    else if (Ship.Turrets.EnergyFact(Ship.TechLevel) > 0) then
    begin
      EnergyLbl.Caption := IntToStr(Ship.Turrets.EnergyFact(Ship.TechLevel));
      if (Ship.Turrets.MixedTurrets = 0) then
      begin
        EnergyBatLbl.Caption := IntToTrav(Ship.Turrets.MixBatteries(Ship.Turrets.MixTurretEnergy));
        EnergyBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.Turrets.MixBatteries(Ship.Turrets.MixTurretEnergy)));
      end
      else
      begin
        EnergyBatLbl.Caption := IntToTrav(Ship.Turrets.EnergyBatteries);
        EnergyBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.Turrets.EnergyBatteries));
      end;
    end
    //there are no energy weapons
    else
    begin
      EnergyLbl.Caption := '0';
      EnergyBatLbl.Visible := False;
      EnergyBatBearLbl.Visible := False;
    end; *)
    EnergyLbl.Caption := Analysis.EnergyFact;
    if (StrToInt(Analysis.EnergyFact) > 0) then
    begin
      EnergyBatLbl.Caption := IntToTrav(Analysis.EnergyBat);
      EnergyBatBearLbl.Caption := IntToTrav(Analysis.EnergyBatBear);
    end
    else
    begin
      EnergyBatLbl.Visible := False;
      EnergyBatBearLbl.Visible := False;
    end;
    PALbl.Caption := Analysis.PAFact;
    if (Analysis.PAFact <> '0') then
    begin
      PABatLbl.Caption := IntToTrav(Analysis.PABat);
      PABatBearLbl.Caption := IntToTrav(Analysis.PABatBear);
    end
    else
    begin
      PABatLbl.Visible := False;
      PABatBearLbl.Visible := False;
    end;
    MesGunLbl.Caption := Analysis.MesGunFact;
    if (Analysis.MesGunFact <> '0') then
    begin
      MesGunBatLbl.Caption := IntToTrav(Analysis.MesGunBat);
      MesGunBatBearLbl.Caption := IntToTrav(Analysis.MesGunBatBear);
    end
    else
    begin
      MesGunBatLbl.Visible := False;
      MesGunBatBearLbl.Visible := False;
    end;
    MissilesLbl.Caption := IntToStr(Ship.CalcMissileFactor);
    if (Ship.CalcMissileFactor > 0) then
    begin
      MissileBatLbl.Caption := IntToTrav(Ship.CalcMissileBattery);
      MissileBatBearLbl.Caption := IntToTrav(Ship.CalcBatteryBearing(Ship.CalcMissileBattery));
    end
    else
    begin
      MissileBatLbl.Visible := False;
      MissileBatBearLbl.Visible := False;
    end;

    //misc
    CostLbl.Caption := Analysis.ShipCost;
    TonnageLbl.Caption := Analysis.Disp;
    CrewNoLbl.Caption := IntToStr(Ship.GetTotalCmdCrew + Ship.GetTotalCrew);
    TLUSPLbl.Caption := IntToStr(Ship.TechLevel);
    GenerateDetails;
  finally
    FreeAndNil(Data);
    FreeAndNil(Analysis)
  end;
end;

function TShipFrm.FloatToIntDown(TheFloat: Extended): Integer;
//convert a float to int rounding down

begin
   Result := StrToInt(FloatToStr(Int(TheFloat)));
end;

function TShipFrm.FloatToIntUp(TheFloat: Extended): Integer;
//convert a float to an int rounding up

begin
   if ((TheFloat - Int(TheFloat)) <> 0) then begin
      Result := FloatToIntDown(TheFloat) + 1;
   end
   else begin
      Result := FloatToIntDown(TheFloat);
   end;
end;

function TShipFrm.IntToTrav(Value: Integer): String;
//convert an integer to a traveller value

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
      else Result := UseHighValues(Value);
   end;
end;

function TShipFrm.UseHighValues(Value: Integer): String;
//use this for values bigger than twenty five

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

procedure TShipFrm.GenerateDetails;
//generate the details for the ship
//THIS FUNCTION IS TOO BIG BREAK IT UP

var
   Details : TStringList;
   Data : TData;
   Gen, Fuel, Craft, Bak, Subs, ArchFee : String;
   FuelTons : Extended;
   sBakMDrive, sNumBakMDrive, sBakJDrive, sNumBakJDrive,
   sBakPPlant, sNumBakPPlant, sBakPowerTons, sNumBakPowerTons: String;
   ePowerTons: Extended;
   iPPlant, PowerTonsTech: Integer;
begin
  if (Ship.Eng.PPlantIsRefitted) then iPPlant := Ship.Eng.NewPPlant
      else iPPlant := Ship.Eng.PPlant;
  if (Ship.Eng.PowerTonsIsRefitted) then ePowerTons := Ship.Eng.NewPowerTons
      else ePowerTons := Ship.Eng.PowerTons;
  if (Ship.Eng.PowerTonsIsRefitted) then PowerTonsTech := Ship.Eng.PowerTonsRefitTech
      else PowerTonsTech := Ship.TechLevel;
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
  Details := TStringList.Create;
  Data := TData.Create;
  try
    Data.InitialiseData;
    Gen := '';
    Fuel := '';
    Craft := '';
    Bak := '';
    Subs := '';
    ArchFee := '';

    Gen := Gen + GetCargoDetails;
    Gen := Gen + GetPassengerDetails(Data);

    //fuel
    //FuelTons := (Ship.Tonnage * (((Ship.Fuel.PFuel / 28)  * Ship.Eng.PPlant) * 0.01))
    //    + (Ship.Tonnage * (Ship.Fuel.JFuel * 0.1)) + Ship.Fuel.ExtraFuel;
    FuelTons := Ship.Fuel.FuelSpace(Ship.Tonnage, ePowerTons, iPPlant,
        PowerTonsTech, Ship.ShipRace, Ship.DesignRules);
    if (FuelTons < 1) and (Ship.DesignRules = 1) then begin
      Gen := Gen + '   Fuel: 1.000';
    end
    else begin
      Gen := Gen + '   Fuel: ' + FloatToStrF(FuelTons, ffNumber, 18, 3);
    end;

    //power and agility
    Gen := Gen + '   EP: ' + FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3);
    Gen := Gen + '   Agility: ' + IntToStr(Ship.Agility);

    //troops and marines
    if (Ship.Accom.ShipsTroops > 0) then begin
      Gen := Gen + '   Shipboard Security Detail: ' + IntToStr(Ship.Accom.ShipsTroops);
    end;
    if (Ship.Accom.Marines > 0) then begin
      Gen := Gen + '   Marines: ' + IntToStr(Ship.Accom.Marines);
    end;
    if (Ship.Accom.DropCaps > 0) then begin
      Gen := Gen + '   Drop Capsules: ' + IntToStr(Ship.Accom.DropCaps);
      if (Ship.Accom.ReadyDropCaps > 0) or (Ship.Accom.StoredDropCaps > 0) then begin
        Gen := Gen + ' (plus';
        if (Ship.Accom.ReadyDropCaps > 0) then begin
          Gen := Gen + ' ' + IntToStr(Ship.Accom.ReadyDropCaps) + ' Ready';
        end;
        if (Ship.Accom.StoredDropCaps > 0) then begin
          Gen := Gen + ' ' + IntToStr(Ship.Accom.StoredDropCaps) + ' Stored';
        end;
        Gen := Gen + ')';
      end;
    end;

    //misc details
    if (Ship.Turrets.LaserTurrets > 0) or (Ship.Turrets.MixTurretLasers > 0) then begin
      if (Ship.Turrets.LaserType = 1) and (Ship.Turrets.MixedTurrets = 1) then begin
        Gen := Gen + ' Pulse Lasers';
      end
      //else if (Ship.Turrets.MixLaserType = 1) and (Ship.Turrets.MixedTurrets = 0) then begin
      else if (Ship.Turrets.LaserType = 1) and (Ship.Turrets.MixedTurrets = 0) then begin
        Gen := Gen + ' Pulse Lasers';
      end;
    end;
    Details.Add(Gen);

    //craft
    if (Ship.Craft.Cr1Num > 0) or (Ship.Craft.Cr2Num > 0) or (Ship.Craft.Cr3Num > 0) or
       (Ship.Craft.Cr4Num > 0) or (Ship.Craft.Cr5Num > 0) or (Ship.Craft.Cr6Num > 0) or
       (Ship.Craft.Cr7Num > 0) or (Ship.Craft.Cr8Num > 0) then
    begin
      Craft := Craft + 'Craft:';
      if (Ship.Craft.Cr1Num > 0) then begin
        Craft := Craft + ' ' + IntToStr(Ship.Craft.Cr1Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr1Tonnage)
            + 'T ' + Ship.Craft.Cr1Desc;
        if (Ship.Craft.Cr1Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr2Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr2Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr2Tonnage)
            + 'T ' + Ship.Craft.Cr2Desc;
        if (Ship.Craft.Cr2Num > 1) then begin
           Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr3Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr3Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr3Tonnage)
            + 'T ' + Ship.Craft.Cr3Desc;
        if (Ship.Craft.Cr3Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr4Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr4Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr4Tonnage)
            + 'T ' + Ship.Craft.Cr4Desc;
        if (Ship.Craft.Cr4Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr5Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr5Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr5Tonnage)
            + 'T ' + Ship.Craft.Cr5Desc;
        if (Ship.Craft.Cr5Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr6Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr6Num)
           + ' x ' + FloatToStr(Ship.Craft.Cr6Tonnage)
           + 'T ' + Ship.Craft.Cr6Desc;
        if (Ship.Craft.Cr6Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr7Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr7Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr7Tonnage)
            + 'T ' + Ship.Craft.Cr7Desc;
        if (Ship.Craft.Cr7Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.Cr8Num > 0) then begin
        Craft := Craft + ', ' + IntToStr(Ship.Craft.Cr8Num)
            + ' x ' + FloatToStr(Ship.Craft.Cr8Tonnage)
            + 'T ' + Ship.Craft.Cr8Desc;
        if (Ship.Craft.Cr8Num > 1) then begin
          Craft := Craft + 's';
        end;
      end;
      if (Ship.Craft.LF1Num > 0) then begin
         Craft := Craft + ', ' + IntToStr(Ship.Craft.LF1Num)
             + ' ' + FloatToStr(Ship.Craft.LF1Size) + 'T Launch Tube';
         if (Ship.Craft.LF1Num > 1) then begin
           Craft := Craft + 's';
         end;
       end;
      if (Ship.Craft.LF2Num > 0) then begin
         Craft := Craft + ', ' + IntToStr(Ship.Craft.LF2Num)
             + ' ' + FloatToStr(Ship.Craft.LF2Size) + 'T Launch Tube';
         if (Ship.Craft.LF2Num > 1) then begin
           Craft := Craft + 's';
         end;
       end;
       Details.Add(Craft);
    end;

      //fuel treatment
      if (Ship.Fuel.Scoops = 0) or (Ship.Fuel.Purif = 0) then begin
      Fuel := 'Fuel Treatment:';
         if (Ship.Fuel.Scoops = 0) then begin
            Fuel := Fuel + '   Fuel Scoops';
         end;
         if (Ship.Fuel.Scoops = 0) and (Ship.Fuel.Purif = 0) then begin
            Fuel := Fuel + ' and'
         end
         else begin
            Fuel := Fuel + '  ';
         end;
         if (Ship.Fuel.Purif = 0) then begin
            Fuel := Fuel + ' On Board Fuel Purification';
         end;
         Details.Add(Fuel);
      end;

      //backups
      if (StrToInt(sBakMDrive) > 0) or (StrToInt(sBakJDrive) > 0) or (StrToInt(sBakPPlant) > 0) or
            (Ship.Avionics.BakComp > 0) or (Ship.Avionics.BakBridge = 0) or (Ship.Screens.BakNucDamp > 0) or
            (Ship.Screens.BakMesScrn > 0) or (Ship.Screens.BakBlkGlb > 0) then begin
         Bak := 'Backups:';
         if (StrToInt(sBakMDrive) > 0) then begin
            Bak := Bak + ' ' + sNumBakMDrive + ' x ' + sBakMDrive + 'G Maneuver Drive';
            if (StrToInt(sNumBakMDrive) > 1) then Bak := Bak + 's';
         end;
         if (StrToInt(sBakJDrive) > 0) then begin
            Bak := Bak + ' ' + sNumBakJDrive + ' x Jump ' + sBakJDrive + ' Drive';
            if (StrToInt(sNumBakJDrive) > 1) then Bak := Bak + 's';
         end;
         if (StrToInt(sBakPPlant) > 0) then begin
            Bak := Bak + ' ' + sNumBakPPlant + ' x Factor ' + sBakPPlant + ' Power Plant';
            if (StrToInt(sNumBakPPlant) > 1) then Bak := Bak + 's';
         end;
         if (StrToFloat(sBakPowerTons) > 0) then begin
            Bak := Bak + ' ' + sNumBakPowerTons + ' x ' + sBakPowerTons + ' Ton Power Plant';
            if (StrToInt(sNumBakPowerTons) > 1) then Bak := Bak + 's';
         end;
         if (Ship.Avionics.BakComp > 0) then begin
            Bak := Bak + ' ' + IntToStr(Ship.Avionics.BakCompNum) + ' x ' + Copy(Data.GetComputerData(7, Ship.Avionics.BakComp), 3, Length(Data.GetComputerData(7, Ship.Avionics.BakComp))) + ' Computer';
            if (Ship.Avionics.BakCompNum > 1) then Bak := Bak + 's';
         end;
         if (Ship.Avionics.BakBridge = 0) then begin
            Bak := Bak + ' ' + IntToStr(Ship.Avionics.BakBridgeNum) + ' x Bridge';
            if (Ship.Avionics.BakBridgeNum > 1) then Bak := Bak + 's';
         end;
         if (Ship.Screens.BakNucDamp > 0) then begin
            Bak := Bak + ' ' + IntToStr(Ship.Screens.BakNucDampNum) + ' x Factor ' + IntToStr(Ship.Screens.BakNucDamp) + ' Nuclear Damper';
            if (Ship.Screens.BakNucDampNum > 1) then Bak := Bak + 's';
         end;
         if (Ship.Screens.BakMesScrn > 0) then begin
            Bak := Bak + ' ' + IntToStr(Ship.Screens.BakMesScrnNum) + ' x Factor ' + IntToStr(Ship.Screens.BakMesScrn) + ' Meson Screen';
            if (Ship.Screens.BakMesScrnNum > 1) then Bak := Bak + 's';
         end;
         if (Ship.Screens.BakBlkGlb > 0) then begin
            Bak := Bak + ' ' + IntToStr(Ship.Screens.BakBlkGlbNum) + ' x Factor ' + IntToStr(Ship.Screens.BakBlkGlb) + ' Black Globe';
            if (Ship.Screens.BakBlkGlbNum > 1) then Bak := Bak + 's';
         end;
         Details.Add(Bak);
      end;

      //substitutions
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
         Details.Add(Subs);
      end;
      Details.Add('');

      //costs
      ArchFee := 'Architects Fee: MCr ';
      ArchFee := ArchFee + FloatToStrF(((Ship.Price) * 0.01), ffNumber, 18, 3);
      ArchFee := ArchFee + '   Cost in Quantity: MCr ';
      ArchFee := ArchFee + FloatToStrF((Ship.Price * 0.8) + Ship.CraftCost, ffNumber, 18, 3);
      Details.Add(ArchFee);
      DetailsMemo.Lines := Details;
   finally
      FreeAndNil(Details);
      FreeAndNil(Data);
   end;
end;

function TShipFrm.GetCargoDetails: String;
begin
  Result := '';
  //cargo
  if (Ship.Accom.AutoCargoMark = 0) then
  begin
    Result := 'Cargo: ' + FloatToStrF(Ship.Accom.Cargo
                        + Ship.Eng.UpgradeSpaceAvailable, ffNumber, 18, 3);
  end
  else
  begin
    Result := 'Cargo: ' + FloatToStrF(Ship.GetRemTonnage
                        + Ship.Eng.UpgradeSpaceAvailable, ffNumber, 18, 3);
  end;
end;

function TShipFrm.GetPassengerDetails(Data: TData): String;
begin
  Result := '';
   //passengers and low berths
  if ((Ship.Accom.HighPass + Ship.Accom.MidPass) > 0) then
  begin
    Result := Result + '   Passengers: ' + IntToStr(Ship.Accom.HighPass + Ship.Accom.MidPass);
  end;
  //crew sections
  if  (Ship.AlternateCrewRules < 2) then
  begin
    Result := Result + ' Crew Sections: ' + IntToStr(Ship.CalcNumCrewSections)
        + ' of ' + IntToStr(Ship.CalcSizeCrewSections);
  end;
  if (Ship.Accom.FrozWatch > 0) then
  begin
    Result := Result + '   Frozen Watch';
    if (Ship.Accom.FrozWatch > 1) then
    begin
      Result := Result + ' (x ' + IntToStr(Ship.Accom.FrozWatch) + ')';
    end;
  end;
  if (Ship.Accom.LowPass > 0) then
  begin
    Result := Result + '   Low: ' + IntToStr(Ship.Accom.LowPass);
  end;
  if (Ship.Accom.EmLowBerth > 0) then
  begin
    Result := Result + '   Emergency Low: ' + IntToStr(Ship.Accom.EmLowBerth);
  end;
  //flag items
  if (Ship.FlagShip) then
  begin
    Result := Result + '  Fitted as flagship: Accomodation for Admiral and ten staff';
    if (Ship.Avionics.FlagBridge) and ((Ship.Avionics.NewFlagComp > 0) or (Ship.Avionics.FlagComp > 0)) then
    begin
      if (Ship.Avionics.RefitFlagComp) then
      begin
        Result := Result + ' with Flag Bridge and ' + Copy(Data.GetComputerData(7, Ship.Avionics.NewFlagComp), 3,
            Length(Data.GetComputerData(7, Ship.Avionics.NewFlagComp))) + ' Flag Computer';
      end
      else
      begin
        Result := Result + ' with Flag Bridge and ' + Copy(Data.GetComputerData(7, Ship.Avionics.FlagComp), 3,
            Length(Data.GetComputerData(7, Ship.Avionics.FlagComp))) + ' Flag Computer';
      end;
    end
    else if (Ship.Avionics.FlagBridge) and ((Ship.Avionics.NewFlagComp = 0) and (Ship.Avionics.FlagComp = 0)) then
    begin
      Result := Result + ' with Flag Bridge';
    end
    else if (not (Ship.Avionics.FlagBridge)) and ((Ship.Avionics.NewFlagComp > 0) or (Ship.Avionics.FlagComp > 0)) then
    begin
      if (Ship.Avionics.RefitFlagComp) then
      begin
        Result := Result + ' with ' + Copy(Data.GetComputerData(7, Ship.Avionics.NewFlagComp), 3,
            Length(Data.GetComputerData(7, Ship.Avionics.NewFlagComp))) + ' Flag Computer';
      end
      else
      begin
        Result := Result + ' with ' + Copy(Data.GetComputerData(7, Ship.Avionics.FlagComp), 3,
            Length(Data.GetComputerData(7, Ship.Avionics.FlagComp))) + ' Flag Computer';
      end;
    end;
  end;
end;

end.
