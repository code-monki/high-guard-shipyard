unit AvionicsFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShipPas, DataPas, Math, DesAssistFrmPas,
  HgsFormFrm;

type
  TComputerSet = set of 0..20;

  { TAvionicsFrm }

  TAvionicsFrm = class(THgsForm)
    RefitFlagCompEdit: TEdit;
    RefitFlagCompChkBx: TCheckBox;
    FlagCompComboBx: TComboBox;
    BridgeRadGrp: TRadioGroup;
    BakCompEdit: TEdit;
    BakBridgeRadGrp: TRadioGroup;
    BakBridgeEdit: TEdit;
    FlagBridgeChkBx: TCheckBox;
    CompComboBx: TComboBox;
    BakCompComboBx: TComboBox;
    FlagCompLbl: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    CompStatLbl: TLabel;
    BakCompStatLbl: TLabel;
    NumberStatLbl: TLabel;
    RefitCompChkBx: TCheckBox;
    RefitBakCompChkBx: TCheckBox;
    RefitBakBridgeChkBx: TCheckBox;
    RefitTechStatLbl: TLabel;
    RefitCompEdit: TEdit;
    RefitBakCompEdit: TEdit;
    ModelStatLbl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure BakCompComboBxChange(Sender: TObject);
    procedure BakBridgeRadGrpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RefitBakBridgeChkBxChange(Sender: TObject);
    procedure RefitBakCompChkBxChange(Sender: TObject);
    procedure RefitBakCompEditChange(Sender: TObject);
    procedure RefitCompChkBxChange(Sender: TObject);
    procedure RefitCompEditChange(Sender: TObject);
    procedure RefitFlagCompChkBxChange(Sender: TObject);
    procedure RefitFlagCompEditChange(Sender: TObject);
  private
    { Private declarations }
    function SetCompValue(Comp : Char) : integer;
    function GenerateAvionicsDetails : String;
    function IsSmallCraftComp(CompValue : Integer) : Boolean;
    function Warn (TheMessage: String) : Boolean;
    function TrapErrors : Boolean;
    function NoValues: Boolean;
    function InvalidNumbers: Boolean;
    function NegativeValues: Boolean;
    function InsufficentJumpComputer: Boolean;
    function InsufficentSizeComputer: Boolean;
    function BridgeError: Boolean;
    procedure SendRefitItems;
    procedure SendNonRefitItems;
    procedure SetRefitData;
    procedure SetNonRefitData;
    procedure SetFlagOptions;
    procedure SetRefitOptions;
    procedure FillComputerCombo(TheCombo: TComboBox; TechLevel: Integer);
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  AvionicsFrm: TAvionicsFrm;
  Data: TData;
implementation

uses MainPas;

{$R *.lfm}

{ TAvionicsFrm }

procedure TAvionicsFrm.FormCreate(Sender: TObject);
//create the form and fill it with values from ship

begin
  Data := TData.Create;
  try
    Data.InitialiseData;
    FillComputerCombo(CompComboBx, Ship.TechLevel);
    FillComputerCombo(BakCompComboBx, Ship.TechLevel);
    FillComputerCombo(FlagCompComboBx, Ship.TechLevel);
    SetFlagOptions;
    SetRefitOptions;
    if (Ship.IsRefitted) then
    begin
      SetRefitData;
    end
    else
    begin
      SetNonRefitData;
    end;

    if (Ship.Tonnage >= 100) then
    begin
      BridgeRadGrp.ItemIndex := 0;
      BridgeRadGrp.Enabled := False;
    end;
  finally
    //Data.Free;
  end;
end;

procedure TAvionicsFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//clean up and close the form

begin
   FreeAndNil(Data);
   Action := caFree;
end;

procedure TAvionicsFrm.OKBtnClick(Sender: TObject);
//check for errors and if okay send the form values to the ship

begin
  if (TrapErrors) then
  begin
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    SendRefitItems;
  end
  else
  begin
    SendNonRefitItems;
  end;
  Ship.DesignShip;
  MainFrm.RefreshForm;
  Ship.HasChanged := True;
  MainFrm.SaveMenuItem.Enabled := True;
  MainFrm.RestoreMenuItem.Enabled := True;
  Close;
end;

procedure TAvionicsFrm.CancelBtnClick(Sender: TObject);
//close the form with out applying the changes

begin
   Close;
end;

function TAvionicsFrm.SetCompValue(Comp: Char): integer;
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

function TAvionicsFrm.TrapErrors: Boolean;
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

function TAvionicsFrm.NoValues: Boolean;
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
  if (RefitFlagCompEdit.Text = '') then
  begin
    MessageDlg('No TL for Flag Computer Refit Entered (This may be Zero)', mtError, [mbOk], 0);
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

function TAvionicsFrm.InvalidNumbers: Boolean;
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
  if (StrToIntDef(RefitFlagCompEdit.Text, 3) = 3) and (StrToIntDef(RefitFlagCompEdit.Text, 2) = 2) then
  begin
    MessageDlg('TL for Flag Computer Refit must be an Integer Value (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
end;

function TAvionicsFrm.NegativeValues: Boolean;
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
  if (StrToInt(RefitFlagCompEdit.Text) < 0) then
  begin
    MessageDlg('TL for Flag Computer Refit may not be less than Zero', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
end;

function TAvionicsFrm.InsufficentJumpComputer: Boolean;
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

function TAvionicsFrm.InsufficentSizeComputer: Boolean;
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

function TAvionicsFrm.BridgeError: Boolean;
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

procedure TAvionicsFrm.SendRefitItems;
begin
  Ship.Avionics.RefitComp := RefitCompChkBx.Checked;
  Ship.Avionics.RefitBakComp := RefitBakCompChkBx.Checked;
  Ship.Avionics.RefitFlagComp := RefitFlagCompChkBx.Checked;
  if (BridgeRadGrp.ItemIndex <> Ship.Avionics.Bridge) then
  begin
    Ship.Avionics.RefitBridge := True;
  end
  else
  begin
    Ship.Avionics.RefitBridge := False;
  end;
  Ship.Avionics.RefitBakBridge := RefitBakBridgeChkBx.Checked;
  if (FlagBridgeChkBx.Checked <> Ship.Avionics.FlagBridge) then
  begin
    Ship.Avionics.RefitFlagBridge := True;
  end
  else
  begin
    Ship.Avionics.RefitFlagBridge := False;
  end;
  //values
  Ship.Avionics.NewComp := SetCompValue(CompComboBx.Text[1]);
  Ship.Avionics.NewBakComp := SetCompValue(BakCompComboBx.Text[1]);
  Ship.Avionics.Bridge := BridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridge := BakBridgeRadGrp.ItemIndex;
  Ship.Avionics.FlagBridge := FlagBridgeChkBx.Checked;
  Ship.Avionics.NewFlagComp := SetCompValue(FlagCompComboBx.Text[1]);
  //tech
  Ship.Avionics.CompRefitTech := StrToInt(RefitCompEdit.Text);
  Ship.Avionics.BakCompRefitTech := StrToInt(RefitBakCompEdit.Text);
  Ship.Avionics.FlagCompRefitTech := StrToInt(RefitFlagCompEdit.Text);
  //numbers
  Ship.Avionics.NewBakCompNum := StrToInt(BakCompEdit.Text);
  Ship.Avionics.NewBakBridgeNum := StrToInt(BakBridgeEdit.Text);
end;

procedure TAvionicsFrm.SendNonRefitItems;
begin
  Ship.Avionics.MainComp := SetCompValue(CompComboBx.Text[1]);
  Ship.Avionics.BakComp := SetCompValue(BakCompComboBx.Text[1]);
  Ship.Avionics.BakCompNum := StrToInt(BakCompEdit.Text);
  Ship.Avionics.Bridge := BridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridge := BakBridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridgeNum := StrToInt(BakBridgeEdit.Text);
  Ship.Avionics.FlagBridge := FlagBridgeChkBx.Checked;
  Ship.Avionics.FlagComp := SetCompValue(FlagCompComboBx.Text[1]);
  Ship.Avionics.RefitComp := False;
  Ship.Avionics.RefitBakComp := False;
  Ship.Avionics.RefitFlagComp := False;
  Ship.Avionics.RefitBridge := False;
  Ship.Avionics.RefitBakBridge := False;
  Ship.Avionics.RefitFlagBridge := False;
  //values
  Ship.Avionics.NewComp := 0;
  Ship.Avionics.NewBakComp := 0;
  Ship.Avionics.Bridge := BridgeRadGrp.ItemIndex;
  Ship.Avionics.BakBridge := BakBridgeRadGrp.ItemIndex;
  Ship.Avionics.NewFlagComp := 0;
  //tech
  Ship.Avionics.CompRefitTech := 0;
  Ship.Avionics.BakCompRefitTech := 0;
  Ship.Avionics.FlagCompRefitTech := 0;
  //numbers
  Ship.Avionics.NewBakCompNum := 0;
  Ship.Avionics.NewBakBridgeNum := 0;
end;

procedure TAvionicsFrm.SetRefitData;
begin
  RefitCompChkBx.Checked := Ship.Avionics.RefitComp;
  RefitBakCompChkBx.Checked := Ship.Avionics.RefitBakComp;
  RefitFlagCompChkBx.Checked := Ship.Avionics.RefitFlagComp;
  CompComboBx.Text := Data.GetComputerData(7, Ship.Avionics.NewComp);
  BakCompComboBx.Text := Data.GetComputerData(7, Ship.Avionics.NewBakComp);
  FlagCompComboBx.Text := Data.GetComputerData(7, Ship.Avionics.NewFlagComp);
  BakCompEdit.Text := IntToStr(Ship.Avionics.NewBakCompNum);
  BridgeRadGrp.ItemIndex := Ship.Avionics.Bridge;
  BakBridgeRadGrp.ItemIndex := Ship.Avionics.BakBridge;
  BakBridgeEdit.Text := IntToStr(Ship.Avionics.NewBakBridgeNum);
  RefitBakBridgeChkBx.Checked := Ship.Avionics.RefitBakBridge;
  FlagBridgeChkBx.Checked := Ship.Avionics.FlagBridge;
  RefitCompEdit.Text := IntToStr(Ship.Avionics.CompRefitTech);
  RefitBakCompEdit.Text := IntToStr(Ship.Avionics.BakCompRefitTech);
  RefitFlagCompEdit.Text := IntToStr(Ship.Avionics.FlagCompRefitTech);
end;

procedure TAvionicsFrm.SetNonRefitData;
begin
  CompComboBx.Text := Data.GetComputerData(7, Ship.Avionics.MainComp);
  BakCompComboBx.Text := Data.GetComputerData(7, Ship.Avionics.BakComp);
  FlagCompComboBx.Text := Data.GetComputerData(7, Ship.Avionics.FlagComp);
  BakCompEdit.Text := IntToStr(Ship.Avionics.BakCompNum);
  BridgeRadGrp.ItemIndex := Ship.Avionics.Bridge;
  BakBridgeRadGrp.ItemIndex := Ship.Avionics.BakBridge;
  BakBridgeEdit.Text := IntToStr(Ship.Avionics.BakBridgeNum);
  FlagBridgeChkBx.Checked := Ship.Avionics.FlagBridge;
end;

procedure TAvionicsFrm.SetFlagOptions;
begin
  FlagBridgeChkBx.Enabled:= Ship.Flagship;
  FlagBridgeChkBx.Visible := Ship.Flagship;
  FlagCompLbl.Visible := Ship.Flagship;
  FlagCompComboBx.Enabled := Ship.Flagship;
  FlagCompComboBx.Visible := Ship.Flagship;
  RefitFlagCompChkBx.Enabled:= Ship.Flagship;
  RefitFlagCompChkBx.Visible := Ship.Flagship;
  RefitFlagCompEdit.Enabled:= Ship.Flagship;
  RefitFlagCompEdit.Visible := Ship.Flagship;
end;

procedure TAvionicsFrm.SetRefitOptions;
var
  iMark: Integer;
begin
  RefitTechStatLbl.Visible := Ship.IsRefitted;
  //main computer
  RefitCompChkBx.Enabled := Ship.IsRefitted;
  RefitCompChkBx.Visible := Ship.IsRefitted;
  RefitCompEdit.Enabled := Ship.Avionics.RefitComp;
  RefitCompEdit.Visible := Ship.IsRefitted;
  if (Ship.IsRefitted) then
  begin
    CompComboBx.Enabled := Ship.Avionics.RefitComp;
  end;
  //backkup computer
  RefitBakCompChkBx.Enabled := Ship.IsRefitted;
  RefitBakCompChkBx.Visible := Ship.IsRefitted;
  RefitBakCompEdit.Enabled := Ship.Avionics.RefitBakComp;
  RefitBakCompEdit.Visible := Ship.IsRefitted;
  if (Ship.IsRefitted) then
  begin
    BakCompComboBx.Enabled := Ship.Avionics.RefitBakComp;
    BakCompEdit.Enabled := Ship.Avionics.RefitBakComp;
  end;
  //backup bridge
  RefitBakBridgeChkBx.Enabled := Ship.IsRefitted;
  RefitBakBridgeChkBx.Visible := Ship.IsRefitted;
  if (Ship.IsRefitted) then
  begin
    BakBridgeEdit.Enabled := Ship.Avionics.RefitBakBridge;
    BakBridgeRadGrp.Enabled := Ship.Avionics.RefitBakBridge;
  end;
  //flag computer
  if (Ship.Flagship) then
  begin
    RefitFlagCompChkBx.Enabled := Ship.IsRefitted;
    RefitFlagCompChkBx.Visible := Ship.IsRefitted;
    RefitFlagCompEdit.Enabled := Ship.Avionics.RefitFlagComp;
    RefitFlagCompEdit.Visible := Ship.IsRefitted;
    if (Ship.IsRefitted) then
    begin
      FlagCompComboBx.Enabled := Ship.Avionics.RefitFlagComp;
    end;
  end;
  //captions
  if (Ship.IsRefitted) then
  begin
    CompStatLbl.Caption := 'Comp Model/' + Data.GetComputerData(7, Ship.Avionics.MainComp)[1];
    BakCompStatLbl.Caption := 'Bak Comp ' + IntToStr(Ship.Avionics.BakCompNum) + ' x Mod/'
        + Data.GetComputerData(7, Ship.Avionics.BakComp)[1];
    FlagCompLbl.Caption := 'Flag Comp Model/' + Data.GetComputerData(7, Ship.Avionics.FlagComp)[1];
  end;
end;

procedure TAvionicsFrm.FillComputerCombo(TheCombo: TComboBox; TechLevel: Integer);
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

procedure TAvionicsFrm.BakCompComboBxChange(Sender: TObject);
//if the bak comp is not set to none, get the number of bak comps from the ship
//if the bak comp is set to none, set the number of bak comps to zero

begin
   if (BakCompComboBx.Text = '') then begin
      abort;
   end;
   if (SetCompValue(BakCompComboBx.Text[1]) > 0) then begin
      if (StrToInt(BakCompEdit.Text) = 0) then begin
         BakCompEdit.Text := IntToStr(Max(1, Ship.Avionics.BakCompNum));
      end;
   end
   else if (SetCompValue(BakCompComboBx.Text[1]) = 0) then begin
      BakCompEdit.Text := '0';
   end;
end;

procedure TAvionicsFrm.BakBridgeRadGrpClick(Sender: TObject);
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

procedure TAvionicsFrm.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TAvionicsFrm.RefitBakBridgeChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakBridgeChkBx do
    begin
      BakBridgeRadGrp.Enabled := Checked;
      BakBridgeEdit.Enabled := Checked;
      if (Checked) then
      begin
        BakBridgeRadGrp.ItemIndex := Ship.Avionics.BakBridge;
        BakBridgeEdit.Text := IntToStr(Ship.Avionics.NewBakBridgeNum);
      end
      else
      begin
        BakBridgeRadGrp.ItemIndex := Ship.Avionics.BakBridge;
        BakBridgeEdit.Text := IntToStr(Ship.Avionics.BakBridgeNum);
      end;
    end;
  end;
end;

procedure TAvionicsFrm.RefitBakCompChkBxChange(Sender: TObject);
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

procedure TAvionicsFrm.RefitBakCompEditChange(Sender: TObject);
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

procedure TAvionicsFrm.RefitCompChkBxChange(Sender: TObject);
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

procedure TAvionicsFrm.RefitCompEditChange(Sender: TObject);
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

procedure TAvionicsFrm.RefitFlagCompChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitFlagCompChkBx do
    begin
      FlagCompComboBx.Enabled := Checked;
      RefitFlagCompEdit.Enabled := Checked;
      if (Checked) then
      begin
        RefitFlagCompEdit.Text := IntToStr(Ship.Avionics.FlagCompRefitTech);
        FillComputerCombo(FlagCompComboBx, StrToInt(RefitFlagCompEdit.Text));
        FlagCompComboBx.ItemIndex := Ship.Avionics.NewFlagComp;
      end
      else
      begin
        RefitFlagCompEdit.Text := '0';
        FillComputerCombo(FlagCompComboBx, Ship.TechLevel);
        FlagCompComboBx.ItemIndex := 0;
      end;
    end;
  end;
end;

procedure TAvionicsFrm.RefitFlagCompEditChange(Sender: TObject);
var
  iMark: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitFlagCompEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Flag Computer Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.Avionics.FlagCompRefitTech);
        Exit;
      end;
      iMark := FlagCompComboBx.ItemIndex;
      FillComputerCombo(FlagCompComboBx, StrToInt(Text));
      FlagCompComboBx.ItemIndex := iMark;
    end;
  end;
end;

function TAvionicsFrm.GenerateAvionicsDetails: String;
//generate avionics file data

begin
   Result := IntToStr(SetCompValue(CompComboBx.Text[1]))
         + SEP + IntToStr(SetCompValue(BakCompComboBx.Text[1]))
         + SEP + BakCompEdit.Text
         + SEP + IntToStr(BridgeRadGrp.ItemIndex)
         + SEP + IntToStr(BakBridgeRadGrp.ItemIndex)
         + SEP + BakBridgeEdit.Text
         + SEP + IntToStr(Ship.Avionics.FltAvionics)
         + SEP + IntToStr(Ship.Avionics.BakFltAvionics)
         + SEP + IntToStr(Ship.Avionics.BakFltAvionicsNum)
         + SEP + IntToStr(Ship.Avionics.Sensors)
         + SEP + IntToStr(Ship.Avionics.BakSensors)
         + SEP + IntToStr(Ship.Avionics.BakSensorsNum)
         + SEP + IntToStr(Ship.Avionics.Comms)
         + SEP + IntToStr(Ship.Avionics.BakComms)
         + SEP + IntToStr(Ship.Avionics.BakCommsNum)
         + SEP + IntToStr(Ship.Avionics.CommsType)
         + SEP + IntToStr(Ship.Avionics.CommsType)
         + SEP + BoolToStr(FlagBridgeChkBx.Checked)
         + SEP + IntToStr(SetCompValue(FlagCompComboBx.Text[1]))
         + SEP + BoolToStr(Ship.Avionics.RefitBridge)
         + SEP + BoolToStr(RefitBakBridgeChkBx.Checked)     //19
         + SEP + BoolToStr(RefitCompChkBx.Checked)          //20
         + SEP + BoolToStr(RefitBakCompChkBx.Checked)       //21
         + SEP + BoolToStr(RefitFlagCompChkBx.Checked)      //22
         + SEP + BoolToStr(Ship.Avionics.RefitFltAvionics)       //23
         + SEP + BoolToStr(Ship.Avionics.RefitBakFltAvionics)    //24
         + SEP + BoolToStr(Ship.Avionics.RefitSensors)           //25
         + SEP + BoolToStr(Ship.Avionics.RefitBakSensors)        //26
         + SEP + BoolToStr(Ship.Avionics.RefitComms)             //27
         + SEP + BoolToStr(Ship.Avionics.RefitBakComms)          //28
         + SEP + RefitCompEdit.Text                         //29
         + SEP + RefitBakCompEdit.Text                      //30
         + SEP + RefitFlagCompEdit.Text                     //31
         + SEP + IntToStr(Ship.Avionics.FltAvionicsRefitTech)    //32
         + SEP + IntToStr(Ship.Avionics.BakFltAvionicsRefitTech) //33
         + SEP + IntToStr(Ship.Avionics.SensorsRefitTech)        //34
         + SEP + IntToStr(Ship.Avionics.BakSensorsRefitTech)     //35
         + SEP + IntToStr(Ship.Avionics.CommsRefitTech)          //36
         + SEP + IntToStr(Ship.Avionics.BakCommsRefitTech)       //37
         + SEP + IntToStr(SetCompValue(CompComboBx.Text[1]))//38
         + SEP + IntToStr(SetCompValue(BakCompComboBx.Text[1]))//39
         + SEP + IntToStr(SetCompValue(FlagCompComboBx.Text[1]))             //40
         + SEP + IntToStr(Ship.Avionics.NewFltAvionics)          //41
         + SEP + IntToStr(Ship.Avionics.NewBakFltAvionics)       //42
         + SEP + IntToStr(Ship.Avionics.NewSensors)              //43
         + SEP + IntToStr(Ship.Avionics.NewBakSensors)           //44
         + SEP + IntToStr(Ship.Avionics.NewComms)                //45
         + SEP + IntToStr(Ship.Avionics.NewBakComms)             //46
         + SEP + BakBridgeEdit.Text                         //47
         + SEP + BakCompEdit.Text                           //48
         + SEP + IntToStr(Ship.Avionics.NewBakFltAvionicsNum)    //49
         + SEP + IntToStr(Ship.Avionics.NewBakSensorsNum)        //50
         + SEP + IntToStr(Ship.Avionics.NewBakCommsNum)          //51
         + SEP + IntToStr(Ship.Avionics.NewCommsType)            //52
         + SEP + BoolToStr(Ship.Avionics.RefitCommsType)         //53
         + SEP + IntToStr(Ship.Avionics.CommsTypeRefitTech)      //54
         + SEP + BoolToStr(Ship.Avionics.RefitFlagBridge)        //55
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         + SEP + '0'
         ; //terminator
end;

function TAvionicsFrm.IsSmallCraftComp(CompValue: Integer): Boolean;
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

function TAvionicsFrm.Warn(TheMessage: String): Boolean;
//display a warning message and get a yes no answer

begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

end.
