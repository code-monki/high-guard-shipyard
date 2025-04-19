unit LittleBaysFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShipPas, DesAssistFrmPas;

type

  { TLittleBaysFrm }

  TLittleBaysFrm = class(TForm)
    RefitEmptyChkBx: TCheckBox;
    RefitMesonChkBx: TCheckBox;
    RefitPaChkBx: TCheckBox;
    RefitRepulsorChkBx: TCheckBox;
    RefitMissileChkBx: TCheckBox;
    RefitEnergyChkBx: TCheckBox;
    RefitMesonEdit: TEdit;
    RefitPaEdit: TEdit;
    RefitRepulsorEdit: TEdit;
    RefitMissileEdit: TEdit;
    RefitEnergyEdit: TEdit;
    NumStatLbl: TLabel;
    FactStatLbl: TLabel;
    EmptyStatLbl: TLabel;
    MesonStatLbl: TLabel;
    RefitPanel: TPanel;
    PAStatLbl: TLabel;
    RepulsStatLbl: TLabel;
    MissileStatLbl: TLabel;
    EmptyEdit: TEdit;
    MesonEdit: TEdit;
    PAEdit: TEdit;
    RepulsorEdit: TEdit;
    MissileEdit: TEdit;
    MesonLbl: TLabel;
    PAlbl: TLabel;
    RepulsLbl: TLabel;
    MissileLbl: TLabel;
    EnergyStatLbl: TLabel;
    EnergyEdit: TEdit;
    EnergyLbl: TLabel;
    EnergyRadGrp: TRadioGroup;
    OKBtn: TButton;
    CancelBtn: TButton;
    HardPointsLbl: TLabel;
    HardPointsStatLbl: TLabel;
    RefitTlStatLbl: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EmptyEditChange(Sender: TObject);
    procedure MesonEditChange(Sender: TObject);
    procedure PAEditChange(Sender: TObject);
    procedure RefitEmptyChkBxChange(Sender: TObject);
    procedure RefitEnergyChkBxChange(Sender: TObject);
    procedure RefitEnergyEditChange(Sender: TObject);
    procedure RefitMesonChkBxChange(Sender: TObject);
    procedure RefitMesonEditChange(Sender: TObject);
    procedure RefitMissileChkBxChange(Sender: TObject);
    procedure RefitMissileEditChange(Sender: TObject);
    procedure RefitPaChkBxChange(Sender: TObject);
    procedure RefitPaEditChange(Sender: TObject);
    procedure RefitRepulsorChkBxChange(Sender: TObject);
    procedure RefitRepulsorEditChange(Sender: TObject);
    procedure RepulsorEditChange(Sender: TObject);
    procedure MissileEditChange(Sender: TObject);
    procedure EnergyEditChange(Sender: TObject);
    procedure EnergyRadGrpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function TrapErrors : Boolean;
    function NoValues: Boolean;
    function InvalidValues: Boolean;
    function NegativeValues: Boolean;
    function CalcRemHardPoints : Integer;
    function Warn(TheMessage : String) : Boolean;
    function GenerateLittleBaysDetails : String;
    procedure SetBayFactors(TheTechLevel: Integer);
    procedure SetMesonBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetPaBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetRepulsorBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetMissileBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetEnergyBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure ForceRefits;
    procedure SetRefitData;
    procedure SetNonRefitData;
    procedure SendData;
    procedure DisableDuplicates;
    procedure DisableSpinals;
    procedure DisableBigBays;
    procedure DisableTurrets;
  public
    { Public declarations }
  end;

var
  LittleBaysFrm: TLittleBaysFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TLittleBaysFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
   Action := caFree;
end;

procedure TLittleBaysFrm.OKBtnClick(Sender: TObject);
//Trap errors and then send the form data to the ship

begin
   if (TrapErrors) then begin
      exit;
   end;
   SendData;
   Ship.DesignShip;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TLittleBaysFrm.CancelBtnClick(Sender: TObject);
//close the form without sending the data to the ship

begin
   Close;
end;

function TLittleBaysFrm.TrapErrors: Boolean;
//trap any errors

var
  BaseBayNum, FormBayNum: Integer;
begin
  Result := False;
  if (NoValues) then
  begin
    Result := True;
    Exit;
  end;
  if (InvalidValues) then
  begin
    Result := True;
    Exit;
  end;
  if (NegativeValues) then
  begin
    Result := True;
    Exit;
  end;

  with (Ship.LittleBays) do
  begin
    BaseBayNum := EmptyBays + MesonBays + PaBays + RepulsorBays + MissileBays + EnergyBays;
    FormBayNum := StrToInt(EmptyEdit.Text) + StrToInt(MesonEdit.Text) + StrToInt(PaEdit.Text)
        + StrToInt(RepulsorEdit.Text) + StrToInt(MissileEdit.Text) + StrToInt(EnergyEdit.Text);
  end;
  if (Ship.IsRefitted) then
  begin
    if (FormBayNum > BaseBayNum) then
    begin
      if (Warn('The number of bays may not be increased. Do you wish to change this')) then
      begin
        //MessageDlg('The number of bays may not be increased', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
    end;
    if (FormBayNum < BaseBayNum) then
    begin
      if (Warn('The number of bays may not be decreased. Do you wish to change this')) then
      begin
        //MessageDlg('The number of bays may not be decreased', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
    end;
  end
  else
  begin
    if (StrToInt(MesonEdit.Text) > 0) and (Ship.TechLevel < 15) then
    begin
      MessageDlg('Meson Bays are not permitted below Tech Level 13', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(PAEdit.Text) > 0) and (Ship.TechLevel < 10) then
    begin
      MessageDlg('Particle Accelerator Bays are not permitted below Tech Level 8', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(RepulsorEdit.Text) > 0) and (Ship.TechLevel < 10) then
    begin
      MessageDlg('Repulsor Bays are not permitted below Tech Level 10', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(MissileEdit.Text) > 0) and (Ship.TechLevel < 10) then begin
      MessageDlg('Missile Bays are not permitted below Tech Level 10', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(EnergyEdit.Text) > 0) and (EnergyRadGrp.ItemIndex = 0) and (Ship.TechLevel < 10) then begin
      MessageDlg('Plasma Gun Bays are not permitted below Tech Level 10', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(EnergyEdit.Text) > 0) and (EnergyRadGrp.ItemIndex = 1) and (Ship.TechLevel < 12) then begin
      MessageDlg('Fusion Gun Bays are not permitted below Tech Level 12', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
  if (CalcRemHardPoints < 0) then
  begin
    if (Warn('There are not enough hardpoints for the weapons installed, do you wish to alter these weapons?')) then begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(EmptyEdit.Text) > 0) and (Ship.TechLevel < 10) then begin
    if (MessageDlg('No 50T Bay weaponry is available below Tech Level 10',
        mtWarning, [mbOk, mbCancel], 0) = mrOk) then begin;
      Result := True;
      exit;
    end;
  end;
end;

function TLittleBaysFrm.NoValues: Boolean;
begin
  Result := False;
  if (EmptyEdit.Text = '') then
  begin
    MessageDlg('No Value for Empty Bays Entered (This may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (MesonEdit.Text = '') then
  begin
    MessageDlg('No Value for Meson Bays Entered (This may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (PAEdit.Text = '') then
  begin
    MessageDlg('No Value for Particle Accelerator Bays Entered (This may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RepulsorEdit.Text = '') then
  begin
    MessageDlg('No Value for Repulsor Bays Entered (This may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (MissileEdit.Text = '') then
  begin
    MessageDlg('No Value for Missile Bays Entered (This may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (EnergyEdit.Text = '') then
  begin
    MessageDlg('No Value for Energy Bays Entered (This may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    if (RefitMesonEdit.Text = '') then
    begin
      MessageDlg('No Value for Meson Bays Refit Tech Level Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (RefitPAEdit.Text = '') then
    begin
      MessageDlg('No Value for Particle Accelerator Bays Refit Tech Level Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (RefitRepulsorEdit.Text = '') then
    begin
      MessageDlg('No Value for Repulsor Bays Refit Tech Level Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (RefitMissileEdit.Text = '') then
    begin
      MessageDlg('No Value for Missile Bays Refit Tech Level Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (RefitEnergyEdit.Text = '') then
    begin
      MessageDlg('No Value for Energy Bays Refit Tech Level Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
end;

function TLittleBaysFrm.InvalidValues: Boolean;
begin
  Result := False;
  if (StrToIntDef(EmptyEdit.Text, 3) = 3) and (StrToIntDef(EmptyEdit.Text, 2) = 2) then
  begin
    MessageDlg('Empty Bays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(MesonEdit.Text, 3) = 3) and (StrToIntDef(MesonEdit.Text, 2) = 2) then
  begin
    MessageDlg('Meson Bays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(PAEdit.Text, 3) = 3) and (StrToIntDef(PAEdit.Text, 2) = 2) then
  begin
    MessageDlg('Particle Accelerator Bays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RepulsorEdit.Text, 3) = 3) and (StrToIntDef(RepulsorEdit.Text, 2) = 2) then
  begin
    MessageDlg('Repulsor Bays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(MissileEdit.Text, 3) = 3) and (StrToIntDef(MissileEdit.Text, 2) = 2) then
  begin
    MessageDlg('Missile Bays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(EnergyEdit.Text, 3) = 3) and (StrToIntDef(EnergyEdit.Text, 2) = 2) then
  begin
    MessageDlg('Energy Bays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    if (StrToIntDef(RefitMesonEdit.Text, 3) = 3) and (StrToIntDef(RefitMesonEdit.Text, 2) = 2) then
    begin
      MessageDlg('Meson Bays Refit TL must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToIntDef(RefitPAEdit.Text, 3) = 3) and (StrToIntDef(RefitPAEdit.Text, 2) = 2) then
    begin
      MessageDlg('Particle Accelerator Bays Refit TL must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToIntDef(RefitRepulsorEdit.Text, 3) = 3) and (StrToIntDef(RefitRepulsorEdit.Text, 2) = 2) then
    begin
      MessageDlg('Repulsor Bays Refit TL must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToIntDef(RefitMissileEdit.Text, 3) = 3) and (StrToIntDef(RefitMissileEdit.Text, 2) = 2) then
    begin
      MessageDlg('Missile Bays Refit TL must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToIntDef(RefitEnergyEdit.Text, 3) = 3) and (StrToIntDef(RefitEnergyEdit.Text, 2) = 2) then
    begin
      MessageDlg('Energy Bays Refit TL must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
end;

function TLittleBaysFrm.NegativeValues: Boolean;
begin
  Result := False;
  if (StrToInt(EmptyEdit.Text) < 0) then
  begin
    MessageDlg('Empty Bays may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(MesonEdit.Text) < 0) then
  begin
    MessageDlg('Meson Gun Bays may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(PAEdit.Text) < 0) then
  begin
    MessageDlg('Particle Accelerator Bays may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RepulsorEdit.Text) < 0) then
  begin
    MessageDlg('Repulsor Bays may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(MissileEdit.Text) < 0) then
  begin
    MessageDlg('Missile Bays may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(EnergyEdit.Text) < 0) then
  begin
    MessageDlg('Energy Bays may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    if (StrToInt(RefitMesonEdit.Text) < 0) then
    begin
      MessageDlg('Meson Gun Bays Refit TL may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(RefitPAEdit.Text) < 0) then
    begin
      MessageDlg('Particle Accelerator Bays Refit TL may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(RefitRepulsorEdit.Text) < 0) then
    begin
      MessageDlg('Repulsor Bays Refit TL may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(RefitMissileEdit.Text) < 0) then
    begin
      MessageDlg('Missile Bays Refit TL may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(RefitEnergyEdit.Text) < 0) then
    begin
      MessageDlg('Energy Bays Refit TL may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
end;

function TLittleBaysFrm.CalcRemHardPoints: Integer;
//calculate the number of hardpoints remaining based on the form data

var
  HardPoints : Integer;
  ExistingBays, FormBays : Integer;
begin
  HardPoints := Ship.GetRemHardPoints;
  if (Ship.IsRefitted) then
  begin
    FormBays := 0;
    if (RefitEmptyChkBx.Checked) then FormBays := FormBays + StrToInt(EmptyEdit.Text)
        else FormBays := FormBays + Ship.LittleBays.EmptyBays;
    if (RefitMesonChkBx.Checked) then FormBays := FormBays + StrToInt(MesonEdit.Text)
        else FormBays := FormBays + Ship.LittleBays.MesonBays;
    if (RefitPaChkBx.Checked) then FormBays := FormBays + StrToInt(PaEdit.Text)
        else FormBays := FormBays + Ship.LittleBays.PaBays;
    if (RefitRepulsorChkBx.Checked) then FormBays := FormBays + StrToInt(RepulsorEdit.Text)
        else FormBays := FormBays + Ship.LittleBays.RepulsorBays;
    if (RefitMissileChkBx.Checked) then FormBays := FormBays + StrToInt(MissileEdit.Text)
        else FormBays := FormBays + Ship.LittleBays.MissileBays;
    if (RefitEnergyChkBx.Checked) then FormBays := FormBays + StrToInt(EnergyEdit.Text)
        else FormBays := FormBays + Ship.LittleBays.EnergyBays;
  end
  else
  begin
    FormBays := StrToInt(EmptyEdit.Text) + StrToInt(MesonEdit.Text)
         + StrToInt(PAEdit.Text) + StrToInt(RepulsorEdit.Text)
         + StrToInt(MissileEdit.Text) + StrToInt(EnergyEdit.Text);
  end;
  ExistingBays := Ship.TotalLittleBays;
  Result := HardPoints + (ExistingBays * 10) - (FormBays * 10);
end;

procedure TLittleBaysFrm.FormCreate(Sender: TObject);
//create the form and fill it with data from the ship

begin
  RefitPanel.Caption := '';
  RefitPanel.Visible := Ship.IsRefitted;
  RefitPanel.Enabled := Ship.IsRefitted;
  if (Ship.IsRefitted) then
  begin
    RefitPanel.Left := RefitPanel.Left - 40;
    SetRefitData;
    with (Ship.LittleBays) do
    begin
      EmptyStatLbl.Caption := 'Empty ' + IntToStr(EmptyBays);
      MesonStatLbl.Caption := 'Meson ' + IntToStr(MesonBays) + ' @ ' + IntToStr(MesonFactor(Ship.TechLevel));
      PaStatLbl.Caption := 'PA ' + IntToStr(PaBays) + ' @ ' + IntToStr(PaFactor(Ship.TechLevel));
      RepulsStatLbl.Caption := 'Repulsor ' + IntToStr(RepulsorBays) + ' @ ' + IntToStr(RepulsorFactor(Ship.TechLevel));
      MissileStatLbl.Caption := 'Missile ' + IntToStr(MissileBays) + ' @ ' + IntToStr(MissileFactor(Ship.TechLevel));
      EnergyStatLbl.Caption := 'Energy ' + IntToStr(EnergyBays) + ' @ ' + IntToStr(EnergyFactor(Ship.TechLevel));
    end;
  end
  else
  begin
    SetNonRefitData;
    SetBayFactors(Ship.TechLevel);
  end;
  HardPointsLbl.Caption := IntToStr(CalcRemHardPoints);
  DisableDuplicates;
  ForceRefits;

(* this section removed to allow ship < 1000Td to have bays
   if (Ship.Tonnage < 1000) then begin
      EmptyEdit.Text := '0';
      EmptyEdit.Enabled := False;
      MesonLbl.Caption := '0';
      MesonEdit.Text := '0';
      MesonEdit.Enabled := False;
      PALbl.Caption := '0';
      PAEdit.Text := '0';
      PAEdit.Enabled := False;
      RepulsLbl.Caption := '0';
      RepulsorEdit.Text := '0';
      RepulsorEdit.Enabled := False;
      MissileLbl.Caption := '0';
      MissileEdit.Text := '0';
      MissileEdit.Enabled := False;
      EnergyLbl.Caption := '0';
      EnergyEdit.Text := '0';
      EnergyEdit.Enabled := False;
   end;
*)
end;

procedure TLittleBaysFrm.EmptyEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (EmptyEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TLittleBaysFrm.MesonEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (MesonEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TLittleBaysFrm.PAEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (PAEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TLittleBaysFrm.RefitEmptyChkBxChange(Sender: TObject);
begin
  with (RefitEmptyChkBx) do
  begin
    if (Checked) then
    begin
      EmptyEdit.Text := IntToStr(Ship.LittleBays.NewEmptyBays);
    end
    else
    begin
      EmptyEdit.Text := '0';
    end;
    EmptyEdit.Enabled := Checked;
  end;
end;

procedure TLittleBaysFrm.RefitEnergyChkBxChange(Sender: TObject);
begin
  with (RefitEnergyChkBx) do
  begin
    if (Checked) then
    begin
      RefitEnergyEdit.Text := IntToStr(Ship.LittleBays.EnergyBaysRefitTech);
      EnergyRadGrp.ItemIndex := Ship.LittleBays.NewEnergyType;
    end
    else
    begin
      RefitEnergyEdit.Text := '0';
      EnergyRadGrp.ItemIndex := Ship.LittleBays.EnergyType;
    end;
    RefitEnergyEdit.Enabled := Checked;
    EnergyRadGrp.Enabled := Checked;
  end;
end;

procedure TLittleBaysFrm.RefitEnergyEditChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitEnergyEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Energy Bay Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.LittleBays.EnergyBaysRefitTech);
        Exit;
      end;
      SetEnergyBayFactors(StrToInt(Text), RefitEnergyChkBx.Checked);
    end;
  end;
end;

procedure TLittleBaysFrm.RefitMesonChkBxChange(Sender: TObject);
begin
  with (RefitMesonChkBx) do
  begin
    if (Checked) then
    begin
      RefitMesonEdit.Text := IntToStr(Ship.LittleBays.MesonBaysRefitTech);
    end
    else
    begin
      RefitMesonEdit.Text := '0';
    end;
    RefitMesonEdit.Enabled := Checked;
  end;
end;

procedure TLittleBaysFrm.RefitMesonEditChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitMesonEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Meson Bay Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.LittleBays.MesonBaysRefitTech);
        Exit;
      end;
      SetMesonBayFactors(StrToInt(Text), RefitMesonChkBx.Checked);
    end;
  end;
end;

procedure TLittleBaysFrm.RefitMissileChkBxChange(Sender: TObject);
begin
  with (RefitMissileChkBx) do
  begin
    if (Checked) then
    begin
      RefitMissileEdit.Text := IntToStr(Ship.LittleBays.MissileBaysRefitTech);
    end
    else
    begin
      RefitMissileEdit.Text := '0';
    end;
    RefitMissileEdit.Enabled := Checked;
  end;
end;

procedure TLittleBaysFrm.RefitMissileEditChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitMissileEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Missile Bay Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.LittleBays.MissileBaysRefitTech);
        Exit;
      end;
      SetMissileBayFactors(StrToInt(Text), RefitMissileChkBx.Checked);
    end;
  end;
end;

procedure TLittleBaysFrm.RefitPaChkBxChange(Sender: TObject);
begin
  with (RefitPaChkBx) do
  begin
    if (Checked) then
    begin
      RefitPaEdit.Text := IntToStr(Ship.LittleBays.PaBaysRefitTech);
    end
    else
    begin
      RefitPaEdit.Text := '0';
    end;
    RefitPaEdit.Enabled := Checked;
  end;
end;

procedure TLittleBaysFrm.RefitPaEditChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitPaEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Particle Accelerator Bay Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.LittleBays.PaBaysRefitTech);
        Exit;
      end;
      SetPaBayFactors(StrToInt(Text), RefitPaChkBx.Checked);
    end;
  end;
end;

procedure TLittleBaysFrm.RefitRepulsorChkBxChange(Sender: TObject);
begin
  with (RefitRepulsorChkBx) do
  begin
    if (Checked) then
    begin
      RefitRepulsorEdit.Text := IntToStr(Ship.LittleBays.RepulsorBaysRefitTech);
    end
    else
    begin
      RefitRepulsorEdit.Text := '0';
    end;
    RefitRepulsorEdit.Enabled := Checked;
  end;
end;

procedure TLittleBaysFrm.RefitRepulsorEditChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitRepulsorEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Repulsor Bay Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.LittleBays.RepulsorBaysRefitTech);
        Exit;
      end;
      SetRepulsorBayFactors(StrToInt(Text), RefitRepulsorChkBx.Checked);
    end;
  end;
end;

procedure TLittleBaysFrm.RepulsorEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (RepulsorEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TLittleBaysFrm.MissileEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (MissileEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TLittleBaysFrm.EnergyEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (EnergyEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TLittleBaysFrm.EnergyRadGrpClick(Sender: TObject);
//change the energy bay factor according to the type selected
var
  sNum: String;
begin
  sNum := EnergyEdit.Text;
  if (RefitEnergyChkBx.Checked) then
  begin
    SetEnergyBayFactors(StrToInt(RefitEnergyEdit.Text), RefitEnergyChkBx.Checked);
  end
  else
  begin
    SetEnergyBayFactors(Ship.TechLevel, True);
    EnergyEdit.Text := sNum;
  end;
(*  Case (Ship.TechLevel) of
  12: begin
        if (EnergyRadGrp.ItemIndex = 0) then
        begin
          EnergyLbl.Caption := '6';
        end
        else EnergyLbl.Caption := '7';
      end;
  14: begin
        if (EnergyRadGrp.ItemIndex = 0) then
        begin
          EnergyLbl.Caption := '6';
        end
        else EnergyLbl.Caption := '8';
      end;
  else
    begin
      if (EnergyRadGrp.ItemIndex = 0) then
      begin
        EnergyLbl.Caption := '6';
      end
      else EnergyLbl.Caption := '9';
    end;
  end;  *)
end;

procedure TLittleBaysFrm.DisableDuplicates;
//disable weapon types that appear elsewhere in the ship

begin
   //spinal mounts
  DisableSpinals;
   //100t bays
   DisableBigBays;
   //turrets
   DisableTurrets;
end;

procedure TLittleBaysFrm.DisableSpinals;
begin
  if (Ship.SpinalMount.RefitSpinalMount) then
  begin
    Case (Ship.SpinalMount.NewSpinalType) of
    1: begin
         MesonEdit.Text := '0';
         MesonLbl.Caption := '0';
         MesonEdit.Enabled := False;
         if (Ship.IsRefitted) then
         begin
           RefitMesonChkBx.Enabled := False;
         end;
       end;
    2: begin
         PAEdit.Text := '0';
         PALbl.Caption := '0';
         PAEdit.Enabled := False;
         if (Ship.IsRefitted) then
         begin
           RefitPaChkBx.Enabled := False;
         end;
       end;
    end;
  end
  else
  begin
    Case (Ship.SpinalMount.SpinalType) of
    1: begin
         MesonEdit.Text := '0';
         MesonLbl.Caption := '0';
         MesonEdit.Enabled := False;
         if (Ship.IsRefitted) then
         begin
           RefitMesonChkBx.Enabled := False;
         end;
       end;
    2: begin
         PAEdit.Text := '0';
         PALbl.Caption := '0';
         PAEdit.Enabled := False;
         if (Ship.IsRefitted) then
         begin
           RefitPaChkBx.Enabled := False;
         end;
       end;
    end;
  end;
end;

procedure TLittleBaysFrm.DisableBigBays;
begin
  if (Ship.BigBays.RefitMesonBays) then
  begin
    if (Ship.BigBays.NewMesonBays > 0) then
    begin
      MesonEdit.Text := '0';
      MesonLbl.Caption := '0';
      MesonEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMesonChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.BigBays.MesonBays > 0) then
    begin
      MesonEdit.Text := '0';
      MesonLbl.Caption := '0';
      MesonEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMesonChkBx.Enabled := False;
      end;
    end;
  end;
  if (Ship.BigBays.RefitPaBays) then
  begin
    if (Ship.BigBays.NewPABays > 0) then
    begin
      PAEdit.Text := '0';
      PALbl.Caption := '0';
      PAEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitPaChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.BigBays.PABays > 0) then
    begin
      PAEdit.Text := '0';
      PALbl.Caption := '0';
      PAEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitPaChkBx.Enabled := False;
      end;
    end;
  end;
  if (Ship.BigBays.RefitRepulsorBays) then
  begin
    if (Ship.BigBays.NewRepulsorBays > 0) then
    begin
      RepulsorEdit.Text := '0';
      RepulsLbl.Caption := '0';
      RepulsorEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitRepulsorChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.BigBays.RepulsorBays > 0) then
    begin
      RepulsorEdit.Text := '0';
      RepulsLbl.Caption := '0';
      RepulsorEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitRepulsorChkBx.Enabled := False;
      end;
    end;
  end;
  if (Ship.BigBays.RefitMissileBays) then
  begin
    if (Ship.BigBays.NewMissileBays > 0) then
    begin
      MissileEdit.Text := '0';
      MissileLbl.Caption := '0';
      MissileEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMissileChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.BigBays.MissileBays > 0) then
    begin
      MissileEdit.Text := '0';
      MissileLbl.Caption := '0';
      MissileEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMissileChkBx.Enabled := False;
      end;
    end;
  end;
end;

procedure TLittleBaysFrm.DisableTurrets;
begin
  if (Ship.Turrets.RefitEnergyTurrets) then
  begin
    if (Ship.Turrets.NewEnergyTurrets > 0) then
    begin
      EnergyEdit.Text := '0';
      EnergyLbl.Caption := '0';
      EnergyRadGrp.ItemIndex := 1;
      EnergyEdit.Enabled := False;
      EnergyRadGrp.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitEnergyChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.Turrets.EnergyTurrets > 0) then
    begin
      EnergyEdit.Text := '0';
      EnergyLbl.Caption := '0';
      EnergyRadGrp.ItemIndex := 1;
      EnergyEdit.Enabled := False;
      EnergyRadGrp.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitEnergyChkBx.Enabled := False;
      end;
    end;
  end;
  if (Ship.Turrets.RefitPATurrets) then
  begin
    if (Ship.Turrets.NewPATurrets > 0) then
    begin
      PAEdit.Text := '0';
      PALbl.Caption := '0';
      PAEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitPaChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.Turrets.PATurrets > 0) then
    begin
      PAEdit.Text := '0';
      PALbl.Caption := '0';
      PAEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitPaChkBx.Enabled := False;
      end;
    end;
  end;
  if (Ship.Turrets.RefitMissileTurrets) then
  begin
    if (Ship.Turrets.NewMissileTurrets > 0) then   //or (Ship.Turrets.MixTurretMissiles > 0)
    begin
      MissileEdit.Text := '0';
      MissileLbl.Caption := '0';
      MissileEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMissileChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.Turrets.MissileTurrets > 0) then   //or (Ship.Turrets.MixTurretMissiles > 0)
    begin
      MissileEdit.Text := '0';
      MissileLbl.Caption := '0';
      MissileEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMissileChkBx.Enabled := False;
      end;
    end;
  end;
  if (Ship.Turrets.RefitMixTurrets) then
  begin
    if (Ship.Turrets.NewNumMixTurrets > 0) and (Ship.Turrets.NewMixTurretMissiles > 0) then
    begin
      MissileEdit.Text := '0';
      MissileLbl.Caption := '0';
      MissileEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMissileChkBx.Enabled := False;
      end;
    end;
    if (Ship.Turrets.NewNumMixTurrets > 0) and (Ship.Turrets.NewMixTurretEnergy > 0) then
    begin
      EnergyEdit.Text := '0';
      EnergyLbl.Caption := '0';
      EnergyRadGrp.ItemIndex := 1;
      EnergyEdit.Enabled := False;
      EnergyRadGrp.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitEnergyChkBx.Enabled := False;
      end;
    end;
  end
  else
  begin
    if (Ship.Turrets.NumMixTurrets > 0) and (Ship.Turrets.MixTurretMissiles > 0) then
    begin
      MissileEdit.Text := '0';
      MissileLbl.Caption := '0';
      MissileEdit.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitMissileChkBx.Enabled := False;
      end;
    end;
    if (Ship.Turrets.NumMixTurrets > 0) and (Ship.Turrets.MixTurretEnergy > 0) then
    begin
      EnergyEdit.Text := '0';
      EnergyLbl.Caption := '0';
      EnergyRadGrp.ItemIndex := 1;
      EnergyEdit.Enabled := False;
      EnergyRadGrp.Enabled := False;
      if (Ship.IsRefitted) then
      begin
        RefitEnergyChkBx.Enabled := False;
      end;
    end;
  end;
end;

procedure TLittleBaysFrm.SetBayFactors(TheTechLevel: Integer);
//calculate the factors based on the ship tech level

begin
  Case (TheTechLevel) of
    7..9: begin
            EmptyEdit.Text := '0';
            EmptyEdit.Enabled := True;
            MesonLbl.Caption := '0';
            MesonEdit.Text := '0';
            MesonEdit.Enabled := False;
            PALbl.Caption := '0';
            PAEdit.Text := '0';
            PAEdit.Enabled := False;
            RepulsLbl.Caption := '0';
            RepulsorEdit.Text := '0';
            RepulsorEdit.Enabled := False;
            MissileLbl.Caption := '0';
            MissileEdit.Text := '0';
            MissileEdit.Enabled := False;
            if (Ship.LittleBays.EnergyType = 0) then
            begin
              EnergyLbl.Caption := '0';
              EnergyEdit.Text := '0';
              EnergyEdit.Enabled := False;
            end
            else if (Ship.LittleBays.EnergyType = 1) then
            begin
              EnergyLbl.Caption := '0';
              EnergyEdit.Text := '0';
              EnergyEdit.Enabled := False;
            end;
            EnergyRadGrp.ItemIndex := 0;
            EnergyRadGrp.Enabled := False;
          end;
    10: begin
          MesonLbl.Caption := '0';
          MesonEdit.Text := '0';
          MesonEdit.Enabled := False;
          PALbl.Caption := '3';
          RepulsLbl.Caption := '0';
          RepulsorEdit.Text := '0';
          RepulsorEdit.Enabled := False;
          MissileLbl.Caption := '7';
          if (Ship.LittleBays.EnergyType = 0) then
          begin
            EnergyLbl.Caption := '4';
          end
          else if (Ship.LittleBays.EnergyType = 1) then
          begin
            EnergyLbl.Caption := '0';
            EnergyEdit.Text := '0';
            EnergyEdit.Enabled := False;
          end;
          EnergyRadGrp.ItemIndex := 0;
          EnergyRadGrp.Enabled := False;
        end;
    11: begin
          MesonLbl.Caption := '0';
          MesonEdit.Text := '0';
          MesonEdit.Enabled := False;
          PALbl.Caption := '3';
          RepulsLbl.Caption := '0';
          RepulsorEdit.Text := '0';
          RepulsorEdit.Enabled := False;
          MissileLbl.Caption := '7';
          if (Ship.LittleBays.EnergyType = 0) then
          begin
            EnergyLbl.Caption := '5';
          end
          else if (Ship.LittleBays.EnergyType = 1) then
          begin
            EnergyLbl.Caption := '0';
            EnergyEdit.Text := '0';
            EnergyEdit.Enabled := False;
          end;
          EnergyRadGrp.ItemIndex := 0;
          EnergyRadGrp.Enabled := False;
        end;
    12: begin
          MesonLbl.Caption := '0';
          MesonEdit.Text := '0';
          MesonEdit.Enabled := False;
          PALbl.Caption := '4';
          RepulsLbl.Caption := '0';
          RepulsorEdit.Text := '0';
          RepulsorEdit.Enabled := False;
          MissileLbl.Caption := '8';
          if (Ship.LittleBays.EnergyType = 0) then
          begin
            EnergyLbl.Caption := '6';
          end
          else if (Ship.LittleBays.EnergyType = 1) then
          begin
            EnergyLbl.Caption := '7';
          end;
        end;
    13: begin
          MesonLbl.Caption := '0';
          MesonEdit.Text := '0';
          MesonEdit.Enabled := False;
          PALbl.Caption := '4';
          RepulsLbl.Caption := '0';
          RepulsorEdit.Text := '0';
          RepulsorEdit.Enabled := False;
          MissileLbl.Caption := '8';
          if (Ship.LittleBays.EnergyType = 0) then
          begin
            EnergyLbl.Caption := '6';
          end
          else if (Ship.LittleBays.EnergyType = 1) then
          begin
            EnergyLbl.Caption := '8';
          end;
        end;
    14: begin
          MesonLbl.Caption := '0';
          MesonEdit.Text := '0';
          MesonEdit.Enabled := False;
          PALbl.Caption := '5';
          RepulsLbl.Caption := '3';
          MissileLbl.Caption := '9';
          if (Ship.LittleBays.EnergyType = 0) then
          begin
            EnergyLbl.Caption := '6';
          end
          else if (Ship.LittleBays.EnergyType = 1) then
          begin
            EnergyLbl.Caption := '9';
          end;
        end;
    else
    begin
      MesonLbl.Caption := '4';
      PALbl.Caption := '5';
      RepulsLbl.Caption := '5';
      MissileLbl.Caption := '9';
      if (Ship.LittleBays.EnergyType = 0) then
      begin
        EnergyLbl.Caption := '6';
      end
      else if (Ship.LittleBays.EnergyType = 1) then
      begin
        EnergyLbl.Caption := '9';
      end;
    end;
  end;
end;

procedure TLittleBaysFrm.SetMesonBayFactors(TheTechLevel: Integer;
  IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..14: begin
              MesonLbl.Caption := '0';
              MesonEdit.Text := '0';
              MesonEdit.Enabled := False;
            end;
    else
    begin
      MesonLbl.Caption := '4';
      MesonEdit.Text := IntToStr(Ship.LittleBays.NewMesonBays);
      MesonEdit.Enabled := IsActive;
    end;
  end;
end;

procedure TLittleBaysFrm.SetPaBayFactors(TheTechLevel: Integer;
  IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..9: begin
            PALbl.Caption := '0';
            PAEdit.Text := '0';
            PAEdit.Enabled := False;
          end;
    10..11: begin
              PALbl.Caption := '3';
              PAEdit.Text := IntToStr(Ship.LittleBays.NewPaBays);
              PAEdit.Enabled := IsActive;
            end;
    12..13: begin
              PALbl.Caption := '4';
              PAEdit.Text := IntToStr(Ship.LittleBays.NewPaBays);
              PAEdit.Enabled := IsActive;
            end;
    else
      begin
        PALbl.Caption := '5';
        PAEdit.Text := IntToStr(Ship.LittleBays.NewPaBays);
        PAEdit.Enabled := IsActive;
      end;
  end;
end;

procedure TLittleBaysFrm.SetRepulsorBayFactors(TheTechLevel: Integer;
  IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..13: begin
             RepulsLbl.Caption := '0';
             RepulsorEdit.Text := '0';
             RepulsorEdit.Enabled := False;
           end;
    14: begin
          RepulsLbl.Caption := '3';
          RepulsorEdit.Text := IntToStr(Ship.LittleBays.NewRepulsorBays);
          RepulsorEdit.Enabled := IsActive;
        end;
    else
      begin
        RepulsLbl.Caption := '5';
        RepulsorEdit.Text := IntToStr(Ship.LittleBays.NewRepulsorBays);
        RepulsorEdit.Enabled := IsActive;
      end;
  end;
end;

procedure TLittleBaysFrm.SetMissileBayFactors(TheTechLevel: Integer;
  IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..9: begin
            MissileLbl.Caption := '0';
            MissileEdit.Text := '0';
            MissileEdit.Enabled := False;
          end;
    10..11: begin
              MissileLbl.Caption := '7';
              MissileEdit.Text := IntToStr(Ship.LittleBays.NewMissileBays);
              MissileEdit.Enabled := IsActive;
            end;
    12..13: begin
              MissileLbl.Caption := '8';
              MissileEdit.Text := IntToStr(Ship.LittleBays.NewMissileBays);
              MissileEdit.Enabled := IsActive;
            end;
    else
      begin
        MissileLbl.Caption := '9';
        MissileEdit.Text := IntToStr(Ship.LittleBays.NewMissileBays);
        MissileEdit.Enabled := IsActive;
      end;
  end;
end;

procedure TLittleBaysFrm.SetEnergyBayFactors(TheTechLevel: Integer;
  IsActive: Boolean);
begin
  if (EnergyRadGrp.ItemIndex = 0) then
  begin
    Case (TheTechLevel) of
      0..9: begin
              EnergyLbl.Caption := '0';
              EnergyEdit.Text := '0';
              EnergyEdit.Enabled := False;
            end;
      10: begin
            EnergyLbl.Caption := '4';
            EnergyEdit.Text := IntToStr(Ship.LittleBays.NewEnergyBays);
            EnergyEdit.Enabled := IsActive;
          end;
      11: begin
            EnergyLbl.Caption := '5';
            EnergyEdit.Text := IntToStr(Ship.LittleBays.NewEnergyBays);
            EnergyEdit.Enabled := IsActive;
          end;
      else
        begin
          EnergyLbl.Caption := '6';
          EnergyEdit.Text := IntToStr(Ship.LittleBays.NewEnergyBays);
          EnergyEdit.Enabled := IsActive;
        end;
    end;
  end
  else
  begin
    Case (TheTechLevel) of
      0..11: begin
               EnergyLbl.Caption := '0';
               EnergyEdit.Text := '0';
               EnergyEdit.Enabled := False;
             end;
      12: begin
            EnergyLbl.Caption := '7';
            EnergyEdit.Text := IntToStr(Ship.LittleBays.NewEnergyBays);
            EnergyEdit.Enabled := IsActive;
          end;
      13: begin
            EnergyLbl.Caption := '8';
            EnergyEdit.Text := IntToStr(Ship.LittleBays.NewEnergyBays);
            EnergyEdit.Enabled := IsActive;
          end;
      else
        begin
          EnergyLbl.Caption := '9';
          EnergyEdit.Text := IntToStr(Ship.LittleBays.NewEnergyBays);
          EnergyEdit.Enabled := IsActive;
        end;
    end;
  end;
end;

procedure TLittleBaysFrm.ForceRefits;
var
  iEmpty: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    iEmpty := Ship.LittleBays.EmptyBays;
    //sand casters
    //repulsors
     if (Ship.LittleBays.RepulsorBays > 0)
         and ((Ship.BigBays.RefitRepulsorBays) and (Ship.BigBays.NewRepulsorBays > 0)) then
     begin
       RefitRepulsorChkBx.Checked := True;
       RefitRepulsorChkBx.Enabled := False;
       RepulsorEdit.Text := '0';
       RepulsorEdit.Enabled := False;
       RefitRepulsorEdit.Enabled := False;
       iEmpty := iEmpty + Ship.LittleBays.RepulsorBays;
     end;
    //lasers
    //energy weapons
     if (Ship.LittleBays.EnergyBays > 0)
         and (((Ship.Turrets.RefitEnergyTurrets) and (Ship.Turrets.NewEnergyTurrets > 0))
         or ((Ship.Turrets.RefitMixTurrets) and (Ship.Turrets.NewMixTurretEnergy > 0))) then
     begin
       RefitEnergyChkBx.Checked := True;
       RefitEnergyChkBx.Enabled := False;
       EnergyEdit.Text := '0';
       EnergyEdit.Enabled := False;
       RefitEnergyEdit.Enabled := False;
       iEmpty := iEmpty + Ship.LittleBays.EnergyBays;
     end;
    //Particle Accelerators
    if (Ship.LittleBays.PABays > 0)
        and (((Ship.SpinalMount.RefitSpinalMount) and (Ship.SpinalMount.NewSpinalType = 2))
        or ((Ship.BigBays.RefitPaBays) and (Ship.BigBays.NewPaBays > 0))
        or ((Ship.Turrets.RefitPaTurrets) and (Ship.Turrets.NewPaTurrets > 0))) then
    begin
      RefitPaChkBx.Checked := True;
      RefitPaChkBx.Enabled := False;
      PaEdit.Text := '0';
      PaEdit.Enabled := False;
      RefitPaEdit.Enabled := False;
      iEmpty := iEmpty + Ship.LittleBays.PaBays;
    end;
    //meson guns
    if (Ship.LittleBays.MesonBays > 0)
        and (((Ship.SpinalMount.RefitSpinalMount) and (Ship.SpinalMount.NewSpinalType = 1))
        or ((Ship.BigBays.RefitMesonBays) and (Ship.BigBays.NewMesonBays > 0))) then
    begin
      RefitMesonChkBx.Checked := True;
      RefitMesonChkBx.Enabled := False;
      MesonEdit.Text := '0';
      MesonEdit.Enabled := False;
      RefitMesonEdit.Enabled := False;
      iEmpty := iEmpty + Ship.LittleBays.MesonBays;
    end;
    //missiles
    if (Ship.LittleBays.MissileBays > 0)
        and (((Ship.BigBays.RefitMissileBays) and (Ship.LittleBays.NewMissileBays > 0))
        or ((Ship.Turrets.RefitMissileTurrets) and (Ship.Turrets.NewMissileTurrets > 0))
        or ((Ship.Turrets.RefitMixTurrets) and (Ship.Turrets.NewMixTurretMissiles > 0))) then
    begin
      RefitMissileChkBx.Checked := True;
      RefitMissileChkBx.Enabled := False;
      MissileEdit.Text := '0';
      MissileEdit.Enabled := False;
      RefitMissileEdit.Enabled := False;
      iEmpty := iEmpty + Ship.LittleBays.MissileBays;
    end;

    //empty bays
    if (iEmpty > Ship.LittleBays.EmptyBays) then
    begin
      RefitEmptyChkBx.Checked := True;
      EmptyEdit.Enabled := True;
      EmptyEdit.Text := IntToStr(iEmpty);
    end;
  end;
end;

procedure TLittleBaysFrm.SetRefitData;
begin
  RefitEmptyChkBx.Checked := not Ship.LittleBays.RefitEmptyBays;
  RefitEmptyChkBx.Checked := Ship.LittleBays.RefitEmptyBays;

  RefitMesonChkBx.Checked := not Ship.LittleBays.RefitMesonBays;
  RefitMesonChkBx.Checked := Ship.LittleBays.RefitMesonBays;
  SetMesonBayFactors(Ship.LittleBays.MesonBaysRefitTech, Ship.LittleBays.RefitMesonBays);

  RefitPaChkBx.Checked := not Ship.LittleBays.RefitPaBays;
  RefitPaChkBx.Checked := Ship.LittleBays.RefitPaBays;
  SetPaBayFactors(Ship.LittleBays.PaBaysRefitTech, Ship.LittleBays.RefitPaBays);

  RefitRepulsorChkBx.Checked := not Ship.LittleBays.RefitRepulsorBays;
  RefitRepulsorChkBx.Checked := Ship.LittleBays.RefitRepulsorBays;
  SetRepulsorBayFactors(Ship.LittleBays.RepulsorBaysRefitTech, Ship.LittleBays.RefitRepulsorBays);

  RefitMissileChkBx.Checked := not Ship.LittleBays.RefitMissileBays;
  RefitMissileChkBx.Checked := Ship.LittleBays.RefitMissileBays;
  SetMissileBayFactors(Ship.LittleBays.MissileBaysRefitTech, Ship.LittleBays.RefitMissileBays);

  RefitEnergyChkBx.Checked := not Ship.LittleBays.RefitEnergyBays;
  RefitEnergyChkBx.Checked := Ship.LittleBays.RefitEnergyBays;
  EnergyRadGrp.ItemIndex := Ship.LittleBays.NewEnergyType;
  SetEnergyBayFactors(Ship.LittleBays.EnergyBaysRefitTech, Ship.LittleBays.RefitEnergyBays);
end;

procedure TLittleBaysFrm.SetNonRefitData;
begin
  EmptyEdit.Text := IntToStr(Ship.LittleBays.EmptyBays);
  MesonEdit.Text := IntToStr(Ship.LittleBays.MesonBays);
  PAEdit.Text := IntToStr(Ship.LittleBays.PABays);
  RepulsorEdit.Text := IntToStr(Ship.LittleBays.RepulsorBays);
  MissileEdit.Text := IntToStr(Ship.LittleBays.MissileBays);
  EnergyEdit.Text := IntToStr(Ship.LittleBays.EnergyBays);
  EnergyRadGrp.ItemIndex := Ship.LittleBays.EnergyType;
  RefitEmptyChkBx.Checked := False;
  RefitMesonChkBx.Checked := False;
  RefitPaChkBx.Checked := False;
  RefitRepulsorChkBx.Checked := False;
  RefitMissileChkBx.Checked := False;
  RefitMesonEdit.Text := '0';
  RefitPaEdit.Text := '0';
  RefitRepulsorEdit.Text := '0';
  RefitMissileEdit.Text := '0';
end;

procedure TLittleBaysFrm.SendData;
begin
  if (Ship.IsRefitted) then
  begin
    Ship.LittleBays.NewEmptyBays := StrToInt(EmptyEdit.Text);
    Ship.LittleBays.NewMesonBays := StrToInt(MesonEdit.Text);
    Ship.LittleBays.NewPABays := StrToInt(PAEdit.Text);
    Ship.LittleBays.NewRepulsorBays := StrToInt(RepulsorEdit.Text);
    Ship.LittleBays.NewMissileBays := StrToInt(MissileEdit.Text);
    Ship.LittleBays.NewEnergyBays := StrToInt(EnergyEdit.Text);
    Ship.LittleBays.RefitEmptyBays := RefitEmptyChkBx.Checked;
    Ship.LittleBays.RefitMesonBays := RefitMesonChkBx.Checked;
    Ship.LittleBays.RefitPaBays := RefitPaChkBx.Checked;
    Ship.LittleBays.RefitRepulsorBays := RefitRepulsorChkBx.Checked;
    Ship.LittleBays.RefitMissileBays := RefitMissileChkBx.Checked;
    Ship.LittleBays.RefitEnergyBays := RefitEnergyChkBx.Checked;
    Ship.LittleBays.MesonBaysRefitTech := StrToInt(RefitMesonEdit.Text);
    Ship.LittleBays.PaBaysRefitTech := StrToInt(RefitPaEdit.Text);
    Ship.LittleBays.RepulsorBaysRefitTech := StrToInt(RefitRepulsorEdit.Text);
    Ship.LittleBays.MissileBaysRefitTech := StrToInt(RefitMissileEdit.Text);
    Ship.LittleBays.EnergyBaysRefitTech := StrToInt(RefitEnergyEdit.Text);
    Ship.LittleBays.NewEnergyType := EnergyRadGrp.ItemIndex;
  end
  else
  begin
    Ship.LittleBays.EmptyBays := StrToInt(EmptyEdit.Text);
    Ship.LittleBays.MesonBays := StrToInt(MesonEdit.Text);
    Ship.LittleBays.PABays := StrToInt(PAEdit.Text);
    Ship.LittleBays.RepulsorBays := StrToInt(RepulsorEdit.Text);
    Ship.LittleBays.MissileBays := StrToInt(MissileEdit.Text);
    Ship.LittleBays.EnergyBays := StrToInt(EnergyEdit.Text);
    Ship.LittleBays.EnergyType := EnergyRadGrp.ItemIndex;
  end;
end;

function TLittleBaysFrm.Warn(TheMessage: String): Boolean;
//display a warning message

begin
  if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

procedure TLittleBaysFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(Ship.GenAvionicsDetails);
         FullShipData.Add(Ship.GenSpinalMountDetails);
         FullShipData.Add(Ship.GenBigBaysDetails);
         FullShipData.Add(GenerateLittleBaysDetails);
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

function TLittleBaysFrm.GenerateLittleBaysDetails: String;
//generate 50 ton bay file details

begin
  Result := EmptyEdit.Text
         + SEP + MesonEdit.Text
         + SEP + PAEdit.Text
         + SEP + RepulsorEdit.Text
         + SEP + MissileEdit.Text
         + SEP + EnergyEdit.Text
         + SEP + IntToStr(EnergyRadGrp.ItemIndex)
         + SEP + BoolToStr(RefitEmptyChkBx.Checked)       //7
         + SEP + BoolToStr(RefitMesonChkBx.Checked)       //8
         + SEP + BoolToStr(RefitPaChkBx.Checked)          //9
         + SEP + BoolToStr(RefitRepulsorChkBx.Checked)    //10
         + SEP + BoolToStr(RefitMissileChkBx.Checked)     //11
         + SEP + BoolToStr(RefitEnergyChkBx.Checked)      //12
         + SEP + RefitMesonEdit.Text    //13
         + SEP + RefitPaEdit.Text       //14
         + SEP + RefitRepulsorEdit.Text //15
         + SEP + RefitMissileEdit.Text  //16
         + SEP + RefitEnergyEdit.Text   //17
         + SEP + EmptyEdit.Text          //18
         + SEP + MesonEdit.Text          //19
         + SEP + PAEdit.Text             //20
         + SEP + RepulsorEdit.Text       //21
         + SEP + MissileEdit.Text        //22
         + SEP + EnergyEdit.Text         //23
         + SEP + IntToStr(EnergyRadGrp.ItemIndex)        //24
         + SEP + '0'                                     //25
         + SEP + '0'                                     //26
         + SEP + '0'                                     //27
         + SEP + '0'                                     //28
         + SEP + '0'                                     //29
         + SEP + '0'                                     //30
         + SEP + '0'                                     //31
         + SEP + '0'                                     //32
         + SEP + '0'                                     //33
         + SEP + '0'                                     //34
         ; //terminator
end;

end.
