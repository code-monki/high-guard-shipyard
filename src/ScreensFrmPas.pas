unit ScreensFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DataPas, ShipPas, Math, DesAssistFrmPas;

type
  TScreensFrm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    BakGrpBx: TGroupBox;
    BakNucDampStatLbl: TLabel;
    BakMesScrnStatLbl: TLabel;
    BakBlkGlbStatLbl: TLabel;
    BakBlkGlbComboBx: TComboBox;
    BakBlkGlbEdit: TEdit;
    BakMesScrnEdit: TEdit;
    BakMesScrnComboBx: TComboBox;
    BakNucDampComboBx: TComboBox;
    BakNucDampEdit: TEdit;
    MainGrpBx: TGroupBox;
    NucDampStatLbl: TLabel;
    NucDampComboBx: TComboBox;
    MesScrnComboBx: TComboBox;
    BlkGlbComboBx: TComboBox;
    BlkGlbStatLbl: TLabel;
    MesSrnStatLbl: TLabel;
    NumStatLbl: TLabel;
    ExtCapsEdit: TEdit;
    ExtCapStatLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure BakNucDampComboBxChange(Sender: TObject);
    procedure BakMesScrnComboBxChange(Sender: TObject);
    procedure BakBlkGlbComboBxChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Data : TData;
    function TrapErrors : Boolean;
    procedure SetupNucDamp;
    procedure SetupMesScrn;
    procedure SetupBlkGlb;
    function RemoveCommas(Text : String) : String;
    function StrToFloatDef(const S: string; Default: Extended): Extended;
    function GenerateScreenDetails : String;
  public
    { Public declarations }
  end;

var
  ScreensFrm: TScreensFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TScreensFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close

begin
   FreeAndNil(Data);
   Action := caFree;
end;

procedure TScreensFrm.FormCreate(Sender: TObject);
//create the form and data store and fill it with defaults from the ship

begin
   Data := TData.Create;
   Data.InitialiseData;
   SetupNucDamp;
   SetupMesScrn;
   SetupBlkGlb;
   ExtCapsEdit.Text := FloatToStrF(Ship.Screens.ExtraCaps, ffNumber, 18, 3);;
end;

procedure TScreensFrm.SetupNucDamp;
//fill the nuclear damper details from the ship

var
   iCount : Integer;
begin
   NucDampComboBx.Clear;
   BakNucDampComboBx.Clear;
   NucDampComboBx.Text := IntToStr(Ship.Screens.NucDamp);
   BakNucDampComboBx.Text := IntToStr(Ship.Screens.BakNucDamp);
   BakNucDampEdit.Text := IntToStr(Ship.Screens.BakNucDampNum);
   for iCount := 0 to 9 do begin
      //if the tech level of the nuc damper is less or equal to ships tech add it
      if (Ship.TechLevel >= StrToInt(Data.GetNucDampData(2, iCount))) then begin
         NucDampComboBx.Items.Add(Data.GetNucDampData(1, iCount));
         BakNucDampComboBx.Items.Add(Data.GetNucDampData(1, iCount));
      end;
   end;
   //if less than tech 12 disable
   if (Ship.TechLevel < 12) then begin
      NucDampComboBx.Text := '0';
      NucDampComboBx.Enabled := False;
      BakNucDampComboBx.Text := '0';
      BakNucDampComboBx.Enabled := False;
      BakNucDampEdit.Text := '0';
      BakNucDampEdit.Enabled := False;
   end;
   //if current nuc damp is over tech reduce it to max allowed
   if (Ship.TechLevel = 12) and (StrToInt(NucDampComboBx.Text) > 1) then begin
      NucDampComboBx.Text := '1';
   end
   else if (Ship.TechLevel = 13) and (StrToInt(NucDampComboBx.Text) > 3) then begin
      NucDampComboBx.Text := '3';
   end
   else if (Ship.TechLevel = 14) and (StrToInt(NucDampComboBx.Text) > 6) then begin
      NucDampComboBx.Text := '6';
   end
   else if (StrToInt(NucDampComboBx.Text) > 9) then begin
      NucDampComboBx.Text := '9';
   end;
   if (Ship.TechLevel = 12) and (StrToInt(BakNucDampComboBx.Text) > 1) then begin
      BakNucDampComboBx.Text := '1';
   end
   else if (Ship.TechLevel = 13) and (StrToInt(BakNucDampComboBx.Text) > 3) then begin
      BakNucDampComboBx.Text := '3';
   end
   else if (Ship.TechLevel = 14) and (StrToInt(BakNucDampComboBx.Text) > 6) then begin
      BakNucDampComboBx.Text := '6';
   end
   else if (StrToInt(BakNucDampComboBx.Text) > 9) then begin
      BakNucDampComboBx.Text := '9';
   end;
end;

procedure TScreensFrm.SetupMesScrn;
//fill the meson screen details from the ship

var
   iCount : Integer;
begin
   MesScrnComboBx.Clear;
   BakMesScrnComboBx.Clear;
   MesScrnComboBx.Text := IntToStr(Ship.Screens.MesScrn);
   BakMesScrnComboBx.Text := IntToStr(Ship.Screens.BakMesScrn);
   BakMesScrnEdit.Text := IntToStr(Ship.Screens.BakMesScrnNum);
   for iCount := 0 to 9 do begin
      //if the tech level of the meson screen is less or equal to ships tech add it
      if (Ship.TechLevel >= StrToInt(Data.GetMesScrnData(2, iCount))) then begin
         MesScrnComboBx.Items.Add(Data.GetMesScrnData(1, iCount));
         BakMesScrnComboBx.Items.Add(Data.GetMesScrnData(1, iCount));
      end;
   end;
   //if less than tech 12 disable
   if (Ship.TechLevel < 12) then begin
      MesScrnComboBx.Text := '0';
      MesScrnComboBx.Enabled := False;
      BakMesScrnComboBx.Text := '0';
      BakMesScrnComboBx.Enabled := False;
      BakMesScrnEdit.Text := '0';
      BakMesScrnEdit.Enabled := False;
   end;
   //if current meson screen is over tech reduce it to max allowed
   if (Ship.TechLevel = 12) and (StrToInt(MesScrnComboBx.Text) > 1) then begin
      MesScrnComboBx.Text := '1';
   end
   else if (Ship.TechLevel = 13) and (StrToInt(MesScrnComboBx.Text) > 3) then begin
      MesScrnComboBx.Text := '3';
   end
   else if (Ship.TechLevel = 14) and (StrToInt(MesScrnComboBx.Text) > 6) then begin
      MesScrnComboBx.Text := '6';
   end
   else if (StrToInt(MesScrnComboBx.Text) > 9) then begin
      MesScrnComboBx.Text := '9';
   end;
   if (Ship.TechLevel = 12) and (StrToInt(BakMesScrnComboBx.Text) > 1) then begin
      BakMesScrnComboBx.Text := '1';
   end
   else if (Ship.TechLevel = 13) and (StrToInt(BakMesScrnComboBx.Text) > 3) then begin
      BakMesScrnComboBx.Text := '3';
   end
   else if (Ship.TechLevel = 14) and (StrToInt(BakMesScrnComboBx.Text) > 6) then begin
      BakMesScrnComboBx.Text := '6';
   end
   else if (StrToInt(BakMesScrnComboBx.Text) > 9) then begin
      BakMesScrnComboBx.Text := '9';
   end;
end;

procedure TScreensFrm.SetupBlkGlb;
//fill the black globe details from the ship

var
   iCount : Integer;
begin
   BlkGlbComboBx.Clear;
   BakBlkGlbComboBx.Clear;
   BlkGlbComboBx.Text := IntToStr(Ship.Screens.BlkGlb);
   BakBlkGlbComboBx.Text := IntToStr(Ship.Screens.BakBlkGlb);
   BakBlkGlbEdit.Text := IntToStr(Ship.Screens.BakBlkGlbNum);
   for iCount := 0 to 9 do begin
      //if the tech level of the black globe is less or equal to ships tech add it
      if (Ship.TechLevel >= StrToInt(Data.GetBlkGlbData(2, iCount))) then begin
         BlkGlbComboBx.Items.Add(Data.GetBlkGlbData(1, iCount));
         BakBlkGlbComboBx.Items.Add(Data.GetBlkGlbData(1, iCount));
      end;
   end;
   //if less than tech 15 disable
   if (Ship.TechLevel < 15) then begin
      BlkGlbComboBx.Text := '0';
      BlkGlbComboBx.Enabled := False;
      BakBlkGlbComboBx.Text := '0';
      BakBlkGlbComboBx.Enabled := False;
      BakBlkGlbEdit.Text := '0';
      BakBlkGlbEdit.Enabled := False;
      ExtCapsEdit.Text := '0';
      ExtCapsEdit.Enabled := False;
   end;
   //if current black globe is over tech reduce it to max allowed
   if (Ship.TechLevel = 15) and (StrToInt(BlkGlbComboBx.Text) > 4) then begin
      BlkGlbComboBx.Text := '4';
   end
   else if (Ship.TechLevel = 16) and (StrToInt(BlkGlbComboBx.Text) > 7) then begin
      BlkGlbComboBx.Text := '7';
   end
   else if (Ship.TechLevel = 17) and (StrToInt(BlkGlbComboBx.Text) > 8) then begin
      BlkGlbComboBx.Text := '8';
   end
   else if (StrToInt(BlkGlbComboBx.Text) > 9) then begin
      BlkGlbComboBx.Text := '9';
   end;
   if (Ship.TechLevel = 15) and (StrToInt(BakBlkGlbComboBx.Text) > 4) then begin
      BakBlkGlbComboBx.Text := '4';
   end
   else if (Ship.TechLevel = 16) and (StrToInt(BakBlkGlbComboBx.Text) > 7) then begin
      BakBlkGlbComboBx.Text := '7';
   end
   else if (Ship.TechLevel = 17) and (StrToInt(BakBlkGlbComboBx.Text) > 8) then begin
      BakBlkGlbComboBx.Text := '8';
   end
   else if (StrToInt(BakBlkGlbComboBx.Text) > 9) then begin
      BakBlkGlbComboBx.Text := '9';
   end;
end;

procedure TScreensFrm.OKBtnClick(Sender: TObject);
//send the form details to the ship and close the form

begin
   if (TrapErrors) then begin
      exit;
   end;
   Ship.Screens.NucDamp := StrToInt(NucDampComboBx.Text);
   Ship.Screens.MesScrn := StrToInt(MesScrnComboBx.Text);
   Ship.Screens.BlkGlb := StrToInt(BlkGlbComboBx.Text);
   Ship.Screens.BakNucDamp := StrToInt(BakNucDampComboBx.Text);
   Ship.Screens.BakMesScrn := StrToInt(BakMesScrnComboBx.Text);
   Ship.Screens.BakBlkGlb := StrToInt(BakBlkGlbComboBx.Text);
   Ship.Screens.BakNucDampNum := StrToInt(BakNucDampEdit.Text);
   Ship.Screens.BakMesScrnNum := StrToInt(BakMesScrnEdit.Text);
   Ship.Screens.BakBlkGlbNum := StrToInt(BakBlkGlbEdit.Text);
   Ship.Screens.ExtraCaps := StrToFloat(RemoveCommas(ExtCapsEdit.Text));
   Ship.DesignShip;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TScreensFrm.CancelBtnClick(Sender: TObject);
//close the form without sending the details to the ship

begin
   Close;
end;

function TScreensFrm.TrapErrors: Boolean;
//trap any errors

begin
   Result := False;
   if (NucDampComboBx.Text = '') then begin
      MessageDlg('No Value for Nuclear Damper Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (MesScrnComboBx.Text = '') then begin
      MessageDlg('No Value for Meson Screen Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (BlkGlbComboBx.Text = '') then begin
      MessageDlg('No Value for Black Globe Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (BakNucDampComboBx.Text = '') then begin
      MessageDlg('No Value for Backup Nuclear Damper Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (BakMesScrnComboBx.Text = '') then begin
      MessageDlg('No Value for Backup Meson Screen Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (BakBlkGlbComboBx.Text = '') then begin
      MessageDlg('No Value for Backup Black Globe Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (BakNucDampEdit.Text = '') then begin
      MessageDlg('Number of Backup Nuclear Dampers not Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (BakMesScrnEdit.Text = '') then begin
      MessageDlg('Number of Backup Meson Screens not Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (BakBlkGlbEdit.Text = '') then begin
      MessageDlg('Number of Backup Black Globes not Entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (ExtCapsEdit.Text = '') then begin
      MessageDlg('No value entered for Tonnage of Extra Capacitors (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(NucDampComboBx.Text) < 0) then begin
      MessageDlg('Nuclear Damper may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(MesScrnComboBx.Text) < 0) then begin
      MessageDlg('Meson Screen may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BlkGlbComboBx.Text) < 0) then begin
      MessageDlg('Black Globe may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BakNucDampComboBx.Text) < 0) then begin
      MessageDlg('Backup Nuclear Damper may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BakMesScrnComboBx.Text) < 0) then begin
      MessageDlg('Backup Meson Screen may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BakBlkGlbComboBx.Text) < 0) then begin
      MessageDlg('Backup Black Globe may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BakNucDampEdit.Text) < 0) then begin
      MessageDlg('Number of Backup Nuclear Dampers may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BakMesScrnEdit.Text) < 0) then begin
      MessageDlg('Number of Backup Meson Screens may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(BakBlkGlbEdit.Text) < 0) then begin
      MessageDlg('Number of Backup Black Globes may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(ExtCapsEdit.Text) < 0) then begin
      MessageDlg('The tonnage of Extra Capacitors may not be a negative number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(NucDampComboBx.Text, 3) = 3)
         and (StrToIntDef(NucDampComboBx.Text, 2) = 2) then begin
      MessageDlg('Nuclear Damper must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(MesScrnComboBx.Text, 3) = 3)
         and (StrToIntDef(MesScrnComboBx.Text, 2) = 2) then begin
      MessageDlg('Meson Screen must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BlkGlbComboBx.Text, 3) = 3)
         and (StrToIntDef(BlkGlbComboBx.Text, 2) = 2) then begin
      MessageDlg('Black Globe must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BakNucDampComboBx.Text, 3) = 3)
         and (StrToIntDef(BakNucDampComboBx.Text, 2) = 2) then begin
      MessageDlg('Backup Nuclear Damper must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BakMesScrnComboBx.Text, 3) = 3)
         and (StrToIntDef(BakMesScrnComboBx.Text, 2) = 2) then begin
      MessageDlg('Backup Meson Screen must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BakBlkGlbComboBx.Text, 3) = 3)
         and (StrToIntDef(BakBlkGlbComboBx.Text, 2) = 2) then begin
      MessageDlg('Backup Black Globe must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BakNucDampEdit.Text, 3) = 3)
         and (StrToIntDef(BakNucDampEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Backup Nuclear Dampers must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BakMesScrnEdit.Text, 3) = 3)
         and (StrToIntDef(BakMesScrnEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Backup Meson Screens must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(BakBlkGlbEdit.Text, 3) = 3)
         and (StrToIntDef(BakBlkGlbEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Backup Black Globes must be an integer value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(ExtCapsEdit.Text, 3) = 3)
         and (StrToFloatDef(ExtCapsEdit.Text, 2) = 2) then begin
      MessageDlg('The tonnage of Extra Capacitors must be a floating point value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Data.GetNucDampData(2, StrToInt(NucDampComboBx.Text))) > Ship.TechLevel) then begin
      MessageDlg('Factor ' + Data.GetNucDampData(1, StrToInt(NucDampComboBx.Text)) + ' Nuclear Dampers require a minimum Tech Level of ' + Data.GetNucDampData(2, StrToInt(NucDampComboBx.Text)), mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Data.GetMesScrnData(2, StrToInt(MesScrnComboBx.Text))) > Ship.TechLevel) then begin
      MessageDlg('Factor ' + Data.GetMesScrnData(1, StrToInt(MesScrnComboBx.Text)) + ' Meson Screens require a minimum Tech Level of ' + Data.GetMesScrnData(2, StrToInt(MesScrnComboBx.Text)), mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Data.GetBlkGlbData(2, StrToInt(BlkGlbComboBx.Text))) > Ship.TechLevel) then begin
      MessageDlg('Factor ' + Data.GetBlkGlbData(1, StrToInt(BlkGlbComboBx.Text)) + ' Black Globes require a minimum Tech Level of ' + Data.GetBlkGlbData(2, StrToInt(BlkGlbComboBx.Text)), mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Data.GetNucDampData(2, StrToInt(BakNucDampComboBx.Text))) > Ship.TechLevel) then begin
      MessageDlg('Factor ' + Data.GetNucDampData(1, StrToInt(BakNucDampComboBx.Text)) + ' Backup Nuclear Dampers require a minimum Tech Level of ' + Data.GetNucDampData(2, StrToInt(BakNucDampComboBx.Text)), mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Data.GetMesScrnData(2, StrToInt(BakMesScrnComboBx.Text))) > Ship.TechLevel) then begin
      MessageDlg('Factor ' + Data.GetMesScrnData(1, StrToInt(BakMesScrnComboBx.Text)) + ' Backup Meson Screens require a minimum Tech Level of ' + Data.GetMesScrnData(2, StrToInt(BakMesScrnComboBx.Text)), mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Data.GetBlkGlbData(2, StrToInt(BakBlkGlbComboBx.Text))) > Ship.TechLevel) then begin
      MessageDlg('Factor ' + Data.GetBlkGlbData(1, StrToInt(BakBlkGlbComboBx.Text)) + ' Backup Black Globes require a minimum Tech Level of ' + Data.GetBlkGlbData(2, StrToInt(BakBlkGlbComboBx.Text)), mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
end;

procedure TScreensFrm.BakNucDampComboBxChange(Sender: TObject);
//ignore errors update number of backups

begin
   with BakNucDampComboBx do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
      if (StrToInt(Text) = 0) then begin
         BakNucDampEdit.Text := '0';
      end;
      if (StrToInt(Text) > 0) then begin
         BakNucDampEdit.Text := IntToStr(Max(1, Ship.Screens.BakNucDampNum));
      end;
   end;
end;

procedure TScreensFrm.BakMesScrnComboBxChange(Sender: TObject);
//ignore errors update number of backups

begin
   with BakMesScrnComboBx do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
      if (StrToInt(Text) = 0) then begin
         BakMesScrnEdit.Text := '0';
      end;
      if (StrToInt(Text) > 0) then begin
         BakMesScrnEdit.Text := IntToStr(Max(1, Ship.Screens.BakMesScrnNum));
      end;
   end;
end;

procedure TScreensFrm.BakBlkGlbComboBxChange(Sender: TObject);
//ignore errors update number of backups

begin
   with BakBlkGlbComboBx do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
      if (StrToInt(Text) = 0) then begin
         BakBlkGlbEdit.Text := '0';
      end;
      if (StrToInt(Text) > 0) then begin
         BakBlkGlbEdit.Text := IntToStr(Max(1, Ship.Screens.BakBlkGlbNum));
      end;
   end;
end;

function TScreensFrm.RemoveCommas(Text: String): String;
//remove commas from a number as a string

var
   iPos : Integer;
begin
   iPos := Pos(',', Text);
   while (iPos > 0) do begin
      delete(Text, iPos, 1);
      iPos := Pos(',', Text);
   end;
   Result := Text;
end;

function TScreensFrm.StrToFloatDef(const S: string;
  Default: Extended): Extended;
//like StrToIntDef but with real numbers

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

procedure TScreensFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(Ship.GenTurretDetails);
         FullShipData.Add(GenerateScreenDetails);
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

function TScreensFrm.GenerateScreenDetails: String;
//generate screen file details

begin
   Result := NucDampComboBx.Text
         + SEP + MesScrnComboBx.Text
         + SEP + BlkGlbComboBx.Text
         + SEP + BakNucDampComboBx.Text
         + SEP + BakMesScrnComboBx.Text
         + SEP + BakBlkGlbComboBx.Text
         + SEP + BakNucDampEdit.Text
         + SEP + BakMesScrnEdit.Text
         + SEP + BakBlkGlbEdit.Text
         + SEP + RemoveCommas(ExtCapsEdit.Text);
end;

end.
