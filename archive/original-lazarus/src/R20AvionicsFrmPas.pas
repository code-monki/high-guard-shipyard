unit R20AvionicsFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShipPas, DataPas, Math, DesAssistFrmPas,
  HgsFormFrm;

type
  TComputerSet = set of 0..20;

  { TR20AvionicsFrm }

  TR20AvionicsFrm = class(THgsForm)
    RefitBakFltAviEdit: TEdit;
    RefitBakSensorsEdit: TEdit;
    RefitBakCommsEdit: TEdit;
    FlagBridgeChkBx: TCheckBox;
    OKBtn: TButton;
    CancelBtn: TButton;
    MainStatLbl: TLabel;
    BakStatLbl: TLabel;
    FltAviStatLbl: TLabel;
    RefitBakFltAviChkBx: TCheckBox;
    RefitBakSensorsChkBx: TCheckBox;
    RefitBakCommsChkBx: TCheckBox;
    RefitBakBridgeChkBx: TCheckBox;
    RefitBridgeChkBx: TCheckBox;
    RefitFlagBridgeChkBx: TCheckBox;
    RefitCompChkBx: TCheckBox;
    RefitBakCompChkBx: TCheckBox;
    RefitFltAviChkBx: TCheckBox;
    RefitSensorsChkBx: TCheckBox;
    RefitCommsChkBx: TCheckBox;
    RefitCompEdit: TEdit;
    RefitBakCompEdit: TEdit;
    RefitFltAviEdit: TEdit;
    RefitSensorsEdit: TEdit;
    RefitCommsEdit: TEdit;
    RefitTechStatLbl: TLabel;
    RefitBakTechStatLbl: TLabel;
    SensorsStatLbl: TLabel;
    CommsStatLbl: TLabel;
    FltAviCombo: TComboBox;
    BakFltAviCombo: TComboBox;
    BakFltAviEdit: TEdit;
    SensorsCombo: TComboBox;
    BakSensorsCombo: TComboBox;
    BakSensorsEdit: TEdit;
    CommsCombo: TComboBox;
    BakCommsCombo: TComboBox;
    BakCommsEdit: TEdit;
    BridgeRadGrp: TRadioGroup;
    BakBridgeRadGrp: TRadioGroup;
    CompStatLbl: TLabel;
    CompComboBx: TComboBox;
    BakCompComboBx: TComboBox;
    BakCompEdit: TEdit;
    BakBridgeEdit: TEdit;
    NumberStatLbl: TLabel;
    CommsTypeRadGrp: TRadioGroup;
    procedure CommsTypeRadGrpClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BakCompComboBxChange(Sender: TObject);
    procedure BakBridgeRadGrpClick(Sender: TObject);
    procedure CompComboBxChange(Sender: TObject);
    procedure RefitBakBridgeChkBxChange(Sender: TObject);
    procedure RefitBakCommsChkBxChange(Sender: TObject);
    procedure RefitBakCommsEditChange(Sender: TObject);
    procedure RefitBakCompChkBxChange(Sender: TObject);
    procedure RefitBakCompEditChange(Sender: TObject);
    procedure RefitBakFltAviChkBxChange(Sender: TObject);
    procedure RefitBakFltAviEditChange(Sender: TObject);
    procedure RefitBakSensorsChkBxChange(Sender: TObject);
    procedure RefitBakSensorsEditChange(Sender: TObject);
    procedure RefitBridgeChkBxChange(Sender: TObject);
    procedure RefitCommsChkBxChange(Sender: TObject);
    procedure RefitCommsEditChange(Sender: TObject);
    procedure RefitCompChkBxChange(Sender: TObject);
    procedure RefitCompEditChange(Sender: TObject);
    procedure RefitFlagBridgeChkBxChange(Sender: TObject);
    procedure RefitFltAviChkBxChange(Sender: TObject);
    procedure RefitFltAviEditChange(Sender: TObject);
    procedure RefitSensorsChkBxChange(Sender: TObject);
    procedure RefitSensorsEditChange(Sender: TObject);
  private
    { Private declarations }
    AvionicsList : TStringList;
    SensorsList : TStringList;
    CommsList : TStringList;
    function TrapErrors: Boolean;
    function NoValues: Boolean;
    function InvalidNumbers: Boolean;
    function NegativeValues: Boolean;
    function InsufficentJumpComputer: Boolean;
    function InsufficentSizeComputer: Boolean;
    function BridgeError: Boolean;
    function InsufficentSizeFlightAvionics: Boolean;
    function InsufficentComputerFlightAvionics: Boolean;
    function InsufficentComputerSensors: Boolean;
    function InsufficentComputerComms: Boolean;
    function Warn (TheMessage: String) : Boolean;
    function IsSmallCraftComp(CompValue : Integer) : Boolean;
    function SetCompValue(Comp: Char): Integer;
    function GenerateAvionicsDetails : String;
    function GetTechLimit(TL: Integer): Integer;
    function GetComputerNumber(CompValue: Integer): Integer;
    function SetCommsType(TL, TheCommsType: Integer): Integer;
    procedure FillComputerCombo(TheCombo: TComboBox; TechLevel: Integer);
    procedure FillT20Lists(TechLevel: Integer);
    procedure FillAvionicsCombo(TheCombo: TComboBox; TechLevel, CompVal: Integer);
    procedure FillSensorsCombo(TheCombo: TComboBox; TechLevel, CompVal: Integer);
    procedure FillCommsCombo(TheCombo: TComboBox; TechLevel, CompVal: Integer);
    procedure SetRefitData(TechLevel: Integer);
    procedure SetNonRefitData(TechLevel: Integer);
    procedure SetR20Combos;
    procedure SendRefitData;
    procedure SendNonRefitData;
    procedure DisplayRefitItems(IsRefitted: Boolean);
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  R20AvionicsFrm: TR20AvionicsFrm;
  Data : TData;

implementation

uses MainPas;

{$R *.lfm}

procedure TR20AvionicsFrm.OKBtnClick(Sender: TObject);
//check for errors and if okay send the form values to the ship

begin
  if (TrapErrors) then
  begin
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    SendRefitData;
  end
  else
  begin
    SendNonRefitData;
  end;
  Ship.DesignShip;
  MainFrm.RefreshForm;
  Ship.HasChanged := True;
  MainFrm.SaveMenuItem.Enabled := True;
  MainFrm.RestoreMenuItem.Enabled := True;
  Close;
end;

procedure TR20AvionicsFrm.CommsTypeRadGrpClick(Sender: TObject);
begin

end;

procedure TR20AvionicsFrm.CancelBtnClick(Sender: TObject);
//close the form with out applying the changes

begin
   Close;
end;

procedure TR20AvionicsFrm.FormCreate(Sender: TObject);
//create the form and fill it with values from ship

begin
  Data := TData.Create;
  Data.InitialiseData;
  AvionicsList := TStringList.Create;
  SensorsList := TStringList.Create;
  CommsList := TStringList.Create;
  FlagBridgeChkBx.Visible := Ship.Flagship;
  FlagBridgeChkBx.Enabled := Ship.Flagship;
  FillT20Lists(Ship.TechLevel);
  FillComputerCombo(CompComboBx, Ship.TechLevel);
  FillComputerCombo(BakCompComboBx, Ship.TechLevel);
  SetR20Combos;
  DisplayRefitItems(Ship.IsRefitted);
  if (Ship.IsRefitted) then
  begin
    SetRefitData(Ship.RefitTechLevel);
  end
  else
  begin
    SetNonRefitData(Ship.TechLevel);
  end;

  if (Ship.Tonnage >= 100) then
  begin
    BridgeRadGrp.ItemIndex := 0;
    BridgeRadGrp.Enabled := False;
  end;
end;

procedure TR20AvionicsFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//clean up and close the form

begin
  FreeAndNil(Data);
  FreeAndNil(AvionicsList);
  FreeAndNil(SensorsList);
  FreeAndNil(CommsList);
  Action := caFree;
end;

function TR20AvionicsFrm.TrapErrors: Boolean;
//detect errors

begin
  Result := False;
  if (NoValues) then
  begin
    Result := True;
    Exit;
  end;
  if (InvalidNumbers) then
  begin
    Result := True;
    Exit;
  end;
  if (NegativeValues) then
  begin
    Result := True;
    Exit;
  end;
  if (InsufficentJumpComputer) then
  begin
    Result := True;
    Exit;
  end;
  if (InsufficentSizeComputer) then
  begin
    Result := True;
    Exit;
  end;
  if (BridgeError) then
  begin
    Result := True;
    Exit;
  end;
  if (InsufficentSizeFlightAvionics) then
  begin
    Result := True;
    Exit;
  end;
  if (InsufficentComputerFlightAvionics) then
  begin
    Result := True;
    Exit;
  end;
  if (InsufficentComputerSensors) then
  begin
    Result := True;
    Exit;
  end;
  if (InsufficentComputerComms) then
  begin
    Result := True;
    Exit;
  end;
  //warnings
  if (Ship.Tonnage < 100) and not (IsSmallCraftComp(SetCompValue(CompComboBx.Text[1]))) then
  begin
    if (Warn('Fib and Bis Computers may not be fitted to Small Craft.'
        + #13 + 'Do you wish to change this now?')) then
    begin
      Result := True;
      exit;
    end;
  end;
  if (Ship.Tonnage < 100) and not (IsSmallCraftComp(SetCompValue(BakCompComboBx.Text[1]))) then
  begin
    if (Warn('Fib and Bis Backup Computers may not be fitted to Small Craft.'
        + #13 + 'Do you wish to change this now?')) then
    begin
      Result := True;
      exit;
    end;
  end;
end;

function TR20AvionicsFrm.NoValues: Boolean;
begin
  Result := False;
  if (CompComboBx.Text = '') then
  begin
    MessageDlg('No Main Computer Entered', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakCompComboBx.Text = '') then
  begin
    MessageDlg('No Backup Computer Entered (This may be None)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakCompEdit.Text = '') then
  begin
    MessageDlg('No Backup Computer Number Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakBridgeEdit.Text = '') then
  begin
    MessageDlg('No Backup Bridge Number Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitCompEdit.Text = '') then
  begin
    MessageDlg('No TL for Computer Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakCompEdit.Text = '') then
  begin
    MessageDlg('No TL for Backup Computer Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitFltAviEdit.Text = '') then
  begin
    MessageDlg('No TL for Flight Avionics Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakFltAviEdit.Text = '') then
  begin
    MessageDlg('No TL for Backup Flight Avionics Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitSensorsEdit.Text = '') then
  begin
    MessageDlg('No TL for Sensors Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakSensorsEdit.Text = '') then
  begin
    MessageDlg('No TL for Backup Sensors Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitCommsEdit.Text = '') then
  begin
    MessageDlg('No TL for Comms Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakCommsEdit.Text = '') then
  begin
    MessageDlg('No TL for Backup Comms Refit Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BridgeRadGrp.ItemIndex = -1) then
  begin
    MessageDlg('Bridge State not Selected', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakBridgeRadGrp.ItemIndex = -1) then
  begin
    MessageDlg('Backup Bridge State not Selected', mtError, [mbOk], 0);
    Result := True;
    //exit;
  end;
end;

function TR20AvionicsFrm.InvalidNumbers: Boolean;
begin
  Result := False;
  if (StrToIntDef(BakCompEdit.Text, 3) = 3) and (StrToIntDef(BakCompEdit.Text, 2) = 2) then
  begin
    MessageDlg('Number of Backup Computers must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(BakBridgeEdit.Text, 3) = 3) and (StrToIntDef(BakBridgeEdit.Text, 2) = 2) then
  begin
    MessageDlg('Number of Backup Bridges must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitCompEdit.Text, 3) = 3) and (StrToIntDef(RefitCompEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Computer Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakCompEdit.Text, 3) = 3) and (StrToIntDef(RefitBakCompEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Backup Computer Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitFltAviEdit.Text, 3) = 3) and (StrToIntDef(RefitFltAviEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Flight Avionics Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakFltAviEdit.Text, 3) = 3) and (StrToIntDef(RefitBakFltAviEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Backup Flight Avionics Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitSensorsEdit.Text, 3) = 3) and (StrToIntDef(RefitSensorsEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Sensors Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakSensorsEdit.Text, 3) = 3) and (StrToIntDef(RefitBakSensorsEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Backup Sensors Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitCommsEdit.Text, 3) = 3) and (StrToIntDef(RefitCommsEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Comms Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakCommsEdit.Text, 3) = 3) and (StrToIntDef(RefitBakCommsEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Backup Comms Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
end;

function TR20AvionicsFrm.NegativeValues: Boolean;
begin
  Result := False;
  if (StrToInt(BakCompEdit.Text) < 0) then
  begin
    MessageDlg('Number of Backup Computers may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(BakBridgeEdit.Text) < 0) then
  begin
    MessageDlg('Number of Backup Bridges may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitCompEdit.Text) < 0) then
  begin
    MessageDlg('TL for Computer Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakCompEdit.Text) < 0) then
  begin
    MessageDlg('TL for Backup Computer Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitFltAviEdit.Text) < 0) then
  begin
    MessageDlg('TL for Flight Avionics Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakFltAviEdit.Text) < 0) then
  begin
    MessageDlg('TL for Backup Flight Avionics Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitSensorsEdit.Text) < 0) then
  begin
    MessageDlg('TL for Sensors Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakSensorsEdit.Text) < 0) then
  begin
    MessageDlg('TL for Backup Sensors Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitCommsEdit.Text) < 0) then
  begin
    MessageDlg('TL for Comms Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakCommsEdit.Text) < 0) then
  begin
    MessageDlg('TL for Backup Comms Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
end;

function TR20AvionicsFrm.InsufficentJumpComputer: Boolean;
begin
  Result := False;
  if (not (Ship.IsRefitted)) or ((Ship.IsRefitted) and (RefitCompChkBx.Checked)) then
  begin
    if (Ship.Eng.JDriveIsRefitted) then
    begin
      if (SetCompValue(CompComboBx.Text[1]) < 1) and (Ship.Eng.NewJDrive = 1) then
      begin
        MessageDlg('Ships with Jump Drives require a Computer', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 3) and (Ship.Eng.NewJDrive = 2) then
      begin
        MessageDlg('Jump 2 ships require a Model/1bis Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 6) and (Ship.Eng.NewJDrive = 3) then
      begin
        MessageDlg('Jump 3 ships require a Model/2bis Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 9) and (Ship.Eng.NewJDrive = 4) then
      begin
        MessageDlg('Jump 4 ships require a Model/4 Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 11) and (Ship.Eng.NewJDrive = 5) then
      begin
        MessageDlg('Jump 5 ships require a Model/5 Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 13) and (Ship.Eng.NewJDrive = 6) then
      begin
        MessageDlg('Jump 6 ships require a Model/6 Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
    end
    else
    begin
      if (SetCompValue(CompComboBx.Text[1]) < 1) and (Ship.Eng.JDrive = 1) then
      begin
        MessageDlg('Ships with Jump Drives require a Computer', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 3) and (Ship.Eng.JDrive = 2) then
      begin
        MessageDlg('Jump 2 ships require a Model/1bis Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 6) and (Ship.Eng.JDrive = 3) then
      begin
        MessageDlg('Jump 3 ships require a Model/2bis Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 9) and (Ship.Eng.JDrive = 4) then
      begin
        MessageDlg('Jump 4 ships require a Model/4 Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 11) and (Ship.Eng.JDrive = 5) then
      begin
        MessageDlg('Jump 5 ships require a Model/5 Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
      if (SetCompValue(CompComboBx.Text[1]) < 13) and (Ship.Eng.JDrive = 6) then
      begin
        MessageDlg('Jump 6 ships require a Model/6 Computer or better', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
    end;
  end;
end;

function TR20AvionicsFrm.InsufficentSizeComputer: Boolean;
begin
  Result := False;
  if (not (Ship.IsRefitted)) or ((Ship.IsRefitted) and (RefitCompChkBx.Checked)) then
  begin
    if (SetCompValue(CompComboBx.Text[1]) = 0) and (Ship.Tonnage >= 100) then
    begin
      MessageDlg('Ships of 100T and over must have a Computer', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 600) and (SetCompValue(CompComboBx.Text[1]) < 1) then
    begin
      MessageDlg('Ships of 600T and over must have a Model/1 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 1000) and (SetCompValue(CompComboBx.Text[1]) < 4) then
    begin
      MessageDlg('Ships of 1000T and over must have a Model/2 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 4000) and (SetCompValue(CompComboBx.Text[1]) < 7) then
    begin
      MessageDlg('Ships of 4000T and over must have a Model/3 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 10000) and (SetCompValue(CompComboBx.Text[1]) < 9) then
    begin
      MessageDlg('Ships of 10,000T and over must have a Model/4 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 50000) and (SetCompValue(CompComboBx.Text[1]) < 11) then
    begin
      MessageDlg('Ships of 50,000T and over must have a Model/5 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 100000) and (SetCompValue(CompComboBx.Text[1]) < 13) then
    begin
      MessageDlg('Ships of 100,000T and over must have a Model/6 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (Ship.Tonnage >= 1000000) and (SetCompValue(CompComboBx.Text[1]) < 15) then
    begin
      MessageDlg('Ships of 1,000,000T and over must have a Model/7 Computer or better', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
end;

function TR20AvionicsFrm.BridgeError: Boolean;
begin
  Result := False;
  if ((BridgeRadGrp.ItemIndex = 1) and (SetCompValue(CompComboBx.Text[1]) = 0)) and (Ship.Tonnage < 100) then
  begin
    MessageDlg('Small Craft (Vessels under 100T) must have either a Bridge or a Computer', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BridgeRadGrp.ItemIndex = 1) and (Ship.Tonnage >= 100) then
  begin
    MessageDlg('Ships of 100T and over must have a Bridge', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
end;

function TR20AvionicsFrm.InsufficentSizeFlightAvionics: Boolean;
var
  IsStreamLined, IsAirframe, StreamlinedHull: Boolean;
  ShipSize: Extended;
  MinFlightAvionics: Integer;
begin
  Result := False;
  ShipSize := Ship.Tonnage;
  if (Ship.Hull.StreamLining = 0) then
  begin
    IsStreamlined := True;
  end
  else
  begin
    IsStreamLined := False;
  end;
  if (Ship.Hull.Airframe = 0) then
  begin
    IsAirframe := True;
  end
  else
  begin
    IsAirframe := False;
  end;
  if (Ship.Hull.Config < 3) or (Ship.Hull.Config = 6) then
  begin
    StreamlinedHull := True;
  end
  else
  begin
    StreamlinedHull := False;
  end;
  if (ShipSize > 100000) then MinFlightAvionics := 7
      else if (ShipSize > 50000) then MinFlightAvionics := 6
      else if (ShipSize > 10000) then MinFlightAvionics := 5
      else if (ShipSize > 4000) then MinFlightAvionics := 4
      else if (ShipSize > 1000) then MinFlightAvionics := 3
      else if (ShipSize > 600) then MinFlightAvionics := 2
      else MinFlightAvionics := 1;
  if (IsStreamlined) and not (StreamlinedHull) then Inc(MinFlightAvionics, 1);
  if (IsAirframe) and (StreamlinedHull) then Inc(MinFlightAvionics, 1);
  if (IsAirframe) and not (StreamlinedHull) then Inc(MinFlightAvionics, 2);
  if (not (Ship.IsRefitted)) or ((Ship.IsRefitted) and(RefitFltAviChkBx.Checked)) then
  begin
    if (StrToInt(FltAviCombo.Text[1]) < MinFlightAvionics) then
    begin
      MessageDlg('Minimum of Model/' + IntToStr(MinFlightAvionics) + ' Flight Avionics required', mtError, [mbOk], 0);
      Result := True;
    end;
  end;
end;

function TR20AvionicsFrm.InsufficentComputerFlightAvionics: Boolean;
var
  EffectiveCompNum: Integer;
begin
  Result := False;
  if (Ship.IsRefitted) and (not (RefitCompChkBx.Checked)) then
  begin
    EffectiveCompNum := GetComputerNumber(Ship.Avionics.MainComp);
  end
  else
  begin
    EffectiveCompNum := GetComputerNumber(SetCompValue(CompComboBx.Text[1]));
  end;
  if (SetCompValue(CompComboBx.Text[1]) = 3) or (SetCompValue(CompComboBx.Text[1]) = 6) then
  begin
    Inc(EffectiveCompNum, 1)
  end;
  if (not (Ship.IsRefitted)) or ((Ship.IsRefitted) and (RefitFltAviChkBx.Checked)) then
  begin
    if (EffectiveCompNum < StrToInt(FltAviCombo.Text[1])) then
    begin
      MessageDlg('Flight Avionics Model may not be greater than the Computer Model'
          + #13 + '(bis models are treated as one computer model higher)', mtError, [mbOk], 0);
      Result := True;
    end;
  end;
end;

function TR20AvionicsFrm.InsufficentComputerSensors: Boolean;
var
  EffectiveCompNum: Integer;
begin
  Result := False;
  if (Ship.IsRefitted) and (not (RefitCompChkBx.Checked)) then
  begin
    EffectiveCompNum := GetComputerNumber(Ship.Avionics.MainComp);
  end
  else
  begin
    EffectiveCompNum := GetComputerNumber(SetCompValue(CompComboBx.Text[1]));
  end;
  if (not (Ship.IsRefitted)) or ((Ship.IsRefitted) and(RefitSensorsChkBx.Checked)) then
  begin
    if (EffectiveCompNum < StrToInt(SensorsCombo.Text[1])) then
    begin
      MessageDlg('Sensors Model may not be greater than the Computer Model', mtError, [mbOk], 0);
      Result := True;
    end;
  end;
end;

function TR20AvionicsFrm.InsufficentComputerComms: Boolean;
var
  EffectiveCompNum: Integer;
begin
  Result := False;
  if (Ship.IsRefitted) and (not (RefitCompChkBx.Checked)) then
  begin
    EffectiveCompNum := GetComputerNumber(Ship.Avionics.MainComp);
  end
  else
  begin
    EffectiveCompNum := GetComputerNumber(SetCompValue(CompComboBx.Text[1]));
  end;
  if (not (Ship.IsRefitted)) or ((Ship.IsRefitted) and(RefitCommsChkBx.Checked)) then
  begin
    if (EffectiveCompNum < (StrToInt(CommsCombo.Text[1]) + CommsTypeRadGrp.ItemIndex)) then
    begin
      MessageDlg('Communications Model may not be greater than the Computer Model'
          + #13 + '(masers require one level higher, meson two levels higher)', mtError, [mbOk], 0);
      Result := True;
    end;
  end;
end;

function TR20AvionicsFrm.Warn(TheMessage: String): Boolean;
//display a warning message and get a yes no answer

begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TR20AvionicsFrm.IsSmallCraftComp(CompValue: Integer): Boolean;
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

function TR20AvionicsFrm.GenerateAvionicsDetails: String;
//generate avionics file data

begin
   Result := IntToStr(SetCompValue(CompComboBx.Text[1]))
         + SEP + IntToStr(SetCompValue(BakCompComboBx.Text[1]))
         + SEP + BakCompEdit.Text
         + SEP + IntToStr(BridgeRadGrp.ItemIndex)
         + SEP + IntToStr(BakBridgeRadGrp.ItemIndex)
         + SEP + BakBridgeEdit.Text
         + SEP + FltAviCombo.Text[1]
         + SEP + BakFltAviCombo.Text[1]
         + SEP + BakFltAviEdit.Text
         + SEP + SensorsCombo.Text[1]
         + SEP + BakSensorsCombo.Text[1]
         + SEP + BakSensorsEdit.Text
         + SEP + CommsCombo.Text[1]
         + SEP + BakCommsCombo.Text[1]
         + SEP + BakCommsEdit.Text
         + SEP + IntToStr(CommsTypeRadGrp.ItemIndex)
         + SEP + BoolToStr(FlagBridgeChkBx.Checked)
         + SEP + IntToStr(Ship.Avionics.FlagComp)
         + SEP + BoolToStr(RefitBridgeChkBx.Checked)
         + SEP + BoolToStr(RefitBakBridgeChkBx.Checked)     //19
         + SEP + BoolToStr(RefitCompChkBx.Checked)          //20
         + SEP + BoolToStr(RefitBakCompChkBx.Checked)       //21
         + SEP + BoolToStr(Ship.Avionics.RefitFlagComp)      //22
         + SEP + BoolToStr(RefitFltAviChkBx.Checked)       //23
         + SEP + BoolToStr(RefitBakFltAviChkBx.Checked)    //24
         + SEP + BoolToStr(RefitSensorsChkBx.Checked)           //25
         + SEP + BoolToStr(RefitBakSensorsChkBx.Checked)        //26
         + SEP + BoolToStr(RefitCommsChkBx.Checked)             //27
         + SEP + BoolToStr(RefitBakCommsChkBx.Checked)          //28
         + SEP + RefitCompEdit.Text                         //29
         + SEP + RefitBakCompEdit.Text                      //30
         + SEP + IntToStr(Ship.Avionics.FlagCompRefitTech)                     //31
         + SEP + RefitFltAviEdit.Text    //32
         + SEP + RefitBakFltAviEdit.Text //33
         + SEP + RefitSensorsEdit.Text        //34
         + SEP + RefitBakSensorsEdit.Text     //35
         + SEP + RefitCommsEdit.Text          //36
         + SEP + RefitBakCommsEdit.Text       //37
         + SEP + IntToStr(SetCompValue(CompComboBx.Text[1]))//38
         + SEP + IntToStr(SetCompValue(BakCompComboBx.Text[1]))//39
         + SEP + IntToStr(Ship.Avionics.NewFlagComp)             //40
         + SEP + FltAviCombo.Text[1]          //41
         + SEP + BakFltAviCombo.Text[1]       //42
         + SEP + SensorsCombo.Text[1]              //43
         + SEP + BakSensorsCombo.Text[1]           //44
         + SEP + CommsCombo.Text[1]                //45
         + SEP + BakCommsCombo.Text[1]             //46
         + SEP + BakBridgeEdit.Text                         //47
         + SEP + BakCompEdit.Text                           //48
         + SEP + BakFltAviEdit.Text    //49
         + SEP + BakSensorsEdit.Text        //50
         + SEP + BakCommsEdit.Text          //51
         + SEP + IntToStr(CommsTypeRadGrp.ItemIndex)            //52
         + SEP + BoolToStr(Ship.Avionics.RefitCommsType)         //53
         + SEP + IntToStr(Ship.Avionics.CommsTypeRefitTech)      //54
         + SEP + BoolToStr(RefitFlagBridgeChkBx.Checked)        //55
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         ; //terminator
end;

function TR20AvionicsFrm.SetCompValue(Comp: Char): Integer;
//get the comp value from its usp code

begin
   Case (Comp) of
      '0' : Result := 0;
      '1' : Result := 1;
      'A' : Result := 2;
      'R' : Result := 3;
      '2' : Result := 4;
      'B' : Result := 5;
      'S' : Result := 6;
      '3' : Result := 7;
      'C' : Result := 8;
      '4' : Result := 9;
      'D' : Result := 10;
      '5' : Result := 11;
      'E' : Result := 12;
      '6' : Result := 13;
      'F' : Result := 14;
      '7' : Result := 15;
      'G' : Result := 16;
      '8' : Result := 17;
      'H' : Result := 18;
      '9' : Result := 19;
      'J' : Result := 20;
   end;
end;

procedure TR20AvionicsFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//go to the design assistant

var
   DesAssist : TDesAssistFrm;
   FullShipData : TStringList;
begin
//   if (Key = VK_F1) and (ssCtrl in Shift) then begin
   if (Key = VK_F3) then begin
      DesAssist := TDesAssistFrm.Create(Self);
      FullShipData := TStringList.Create;
      try
         FullShipData.Add(Ship.GetCurver);
         FullShipData.Add(Ship.GenShipDetails);
         FullShipData.Add(Ship.GenHullDetails);
         FullShipData.Add(Ship.GenEngDetails);
         FullShipData.Add(Ship.GenFuelDetails);
         FullShipData.Add(GenerateAvionicsDetails);
         FullShipData.Add(Ship.GenSpinalMountDetails);
         FullShipData.Add(Ship.GenBigBaysDetails);
         FullShipData.Add(Ship.GenLittleBaysDetails);
         FullShipData.Add(Ship.GenTurretDetails);
         FullShipData.Add(Ship.GenScreenDetails);
         FullShipData.Add(Ship.GenCraftDetails);
         FullShipData.Add(Ship.GenAccomDetails);
         FullShipData.Add(Ship.GenUserDefDetails);
         FullShipData.Add(Ship.GenOptionsDetails);

         //reserved space
         FullShipData.Add('Reserved for future expansion');
         FullShipData.Add('Reserved for future expansion');
         FullShipData.Add('Reserved for future expansion');

         //comments
         FullShipData.AddStrings(Ship.ShipComments);

         DesAssist.DetailForm(FullShipData);
      finally
         FreeAndNil(FullShipData);
      end;
      DesAssist.ShowModal;
   end;
end;

procedure TR20AvionicsFrm.BakCompComboBxChange(Sender: TObject);
//if the bak comp is not set to none, get the number of bak comps from the ship
//if the bak comp is set to none, set the number of bak comps to zero
//fill the other combos

begin
   if (BakCompComboBx.Text = '') then begin
      abort;
   end;
   if (SetCompValue(BakCompComboBx.Text[1]) > 0) then begin
      if (StrToInt(BakCompEdit.Text) = 0) and (not (Ship.IsRefitted)) then begin
         BakCompEdit.Text := IntToStr(Max(1, Ship.Avionics.BakCompNum));
      end;
   end
   else if (SetCompValue(BakCompComboBx.Text[1]) = 0) then begin
      BakCompEdit.Text := '0';
   end;
   SetR20Combos;
end;

procedure TR20AvionicsFrm.BakBridgeRadGrpClick(Sender: TObject);
//if the bak bridge is not set to no, get the number of bak bridges from the ship
//if the bak bridge is set to no, set the number to zero

begin
   if (BakBridgeRadGrp.ItemIndex = 0) then begin
      if (StrToInt(BakBridgeEdit.Text) = 0) then begin
         BakBridgeEdit.Text := IntToStr(Max(1, Ship.Avionics.BakBridgeNum));
      end;
   end
   else if (BakBridgeRadGrp.ItemIndex = 1) then begin
      BakBridgeEdit.Text := '0';
   end;
end;

procedure TR20AvionicsFrm.FillAvionicsCombo(TheCombo: TComboBox; TechLevel, CompVal: Integer);
//fill the flight avionics combos

var
  iStart, iEnd : Integer;
begin
  TheCombo.Items.Clear;
  iEnd := Min(GetTechLimit(TechLevel), SetCompValue(Data.GetComputerData(1, CompVal)[1]));
  for iStart := 0 to iEnd do
  begin
    TheCombo.Items.Add(AvionicsList[iStart]);
  end;
end;

procedure TR20AvionicsFrm.FillSensorsCombo(TheCombo: TComboBox; TechLevel, CompVal: Integer);
//fill the sensor combos

var
  iStart, iEnd : Integer;
begin
  TheCombo.Items.Clear;
  iEnd := Min(GetTechLimit(TechLevel), SetCompValue(Data.GetComputerData(1, CompVal)[1]));
  for iStart := 0 to iEnd do
  begin
    TheCombo.Items.Add(SensorsList[iStart]);
  end;
end;

procedure TR20AvionicsFrm.FillCommsCombo(TheCombo: TComboBox; TechLevel, CompVal: Integer);
//fill the flight avionics combos

var
  iStart, iEnd : Integer;
begin
  TheCombo.Items.Clear;
  iEnd := Min(GetTechLimit(TechLevel), SetCompValue(Data.GetComputerData(1, CompVal)[1]));
  for iStart := 0 to iEnd do
  begin
    TheCombo.Items.Add(CommsList[iStart]);
  end;
end;

procedure TR20AvionicsFrm.SetRefitData(TechLevel: Integer);
begin
  //computer
  CompComboBx.ItemIndex := Ship.Avionics.NewComp;
  RefitCompChkBx.Checked := Ship.Avionics.RefitComp;
  //bak comp;uter
  BakCompComboBx.ItemIndex := Ship.Avionics.NewBakComp;
  BakCompEdit.Text := IntToStr(Ship.Avionics.NewBakCompNum);
  RefitBakCompChkBx.Checked := Ship.Avionics.RefitBakComp;
  //flt avionics
  FltAviCombo.ItemIndex := Ship.Avionics.NewFltAvionics;
  RefitFltAviChkBx.Checked := Ship.Avionics.RefitFltAvionics;
  RefitCompEdit.Text := IntToStr(Ship.Avionics.CompRefitTech);
  RefitBakCompEdit.Text := IntToStr(Ship.Avionics.BakCompRefitTech);
  RefitFltAviEdit.Text := IntToStr(Ship.Avionics.FltAvionicsRefitTech);
  //bak flt avionics
  BakFltAviCombo.ItemIndex := Ship.Avionics.NewBakFltAvionics;
  BakFltAviEdit.Text := IntToStr(Ship.Avionics.NewBakFltAvionicsNum);
  RefitBakFltAviChkBx.Checked := Ship.Avionics.RefitBakFltAvionics;
  //sensors
  SensorsCombo.ItemIndex := Ship.Avionics.NewSensors;
  RefitSensorsChkBx.Checked := Ship.Avionics.RefitSensors;
  //bak sensors
  BakSensorsCombo.ItemIndex := Ship.Avionics.NewBakSensors;
  BakSensorsEdit.Text := IntToStr(Ship.Avionics.NewBakSensorsNum);
  RefitBakSensorsChkBx.Checked := Ship.Avionics.RefitBakSensors;
  //comms
  CommsCombo.ItemIndex := Ship.Avionics.NewComms;
  RefitCommsChkBx.Checked := Ship.Avionics.RefitComms;
  //bak comms
  BakCommsCombo.ItemIndex := Ship.Avionics.NewBakComms;
  BakCommsEdit.Text := IntToStr(Ship.Avionics.NewBakCommsNum);
  RefitBakCommsChkBx.Checked := Ship.Avionics.RefitBakComms;
  SetCommsType(Ship.Avionics.CommsRefitTech, Ship.Avionics.NewCommsType);
  //bridges
  BridgeRadGrp.ItemIndex := Ship.Avionics.Bridge;
  RefitBridgeChkBx.Checked := Ship.Avionics.RefitBridge;
  BakBridgeRadGrp.ItemIndex := Ship.Avionics.BakBridge;
  RefitBakBridgeChkBx.Checked := Ship.Avionics.RefitBakBridge;
  BakBridgeEdit.Text := IntToStr(Ship.Avionics.NewBakBridgeNum);
  FlagBridgeChkBx.Checked := Ship.Avionics.FlagBridge;
  RefitFlagBridgeChkBx.Checked := Ship.Avionics.RefitFlagBridge;
  //make sure tech levels are set last
  RefitCompEdit.Text := IntToStr(Ship.Avionics.CompRefitTech);
  RefitBakCompEdit.Text := IntToStr(Ship.Avionics.BakCompRefitTech);
  RefitFltAviEdit.Text := IntToStr(Ship.Avionics.FltAvionicsRefitTech);
  RefitBakFltAviEdit.Text := IntToStr(Ship.Avionics.BakFltAvionicsRefitTech);
  RefitSensorsEdit.Text := IntToStr(Ship.Avionics.SensorsRefitTech);
  RefitBakSensorsEdit.Text := IntToStr(Ship.Avionics.BakSensorsRefitTech);
  RefitCommsEdit.Text := IntToStr(Ship.Avionics.CommsRefitTech);
  RefitBakCommsEdit.Text := IntToStr(Ship.Avionics.BakCommsRefitTech);
end;

procedure TR20AvionicsFrm.SetNonRefitData(TechLevel: Integer);
begin
  CompComboBx.ItemIndex := Ship.Avionics.MainComp;
  BakCompComboBx.ItemIndex := Ship.Avionics.BakComp;
  BakCompEdit.Text := IntToStr(Ship.Avionics.BakCompNum);
  FltAviCombo.ItemIndex := Ship.Avionics.FltAvionics;
  BakFltAviCombo.ItemIndex := Ship.Avionics.BakFltAvionics;
  BakFltAviEdit.Text := IntToStr(Ship.Avionics.BakFltAvionicsNum);
  SensorsCombo.ItemIndex := Ship.Avionics.Sensors;
  BakSensorsCombo.ItemIndex := Ship.Avionics.BakSensors;
  BakSensorsEdit.Text := IntToStr(Ship.Avionics.BakSensorsNum);
  CommsCombo.ItemIndex := Ship.Avionics.Comms;
  BakCommsCombo.ItemIndex := Ship.Avionics.BakComms;
  BakCommsEdit.Text := IntToStr(Ship.Avionics.BakCommsNum);
  SetCommsType(Ship.TechLevel, Ship.Avionics.CommsType);
  BridgeRadGrp.ItemIndex := Ship.Avionics.Bridge;
  BakBridgeRadGrp.ItemIndex := Ship.Avionics.BakBridge;
  BakBridgeEdit.Text := IntToStr(Ship.Avionics.BakBridgeNum);
  FlagBridgeChkBx.Checked := Ship.Avionics.FlagBridge;
end;

procedure TR20AvionicsFrm.SetR20Combos;
var
  MainComp, BakComp: Integer;
begin
  if (Ship.Avionics.RefitComp) then MainComp := Ship.Avionics.NewComp
      else MainComp := Ship.Avionics.MainComp;
  if (Ship.Avionics.RefitBakComp) then BakComp := Ship.Avionics.NewBakComp
      else BakComp := Ship.Avionics.BakComp;
  //flt avi
  if (Ship.Avionics.RefitFltAvionics) then
  begin
    FillAvionicsCombo(FltAviCombo, Ship.Avionics.FltAvionicsRefitTech, MainComp);
  end
  else
  begin
    FillAvionicsCombo(FltAviCombo, Ship.TechLevel, MainComp);
  end;
  //bak flt avi
  if (Ship.Avionics.RefitBakFltAvionics) then
  begin
    FillAvionicsCombo(BakFltAviCombo, Ship.Avionics.BakFltAvionicsRefitTech, BakComp);
  end
  else
  begin
    FillAvionicsCombo(BakFltAviCombo, Ship.TechLevel, BakComp);
  end;
  //sensors
  if (Ship.Avionics.RefitSensors) then
  begin
    FillSensorsCombo(SensorsCombo, Ship.Avionics.SensorsRefitTech, MainComp);
  end
  else
  begin
    FillSensorsCombo(SensorsCombo, Ship.TechLevel, MainComp);
  end;
  //bak sensors
  if (Ship.Avionics.RefitBakSensors) then
  begin
    FillSensorsCombo(BakSensorsCombo, Ship.Avionics.BakSensorsRefitTech, BakComp);
  end
  else
  begin
    FillSensorsCombo(BakSensorsCombo, Ship.TechLevel, BakComp);
  end;
  //comms
  if (Ship.Avionics.RefitComms) then
  begin
    FillCommsCombo(CommsCombo, Ship.Avionics.CommsRefitTech, MainComp);
  end
  else
  begin
    FillCommsCombo(CommsCombo, Ship.TechLevel, MainComp);
  end;
  //bak comms
  if (Ship.Avionics.RefitBakComms) then
  begin
    FillCommsCombo(BakCommsCombo, Ship.Avionics.BakCommsRefitTech, BakComp);
  end
  else
  begin
    FillCommsCombo(BakCommsCombo, Ship.TechLevel, BakComp);
  end;
end;

procedure TR20AvionicsFrm.SendRefitData;
begin
  Ship.Avionics.Bridge := BridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridge := BakBridgeRadGrp.ItemIndex;
  //flag items
  Ship.Avionics.FlagBridge := FlagBridgeChkBx.Checked;
  Ship.Avionics.FlagComp := 0;
  //refit items main comp
  Ship.Avionics.RefitComp := RefitCompChkBx.Checked;
  Ship.Avionics.NewComp := SetCompValue(CompComboBx.Text[1]);
  Ship.Avionics.CompRefitTech := StrToInt(RefitCompEdit.Text);
  //bak comp
  Ship.Avionics.RefitBakComp := RefitBakCompChkBx.Checked;
  Ship.Avionics.NewBakComp := SetCompValue(BakCompComboBx.Text[1]);
  Ship.Avionics.NewBakCompNum := StrToInt(BakCompEdit.Text);
  Ship.Avionics.BakCompRefitTech := StrToInt(RefitBakCompEdit.Text);
  //flag comp
  Ship.Avionics.RefitFlagComp := False;
  Ship.Avionics.NewFlagComp := 0;
  Ship.Avionics.FlagCompRefitTech := 0;
  // bridge
  Ship.Avionics.RefitBridge := RefitBridgeChkBx.Checked;
  //bak bridge
  Ship.Avionics.RefitBakBridge := RefitBakBridgeChkBx.Checked;
  Ship.Avionics.NewBakBridgeNum := StrToInt(BakBridgeEdit.Text);
  //flag bridge
  Ship.Avionics.RefitFlagBridge := RefitFlagBridgeChkBx.Checked;
  //flt avi
  Ship.Avionics.RefitFltAvionics := RefitFltAviChkBx.Checked;
  Ship.Avionics.NewFltAvionics := StrToInt(FltAviCombo.Text[1]);
  Ship.Avionics.FltAvionicsRefitTech := StrToInt(RefitFltAviEdit.Text);
  //bak flt avi
  Ship.Avionics.RefitBakFltAvionics := RefitBakFltAviChkBx.Checked;
  Ship.Avionics.NewBakFltAvionics := StrToInt(BakFltAviCombo.Text[1]);
  Ship.Avionics.NewBakFltAvionicsNum := StrToInt(BakFltAviEdit.Text);
  Ship.Avionics.BakFltAvionicsRefitTech := StrToInt(RefitBakFltAviEdit.Text);
  //sensors
  Ship.Avionics.RefitSensors := RefitSensorsChkBx.Checked;
  Ship.Avionics.NewSensors := StrToInt(SensorsCombo.Text[1]);
  Ship.Avionics.SensorsRefitTech := StrToInt(RefitSensorsEdit.Text);
  //bak sensors
  Ship.Avionics.RefitBakSensors := RefitBakSensorsChkBx.Checked;
  Ship.Avionics.NewBakSensors := StrToInt(BakSensorsCombo.Text[1]);
  Ship.Avionics.NewBakSensorsNum := StrToInt(BakSensorsEdit.Text);
  Ship.Avionics.BakSensorsRefitTech := StrToInt(RefitBakSensorsEdit.Text);
  //comms
  Ship.Avionics.RefitComms := RefitCommsChkBx.Checked;
  Ship.Avionics.NewComms := StrToInt(CommsCombo.Text[1]);
  Ship.Avionics.CommsRefitTech := StrToInt(RefitCommsEdit.Text);
  Ship.Avionics.NewCommsType := CommsTypeRadGrp.ItemIndex;
  //bak comms
  Ship.Avionics.RefitBakComms := RefitBakCommsChkBx.Checked;
  Ship.Avionics.NewBakComms := StrToInt(BakCommsCombo.Text[1]);
  Ship.Avionics.NewBakCommsNum := StrToInt(BakCommsEdit.Text);
  Ship.Avionics.BakCommsRefitTech := StrToInt(RefitBakCommsEdit.Text);
end;

procedure TR20AvionicsFrm.SendNonRefitData;
begin
  Ship.Avionics.MainComp := SetCompValue(CompComboBx.Text[1]);
  Ship.Avionics.BakComp := SetCompValue(BakCompComboBx.Text[1]);
  Ship.Avionics.BakCompNum := StrToInt(BakCompEdit.Text);
  Ship.Avionics.Bridge := BridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridge := BakBridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridgeNum := StrToInt(BakBridgeEdit.Text);
  Ship.Avionics.FltAvionics := StrToInt(FltAviCombo.Text[1]);
  Ship.Avionics.BakFltAvionics := StrToInt(BakFltAviCombo.Text[1]);
  Ship.Avionics.BakFltAvionicsNum := StrToInt(BakFltAviEdit.Text);
  Ship.Avionics.Sensors := StrToInt(SensorsCombo.Text[1]);
  Ship.Avionics.BakSensors := StrToInt(BakSensorsCombo.Text[1]);
  Ship.Avionics.BakSensorsNum := StrToInt(BakSensorsEdit.Text);
  Ship.Avionics.Comms := StrToInt(CommsCombo.Text[1]);
  Ship.Avionics.BakComms := StrToInt(BakCommsCombo.Text[1]);
  Ship.Avionics.BakCommsNum := StrToInt(BakCommsEdit.Text);
  Ship.Avionics.CommsType := CommsTypeRadGrp.ItemIndex;
  //flag items
  Ship.Avionics.FlagBridge := FlagBridgeChkBx.Checked;
  Ship.Avionics.FlagComp := 0;
  //refit items main comp
  Ship.Avionics.RefitComp := False;
  Ship.Avionics.NewComp := 0;
  Ship.Avionics.CompRefitTech := 0;
  //bak comp
  Ship.Avionics.RefitBakComp := False;
  Ship.Avionics.NewBakComp := 0;
  Ship.Avionics.NewBakCompNum := 0;
  Ship.Avionics.BakCompRefitTech := 0;
  //flag comp
  Ship.Avionics.RefitFlagComp := False;
  Ship.Avionics.NewFlagComp := 0;
  Ship.Avionics.FlagCompRefitTech := 0;
  // bridge
  Ship.Avionics.RefitBridge := False;
  //bak bridge
  Ship.Avionics.RefitBakBridge := False;
  Ship.Avionics.NewBakBridgeNum := 0;
  //flag bridge
  Ship.Avionics.RefitFlagBridge := FlagBridgeChkBx.Checked;
  //flt avi
  Ship.Avionics.RefitFltAvionics := False;
  Ship.Avionics.NewFltAvionics := 0;
  Ship.Avionics.FltAvionicsRefitTech := 0;
  //bak flt avi
  Ship.Avionics.RefitBakFltAvionics := False;
  Ship.Avionics.NewBakFltAvionics := 0;
  Ship.Avionics.NewBakFltAvionicsNum := 0;
  Ship.Avionics.BakFltAvionicsRefitTech := 0;
  //sensors
  Ship.Avionics.RefitSensors := False;
  Ship.Avionics.NewSensors := 0;
  Ship.Avionics.SensorsRefitTech := 0;
  //bak sensors
  Ship.Avionics.RefitBakSensors := False;
  Ship.Avionics.NewBakSensors := 0;
  Ship.Avionics.NewBakSensorsNum := 0;
  Ship.Avionics.BakSensorsRefitTech := 0;
  //comms
  Ship.Avionics.RefitComms := False;
  Ship.Avionics.NewComms := 0;
  Ship.Avionics.CommsRefitTech := 0;
  Ship.Avionics.NewCommsType := 0;
  //bak comms
  Ship.Avionics.RefitBakComms := False;
  Ship.Avionics.NewBakComms := 0;
  Ship.Avionics.NewBakCommsNum := 0;
  Ship.Avionics.BakCommsRefitTech := 0;
end;

procedure TR20AvionicsFrm.DisplayRefitItems(IsRefitted: Boolean);
begin
  RefitTechStatLbl.Visible := IsRefitted;
  RefitBakTechStatLbl.Visible := IsRefitted;
  RefitCompChkBx.Enabled := IsRefitted;
  RefitCompChkBx.Visible := IsRefitted;
  RefitCompEdit.Enabled := IsRefitted;
  RefitCompEdit.Visible := IsRefitted;
  RefitBakCompChkBx.Enabled := IsRefitted;
  RefitBakCompChkBx.Visible := IsRefitted;
  RefitBakCompEdit.Enabled := IsRefitted;
  RefitBakCompEdit.Visible := IsRefitted;
  RefitFltAviChkBx.Enabled := IsRefitted;
  RefitFltAviChkBx.Visible := IsRefitted;
  RefitFltAviEdit.Enabled := IsRefitted;
  RefitFltAviEdit.Visible := IsRefitted;
  RefitBakFltAviChkBx.Enabled := IsRefitted;
  RefitBakFltAviChkBx.Visible := IsRefitted;
  RefitBakFltAviEdit.Enabled := IsRefitted;
  RefitBakFltAviEdit.Visible := IsRefitted;
  RefitSensorsChkBx.Enabled := IsRefitted;
  RefitSensorsChkBx.Visible := IsRefitted;
  RefitSensorsEdit.Enabled := IsRefitted;
  RefitSensorsEdit.Visible := IsRefitted;
  RefitBakSensorsChkBx.Enabled := IsRefitted;
  RefitBakSensorsChkBx.Visible := IsRefitted;
  RefitBakSensorsEdit.Enabled := IsRefitted;
  RefitBakSensorsEdit.Visible := IsRefitted;
  RefitCommsChkBx.Enabled := IsRefitted;
  RefitCommsChkBx.Visible := IsRefitted;
  RefitCommsEdit.Enabled := IsRefitted;
  RefitCommsEdit.Visible := IsRefitted;
  RefitBakCommsChkBx.Enabled := IsRefitted;
  RefitBakCommsChkBx.Visible := IsRefitted;
  RefitBakCommsEdit.Enabled := IsRefitted;
  RefitBakCommsEdit.Visible := IsRefitted;
  RefitBridgeChkBx.Enabled := IsRefitted;
  RefitBridgeChkBx.Visible := IsRefitted;
  RefitBakBridgeChkBx.Enabled := IsRefitted;
  RefitBakBridgeChkBx.Visible := IsRefitted;
  if (Ship.Flagship) then
  begin
    RefitFlagBridgeChkBx.Enabled := IsRefitted;
    RefitFlagBridgeChkBx.Visible := IsRefitted;
  end
  else
  begin
    RefitFlagBridgeChkBx.Enabled := False;
    RefitFlagBridgeChkBx.Visible := False;
  end;
  if (Ship.IsRefitted) then
  begin
    CompComboBx.Enabled:= Ship.Avionics.RefitComp;
    RefitCompEdit.Enabled := Ship.Avionics.RefitComp;
    BakCompComboBx.Enabled:= Ship.Avionics.RefitBakComp;
    BakCompEdit.Enabled := Ship.Avionics.RefitBakComp;
    RefitBakCompEdit.Enabled := Ship.Avionics.RefitBakComp;
    FltAviCombo.Enabled:= Ship.Avionics.RefitFltAvionics;
    RefitFltAviEdit.Enabled := Ship.Avionics.RefitFltAvionics;
    BakFltAviCombo.Enabled:= Ship.Avionics.RefitBakFltAvionics;
    BakFltAviEdit.Enabled := Ship.Avionics.RefitBakFltAvionics;
    RefitBakFltAviEdit.Enabled := Ship.Avionics.RefitBakFltAvionics;
    SensorsCombo.Enabled:= Ship.Avionics.RefitSensors;
    RefitSensorsEdit.Enabled := Ship.Avionics.RefitSensors;
    BakSensorsCombo.Enabled:= Ship.Avionics.RefitBakSensors;
    BakSensorsEdit.Enabled := Ship.Avionics.RefitBakSensors;
    RefitBakSensorsEdit.Enabled := Ship.Avionics.RefitBakSensors;
    CommsCombo.Enabled:= Ship.Avionics.RefitComms;
    RefitCommsEdit.Enabled := Ship.Avionics.RefitComms;
    CommsTypeRadGrp.Enabled:= Ship.Avionics.RefitComms;
    BakCommsCombo.Enabled:= Ship.Avionics.RefitBakComms;
    BakCommsEdit.Enabled := Ship.Avionics.RefitBakComms;
    RefitBakCommsEdit.Enabled := Ship.Avionics.RefitBakComms;
    BridgeRadGrp.Enabled := Ship.Avionics.RefitBridge;
    BakBridgeRadGrp.Enabled := Ship.Avionics.RefitBakBridge;
    BakBridgeEdit.Enabled := Ship.Avionics.RefitBakBridge;
    FlagBridgeChkBx.Enabled := Ship.Avionics.RefitFlagBridge;
  end;
end;

function TR20AvionicsFrm.GetTechLimit(TL: Integer): Integer;
//get how far to go with the combos according to tech level

begin
  case (TL) of
    0..4 : Result := 0;
    5..6 : Result := 1;
    7..8 : Result := 2;
    9 : Result := 3;
    10 : Result := 4;
    11 : Result := 5;
    12 : Result := 6;
    13 : Result := 7;
    14 : Result := 8;
    else Result := 9;
  end;
end;

function TR20AvionicsFrm.GetComputerNumber(CompValue: Integer): Integer;
begin
  case (CompValue) of
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

function TR20AvionicsFrm.SetCommsType(TL, TheCommsType: Integer): Integer;
begin
  case (TL) of
    0..7: begin
      CommsTypeRadGrp.Enabled := False;
      CommsTypeRadGrp.Items.Clear;
      CommsTypeRadGrp.Items.Add('Normal');
      CommsTypeRadGrp.ItemIndex := Min(TheCommsType, 0);
    end;
    8..14: begin
      CommsTypeRadGrp.Enabled := True;
      CommsTypeRadGrp.Items.Clear;
      CommsTypeRadGrp.Items.Add('Normal');
      CommsTypeRadGrp.Items.Add('Maser');
      CommsTypeRadGrp.ItemIndex := Min(TheCommsType, 1);
    end;
    else begin
      CommsTypeRadGrp.Enabled := True;
      CommsTypeRadGrp.Items.Clear;
      CommsTypeRadGrp.Items.Add('Normal');
      CommsTypeRadGrp.Items.Add('Maser');
      CommsTypeRadGrp.Items.Add('Meson');
      CommsTypeRadGrp.ItemIndex := Min(TheCommsType, 2);
    end;
  end;
  if (Ship.IsRefitted) then
  begin
    CommsTypeRadGrp.Enabled := RefitCommsChkBx.Checked;
  end;
  Result := CommsTypeRadGrp.ItemIndex;
end;

procedure TR20AvionicsFrm.FillComputerCombo(TheCombo: TComboBox;
  TechLevel: Integer);
var
  iCount: Integer;
  Data: TData;
  CompList: TStringList;
begin
  Data := TData.Create;
  CompList := TStringList.Create;
  try
    Data.InitialiseData;
    iCount := 0;
    while (iCount < 21) do
    begin
      if (StrToInt(Data.GetComputerData(5, iCount)) <= TechLevel) then
      begin
        CompList.Add(Data.GetComputerData(7, iCount));
      end;
      inc(iCount);
    end;
    TheCombo.Clear;
    TheCombo.Items.AddStrings(CompList);
  finally
    Data.Free;
    CompList.Free;
  end;
end;

procedure TR20AvionicsFrm.FillT20Lists(TechLevel: Integer);
begin
  //avionics
  AvionicsList.Add('0 None');
  AvionicsList.Add('1 600 Td');
  AvionicsList.Add('2 1,000 Td');
  AvionicsList.Add('3 4,000 Td');
  AvionicsList.Add('4 10,000 Td');
  AvionicsList.Add('5 50,000 Td');
  AvionicsList.Add('6 100,000 Td');
  AvionicsList.Add('7 1,000,000 Td');
  AvionicsList.Add('8 Unlimited');
  AvionicsList.Add('9 Unlimited');
  //sensors
  SensorsList.Add('0 None');
  SensorsList.Add('1 Close Range');
  SensorsList.Add('2 Short Range');
  SensorsList.Add('3 Medium Range');
  SensorsList.Add('4 Long Range');
  SensorsList.Add('5 Very Long Range');
  SensorsList.Add('6 Extreme Range');
  SensorsList.Add('7 System Wide');
  SensorsList.Add('8 1 Parsec');
  SensorsList.Add('9 2 Parsecs');
  //comms
  CommsList.Add('0 None');
  CommsList.Add('1 Close Range');
  CommsList.Add('2 Short Range');
  CommsList.Add('3 Medium Range');
  CommsList.Add('4 Long Range');
  CommsList.Add('5 Very Long Range');
  CommsList.Add('6 Extreme Range');
  CommsList.Add('7 System Wide');
  CommsList.Add('8 System Wide');
  CommsList.Add('9 System Wide');
end;

procedure TR20AvionicsFrm.CompComboBxChange(Sender: TObject);
//update the other sensors depending on the computer

begin
   SetR20Combos;
end;

procedure TR20AvionicsFrm.RefitBakBridgeChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    BakBridgeRadGrp.Enabled := RefitBakBridgeChkBx.Checked;
    BakBridgeEdit.Enabled := RefitBakBridgeChkBx.Checked;
  end;
end;

procedure TR20AvionicsFrm.RefitBakCommsChkBxChange(Sender: TObject);
var
  iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakCommsChkBx do
    begin
      if (RefitBakCompChkBx.Checked) then iComp := SetCompValue(BakCompComboBx.Text[1])
          else iComp := Ship.Avionics.BakComp;
      BakCommsCombo.Enabled := Checked;
      RefitBakCommsEdit.Enabled := Checked;
      BakCommsEdit.Enabled := Checked;
      //CommsTypeRadGrp.Enabled := Checked;
      if (Checked) then
      begin
        RefitBakCommsEdit.Text := IntToStr(Ship.Avionics.BakCommsRefitTech);
        FillCommsCombo(BakCommsCombo, StrToInt(RefitBakCommsEdit.Text), iComp);
        BakCommsCombo.ItemIndex := Ship.Avionics.NewBakComms;
        BakCommsEdit.Text := IntToStr(Ship.Avionics.BakCommsNum);
        //SetCommsType(StrToInt(RefitBakCommsEdit.Text), Ship.Avionics.NewCommsType)
      end
      else
      begin
        RefitBakCommsEdit.Text := '0';
        FillCommsCombo(BakCommsCombo, Ship.TechLevel, iComp);
        CommsCombo.ItemIndex := 0;
        BakCommsEdit.Text := '0';
        //SetCommsType(Ship.TechLevel, Ship.Avionics.CommsType)
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakCommsEditChange(Sender: TObject);
var
  iMark, iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitBakCommsEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Backup Comms Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.BakCommsRefitTech);
        Exit;
      end;
      iMark := BakCommsCombo.ItemIndex;
      if (RefitBakCompChkBx.Checked) then iComp := SetCompValue(BakCompComboBx.Text[1])
          else iComp := Ship.Avionics.BakComp;
      FillCommsCombo(BakCommsCombo, StrToInt(Text), iComp);
      BakCommsCombo.ItemIndex := iMark;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakCompChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakCompChkBx do
    begin
      BakCompComboBx.Enabled := Checked;
      BakCompEdit.Enabled := Checked;
      RefitBakCompEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitBakCompEdit.Text := IntToStr(Ship.Avionics.BakCompRefitTech);
        FillComputerCombo(BakCompComboBx, StrToInt(RefitBakCompEdit.Text));
        BakCompComboBx.ItemIndex := Ship.Avionics.NewBakComp;
        BakCompEdit.Text := IntToStr(Ship.Avionics.BakCompNum);
      end
      else
      begin
        RefitBakCompEdit.Text := '0';
        FillComputerCombo(BakCompComboBx, Ship.TechLevel);
        BakCompComboBx.ItemIndex := 0;
        BakCompEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakCompEditChange(Sender: TObject);
var
  iMark: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitBakCompEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Backup Computer Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.BakCompRefitTech);
        Exit;
      end;
      iMark := BakCompComboBx.ItemIndex;
      FillComputerCombo(BakCompComboBx, StrToInt(Text));
      BakCompComboBx.ItemIndex := iMark;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakFltAviChkBxChange(Sender: TObject);
var
  iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakFltAviChkBx do
    begin
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(BakCompComboBx.Text[1])
          else iComp := Ship.Avionics.BakComp;
      BakFltAviCombo.Enabled := Checked;
      BakFltAviEdit.Enabled := Checked;
      RefitBakFltAviEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitBakFltAviEdit.Text := IntToStr(Ship.Avionics.BakFltAvionicsRefitTech);
        FillAvionicsCombo(BakFltAviCombo, StrToInt(RefitBakFltAviEdit.Text), iComp);
        BakFltAviCombo.ItemIndex := Ship.Avionics.NewBakFltAvionics;
        BakFltAviEdit.Text := IntToStr(Ship.Avionics.BakFltAvionicsNum);
      end
      else
      begin
        RefitBakFltAviEdit.Text := '0';
        FillAvionicsCombo(BakFltAviCombo, Ship.TechLevel, iComp);
        BakFltAviCombo.ItemIndex := 0;
        BakFltAviEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakFltAviEditChange(Sender: TObject);
var
  iMark, iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitBakFltAviEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Backup Flight Avionics Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.BakFltAvionicsRefitTech);
        Exit;
      end;
      iMark := BakFltAviCombo.ItemIndex;
      if (RefitBakCompChkBx.Checked) then iComp := SetCompValue(BakCompComboBx.Text[1])
          else iComp := Ship.Avionics.BakComp;
      FillAvionicsCombo(BakFltAviCombo, StrToInt(Text), iComp);
      BakFltAviCombo.ItemIndex := iMark;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakSensorsChkBxChange(Sender: TObject);
var
  iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakSensorsChkBx do
    begin
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(BakCompComboBx.Text[1])
          else iComp := Ship.Avionics.BakComp;
      BakSensorsCombo.Enabled := Checked;
      BakSensorsEdit.Enabled := Checked;
      RefitBakSensorsEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitBakSensorsEdit.Text := IntToStr(Ship.Avionics.BakSensorsRefitTech);
        FillSensorsCombo(BakSensorsCombo, StrToInt(RefitBakSensorsEdit.Text), iComp);
        BakSensorsCombo.ItemIndex := Ship.Avionics.NewBakSensors;
        BakSensorsEdit.Text := IntToStr(Ship.Avionics.BakSensorsNum);
      end
      else
      begin
        RefitBakSensorsEdit.Text := '0';
        FillSensorsCombo(BakSensorsCombo, Ship.TechLevel, iComp);
        BakSensorsCombo.ItemIndex := 0;
        BakSensorsEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBakSensorsEditChange(Sender: TObject);
var
  iMark, iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitBakSensorsEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Backup Sensors Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.BakSensorsRefitTech);
        Exit;
      end;
      iMark := BakSensorsCombo.ItemIndex;
      if (RefitBakCompChkBx.Checked) then iComp := SetCompValue(BakCompComboBx.Text[1])
          else iComp := Ship.Avionics.BakComp;
      FillSensorsCombo(BakSensorsCombo, StrToInt(Text), iComp);
      BakSensorsCombo.ItemIndex := iMark;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitBridgeChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) and (Ship.Tonnage < 100) then
  begin
    BridgeRadGrp.Enabled := RefitBridgeChkBx.Checked;
  end;
end;

procedure TR20AvionicsFrm.RefitCommsChkBxChange(Sender: TObject);
var
  iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with RefitCommsChkBx do
    begin
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(CompComboBx.Text[1])
          else iComp := Ship.Avionics.MainComp;
      CommsCombo.Enabled := Checked;
      RefitCommsEdit.Enabled := Checked;
      CommsTypeRadGrp.Enabled := Checked;
      if (Checked) then
      begin
        RefitCommsEdit.Text := IntToStr(Ship.Avionics.CommsRefitTech);
        FillCommsCombo(CommsCombo, StrToInt(RefitCommsEdit.Text), iComp);
        CommsCombo.ItemIndex := Ship.Avionics.NewComms;
        SetCommsType(StrToInt(RefitCommsEdit.Text), Ship.Avionics.NewCommsType)
      end
      else
      begin
        RefitCommsEdit.Text := '0';
        FillCommsCombo(CommsCombo, Ship.TechLevel, iComp);
        CommsCombo.ItemIndex := 0;
        SetCommsType(Ship.TechLevel, Ship.Avionics.CommsType)
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitCommsEditChange(Sender: TObject);
var
  iMark, iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitCommsEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Comms Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.CommsRefitTech);
        Exit;
      end;
      iMark := CommsCombo.ItemIndex;
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(CompComboBx.Text[1])
          else iComp := Ship.Avionics.MainComp;
      FillCommsCombo(CommsCombo, StrToInt(Text), iComp);
      CommsCombo.ItemIndex := iMark;
      SetCommsType(StrToInt(Text), CommsTypeRadGrp.ItemIndex);
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitCompChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitCompChkBx do
    begin
      CompComboBx.Enabled := Checked;
      RefitCompEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitCompEdit.Text := IntToStr(Ship.Avionics.CompRefitTech);
        FillComputerCombo(CompComboBx, StrToInt(RefitCompEdit.Text));
        CompComboBx.ItemIndex := Ship.Avionics.NewComp;
      end
      else
      begin
        RefitCompEdit.Text := '0';
        FillComputerCombo(CompComboBx, Ship.TechLevel);
        CompComboBx.ItemIndex := 0;
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitCompEditChange(Sender: TObject);
var
  iMark: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitCompEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Computer Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.CompRefitTech);
        Exit;
      end;
      iMark := CompComboBx.ItemIndex;
      FillComputerCombo(CompComboBx, StrToInt(Text));
      CompComboBx.ItemIndex := iMark;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitFlagBridgeChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    FlagBridgeChkBx.Enabled := RefitFlagBridgeChkBx.Checked;
  end;
end;

procedure TR20AvionicsFrm.RefitFltAviChkBxChange(Sender: TObject);
var
  iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with RefitFltAviChkBx do
    begin
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(CompComboBx.Text[1])
          else iComp := Ship.Avionics.MainComp;
      FltAviCombo.Enabled := Checked;
      RefitFltAviEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitFltAviEdit.Text := IntToStr(Ship.Avionics.FltAvionicsRefitTech);
        FillAvionicsCombo(FltAviCombo, StrToInt(RefitFltAviEdit.Text), iComp);
        FltAviCombo.ItemIndex := Ship.Avionics.NewFltAvionics;
      end
      else
      begin
        RefitFltAviEdit.Text := '0';
        FillAvionicsCombo(FltAviCombo, Ship.TechLevel, iComp);
        FltAviCombo.ItemIndex := 0;
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitFltAviEditChange(Sender: TObject);
var
  iMark, iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitFltAviEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Flight Avionics Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.FltAvionicsRefitTech);
        Exit;
      end;
      iMark := FltAviCombo.ItemIndex;
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(CompComboBx.Text[1])
          else iComp := Ship.Avionics.MainComp;
      FillAvionicsCombo(FltAviCombo, StrToInt(Text), iComp);
      FltAviCombo.ItemIndex := iMark;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitSensorsChkBxChange(Sender: TObject);
var
  iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with RefitSensorsChkBx do
    begin
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(CompComboBx.Text[1])
          else iComp := Ship.Avionics.MainComp;
      SensorsCombo.Enabled := Checked;
      RefitSensorsEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitSensorsEdit.Text := IntToStr(Ship.Avionics.SensorsRefitTech);
        FillSensorsCombo(SensorsCombo, StrToInt(RefitSensorsEdit.Text), iComp);
        SensorsCombo.ItemIndex := Ship.Avionics.NewSensors;
      end
      else
      begin
        RefitSensorsEdit.Text := '0';
        FillSensorsCombo(SensorsCombo, Ship.TechLevel, iComp);
        SensorsCombo.ItemIndex := 0;
      end;
    end;
  end;
end;

procedure TR20AvionicsFrm.RefitSensorsEditChange(Sender: TObject);
var
  iMark, iComp: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitSensorsEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Sensors Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.SensorsRefitTech);
        Exit;
      end;
      iMark := SensorsCombo.ItemIndex;
      if (RefitCompChkBx.Checked) then iComp := SetCompValue(CompComboBx.Text[1])
          else iComp := Ship.Avionics.MainComp;
      FillSensorsCombo(SensorsCombo, StrToInt(Text), iComp);
      SensorsCombo.ItemIndex := iMark;
    end;
  end;
end;

end.
