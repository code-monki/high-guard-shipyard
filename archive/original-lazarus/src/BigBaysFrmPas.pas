unit BigBaysFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShipPas, DesAssistFrmPas, HgsFormFrm;

type

  { TBigBaysFrm }

  TBigBaysFrm = class(THgsForm)
    RefitEmptyChkBx: TCheckBox;
    RefitMesonChkBx: TCheckBox;
    RefitPaChkBx: TCheckBox;
    RefitRepulsorChkBx: TCheckBox;
    RefitMissileChkBx: TCheckBox;
    RefitMesonEdit: TEdit;
    RefitPaEdit: TEdit;
    RefitRepulsorEdit: TEdit;
    RefitMissileEdit: TEdit;
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
    OKBtn: TButton;
    CancelBtn: TButton;
    HardPointsLbl: TLabel;
    HardPointsStatLbl: TLabel;
    RefirStatTxt: TStaticText;
    procedure RefitEmptyChkBxChange(Sender: TObject);
    procedure RefitEmptyEditChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EmptyEditChange(Sender: TObject);
    procedure MesonEditChange(Sender: TObject);
    procedure PAEditChange(Sender: TObject);
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function TrapErrors: Boolean;
    function NoValues: Boolean;
    function InvalidValues: Boolean;
    function NegativeValues: Boolean;
    function CalcRemHardPoints : Integer;
    function Warn(TheMessage : String) : Boolean;
    function GenerateBigBaysDetails : String;
    procedure SetBayFactors(TheTechLevel: Integer);
    procedure SetMesonBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetPaBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetRepulsorBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure SetMissileBayFactors(TheTechLevel: Integer; IsActive: Boolean);
    procedure ForceRefits;
    procedure DisableDuplicates;
    procedure DisableSpinals;
    procedure DisableLittleBays;
    procedure DisableTurrets;
    procedure SetRefitData;
    procedure SetNonRefitData;
    procedure SendData;
  public
    { Public declarations }
  end;

var
  BigBaysFrm: TBigBaysFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TBigBaysFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
   Action := caFree;
end;

procedure TBigBaysFrm.RefitEmptyEditChange(Sender: TObject);
begin

end;

procedure TBigBaysFrm.RefitEmptyChkBxChange(Sender: TObject);
begin
  with (RefitEmptyChkBx) do
  begin
    if (Checked) then
    begin
      EmptyEdit.Text := IntToStr(Ship.BigBays.NewEmptyBays);
    end
    else
    begin
      EmptyEdit.Text := '0';
    end;
    EmptyEdit.Enabled := Checked;
  end;
end;

procedure TBigBaysFrm.OKBtnClick(Sender: TObject);
//check for errors and if okay send the form data to the ship

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

procedure TBigBaysFrm.CancelBtnClick(Sender: TObject);
//close the form without applying the data

begin
   Close;
end;

function TBigBaysFrm.TrapErrors: Boolean;
//find errors and display an approriate message
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

  with (Ship.BigBays) do
  begin
    BaseBayNum := EmptyBays + MesonBays + PaBays + RepulsorBays + MissileBays;
    FormBayNum := StrToInt(EmptyEdit.Text) + StrToInt(MesonEdit.Text) + StrToInt(PaEdit.Text)
        + StrToInt(RepulsorEdit.Text) + StrToInt(MissileEdit.Text);
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
        //MessageDlg('The number of bays may not be decreased.', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
    end;
  end
  else
  begin
    if (StrToInt(MesonEdit.Text) > 0) and (Ship.TechLevel < 13) then
    begin
      MessageDlg('Meson Bays are not permitted below Tech Level 13', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(PAEdit.Text) > 0) and (Ship.TechLevel < 8) then
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
  end;
  if (CalcRemHardPoints < 0) then
  begin
    if (Warn('There are not enough hardpoints for the weapons installed, do you wish to alter these weapons?')) then begin
      Result := True;
      exit;
    end;
  end;
end;

function TBigBaysFrm.NoValues: Boolean;
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
  end;
end;

function TBigBaysFrm.InvalidValues: Boolean;
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
  end;
end;

function TBigBaysFrm.NegativeValues: Boolean;
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
  end;
end;

procedure TBigBaysFrm.FormCreate(Sender: TObject);
//create the form and fill it with data from the ship

begin
  RefitPanel.Caption := '';
  RefitPanel.Visible := Ship.IsRefitted;
  RefitPanel.Enabled := Ship.IsRefitted;
  if (Ship.IsRefitted) then
  begin
    RefitPanel.Left := RefitPanel.Left - 46;
    SetRefitData;
    with (Ship.BigBays) do
    begin
      EmptyStatLbl.Caption := 'Empty ' + IntToStr(EmptyBays);
      MesonStatLbl.Caption := 'Meson ' + IntToStr(MesonBays) + ' @ ' + IntToStr(MesonFactor(Ship.TechLevel));
      PaStatLbl.Caption := 'PA ' + IntToStr(PaBays) + ' @ ' + IntToStr(PaFactor(Ship.TechLevel));
      RepulsStatLbl.Caption := 'Repulsor ' + IntToStr(RepulsorBays) + ' @ ' + IntToStr(RepulsorFactor(Ship.TechLevel));
      MissileStatLbl.Caption := 'Missile ' + IntToStr(MissileBays) + ' @ ' + IntToStr(MissileFactor(Ship.TechLevel));
    end;
  end
  else
  begin
    SetNonRefitData;
    SetBayFactors(Ship.TechLevel);
  end;
  DisableDuplicates;
  ForceRefits;
  HardPointsLbl.Caption := IntToStr(CalcRemHardPoints);

(*
  if (Ship.Tonnage < 1000) then
  begin
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
  end;
*)
end;

function TBigBaysFrm.CalcRemHardPoints: Integer;
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
        else FormBays := FormBays + Ship.BigBays.EmptyBays;
    if (RefitMesonChkBx.Checked) then FormBays := FormBays + StrToInt(MesonEdit.Text)
        else FormBays := FormBays + Ship.BigBays.MesonBays;
    if (RefitPaChkBx.Checked) then FormBays := FormBays + StrToInt(PaEdit.Text)
        else FormBays := FormBays + Ship.BigBays.PaBays;
    if (RefitRepulsorChkBx.Checked) then FormBays := FormBays + StrToInt(RepulsorEdit.Text)
        else FormBays := FormBays + Ship.BigBays.RepulsorBays;
    if (RefitMissileChkBx.Checked) then FormBays := FormBays + StrToInt(MissileEdit.Text)
        else FormBays := FormBays + Ship.BigBays.MissileBays;
  end
  else
  begin
    FormBays := StrToInt(EmptyEdit.Text) + StrToInt(MesonEdit.Text)
         + StrToInt(PAEdit.Text) + StrToInt(RepulsorEdit.Text)
         + StrToInt(MissileEdit.Text);
  end;
  ExistingBays := Ship.TotalBigBays;
  Result := HardPoints + (ExistingBays * 10) - (FormBays * 10);
end;

procedure TBigBaysFrm.EmptyEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (EmptyEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TBigBaysFrm.MesonEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (MesonEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TBigBaysFrm.PAEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (PAEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TBigBaysFrm.RefitMesonChkBxChange(Sender: TObject);
begin
  with (RefitMesonChkBx) do
  begin
    if (Checked) then
    begin
      RefitMesonEdit.Text := IntToStr(Ship.BigBays.MesonBaysRefitTech);
    end
    else
    begin
      RefitMesonEdit.Text := '0';
    end;
    RefitMesonEdit.Enabled := Checked;
  end;
end;

procedure TBigBaysFrm.RefitMesonEditChange(Sender: TObject);
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
        Text := IntToStr(Ship.BigBays.MesonBaysRefitTech);
        Exit;
      end;
      SetMesonBayFactors(StrToInt(Text), RefitMesonChkBx.Checked);
    end;
  end;
end;

procedure TBigBaysFrm.RefitMissileChkBxChange(Sender: TObject);
begin
  with (RefitMissileChkBx) do
  begin
    if (Checked) then
    begin
      RefitMissileEdit.Text := IntToStr(Ship.BigBays.MissileBaysRefitTech);
    end
    else
    begin
      RefitMissileEdit.Text := '0';
    end;
    RefitMissileEdit.Enabled := Checked;
  end;
end;

procedure TBigBaysFrm.RefitMissileEditChange(Sender: TObject);
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
        Text := IntToStr(Ship.BigBays.MissileBaysRefitTech);
        Exit;
      end;
      SetMissileBayFactors(StrToInt(Text), RefitMissileChkBx.Checked);
    end;
  end;
end;

procedure TBigBaysFrm.RefitPaChkBxChange(Sender: TObject);
begin
  with (RefitPaChkBx) do
  begin
    if (Checked) then
    begin
      RefitPaEdit.Text := IntToStr(Ship.BigBays.PaBaysRefitTech);
    end
    else
    begin
      RefitPaEdit.Text := '0';
    end;
    RefitPaEdit.Enabled := Checked;
  end;
end;

procedure TBigBaysFrm.RefitPaEditChange(Sender: TObject);
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
        Text := IntToStr(Ship.BigBays.PaBaysRefitTech);
        Exit;
      end;
      SetPaBayFactors(StrToInt(Text), RefitPaChkBx.Checked);
    end;
  end;
end;

procedure TBigBaysFrm.RefitRepulsorChkBxChange(Sender: TObject);
begin
  with (RefitRepulsorChkBx) do
  begin
    if (Checked) then
    begin
      RefitRepulsorEdit.Text := IntToStr(Ship.BigBays.RepulsorBaysRefitTech);
    end
    else
    begin
      RefitRepulsorEdit.Text := '0';
    end;
    RefitRepulsorEdit.Enabled := Checked;
  end;
end;

procedure TBigBaysFrm.RefitRepulsorEditChange(Sender: TObject);
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
        Text := IntToStr(Ship.BigBays.RepulsorBaysRefitTech);
        Exit;
      end;
      SetRepulsorBayFactors(StrToInt(Text), RefitRepulsorChkBx.Checked);
    end;
  end;
end;

procedure TBigBaysFrm.RepulsorEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (RepulsorEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TBigBaysFrm.MissileEditChange(Sender: TObject);
//update hardpoints remaining

begin
   if (MissileEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalcRemhardPoints);
end;

procedure TBigBaysFrm.SetBayFactors(TheTechLevel: Integer);
//calculate the factors based on the ship tech level

begin
  Case (TheTechLevel) of
  7: begin
       MesonLbl.Caption := '0';
       MesonEdit.Text := '0';
       MesonEdit.Enabled := False;
       PALbl.Caption := '0';
       PAEdit.Text := '0';
       PAEdit.Enabled := False;
       RepulsLbl.Caption := '0';
       RepulsorEdit.Text := '0';
       RepulsorEdit.Enabled := False;
       MissileLbl.Caption := '7';
     end;
  8..9: begin
          MesonLbl.Caption := '0';
          MesonEdit.Text := '0';
          MesonEdit.Enabled := False;
          PALbl.Caption := '6';
          RepulsLbl.Caption := '0';
          RepulsorEdit.Text := '0';
          RepulsorEdit.Enabled := False;
          MissileLbl.Caption := '7';
        end;
  10: begin
        MesonLbl.Caption := '0';
        MesonEdit.Text := '0';
        MesonEdit.Enabled := False;
        PALbl.Caption := '7';
        RepulsLbl.Caption := '2';
        MissileLbl.Caption := '8';
      end;
  11: begin
        MesonLbl.Caption := '0';
        MesonEdit.Text := '0';
        MesonEdit.Enabled := False;
        PALbl.Caption := '7';
        RepulsLbl.Caption := '4';
        MissileLbl.Caption := '8';
      end;
  12: begin
        MesonLbl.Caption := '0';
        MesonEdit.Text := '0';
        MesonEdit.Enabled := False;
        PALbl.Caption := '8';
        RepulsLbl.Caption := '6';
        MissileLbl.Caption := '9';
      end;
  13: begin
        MesonLbl.Caption := '3';
        PALbl.Caption := '8';
        RepulsLbl.Caption := '7';
        MissileLbl.Caption := '9';
      end;
  14: begin
        MesonLbl.Caption := '5';
        PALbl.Caption := '9';
        RepulsLbl.Caption := '8';
        MissileLbl.Caption := '9';
      end;
  else
    begin
      MesonLbl.Caption := '9';
      PALbl.Caption := '9';
      RepulsLbl.Caption := '9';
      MissileLbl.Caption := '9';
    end;
  end;
end;

procedure TBigBaysFrm.SetMesonBayFactors(TheTechLevel: Integer; IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..12: begin
             MesonLbl.Caption := '0';
             MesonEdit.Text := '0';
             MesonEdit.Enabled := False;
           end;
    13: begin
          MesonLbl.Caption := '3';
          MesonEdit.Text := IntToStr(Ship.BigBays.NewMesonBays);
          MesonEdit.Enabled := IsActive;
        end;
    14: begin
          MesonLbl.Caption := '5';
          MesonEdit.Text := IntToStr(Ship.BigBays.NewMesonBays);
          MesonEdit.Enabled := IsActive;
        end;
    else
    begin
      MesonLbl.Caption := '9';
      MesonEdit.Text := IntToStr(Ship.BigBays.NewMesonBays);
      MesonEdit.Enabled := IsActive;
    end;
  end;
end;

procedure TBigBaysFrm.SetPaBayFactors(TheTechLevel: Integer; IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..7: begin
            PALbl.Caption := '0';
            PAEdit.Text := '0';
            PAEdit.Enabled := False;
          end;
    8..9: begin
            PALbl.Caption := '6';
            PAEdit.Text := IntToStr(Ship.BigBays.NewPaBays);
            PAEdit.Enabled := IsActive;
          end;
    10..11: begin
              PALbl.Caption := '7';
              PAEdit.Text := IntToStr(Ship.BigBays.NewPaBays);
              PAEdit.Enabled := IsActive;
            end;
    12..13: begin
              PALbl.Caption := '8';
              PAEdit.Text := IntToStr(Ship.BigBays.NewPaBays);
              PAEdit.Enabled := IsActive;
            end;
    else
      begin
        PALbl.Caption := '9';
        PAEdit.Text := IntToStr(Ship.BigBays.NewPaBays);
        PAEdit.Enabled := IsActive;
      end;
  end;
end;

procedure TBigBaysFrm.SetRepulsorBayFactors(TheTechLevel: Integer; IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..9: begin
            RepulsLbl.Caption := '0';
            RepulsorEdit.Text := '0';
            RepulsorEdit.Enabled := False;
          end;
    10: begin
          RepulsLbl.Caption := '2';
          RepulsorEdit.Text := IntToStr(Ship.BigBays.NewRepulsorBays);
          RepulsorEdit.Enabled := IsActive;
        end;
    11: begin
          RepulsLbl.Caption := '4';
          RepulsorEdit.Text := IntToStr(Ship.BigBays.NewRepulsorBays);
          RepulsorEdit.Enabled := IsActive;
        end;
    12: begin
          RepulsLbl.Caption := '6';
          RepulsorEdit.Text := IntToStr(Ship.BigBays.NewRepulsorBays);
          RepulsorEdit.Enabled := IsActive;
        end;
    13: begin
          RepulsLbl.Caption := '7';
          RepulsorEdit.Text := IntToStr(Ship.BigBays.NewRepulsorBays);
          RepulsorEdit.Enabled := IsActive;
        end;
    14: begin
          RepulsLbl.Caption := '8';
          RepulsorEdit.Text := IntToStr(Ship.BigBays.NewRepulsorBays);
          RepulsorEdit.Enabled := IsActive;
        end;
    else
      begin
        RepulsLbl.Caption := '9';
        RepulsorEdit.Text := IntToStr(Ship.BigBays.NewRepulsorBays);
        RepulsorEdit.Enabled := IsActive;
      end;
  end;
end;

procedure TBigBaysFrm.SetMissileBayFactors(TheTechLevel: Integer; IsActive: Boolean);
begin
  Case (TheTechLevel) of
    0..6: begin
            MissileLbl.Caption := '0';
            MissileEdit.Text := '0';
            MissileEdit.Enabled := False;
          end;
    7: begin
         MissileLbl.Caption := '7';
         MissileEdit.Text := IntToStr(Ship.BigBays.NewMissileBays);
         MissileEdit.Enabled := IsActive;
       end;
    8..9: begin
            MissileLbl.Caption := '7';
            MissileEdit.Text := IntToStr(Ship.BigBays.NewMissileBays);
            MissileEdit.Enabled := IsActive;
          end;
    10..11: begin
              MissileLbl.Caption := '8';
              MissileEdit.Text := IntToStr(Ship.BigBays.NewMissileBays);
              MissileEdit.Enabled := IsActive;
            end;
    else
      begin
        MissileLbl.Caption := '9';
        MissileEdit.Text := IntToStr(Ship.BigBays.NewMissileBays);
        MissileEdit.Enabled := IsActive;
      end;
  end;
end;

procedure TBigBaysFrm.DisableDuplicates;
//disable weapon types that appear elsewhere in the ship

begin
  //spinal mounts
  DisableSpinals;
  //50t bays
  DisableLittleBays;
  //turrets
  DisableTurrets;
end;

procedure TBigBaysFrm.DisableSpinals;
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

procedure TBigBaysFrm.DisableLittleBays;
begin
  if (Ship.LittleBays.RefitMesonBays) then
  begin
    if (Ship.LittleBays.NewMesonBays > 0) then
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
    if (Ship.LittleBays.MesonBays > 0) then
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
  if (Ship.LittleBays.RefitPaBays) then
  begin
    if (Ship.LittleBays.NewPABays > 0) then
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
    if (Ship.LittleBays.PABays > 0) then
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
  if (Ship.LittleBays.RefitRepulsorBays) then
  begin
    if (Ship.LittleBays.NewRepulsorBays > 0) then
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
    if (Ship.LittleBays.RepulsorBays > 0) then
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
  if (Ship.LittleBays.RefitMissileBays) then
  begin
    if (Ship.LittleBays.NewMissileBays > 0) then
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
    if (Ship.LittleBays.MissileBays > 0) then
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

procedure TBigBaysFrm.DisableTurrets;
begin
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
  end;
end;

procedure TBigBaysFrm.SetRefitData;
begin
  RefitEmptyChkBx.Checked := not Ship.BigBays.RefitEmptyBays;
  RefitEmptyChkBx.Checked := Ship.BigBays.RefitEmptyBays;

  RefitMesonChkBx.Checked := not Ship.BigBays.RefitMesonBays;
  RefitMesonChkBx.Checked := Ship.BigBays.RefitMesonBays;
  SetMesonBayFactors(Ship.BigBays.MesonBaysRefitTech, Ship.BigBays.RefitMesonBays);

  RefitPaChkBx.Checked := not Ship.BigBays.RefitPaBays;
  RefitPaChkBx.Checked := Ship.BigBays.RefitPaBays;
  SetPaBayFactors(Ship.BigBays.PaBaysRefitTech, Ship.BigBays.RefitPaBays);

  RefitRepulsorChkBx.Checked := not Ship.BigBays.RefitRepulsorBays;
  RefitRepulsorChkBx.Checked := Ship.BigBays.RefitRepulsorBays;
  SetRepulsorBayFactors(Ship.BigBays.RepulsorBaysRefitTech, Ship.BigBays.RefitRepulsorBays);

  RefitMissileChkBx.Checked := not Ship.BigBays.RefitMissileBays;
  RefitMissileChkBx.Checked := Ship.BigBays.RefitMissileBays;
  SetMissileBayFactors(Ship.BigBays.MissileBaysRefitTech, Ship.BigBays.RefitMissileBays);
end;

procedure TBigBaysFrm.SetNonRefitData;
begin
  EmptyEdit.Text := IntToStr(Ship.BigBays.EmptyBays);
  MesonEdit.Text := IntToStr(Ship.BigBays.MesonBays);
  PAEdit.Text := IntToStr(Ship.BigBays.PABays);
  RepulsorEdit.Text := IntToStr(Ship.BigBays.RepulsorBays);
  MissileEdit.Text := IntToStr(Ship.BigBays.MissileBays);
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

procedure TBigBaysFrm.SendData;
begin
  if (Ship.IsRefitted) then
  begin
    Ship.BigBays.NewEmptyBays := StrToInt(EmptyEdit.Text);
    Ship.BigBays.NewMesonBays := StrToInt(MesonEdit.Text);
    Ship.BigBays.NewPABays := StrToInt(PAEdit.Text);
    Ship.BigBays.NewRepulsorBays := StrToInt(RepulsorEdit.Text);
    Ship.BigBays.NewMissileBays := StrToInt(MissileEdit.Text);
    Ship.BigBays.RefitEmptyBays := RefitEmptyChkBx.Checked;
    Ship.BigBays.RefitMesonBays := RefitMesonChkBx.Checked;
    Ship.BigBays.RefitPaBays := RefitPaChkBx.Checked;
    Ship.BigBays.RefitRepulsorBays := RefitRepulsorChkBx.Checked;
    Ship.BigBays.RefitMissileBays := RefitMissileChkBx.Checked;
    Ship.BigBays.MesonBaysRefitTech := StrToInt(RefitMesonEdit.Text);
    Ship.BigBays.PaBaysRefitTech := StrToInt(RefitPaEdit.Text);
    Ship.BigBays.RepulsorBaysRefitTech := StrToInt(RefitRepulsorEdit.Text);
    Ship.BigBays.MissileBaysRefitTech := StrToInt(RefitMissileEdit.Text);
  end
  else
  begin
    Ship.BigBays.EmptyBays := StrToInt(EmptyEdit.Text);
    Ship.BigBays.MesonBays := StrToInt(MesonEdit.Text);
    Ship.BigBays.PABays := StrToInt(PAEdit.Text);
    Ship.BigBays.RepulsorBays := StrToInt(RepulsorEdit.Text);
    Ship.BigBays.MissileBays := StrToInt(MissileEdit.Text);
  end;
end;

function TBigBaysFrm.Warn(TheMessage: String): Boolean;
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

procedure TBigBaysFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateBigBaysDetails);
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

function TBigBaysFrm.GenerateBigBaysDetails: String;
//generate 100 ton bay file details

begin
  Result := EmptyEdit.Text
        + SEP + MesonEdit.Text
        + SEP + PAEdit.Text
        + SEP + RepulsorEdit.Text
        + SEP + MissileEdit.Text
        + SEP + BoolToStr(RefitEmptyChkBx.Checked)       //5
        + SEP + BoolToStr(RefitMesonChkBx.Checked)       //6
        + SEP + BoolToStr(RefitPaChkBx.Checked)          //7
        + SEP + BoolToStr(RefitRepulsorChkBx.Checked)    //8
        + SEP + BoolToStr(RefitMissileChkBx.Checked)     //9
        + SEP + RefitMesonEdit.Text    //10
        + SEP + RefitPaEdit.Text       //11
        + SEP + RefitRepulsorEdit.Text //12
        + SEP + RefitMissileEdit.Text  //13
        + SEP + EmptyEdit.Text          //14
        + SEP + MesonEdit.Text          //15
        + SEP + PAEdit.Text             //16
        + SEP + RepulsorEdit.Text       //17
        + SEP + MissileEdit.Text        //18
        + SEP + '0'                                     //19
        + SEP + '0'                                     //20
        + SEP + '0'                                     //21
        + SEP + '0'                                     //22
        + SEP + '0'                                     //23
        + SEP + '0'                                     //24
        + SEP + '0'                                     //25
        + SEP + '0'                                     //26
        + SEP + '0'                                     //27
        + SEP + '0'                                     //28
        ;  //terminator
end;

procedure TBigBaysFrm.ForceRefits;
var
  iEmpty: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    iEmpty := Ship.BigBays.EmptyBays;
    //sand casters
    //repulsors
    if (Ship.BigBays.RepulsorBays > 0)
        and ((Ship.LittleBays.RefitRepulsorBays) and (Ship.LittleBays.NewRepulsorBays > 0)) then
    begin
      RefitRepulsorChkBx.Checked := True;
      RefitRepulsorChkBx.Enabled := False;
      RepulsorEdit.Text := '0';
      RepulsorEdit.Enabled := False;
      RefitRepulsorEdit.Enabled := False;
      iEmpty := iEmpty + Ship.BigBays.RepulsorBays;
    end;
    //lasers
    //energy weapons
    //Particle Accelerators
    if (Ship.BigBays.PABays > 0)
        and (((Ship.SpinalMount.RefitSpinalMount) and (Ship.SpinalMount.NewSpinalType = 2))
        or ((Ship.LittleBays.RefitPaBays) and (Ship.LittleBays.NewPaBays > 0))
        or ((Ship.Turrets.RefitPaTurrets) and (Ship.Turrets.NewPaTurrets > 0))) then
    begin
      RefitPaChkBx.Checked := True;
      RefitPaChkBx.Enabled := False;
      PaEdit.Text := '0';
      PaEdit.Enabled := False;
      RefitPaEdit.Enabled := False;
      iEmpty := iEmpty + Ship.BigBays.PaBays;
    end;
    //meson guns
    if (Ship.BigBays.MesonBays > 0)
        and (((Ship.SpinalMount.RefitSpinalMount) and (Ship.SpinalMount.NewSpinalType = 1))
        or ((Ship.LittleBays.RefitMesonBays) and (Ship.LittleBays.NewMesonBays > 0))) then
    begin
      RefitMesonChkBx.Checked := True;
      RefitMesonChkBx.Enabled := False;
      MesonEdit.Text := '0';
      MesonEdit.Enabled := False;
      RefitMesonEdit.Enabled := False;
      iEmpty := iEmpty + Ship.BigBays.MesonBays;
    end;
    //missiles
    if (Ship.BigBays.MissileBays > 0)
        and (((Ship.LittleBays.RefitMissileBays) and (Ship.LittleBays.NewMissileBays > 0))
        or ((Ship.Turrets.RefitMissileTurrets) and (Ship.Turrets.NewMissileTurrets > 0))
        or ((Ship.Turrets.RefitMixTurrets) and (Ship.Turrets.NewMixTurretMissiles > 0))) then
    begin
      RefitMissileChkBx.Checked := True;
      RefitMissileChkBx.Enabled := False;
      MissileEdit.Text := '0';
      MissileEdit.Enabled := False;
      RefitMissileEdit.Enabled := False;
      iEmpty := iEmpty + Ship.BigBays.MissileBays;
    end;

    //empty bays
    if (iEmpty > Ship.BigBays.EmptyBays) then
    begin
      RefitEmptyChkBx.Checked := True;
      EmptyEdit.Enabled := True;
      EmptyEdit.Text := IntToStr(iEmpty);
    end;
  end;
end;

end.
