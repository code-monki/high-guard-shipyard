unit TurretsFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShipPas, Math, DesAssistFrmPas;

type

  { TTurretsFrm }

  TTurretsFrm = class(TForm)
    BatStatLbl: TLabel;
    EmptyComboBx: TComboBox;
    EmptyEdit: TEdit;
    EmptyStatLbl: TLabel;
    EnergyBatEdit: TEdit;
    EnergyComboBx: TComboBox;
    EnergyEdit: TEdit;
    EnergyLbl: TLabel;
    EnergyRadGrp: TRadioGroup;
    EnergyStatLbl: TLabel;
    FactorStatLbl: TLabel;
    LaserRadGrp: TRadioGroup;
    mIXLaserRadGrp: TRadioGroup;
    MixedRadGrp: TRadioGroup;
    MixEnergyLbl: TLabel;
    LaserBatEdit: TEdit;
    LaserComboBx: TComboBox;
    LaserEdit: TEdit;
    LaserLbl: TLabel;
    LaserStatLbl: TLabel;
    MainPnl: TPanel;
    HardPointsStatLbl: TLabel;
    HardPointsLbl: TLabel;
    MissileBatEdit: TEdit;
    MissileComboBx: TComboBox;
    MissileEdit: TEdit;
    MissileLbl: TLabel;
    MissileStatLbl: TLabel;
    CancelBtn: TButton;
    MixEnergyEdit: TEdit;
    OKBtn: TButton;
    MultiPnl: TPanel;
    MixMissileLbl: TLabel;
    MixLaserLbl: TLabel;
    MixSandLbl: TLabel;
    MixEmptyStatLbl: TLabel;
    MixMissileStatLbl: TLabel;
    MixLaserStatLbl: TLabel;
    MixSandStatLbl: TLabel;
    MixTurretsStatLbl: TLabel;
    MixEmptyEdit: TEdit;
    MixMissileEdit: TEdit;
    MixLaserEdit: TEdit;
    MixSandEdit: TEdit;
    MixComboBx: TComboBox;
    MixTypeStatLbl: TLabel;
    MixFactorStatLbl: TLabel;
    NumStatLbl: TLabel;
    MixTurretsEdit: TEdit;
    PABatEdit: TEdit;
    PAComboBx: TComboBox;
    PAEdit: TEdit;
    PALbl: TLabel;
    PAStatLbl: TLabel;
    PATypeLbl: TLabel;
    PerTurretStatLbl: TLabel;
    MixNumStatLbl: TLabel;
    SandBatEdit: TEdit;
    SandComboBx: TComboBox;
    SandEdit: TEdit;
    SandLbl: TLabel;
    SandStatLbl: TLabel;
    SinglePnl: TPanel;
    MixEnergyStatTxt: TStaticText;
    TurretsStatLbl: TLabel;
    TypeStatLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MixedRadGrpClick(Sender: TObject);
    procedure MixEnergyEditChange(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MixMissileEditChange(Sender: TObject);
    procedure MixLaserEditChange(Sender: TObject);
    procedure MixSandEditChange(Sender: TObject);
    procedure PAEditChange(Sender: TObject);
    procedure PAComboBxChange(Sender: TObject);
    procedure PABatEditChange(Sender: TObject);
    procedure MissileEditChange(Sender: TObject);
    procedure MissileComboBxChange(Sender: TObject);
    procedure MissileBatEditChange(Sender: TObject);
    procedure LaserEditChange(Sender: TObject);
    procedure LaserComboBxChange(Sender: TObject);
    procedure LaserBatEditChange(Sender: TObject);
    procedure LaserRadGrpClick(Sender: TObject);
    procedure EnergyEditChange(Sender: TObject);
    procedure EnergyComboBxChange(Sender: TObject);
    procedure EnergyBatEditChange(Sender: TObject);
    procedure EnergyRadGrpClick(Sender: TObject);
    procedure SandEditChange(Sender: TObject);
    procedure SandComboBxChange(Sender: TObject);
    procedure SandBatEditChange(Sender: TObject);
    procedure MixTurretsEditChange(Sender: TObject);
    procedure MixEmptyEditChange(Sender: TObject);
    procedure EmptyEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function GetTurretStyle(Style : String) : Integer;
    function SetTurretStyle(Style : Integer) : String;
    function HardPointsRem : Integer;
    function TrapErrors : Boolean;
    function CalcMissileFac : String;
    function CalcLaserFac : String;
    function CalcEnergyFac : String;
    function CalcSandFac : String;
    function CalcPAFac : String;
    function CalcBLaserFac : String;
    function CalcPLaserFac : String;
    function CalcPGunFac : String;
    function CalcFGunFac : String;
    function Warn(TheMessage : String) : Boolean;
    function GenerateTurretDetails : String;
    procedure DisableDuplicates;
    procedure DisableByTechLevel;
  public
    { Public declarations }
  end;

var
  TurretsFrm: TTurretsFrm;
  iTest: Integer;
  sTest: String;
  eTest: Extended;
  bTest: Boolean;

implementation

uses MainPas;

{$R *.lfm}

procedure TTurretsFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TTurretsFrm.MixedRadGrpClick(Sender: TObject);
begin
   Case (MixedRadGrp.ItemIndex) of
   0: begin
         SinglePnl.Enabled := False;
         //SinglePnl.Visible := False;
         MultiPnl.Enabled := True;
         //MultiPnl.Visible := True;
      end;
   1: Begin
         SinglePnl.Enabled := True;
         //SinglePnl.Visible := True;
         MultiPnl.Enabled := False;
         //MultiPnl.Visible := False;
      end;
   end;
end;

procedure TTurretsFrm.MixEnergyEditChange(Sender: TObject);
begin
  if (MixEnergyEdit.Text = '') then
  begin
    abort;
  end;
  MixEnergyLbl.Caption := '0';
  Case (EnergyRadGrp.ItemIndex) of
    0: if (StrToInt(MixEnergyEdit.Text) > 0) then
       begin
         if (Ship.TechLevel > 11) then
         begin
           MixEnergyLbl.Caption := '3';
         end
         else if (Ship.TechLevel > 10) then
         begin
           MixEnergyLbl.Caption:= '2';
         end
         else
         begin
           MixEnergyLbl.Caption := '1';
         end;
       end
       else
       begin
         MixEnergyLbl.Caption := '0';
       end;
  1: if (StrToInt(MixEnergyEdit.Text) > 0) then
     begin
         if (Ship.TechLevel > 13) then
         begin
           MixEnergyLbl.Caption := '5';
         end
         else
         begin
           MixEnergyLbl.Caption := '4';
         end;
     end
     else
     begin
       MixEnergyLbl.Caption := '0';
     end;
  end;
end;

procedure TTurretsFrm.OKBtnClick(Sender: TObject);
begin
   if (TrapErrors) then begin
      exit;
   end;
   Ship.Turrets.EmptyTurrets := StrToInt(EmptyEdit.Text);
   Ship.Turrets.EmptyTurretStyle := GetTurretStyle(EmptyComboBx.Text);
   Ship.Turrets.MissileTurrets := StrToInt(MissileEdit.Text);
   Ship.Turrets.MissileTurretStyle := GetTurretStyle(MissileComboBx.Text);
   Ship.Turrets.MissileBatteries := StrToInt(MissileBatEdit.Text);
   Ship.Turrets.LaserTurrets := StrToInt(LaserEdit.Text);
   Ship.Turrets.LaserTurretStyle := GetTurretStyle(LaserComboBx.Text);
   Ship.Turrets.LaserBatteries := StrToInt(LaserBatEdit.Text);
   Ship.Turrets.LaserType := LaserRadGrp.ItemIndex;
   Ship.Turrets.EnergyTurrets := StrToInt(EnergyEdit.Text);
   Ship.Turrets.EnergyTurretStyle := GetTurretStyle(EnergyComboBx.Text);
   Ship.Turrets.EnergyBatteries := StrToInt(EnergyBatEdit.Text);
   Ship.Turrets.EnergyType := EnergyRadGrp.ItemIndex;
   Ship.Turrets.SandTurrets := StrToInt(SandEdit.Text);
   Ship.Turrets.SandTurretStyle := GetTurretStyle(SandComboBx.Text);
   Ship.Turrets.SandBatteries := StrToInt(SandBatEdit.Text);
   Ship.Turrets.PATurrets := StrToInt(PAEdit.Text);
   Ship.Turrets.PATurretStyle := GetTurretStyle(PAComboBx.Text);
   Ship.Turrets.PABatteries := StrToInt(PABatEdit.Text);
   Ship.Turrets.MixedTurrets := MixedRadGrp.ItemIndex;
   iTest := StrToInt(MixTurretsEdit.Text);
   iTest := StrToInt(MixEmptyEdit.Text);
   Ship.Turrets.NumMixTurrets := StrToInt(MixTurretsEdit.Text);
   Ship.Turrets.MixTurretStyle := GetTurretStyle(MixComboBx.Text);
   Ship.Turrets.EmptyMixTurrets := StrToInt(MixEmptyEdit.Text);
   Ship.Turrets.MixTurretMissiles := StrToInt(MixMissileEdit.Text);
   Ship.Turrets.MixTurretLasers := StrToInt(MixLaserEdit.Text);
   //Ship.Turrets.MixLaserType := MixLaserRadGrp.ItemIndex;
   Ship.Turrets.MixTurretSand := StrToInt(MixSandEdit.Text);
   Ship.Turrets.MixTurretEnergy := StrToInt(MixEnergyEdit.Text);
   Ship.DesignShip;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TTurretsFrm.CancelBtnClick(Sender: TObject);
begin
   Close;
end;

function TTurretsFrm.GetTurretStyle(Style: String): Integer;
begin
   Case (Style[1]) of
   'N': Result := 0;
   'S': Result := 1;
   'D': Result := 2;
   'T': Result := 3;
   end;
end;

function TTurretsFrm.HardPointsRem: Integer;
var
   HardPoints : Integer;
   FormTurrets, ExistingTurrets : Integer;
begin
   HardPoints := Ship.GetRemHardPoints;
   if (Ship.Turrets.MixedTurrets = 0) then begin
      ExistingTurrets := Ship.Turrets.NumMixTurrets;
   end
   else begin
      ExistingTurrets := (Ship.Turrets.EmptyTurrets + Ship.Turrets.MissileTurrets + Ship.Turrets.LaserTurrets
            + Ship.Turrets.EnergyTurrets + Ship.Turrets.SandTurrets + Ship.Turrets.PATurrets);
   end;
   if (MixedRadGrp.ItemIndex = 0) then begin
      FormTurrets := StrToInt(MixTurretsEdit.Text);
   end
   else begin
      FormTurrets := StrToInt(EmptyEdit.Text) + StrToInt(MissileEdit.Text)
            + StrToInt(LaserEdit.Text) + StrToInt(EnergyEdit.Text)
            + StrToInt(SandEdit.Text) + StrToInt(PAEdit.Text);
   end;
   Result := HardPoints + ExistingTurrets - FormTurrets;
end;

procedure TTurretsFrm.FormCreate(Sender: TObject);
var
  iTest: Integer;
  sTest: String;
begin
   EmptyEdit.Text := IntToStr(Ship.Turrets.EmptyTurrets);
   EmptyComboBx.Text := SetTurretStyle(Ship.Turrets.EmptyTurretStyle);
   MissileEdit.Text := IntToStr(Ship.Turrets.MissileTurrets);
   MissileComboBx.Text := SetTurretStyle(Ship.Turrets.MissileTurretStyle);
   MissileBatEdit.Text := IntToStr(Ship.Turrets.MissileBatteries);
   LaserRadGrp.ItemIndex := Ship.Turrets.LaserType;
   LaserEdit.Text := IntToStr(Ship.Turrets.LaserTurrets);
   LaserComboBx.Text := SetTurretStyle(Ship.Turrets.LaserTurretStyle);
   LaserBatEdit.Text := IntToStr(Ship.Turrets.LaserBatteries);
   EnergyRadGrp.ItemIndex := Ship.Turrets.EnergyType;
   EnergyEdit.Text := IntToStr(Ship.Turrets.EnergyTurrets);
   EnergyComboBx.Text := SetTurretStyle(Ship.Turrets.EnergyTurretStyle);
   EnergyBatEdit.Text := IntToStr(Ship.Turrets.EnergyBatteries);
   SandEdit.Text := IntToStr(Ship.Turrets.SandTurrets);
   SandComboBx.Text := SetTurretStyle(Ship.Turrets.SandTurretStyle);
   SandBatEdit.Text := IntToStr(Ship.Turrets.SandBatteries);
   PAEdit.Text := IntToStr(Ship.Turrets.PATurrets);
   PAComboBx.Text := SetTurretStyle(Ship.Turrets.PATurretStyle);
   PABatEdit.Text := IntToStr(Ship.Turrets.PABatteries);
   if (Ship.TechLevel < 14) then PATypeLbl.Caption := 'Not Available';
   if (Ship.TechLevel = 14) then PATypeLbl.Caption := 'Barbette';
   if (Ship.TechLevel = 15) then PATypeLbl.Caption := 'Turret';
   iTest := MixedRadGrp.itemIndex;
   MixedRadGrp.itemIndex := Ship.Turrets.MixedTurrets;
   sTest := IntToStr(Ship.Turrets.NumMixTurrets);
   MixTurretsEdit.Text := IntToStr(Ship.Turrets.NumMixTurrets);
   sTest := SetTurretStyle(Ship.Turrets.MixTurretStyle);
   MixComboBx.Text := SetTurretStyle(Ship.Turrets.MixTurretStyle);
   sTest := IntToStr(Ship.Turrets.EmptyMixTurrets);
   MixEmptyEdit.Text := IntToStr(Ship.Turrets.EmptyMixTurrets);
   sTest := IntToStr(Ship.Turrets.MixTurretMissiles);
   MixMissileEdit.Text := IntToStr(Ship.Turrets.MixTurretMissiles);
   //iTest := Ship.Turrets.MixLaserType;
   iTest := Ship.Turrets.LaserType;
   //MixLaserRadGrp.ItemIndex := Ship.Turrets.MixLaserType;
   sTest := IntToStr(Ship.Turrets.MixTurretLasers);
   MixLaserEdit.Text := IntToStr(Ship.Turrets.MixTurretLasers);
   sTest := IntToStr(Ship.Turrets.MixTurretSand);
   MixSandEdit.Text := IntToStr(Ship.Turrets.MixTurretSand);
   MixEnergyEdit.Text := IntToStr(Ship.Turrets.MixTurretEnergy);
   DisableDuplicates;
   DisableByTechLevel;
   if (Ship.Tonnage > 1000) then begin
      MixedRadGrp.ItemIndex := 1;
      MixedRadGrp.Enabled := False;
   end
   else begin
      MixedRadGrp.Enabled := True;
   end;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (MixedRadGrp.ItemIndex = 0) then
   begin
      MultiPnl.Enabled := True;
      SinglePnl.Enabled := False;
   end
   else
   begin
      MultiPnl.Enabled := False;
      SinglePnl.Enabled := True;
   end;
   (*SinglePnl.Left := MultiPnl.Left - 65;
   SinglePnl.Top := MultiPnl.Top;
   MainPnl.Width := 295;
   if (MixedRadGrp.ItemIndex = 0) then
   begin
     SinglePnl.Visible := False;
     MultiPnl.Visible := True;
   end; *)
end;

function TTurretsFrm.SetTurretStyle(Style: Integer): String;
begin
   Case (Style) of
   0: Result := 'None';
   1: Result := 'Single';
   2: Result := 'Dual';
   3: Result := 'Triple';
   end;
end;

function TTurretsFrm.TrapErrors: Boolean;
var
  MixTurretWpnCount: Extended;
begin
   Result := False;
   if (EmptyEdit.Text = '') then begin
      MessageDlg('No Value for Empty Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (EmptyComboBx.Text = '') then begin
      MessageDlg('Empty Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MissileEdit.Text = '') then begin
      MessageDlg('No Value for Missile Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MissileComboBx.Text = '') then begin
      MessageDlg('Missile Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MissileBatEdit.Text = '') then begin
      MessageDlg('No Value for Missile Batteries Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LaserEdit.Text = '') then begin
      MessageDlg('No Value for Laser Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LaserComboBx.Text = '') then begin
      MessageDlg('Laser Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LaserBatEdit.Text = '') then begin
      MessageDlg('No Value for Laser Batteries Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (EnergyEdit.Text = '') then begin
      MessageDlg('No Value for Energy Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (EnergyComboBx.Text = '') then begin
      MessageDlg('Energy Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (EnergyBatEdit.Text = '') then begin
      MessageDlg('No Value for Energy Batteries Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (SandEdit.Text = '') then begin
      MessageDlg('No Value for Sandcaster Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (SandComboBx.Text = '') then begin
      MessageDlg('Sandcaster Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (SandBatEdit.Text = '') then begin
      MessageDlg('No Value for Sandcaster Batteries Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (PAEdit.Text = '') then begin
      MessageDlg('No Value for Particle Accelerator Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (PAComboBx.Text = '') then begin
      MessageDlg('Particle Accelerator Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (PABatEdit.Text = '') then begin
      MessageDlg('No Value for Particle Accelerator Batteries Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixTurretsEdit.Text = '') then begin
      MessageDlg('No Value for the number of Mixed Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixComboBx.Text = '') then begin
      MessageDlg('Mixed Turret Type not selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixEmptyEdit.Text = '') then begin
      MessageDlg('No Value for Mixed Empty Turrets Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixMissileEdit.Text = '') then begin
      MessageDlg('No Value for Missile Launchers per Mixed Turret Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixLaserEdit.Text = '') then begin
      MessageDlg('No Value for Lasers per Mixed Turret Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixEnergyEdit.Text = '') then begin
      MessageDlg('No Value for Energy per Mixed Turret Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixSandEdit.Text = '') then begin
      MessageDlg('No Value for Sandcasters per Mixed Turret Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(EmptyEdit.Text, 3) = 3) and
         (StrToIntDef(EmptyEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Empty Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MissileEdit.Text, 3) = 3) and
         (StrToIntDef(MissileEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Missile Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MissileBatEdit.Text, 3) = 3) and
         (StrToIntDef(MissileBatEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Missile Batteries must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(LaserEdit.Text, 3) = 3) and
         (StrToIntDef(LaserEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Laser Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(LaserBatEdit.Text, 3) = 3) and
         (StrToIntDef(LaserBatEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Laser Batteries must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(EnergyEdit.Text, 3) = 3) and
         (StrToIntDef(EnergyEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Energy Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(EnergyBatEdit.Text, 3) = 3) and
         (StrToIntDef(EnergyBatEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Energy Batteries must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(SandEdit.Text, 3) = 3) and
         (StrToIntDef(SandEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Sandcaster Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(SandBatEdit.Text, 3) = 3) and
         (StrToIntDef(SandBatEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Sandcaster Batteries must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(PAEdit.Text, 3) = 3) and
         (StrToIntDef(PAEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Particle Accelerator Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(PABatEdit.Text, 3) = 3) and
         (StrToIntDef(PABatEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Particle Accelerator Batteries must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MixTurretsEdit.Text, 3) = 3) and
         (StrToIntDef(MixTurretsEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Mixed Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MixEmptyEdit.Text, 3) = 3) and
         (StrToIntDef(MixEmptyEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Empty Mixed Turrets must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MixMissileEdit.Text, 3) = 3) and
         (StrToIntDef(MixMissileEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Missiles per Mixed Turret must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MixLaserEdit.Text, 3) = 3) and
         (StrToIntDef(MixLaserEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Lasers per Mixed Turret must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MixEnergyEdit.Text, 3) = 3) and
         (StrToIntDef(MixEnergyEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Energy per Mixed Turret must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(MixSandEdit.Text, 3) = 3) and
         (StrToIntDef(MixSandEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Sandcasters per Mixed Turret must be an integer value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(EmptyEdit.Text) < 0) then begin
      MessageDlg('Empty Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MissileEdit.Text) < 0) then begin
      MessageDlg('Missile Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MissileBatEdit.Text) < 0) then begin
      MessageDlg('Missile Batteries may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(LaserEdit.Text) < 0) then begin
      MessageDlg('Laser Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(LaserBatEdit.Text) < 0) then begin
      MessageDlg('Laser Batteries may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(EnergyEdit.Text) < 0) then begin
      MessageDlg('Energy Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(EnergyBatEdit.Text) < 0) then begin
      MessageDlg('Energy Batteries may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(SandEdit.Text) < 0) then begin
      MessageDlg('Sandcaster Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(SandBatEdit.Text) < 0) then begin
      MessageDlg('Sandcaster Batteries may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(PAEdit.Text) < 0) then begin
      MessageDlg('Particle Accelerator Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(PABatEdit.Text) < 0) then begin
      MessageDlg('Particle Accelerator Batteries may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MixTurretsEdit.Text) < 0) then begin
      MessageDlg('Number of Mixed Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MixEmptyEdit.Text) < 0) then begin
      MessageDlg('Number of Empty Mixed Turrets may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MixMissileEdit.Text) < 0) then begin
      MessageDlg('Number of Missiles per Mixed Turret may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MixLaserEdit.Text) < 0) then begin
      MessageDlg('Number of Lasers per Mixed Turret may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MixEnergyEdit.Text) < 0) then begin
      MessageDlg('Number of Energy Weapons per Mixed Turret may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MixSandEdit.Text) < 0) then begin
      MessageDlg('Number of Sandcasters per Mixed Turret may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LaserRadGrp.ItemIndex = -1) then begin
      MessageDlg('No Laser Type has been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (EnergyRadGrp.ItemIndex = -1) then begin
      MessageDlg('No Energy Type has been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixedRadGrp.ItemIndex = -1) then begin
      MessageDlg('Mixed Weapon Type Turrets or Single Weapon Type Turrets has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
(*
   if (EmptyComboBx.Text = 'None') and (StrToInt(EmptyEdit.Text) > 0) then begin
      MessageDlg('Empty Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
*)
   if (MissileComboBx.Text = 'None') and (StrToInt(MissileEdit.Text) > 0) then begin
      MessageDlg('Missile Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LaserComboBx.Text = 'None') and (StrToInt(LaserEdit.Text) > 0) then begin
      MessageDlg('Laser Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (EnergyComboBx.Text = 'None') and (StrToInt(EnergyEdit.Text) > 0) then begin
      MessageDlg('Energy Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (SandComboBx.Text = 'None') and (StrToInt(SandEdit.Text) > 0) then begin
      MessageDlg('Sandcaster Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (PAComboBx.Text = 'None') and (StrToInt(PAEdit.Text) > 0) then begin
      MessageDlg('Particle Accelerator Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (MixComboBx.Text = 'None')
         and ((StrToInt(MixTurretsEdit.Text) - StrToInt(MixEmptyEdit.Text)) > 0) then begin
      MessageDlg('Mixed Turret Type has not been selected', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(MissileBatEdit.Text) = 0) and (StrToInt(MissileEdit.Text) > 0) then begin
      MessageDlg('Missile Turrets have not been organised into Batteries', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(LaserBatEdit.Text) = 0) and (StrToInt(LaserEdit.Text) > 0) then begin
      MessageDlg('Laser Turrets have not been organised into Batteries', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(EnergyBatEdit.Text) = 0) and (StrToInt(EnergyEdit.Text) > 0) then begin
      MessageDlg('Energy Turrets have not been organised into Batteries', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(SandBatEdit.Text) = 0) and (StrToInt(SandEdit.Text) > 0) then begin
      MessageDlg('Sandcaster Turrets have not been organised into Batteries', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(PABatEdit.Text) = 0) and (StrToInt(PAEdit.Text) > 0) then begin
      MessageDlg('Particle Accelerator Turrets have not been organised into Batteries', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   MixTurretWpnCount := 0;
   MixTurretWpnCount := MixTurretWpnCount + StrToInt(MixMissileEdit.Text);
   MixTurretWpnCount := MixTurretWpnCount + StrToInt(MixLaserEdit.Text);
   MixTurretWpnCount := MixTurretWpnCount + (StrToInt(MixEnergyEdit.Text) * 1.5);
   MixTurretWpnCount := MixTurretWpnCount + StrToInt(MixSandEdit.Text);
   if (MixTurretWpnCount > GetTurretStyle(MixComboBx.Text)) then begin
      MessageDlg('Too Many Weapons per Mixed Turret', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (HardPointsRem < 0) then begin
      if (Warn('There are not enough hardpoints for the weapons installed, do you wish to alter these weapons?')) then begin
         Result := True;
         exit;
      end;
   end;
end;

procedure TTurretsFrm.DisableDuplicates;
begin
   if (Ship.BigBays.MissileBays > 0) or (Ship.LittleBays.MissileBays > 0) then begin
      MissileEdit.Text := '0';
      MissileEdit.Enabled := False;
      MissileComboBx.Text := 'None';
      MissileComboBx.Enabled := False;
      MissileBatEdit.Text := '0';
      MissileBatEdit.Enabled := False;
      MissileLbl.Caption := '0';
   end;
   if (Ship.LittleBays.EnergyBays > 0) then begin
      EnergyEdit.Text := '0';
      EnergyEdit.Enabled := False;
      EnergyComboBx.Text := 'None';
      EnergyComboBx.Enabled := False;
      EnergyBatEdit.Text := '0';
      EnergyBatEdit.Enabled := False;
      EnergyLbl.Caption := '0';
      MixEnergyEdit.Text := '0';
      MixEnergyEdit.Enabled := False;
      MixEnergyLbl.Caption := '0';
      EnergyRadGrp.ItemIndex := 0;
      EnergyRadGrp.Enabled := False;
   end;
   if (Ship.SpinalMount.SpinalType = 2) or (Ship.BigBays.PABays > 0) or (Ship.LittleBays.PABays > 0) then begin
      PAEdit.Text := '0';
      PAEdit.Enabled := False;
      PAComboBx.Text := 'None';
      PAComboBx.Enabled := False;
      PABatEdit.Text := '0';
      PABatEdit.Enabled := False;
      PALbl.Caption := '0';
   end;
end;

procedure TTurretsFrm.DisableByTechLevel;
begin
   Case (Ship.TechLevel) of
   7..8: Begin
//         LaserRadGrp.ItemIndex := 1;
//         LaserRadGrp.Enabled := False;
//         MixLaserRadGrp.ItemIndex := 1;
//         MixLaserRadGrp.Enabled := False;
         EnergyEdit.Text := '0';
         EnergyEdit.Enabled := False;
         EnergyComboBx.Text := 'None';
         EnergyComboBx.Enabled := False;
         EnergyBatEdit.Text := '0';
         EnergyBatEdit.Enabled := False;
         EnergyLbl.Caption := '0';
         EnergyRadGrp.ItemIndex := 0;
         EnergyRadGrp.Enabled := False;
         MixEnergyEdit.Text := '0';
         MixEnergyEdit.Enabled := False;
         MixEnergyLbl.Caption := '0';
         PAEdit.Text := '0';
         PAEdit.Enabled := False;
         PAComboBx.Text := 'None';
         PAComboBx.Enabled := False;
         PABatEdit.Text := '0';
         PABatEdit.Enabled := False;
         PALbl.Caption := '0';
      end;
   9: Begin
         EnergyEdit.Text := '0';
         EnergyEdit.Enabled := False;
         EnergyComboBx.Text := 'None';
         EnergyComboBx.Enabled := False;
         EnergyBatEdit.Text := '0';
         EnergyBatEdit.Enabled := False;
         EnergyLbl.Caption := '0';
         EnergyRadGrp.ItemIndex := 0;
         EnergyRadGrp.Enabled := False;
         MixEnergyEdit.Text := '0';
         MixEnergyEdit.Enabled := False;
         MixEnergyLbl.Caption := '0';
         PAEdit.Text := '0';
         PAEdit.Enabled := False;
         PAComboBx.Text := 'None';
         PAComboBx.Enabled := False;
         PABatEdit.Text := '0';
         PABatEdit.Enabled := False;
         PALbl.Caption := '0';
      end;
   10..11: Begin
         EnergyRadGrp.ItemIndex := 0;
         EnergyRadGrp.Enabled := False;
         PAEdit.Text := '0';
         PAEdit.Enabled := False;
         PAComboBx.Text := 'None';
         PAComboBx.Enabled := False;
         PABatEdit.Text := '0';
         PABatEdit.Enabled := False;
         PALbl.Caption := '0';
      end;
   12..13: Begin
         PAEdit.Text := '0';
         PAEdit.Enabled := False;
         PAComboBx.Text := 'None';
         PAComboBx.Enabled := False;
         PABatEdit.Text := '0';
         PABatEdit.Enabled := False;
         PALbl.Caption := '0';
      end;
   end;
end;

procedure TTurretsFrm.MixMissileEditChange(Sender: TObject);
begin
   if (MixMissileEdit.Text = '') then begin
      abort;
   end;
   if (StrToInt(MixMissileEdit.Text) > 0) then begin
      if (Ship.TechLevel > 12) then begin
         MixMissileLbl.Caption := '2';
      end
      else begin
         MixMissileLbl.Caption := '1';
      end;
   end
   else begin
      MixMissileLbl.Caption := '0';
   end;
end;

procedure TTurretsFrm.MixLaserEditChange(Sender: TObject);
begin
  if (MixLaserEdit.Text = '') then
  begin
    abort;
  end;
  MixLaserLbl.Caption := '0';
  //Case (MixLaserRadGrp.ItemIndex) of
  Case (LaserRadGrp.ItemIndex) of
    0: if (StrToInt(MixLaserEdit.Text) > 0) then
       begin
         if (Ship.TechLevel > 12) then
         begin
           MixLaserLbl.Caption := '2';
         end
         else
         begin
           MixLaserLbl.Caption := '1';
         end;
       end
       else
       begin
         MixLaserLbl.Caption := '0';
       end;
  1: if (StrToInt(MixLaserEdit.Text) > 0) then
     begin
       if (Ship.TechLevel > 12) then
       begin
         MixLaserLbl.Caption := '2';
       end
       else
       begin
         MixLaserLbl.Caption := '1';
       end;
     end
     else
     begin
       MixLaserLbl.Caption := '0';
     end;
  end;
end;

procedure TTurretsFrm.MixSandEditChange(Sender: TObject);
begin
   if (MixSandEdit.Text = '') then begin
      abort;
   end;
   MixSandLbl.Caption := '0';
   if (StrToInt(MixSandEdit.Text) > 0) then begin
      if (Ship.TechLevel > 9) then begin
         MixSandLbl.Caption := '3';
      end
      else if (Ship.TechLevel > 7) then begin
         MixSandLbl.Caption := '2';
      end
      else begin
         MixSandLbl.Caption := '1';
      end;
   end
   else begin
      MixSandLbl.Caption := '0';
   end;
end;

procedure TTurretsFrm.PAEditChange(Sender: TObject);
begin
   if (PAEdit.Text = '') then begin
      abort;
   end;
   PALbl.Caption := CalcPAFac;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (StrToint(PAEdit.Text) = 0) then begin
      PAComboBx.Text := 'None';
      PABatEdit.Text := '0';
   end;
   if (StrToint(PAEdit.Text) > 0) then begin
      if (PAComboBx.Text = 'None') then begin
         PAComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.PATurretStyle));
      end;
      if (StrToInt(PABatEdit.Text) = 0) then begin
         PABatEdit.Text := IntToStr(Max(1, Ship.Turrets.PABatteries));
      end;
   end;
end;

procedure TTurretsFrm.PAComboBxChange(Sender: TObject);
begin
   if (PAComboBx.Text = '') then begin
      abort;
   end;
   PALbl.Caption := CalcPAFac;
end;

procedure TTurretsFrm.PABatEditChange(Sender: TObject);
begin
   if (PABatEdit.Text = '') then begin
      abort;
   end;
   PALbl.Caption := CalcPAFac;
end;

function TTurretsFrm.CalcPAFac: String;
var
  Num, Fac: Integer;
begin
  try
    Fac := 0;
    Num := 0;
    if (StrToInt(PaBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(PAEdit.Text) div StrToInt(PABatEdit.Text))
          * GetTurretStyle(PAComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1: Fac := 1;
        2..3: Fac := 2;
        4..5: Fac := 3;
        6..7: Fac := 4;
        8..9: Fac := 5;
        else Fac := 6;
      end;
      if (Ship.Techlevel > 14) and (Fac > 0) then
      begin
        inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

function TTurretsFrm.CalcEnergyFac: String;
begin
   if (EnergyRadGrp.ItemIndex = 0) then begin
      Result := CalcPGunFac;
   end
   else if (EnergyRadGrp.ItemIndex = 1) then begin
      Result := CalcFGunFac;
   end;
end;

function TTurretsFrm.CalcLaserFac: String;
begin
   if (LaserRadGrp.ItemIndex = 0) then begin
      Result := CalcBLaserFac;
   end
   else if (LaserRadGrp.ItemIndex = 1) then begin
      Result := CalcPLaserFac;
   end;
end;

function TTurretsFrm.CalcMissileFac: String;
var
  Num, Fac: Integer;
begin
  try
    Num := 0;
    Fac := 0;
    if (StrToInt(MissileBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(MissileEdit.Text) div StrToInt(MissileBatEdit.Text))
          * GetTurretStyle(MissileComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1..2: Fac := 1;
        3..5: Fac := 2;
        6..11: Fac := 3;
        12..17: Fac := 4;
        18..29: Fac := 5;
        else Fac := 6;
      end;
      if (Ship.Techlevel > 12) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

function TTurretsFrm.CalcSandFac: String;
var
  Num, Fac: Integer;
begin
  try
    Num := 0;
    Fac := 0;
    if (StrToInt(SandBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(SandEdit.Text) div StrToInt(SandBatEdit.Text))
          * GetTurretStyle(SandComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1..2: Fac := 1;
        3..5: Fac := 2;
        6..7: Fac := 3;
        8..9: Fac := 4;
        10..20: Fac := 5;
        21..29: Fac := 6;
        else Fac := 7;
      end;
      if (Ship.Techlevel > 7) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      if (Ship.Techlevel > 9) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

function TTurretsFrm.CalcBLaserFac: String;
var
  Num, Fac: Integer;
begin
  try
    Fac := 0;
    Num := 0;
    if (StrToInt(LaserBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(LaserEdit.Text) div StrToInt(LaserBatEdit.Text))
          * GetTurretStyle(LaserComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1: Fac := 1;
        2: Fac := 2;
        3..5: Fac := 3;
        6..9: Fac := 4;
        10..14: Fac := 5;
        15..20: Fac := 6;
        21..29: Fac := 7;
        else Fac := 8;
      end;
      if (Ship.Techlevel > 12) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

function TTurretsFrm.CalcFGunFac: String;
var
  Num, Fac: Integer;
begin
  try
    Fac := 0;
    Num := 0;
    if (StrToInt(EnergyBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(EnergyEdit.Text) div StrToInt(EnergyBatEdit.Text))
          * GetTurretStyle(EnergyComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1..3: Fac := 4;
        4..9: Fac := 5;
        10..15: Fac := 6;
        16..19: Fac := 7;
        else Fac := 8;
      end;
      if (Ship.Techlevel > 13) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

function TTurretsFrm.CalcPGunFac: String;
var
  Num, Fac: Integer;
begin
  try
    Fac := 0;
    Num := 0;
    if (StrToInt(EnergyBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(EnergyEdit.Text) div StrToInt(EnergyBatEdit.Text))
          * GetTurretStyle(EnergyComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1..3: Fac := 1;
        4..9: Fac := 2;
        10..15: Fac := 3;
        16..19: Fac := 4;
        else Fac := 5;
      end;
      if (Ship.Techlevel > 10) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      if (Ship.Techlevel > 11) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

function TTurretsFrm.CalcPLaserFac: String;
var
  Num, Fac: Integer;
begin
  try
    Fac := 0;
    Num := 0;
    if (StrToInt(LaserBatEdit.Text) > 0) then
    begin
      Num := ((StrToInt(LaserEdit.Text) div StrToInt(LaserBatEdit.Text))
          * GetTurretStyle(LaserComboBx.Text));
    end;
    if (Num > 0) then
    begin
      Case (Num) of
        0: Fac := 0;
        1..2: Fac := 1;
        3..5: Fac := 2;
        6..9: Fac := 3;
        10..20: Fac := 4;
        21..29: Fac := 5;
        else Fac := 6;
      end;
      if (Ship.Techlevel > 12) and (Fac > 0) then
      begin
        Inc(Fac);
      end;
      Result := IntToStr(Fac);
    end
    else
    begin
      Result := '0';
    end;
  except
    on EDivByZero do Result := '0';
  end;
end;

procedure TTurretsFrm.MissileEditChange(Sender: TObject);
begin
  if (MissileEdit.Text = '') then
  begin
    abort;
  end;
  MissileLbl.Caption := CalcMissileFac;
  HardPointsLbl.Caption := IntToStr(HardPointsRem);
  if (StrToint(MissileEdit.Text) = 0) then
  begin
    MissileComboBx.Text := 'None';
    MissileBatEdit.Text := '0';
  end;
  if (StrToint(MissileEdit.Text) > 0) then
  begin
    if (MissileComboBx.Text = 'None') then
    begin
      MissileComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.MissileTurretStyle));
    end;
    if (StrToInt(MissileBatEdit.Text) = 0) then
    begin
      MissileBatEdit.Text := IntToStr(Max(1, Ship.Turrets.MissileBatteries));
    end;
  end;
end;

procedure TTurretsFrm.MissileComboBxChange(Sender: TObject);
begin
  if (MissileComboBx.Text = '') then
  begin
    abort;
  end;
  MissileLbl.Caption := CalcMissileFac;
end;

procedure TTurretsFrm.MissileBatEditChange(Sender: TObject);
begin
  if (MissileBatEdit.Text = '') then
  begin
    abort;
  end;
  MissileLbl.Caption := CalcMissileFac;
end;

procedure TTurretsFrm.LaserEditChange(Sender: TObject);
begin
   if (LaserEdit.Text = '') then begin
      abort;
   end;
   LaserLbl.Caption := CalcLaserFac;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (StrToint(LaserEdit.Text) = 0) then begin
      LaserComboBx.Text := 'None';
      LaserBatEdit.Text := '0';
   end;
   if (StrToint(LaserEdit.Text) > 0) then begin
      if (LaserComboBx.Text = 'None') then begin
         LaserComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.LaserTurretStyle));
      end;
      if (StrToInt(LaserBatEdit.Text) = 0) then begin
         LaserBatEdit.Text := IntToStr(Max(1, Ship.Turrets.LaserBatteries));
      end;
   end;
end;

procedure TTurretsFrm.LaserComboBxChange(Sender: TObject);
begin
   if (LaserComboBx.Text = '') then begin
      abort;
   end;
   LaserLbl.Caption := CalcLaserFac;
end;

procedure TTurretsFrm.LaserBatEditChange(Sender: TObject);
begin
   if (LaserBatEdit.Text = '') then begin
      abort;
   end;
   LaserLbl.Caption := CalcLaserFac;
end;

procedure TTurretsFrm.LaserRadGrpClick(Sender: TObject);
begin
   LaserLbl.Caption := CalcLaserFac;
   if (Ship.TechLevel < 9) and (LaserRadGrp.ItemIndex = 0) then begin
      MessageDlg('According to Book 3, Beam Lasers are not available until Tech 9.' + #13
            + 'Under High Guard they are available at Tech 7.', mtInformation, [mbOk], 0);
   end;
   //mixed turrets
  if (MixLaserEdit.Text = '') then
  begin
    abort;
  end;
  MixLaserLbl.Caption := '0';
  //Case (MixLaserRadGrp.ItemIndex) of
  Case (LaserRadGrp.ItemIndex) of
    0: if (StrToInt(MixLaserEdit.Text) > 0) then
       begin
         if (Ship.TechLevel > 12) then
         begin
           MixLaserLbl.Caption := '2';
         end
         else
         begin
           MixLaserLbl.Caption := '1';
         end;
       end
       else
       begin
         MixLaserLbl.Caption := '0';
       end;
  1: if (StrToInt(MixLaserEdit.Text) > 0) then
     begin
       if (Ship.TechLevel > 12) then
       begin
         MixLaserLbl.Caption := '2';
       end
       else
       begin
         MixLaserLbl.Caption := '1';
       end;
     end
     else
     begin
       MixLaserLbl.Caption := '0';
     end;
  end;
end;

procedure TTurretsFrm.EnergyEditChange(Sender: TObject);
begin
   if (EnergyEdit.Text = '') then begin
      abort;
   end;
   EnergyLbl.Caption := CalcEnergyFac;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (StrToint(EnergyEdit.Text) = 0) then begin
      EnergyComboBx.Text := 'None';
      EnergyBatEdit.Text := '0';
   end;
   if (StrToint(EnergyEdit.Text) > 0) then begin
      if (EnergyComboBx.Text = 'None') then begin
         EnergyComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.EnergyTurretStyle));
      end;
      if (StrToInt(EnergyBatEdit.Text) = 0) then begin
         EnergyBatEdit.Text := IntToStr(Max(1, Ship.Turrets.EnergyBatteries));
      end;
   end;
end;

procedure TTurretsFrm.EnergyComboBxChange(Sender: TObject);
begin
   if (EnergyComboBx.Text = '') then begin
      abort;
   end;
   EnergyLbl.Caption := CalcEnergyFac;
end;

procedure TTurretsFrm.EnergyBatEditChange(Sender: TObject);
begin
   if (EnergyBatEdit.Text = '') then begin
      abort;
   end;
   EnergyLbl.Caption := CalcEnergyFac;
end;

procedure TTurretsFrm.EnergyRadGrpClick(Sender: TObject);
begin
   EnergyLbl.Caption := CalcEnergyFac;
   //mixed energy
   Case (EnergyRadGrp.ItemIndex) of
     0: if (StrToInt(MixEnergyEdit.Text) > 0) then
        begin
          if (Ship.TechLevel > 11) then
          begin
            MixEnergyLbl.Caption := '3';
          end
          else if (Ship.TechLevel > 10) then
          begin
            MixEnergyLbl.Caption:= '2';
          end
          else
          begin
            MixEnergyLbl.Caption := '1';
          end;
        end
        else
        begin
          MixEnergyLbl.Caption := '0';
        end;
   1: if (StrToInt(MixEnergyEdit.Text) > 0) then
      begin
          if (Ship.TechLevel > 13) then
          begin
            MixEnergyLbl.Caption := '5';
          end
          else
          begin
            MixEnergyLbl.Caption := '4';
          end;
      end
      else
      begin
        MixEnergyLbl.Caption := '0';
      end;
   end;
end;

procedure TTurretsFrm.SandEditChange(Sender: TObject);
begin
   if (SandEdit.Text = '') then begin
      abort;
   end;
   SandLbl.Caption := CalcSandFac;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (StrToint(SandEdit.Text) = 0) then begin
      SandComboBx.Text := 'None';
      SandBatEdit.Text := '0';
   end;
   if (StrToint(SandEdit.Text) > 0) then begin
      if (SandComboBx.Text = 'None') then begin
         SandComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.SandTurretStyle));
      end;
      if (StrToInt(SandBatEdit.Text) = 0) then begin
         SandBatEdit.Text := IntToStr(Max(1, Ship.Turrets.SandBatteries));
      end;
   end;
end;

procedure TTurretsFrm.SandComboBxChange(Sender: TObject);
begin
   if (SandComboBx.Text = '') then begin
      abort;
   end;
   SandLbl.Caption := CalcSandFac;
end;

procedure TTurretsFrm.SandBatEditChange(Sender: TObject);
begin
   if (SandBatEdit.Text = '') then begin
      abort;
   end;
   SandLbl.Caption := CalcSandFac;
end;

function TTurretsFrm.Warn(TheMessage: String): Boolean;
begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TTurretsFrm.MixTurretsEditChange(Sender: TObject);
begin
   if (MixTurretsEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (StrToint(MixTurretsEdit.Text) = 0) then begin
      MixComboBx.Text := 'None';
      MixEmptyEdit.Text := '0';
      MixMissileEdit.Text := '0';
      MixLaserEdit.Text := '0';
      MixSandEdit.Text := '0';
   end;
   if (StrToint(MixTurretsEdit.Text) > 0) then begin
      if (MixComboBx.Text = 'None') then begin
//         MixComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.MixTurretStyle));
      end;
      if (StrToInt(MixEmptyEdit.Text) = 0) then begin
         MixEmptyEdit.Text := IntToStr(Ship.Turrets.EmptyMixTurrets);
      end;
      if (StrToInt(MixMissileEdit.Text) = 0) then begin
         MixMissileEdit.Text := IntToStr(Ship.Turrets.MixTurretMissiles);
      end;
      if (StrToInt(MixLaserEdit.Text) = 0) then begin
         MixLaserEdit.Text := IntToStr(Ship.Turrets.MixTurretLasers);
      end;
      if (StrToInt(MixEmptyEdit.Text) = 0) then begin
         MixSandEdit.Text := IntToStr(Ship.Turrets.MixTurretSand);
      end;
   end;
end;

procedure TTurretsFrm.MixEmptyEditChange(Sender: TObject);
begin
   if (MixEmptyEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
end;

procedure TTurretsFrm.EmptyEditChange(Sender: TObject);
begin
   if (EmptyEdit.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(HardPointsRem);
   if (StrToint(EmptyEdit.Text) = 0) then begin
      EmptyComboBx.Text := 'None';
   end;
(*
   if (StrToint(EmptyEdit.Text) > 0) then begin
      if (EmptyComboBx.Text = 'None') then begin
         EmptyComboBx.Text := SetTurretStyle(Max(1, Ship.Turrets.EmptyTurretStyle));
      end;
   end;
*)
end;

procedure TTurretsFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(Ship.GenLittleBaysDetails);
         FullShipData.Add(GenerateTurretDetails);
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

function TTurretsFrm.GenerateTurretDetails: String;
//generate turret file details

begin
   Result := EmptyEdit.Text
         + SEP + IntToStr(GetTurretStyle(EmptyComboBx.Text))
         + SEP + MissileEdit.Text
         + SEP + IntToStr(GetTurretStyle(MissileComboBx.Text))
         + SEP + MissileBatEdit.Text
         + SEP + LaserEdit.Text
         + SEP + IntToStr(GetTurretStyle(LaserComboBx.Text))
         + SEP + LaserBatEdit.Text
         + SEP + IntToStr(LaserRadGrp.ItemIndex)
         + SEP + EnergyEdit.Text
         + SEP + IntToStr(GetTurretStyle(EnergyComboBx.Text))
         + SEP + EnergyBatEdit.Text
         + SEP + IntToStr(EnergyRadGrp.ItemIndex)
         + SEP + SandEdit.Text
         + SEP + IntToStr(GetTurretStyle(SandComboBx.Text))
         + SEP + SandBatEdit.Text
         + SEP + PAEdit.Text
         + SEP + IntToStr(GetTurretStyle(PAComboBx.Text))
         + SEP + PABatEdit.Text

         //mixed turrets info
         + SEP + IntToStr(MixedRadGrp.ItemIndex)
         + SEP + MixTurretsEdit.Text
         + SEP + MixEmptyEdit.Text
         + SEP + IntToStr(GetTurretStyle(MixComboBx.Text))
         + SEP + MixMissileEdit.Text
         + SEP + MixLaserEdit.Text
         //+ SEP + IntToStr(MixLaserRadGrp.ItemIndex)
         + SEP + '-42'
         + SEP + MixSandEdit.Text;
end;

end.


