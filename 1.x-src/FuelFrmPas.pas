unit FuelFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Math, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShipPas, DesAssistFrmPas, HgsFormFrm;

type

  { TFuelFrm }

  TFuelFrm = class(THgsForm)
    PurifRefitTechLbl: TLabel;
    RefitPurifEdit: TEdit;
    RefitPurifChkBx: TCheckBox;
    FuelGrpBx: TGroupBox;
    LhydExtraFuelEdit: TEdit;
    PurifGrpBx: TGroupBox;
    DropTanksRadGrpBx: TGroupBox;
    PurifLhydRadGrp: TRadioGroup;
    PwrPlntFuelEdit: TEdit;
    JFuelEdit: TEdit;
    PwrPlntFuelStatLbl: TLabel;
    JFuelStatLbl: TLabel;
    LHydExtraStatTxt: TStaticText;
    PurifyLhydStatTxt: TStaticText;
    WeeksStatLbl: TLabel;
    ParsecsStatLbl: TLabel;
    ScoopsStatLbl: TLabel;
    PurificStatLbl: TLabel;
    ScoopsRadGrp: TRadioGroup;
    PurifRadGrp: TRadioGroup;
    LhydPwrPlntFuelStatLbl: TLabel;
    LhydJFuelStatLbl: TLabel;
    LhydWeeks: TLabel;
    LhydParsecs: TLabel;
    LhydPwrPlntFuelEdit: TEdit;
    LhydJFuelEdit: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    ExtraFuelEdit: TEdit;
    ExtraFuelStatLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LhydExtraFuelEditChange(Sender: TObject);
    procedure LhydJFuelEditChange(Sender: TObject);
    procedure LhydPwrPlntFuelEditChange(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PurifGrpBxClick(Sender: TObject);
    procedure PurifRadGrpClick(Sender: TObject);
    procedure RefitPurifChkBxChange(Sender: TObject);
    procedure RefitPurifEditChange(Sender: TObject);
  private
    { Private declarations }
    function TrapErrors : Boolean;
    function Warn(TheMessage: String): Boolean;
    function GenerateFuelDetails : String;
    function RemoveCommas(Text : String) : String;
    function StrToFloatDef(const S: string; Default: Extended): Extended;
    function HasDropTanks: Boolean;
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  FuelFrm: TFuelFrm;

implementation

uses MainPas;

{$R *.lfm}

{ TFuelFrm }

procedure TFuelFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
   Action := caFree;
end;

procedure TFuelFrm.LhydExtraFuelEditChange(Sender: TObject);
begin
  with (LhydExtraFuelEdit) do
  begin
    if (Text = '') then begin
      abort;
    end;
    if (StrToFloatDef(Text, 2) = 2) and (StrToFloatDef(Text, 3) = 3) then
    begin
      MessageDlg('LHyd Extra Fuel must be a floating point value (may be zero)', mtError, [mbOk], 0);
      abort;
    end;
    if (HasDropTanks) and (Ship.TechLevel > 7) and (PurifRadGrp.ItemIndex = 0) then
    begin
      PurifLHydRadGrp.Enabled := True;
      if (Ship.Fuel.PurifyLHyd) then
      begin
        PurifLhydRadGrp.ItemIndex := 0;
      end
      else
      begin
        PurifLhydRadGrp.ItemIndex := 1;
      end;
    end
    else
    begin
      PurifLHydRadGrp.Enabled := False;
      PurifLHydRadGrp.ItemIndex := 1;
    end;
  end;
end;

procedure TFuelFrm.LhydJFuelEditChange(Sender: TObject);
begin
  with (LhydJFuelEdit) do
  begin
    if (Text = '') then begin
      abort;
    end;
    if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
    begin
      MessageDlg('LHyd Jump Fuel must be an integer value (may be zero)', mtError, [mbOk], 0);
      abort;
    end;
    if (HasDropTanks) and (Ship.TechLevel > 7) and (PurifRadGrp.ItemIndex = 0) then
    begin
      PurifLHydRadGrp.Enabled := True;
      if (Ship.Fuel.PurifyLHyd) then
      begin
        PurifLhydRadGrp.ItemIndex := 0;
      end
      else
      begin
        PurifLhydRadGrp.ItemIndex := 1;
      end;
    end
    else
    begin
      PurifLHydRadGrp.Enabled := False;
      PurifLHydRadGrp.ItemIndex := 1;
    end;
  end;
end;

procedure TFuelFrm.LhydPwrPlntFuelEditChange(Sender: TObject);
begin
  with (LhydPwrPlntFuelEdit) do
  begin
    if (Text = '') then begin
      abort;
    end;
    if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
    begin
      MessageDlg('LHyd Power Plant Fuel must be an integer value (may be zero)', mtError, [mbOk], 0);
      abort;
    end;
    if (HasDropTanks) and (Ship.TechLevel > 7) and (PurifRadGrp.ItemIndex = 0) then
    begin
      PurifLHydRadGrp.Enabled := True;
      if (Ship.Fuel.PurifyLHyd) then
      begin
        PurifLhydRadGrp.ItemIndex := 0;
      end
      else
      begin
        PurifLhydRadGrp.ItemIndex := 1;
      end;
    end
    else
    begin
      PurifLHydRadGrp.Enabled := False;
      PurifLHydRadGrp.ItemIndex := 1;
    end;
  end;
end;

procedure TFuelFrm.OKBtnClick(Sender: TObject);
//Trap errors and then send the form data to the ship

begin
  if (TrapErrors) then
  begin
    exit;
  end;
  Ship.Fuel.PFuel := StrToInt(PwrPlntFuelEdit.Text);
  Ship.Fuel.JFuel := StrToInt(JFuelEdit.Text);
  Ship.Fuel.Scoops := ScoopsRadGrp.ItemIndex;
  Ship.Fuel.Purif := PurifRadGrp.ItemIndex;
  Ship.Fuel.LhydPFuel := StrToInt(LhydPwrPlntFuelEdit.Text);
  Ship.Fuel.LhydJFuel := StrToInt(LhydJFuelEdit.Text);
  Ship.Fuel.ExtraFuel := StrToFloat(RemoveCommas(ExtraFuelEdit.Text));
  Ship.Fuel.LhydExtraFuel := StrToFloat(RemoveCommas(LHydExtraFuelEdit.Text));
  if (PurifLHydRadGrp.ItemIndex = 0) then
  begin
    Ship.Fuel.PurifyLHyd := True;;
  end
  else
  begin
    Ship.Fuel.PurifyLHyd := False;;
  end;
  if (Ship.IsRefitted) then
  begin
    Ship.Fuel.RefitPurif := RefitPurifChkBx.Checked;
    Ship.Fuel.RefitPurifTech := StrToInt(RefitPurifEdit.Text);
  end
  else
  begin
    Ship.Fuel.RefitPurif := False;
    Ship.Fuel.RefitPurifTech := 0;
  end;
  Ship.DesignShip;
  MainFrm.RefreshForm;
  Ship.HasChanged := True;
  MainFrm.SaveMenuItem.Enabled := True;
  MainFrm.RestoreMenuItem.Enabled := True;
  Close;
end;

procedure TFuelFrm.CancelBtnClick(Sender: TObject);
//close the form without send the data to the ship

begin
   Close;
end;

procedure TFuelFrm.FormCreate(Sender: TObject);
//create the form and fill it with data from the ship
var
  Size, PowerTons: Extended;
  PPlant, TL, Race, DesignRules, JDrive: Integer;
  BaseFuelLoad, CurFuelLoad: Extended;
begin
  Size := Ship.Tonnage;
  if (Ship.Eng.PowerTonsIsRefitted) then PowerTons := Ship.Eng.NewPowerTons
      else PowerTons := Ship.Eng.PowerTons;
  if (Ship.Eng.PPlantIsRefitted) then PPlant := Ship.Eng.NewPPlant
      else PPlant := Ship.Eng.PPlant;
  if (Ship.Eng.JDriveIsRefitted) then JDrive := Ship.Eng.NewJDrive else JDrive := Ship.Eng.JDrive;
  //fuel
  BaseFuelLoad := Max((Size * (((Ship.Fuel.BasePFuel / 28)  * Ship.Eng.PPlant) * 0.01))
     + (Size * (Ship.Fuel.BaseJFuel * 0.1)) + Ship.Fuel.BaseEFuel, 1);
  CurFuelLoad := Max((Size * (((Ship.Fuel.PFuel / 28)  * PPlant) * 0.01))
     + (Size * (Ship.Fuel.JFuel * 0.1)) + Ship.Fuel.ExtraFuel, 1);

  TL := Ship.TechLevel;
  Race := Ship.ShipRace;
  DesignRules := Ship.DesignRules;
  PwrPlntFuelEdit.Text := IntToStr(Ship.Fuel.PFuel);
  JFuelEdit.TExt := IntToStr(Ship.Fuel.JFuel);
  ScoopsRadGrp.ItemIndex := Ship.Fuel.Scoops;
  PurifRadGrp.ItemIndex := Ship.Fuel.Purif;
  LhydPwrPlntFuelEdit.Text := IntToStr(Ship.Fuel.LhydPFuel);
  LhydJFuelEdit.Text := IntToStr(Ship.Fuel.LhydJFuel);
  ExtraFuelEdit.Text := FloatToStrF(Ship.Fuel.ExtraFuel, ffNumber, 18, 3);
  LHydExtraFuelEdit.Text := FloatToStrF(Ship.Fuel.LhydExtraFuel, ffNumber, 18, 3);
  if (Ship.Hull.Config > 6) then
  begin
    ScoopsRadGrp.Enabled := False;
    ScoopsRadGrp.ItemIndex := 1;
  end
  else if (Ship.Tonnage < 100) then
  begin
    ScoopsRadGrp.Enabled := False;
    ScoopsRadGrp.ItemIndex := 0;
  end
  else
  begin
    ScoopsRadGrp.Enabled := True;
  end;
  if (Ship.TechLevel < 8) or ((Ship.IsRefitted) and (Ship.RefitTechLevel < 8)) then
  begin
    PurifRadGrp.Enabled := False;
  end
  else
  begin
    PurifRadGrp.Enabled := True;
  end;
  if (Ship.Fuel.CalcLhydFuel(Size, PowerTons, PPlant, TL, Race, DesignRules) > 0)
      and (Ship.TechLevel > 7)
      and (PurifRadGrp.ItemIndex = 0) then
  begin
    PurifLhydRadGrp.Enabled := True;
    if (Ship.Fuel.PurifyLHyd) then
    begin
      PurifLhydRadGrp.ItemIndex := 0;
    end
    else
    begin
      PurifLhydRadGrp.ItemIndex := 1;
    end;
  end
  else
  begin
    PurifLhydRadGrp.Enabled := False;
    PurifLhydRadGrp.ItemIndex := 1;
  end;
  //refit
  RefitPurifChkBx.Visible := Ship.IsRefitted;
  RefitPurifEdit.Visible := Ship.IsRefitted;
  PurifRefitTechLbl.Visible := Ship.IsRefitted;
  RefitPurifEdit.Enabled := Ship.Fuel.RefitPurif;
  RefitPurifChkBx.Checked := Ship.Fuel.RefitPurif;
  RefitPurifEdit.Text := IntToStr(Ship.Fuel.RefitPurifTech);
  if (Ship.IsRefitted) and (CurFuelLoad > 200) and (CurFuelLoad > BaseFuelLoad) then
  begin
    RefitPurifChkBx.Checked := True;
    RefitPurifChkBx.Enabled := False;
    RefitPurifEdit.Enabled := True;
  end;
end;

function TFuelFrm.TrapErrors: Boolean;
//find any errors in the form data

begin
   Result := False;
   if (PwrPlntFuelEdit.Text = '') then begin
      MessageDlg('No Value entered for Power Plant Fuel', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(PwrPlntFuelEdit.Text, 3) = 3)
         and (StrToIntDef(PwrPlntFuelEdit.Text, 2) = 2) then begin
      MessageDlg('Power Plant Fuel must be an Integer Value', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(PwrPlntFuelEdit.Text) < 0) then begin
      MessageDlg('Power Plant Fuel may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
(* this section disabled to allow illegal designs
   if (StrToInt(PwrPlntFuelEdit.Text) < 28) and (StrToInt(PwrPlntFuelEdit.Text) > 0) then begin
      MessageDlg('Under standard rules ships require at least 28 Days Power Plant Fuel', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if ((StrToInt(PwrPlntFuelEdit.Text) Mod 28) <> 0) and (StrToInt(PwrPlntFuelEdit.Text) > 0) then begin
      MessageDlg('Under standard rules Power Plant Fuel must be in multiples of 28 days', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
*)
   if (JFuelEdit.Text = '') then begin
      MessageDlg('No Value entered for Jump Fuel (This May be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(JFuelEdit.Text, 3) = 3)
         and (StrToIntDef(JFuelEdit.Text, 2) = 2) then begin
      MessageDlg('Jump Fuel must be an Integer Value (This May be Zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(JFuelEdit.Text) < 0) then begin
      MessageDlg('Jump Fuel may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LhydPwrPlntFuelEdit.Text = '') then begin
      MessageDlg('No Value entered for Lhyd Power Plant Fuel (This May be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(LhydPwrPlntFuelEdit.Text, 3) = 3)
         and (StrToIntDef(LhydPwrPlntFuelEdit.Text, 2) = 2) then begin
      MessageDlg('Lhyd Power Plant Fuel must be an Integer Value (This May be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(LhydPwrPlntFuelEdit.Text) < 0) then begin
      MessageDlg('Lhyd Power Plant Fuel may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (LhydJFuelEdit.Text = '') then begin
      MessageDlg('No Value entered for Lhyd Jump Fuel (This May be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(LhydJFuelEdit.Text, 3) = 3)
         and (StrToIntDef(LhydJFuelEdit.Text, 2) = 2) then begin
      MessageDlg('Lhyd Jump Fuel must be an Integer Value (This May be Zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(LhydJFuelEdit.Text) < 0) then begin
      MessageDlg('Lhyd Jump Fuel may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
(* this section disabled to allow for illegal designs
   if (StrToInt(LhydPwrPlntFuelEdit.Text) < 28) and (StrToInt(LhydPwrPlntFuelEdit.Text) > 0) then begin
      MessageDlg('Standard rules require a minimum of 28 days Lhyd Power Plant fuel if it is included', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if ((StrToInt(LhydPwrPlntFuelEdit.Text) Mod 28) <> 0) and (StrToInt(LhydPwrPlntFuelEdit.Text) > 0) then begin
      MessageDlg('Standard rules require Lhyd Power Plant Fuel to be be in multiples of 28 days if it is included', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
*)
   if (ScoopsRadGrp.ItemIndex = -1) then begin
      MessageDlg('Scoops option not seleced', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (PurifRadGrp.ItemIndex = -1) then begin
      MessageDlg('Purification option not seleced', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (PurifLHydRadGrp.ItemIndex = -1) then begin
      MessageDlg('Drop Tank Purification option not seleced', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (ScoopsRadGrp.ItemIndex = 0) and (Ship.Hull.Config > 6) then begin
      MessageDlg('Scoops may not be Fitted to an Unstreamlined Ship', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (ScoopsRadGrp.ItemIndex = 0) and (Ship.TechLevel < 7) then begin
      MessageDlg('Fuel Purification requires a minimum Tech Level of 8', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(PwrPlntFuelEdit.Text) < 28) and (StrToInt(PwrPlntFuelEdit.Text) > 0)
         and not (Ship.Tonnage < 100) then begin
      if (Warn('Under standard rules ships require at least 28 Days' + #13
            + 'Power Plant Fuel. Do you wish to alter this')) then begin
         Result := True;
         exit;
      end;
   end;
   if ((StrToInt(PwrPlntFuelEdit.Text) Mod 28) <> 0) and (StrToInt(PwrPlntFuelEdit.Text) > 0)
         and not (Ship.Tonnage < 100) then begin
      if (Warn('Under standard rules Power Plant Fuel must be in multiples'
            + #13 + 'of 28 days .Do you wish to alter this?')) then begin;
         Result := True;
         exit;
      end;
   end;
   if (StrToInt(LhydPwrPlntFuelEdit.Text) < 28) and (StrToInt(LhydPwrPlntFuelEdit.Text) > 0)
         and not (Ship.Tonnage < 100) then begin
      if (Warn('Standard rules require a minimum of 28 days Lhyd' + #13 +
            'Power Plant fuel if it is included. Do you wish to alter this?')) then begin;
         Result := True;
         exit;
      end;
   end;
   if ((StrToInt(LhydPwrPlntFuelEdit.Text) Mod 28) <> 0) and (StrToInt(LhydPwrPlntFuelEdit.Text) > 0)
         and not (Ship.Tonnage < 100) then begin
      if (Warn('Standard rules require Lhyd Power Plant Fuel' + #13
            + 'to be be in multiples of 28 days if it is included.' + #13
            + 'Do you wish to alter this')) then begin;
         Result := True;
         exit;
      end;
   end;
   if (LHydExtraFuelEdit.Text = '') then begin
      MessageDlg('No Value entered for LHyd Extra Fuel (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToFloatDef(RemoveCommas(LHydExtraFuelEdit.Text), 3) = 3)
         and (StrToFloatDef(RemoveCommas(ExtraFuelEdit.Text), 2) = 2) then begin
      MessageDlg('Extra LHyd Fuel must be an Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToFloat(RemoveCommas(LHydExtraFuelEdit.Text)) < 0) then begin
      MessageDlg('Extra LHyd Fuel may not be a Negative Number (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (ExtraFuelEdit.Text = '') then begin
      MessageDlg('No Value entered for Extra Fuel (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToFloatDef(RemoveCommas(ExtraFuelEdit.Text), 3) = 3)
         and (StrToFloatDef(RemoveCommas(ExtraFuelEdit.Text), 2) = 2) then begin
      MessageDlg('Extra Fuel must be an Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToFloat(RemoveCommas(ExtraFuelEdit.Text)) < 0) then begin
      MessageDlg('Extra Fuel may not be a Negative Number (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(PwrPlntFuelEdit.Text) = 0)
         and (Ship.Eng.JDrive > 0) then begin
      if (Warn('Power Plant Fitted but no internal Fuel provided. Do you wish to alter this?')) then begin
         Result := True;
         exit;
      end;
   end;
   if (StrToInt(JFuelEdit.Text) = 0)
         and (Ship.Eng.JDrive > 0) then begin
      if (Warn('Jump Drive Fitted but no internal Fuel provided. Do you wish to alter this?')) then begin
         Result := True;
         exit;
      end;
   end;
   if (RefitPurifEdit.Text = '') then begin
      MessageDlg('No Value entered for Purification Refit Tech', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToIntDef(RefitPurifEdit.Text, 3) = 3)
         and (StrToIntDef(RefitPurifEdit.Text, 2) = 2) then begin
      MessageDlg('Purification Refit Tech must be an Integer Value', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
   if (StrToInt(RefitPurifEdit.Text) < 8) and (RefitPurifChkBx.Checked) then begin
      MessageDlg('Purification Refit Tech may not be less than TL 8', mtError, [mbOk], 0);
      Result := True;
      exit;
   end;
end;

function TFuelFrm.Warn(TheMessage: String): Boolean;
begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TFuelFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateFuelDetails);
         FullShipData.Add(Ship.GenAvionicsDetails);
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

procedure TFuelFrm.PurifGrpBxClick(Sender: TObject);
begin

end;

procedure TFuelFrm.PurifRadGrpClick(Sender: TObject);
begin
  with (PurifRadGrp) do
  begin
    if (ItemIndex = 0) and (HasDropTanks) then
    begin
      PurifLHydRadGrp.Enabled := True;
      if (Ship.Fuel.PurifyLHyd) then
      begin
        PurifLhydRadGrp.ItemIndex := 0;
      end
      else
      begin
        PurifLhydRadGrp.ItemIndex := 1;
      end;
    end
    else
    begin
      PurifLHydRadGrp.Enabled := False;
      PurifLHydRadGrp.ItemIndex := 1;
    end;
  end;
end;

procedure TFuelFrm.RefitPurifChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitPurifChkBx do
    begin
      RefitPurifEdit.Enabled := Checked;
    end;
  end;
end;

procedure TFuelFrm.RefitPurifEditChange(Sender: TObject);
begin
  with (RefitPurifEdit) do
  begin
    if (Text = '') then begin
      abort;
    end;
    if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
    begin
      MessageDlg('Purification Refit Tech must be an integer value (min TL 8)', mtError, [mbOk], 0);
      abort;
    end;
    if (StrToInt(Text) > 7) then
    begin
      PurifRadGrp.Enabled := True;
      PurifRadGrp.ItemIndex := Ship.Fuel.Purif;
      PurifLHydRadGrp.Enabled := True;
      if (Ship.Fuel.PurifyLHyd) then PurifLHydRadGrp.ItemIndex := 0
          else PurifLHydRadGrp.ItemIndex := 1;
    end
    else
    begin
      PurifRadGrp.Enabled := False;
      PurifRadGrp.ItemIndex := 1;
      PurifLHydRadGrp.Enabled := False;
      PurifLHydRadGrp.ItemIndex := 1;
    end;
  end;
end;

function TFuelFrm.GenerateFuelDetails: String;
//generate fuel file details

begin
  Result := PwrPlntFuelEdit.Text
      + SEP + JFuelEdit.Text
      + SEP + IntToStr(ScoopsRadGrp.ItemIndex)
      + SEP + IntToStr(PurifRadGrp.ItemIndex)
      + SEP + LHydPwrPlntFuelEdit.Text
      + SEP + LHydJFuelEdit.Text
      + SEP + RemoveCommas(ExtraFuelEdit.Text)
      + SEP + RemoveCommas(LHydExtraFuelEdit.Text)
      + SEP + IntToStr(PurifLHydRadGrp.ItemIndex - 1)
      + SEP + BoolToStr(RefitPurifChkBx.Checked)
      + SEP + RefitPurifEdit.Text                       //10
      + SEP + IntToStr(Ship.Fuel.BasePFuel)                  //11
      + SEP + IntToStr(Ship.Fuel.BaseJFuel)                  //12
      + SEP + FloatToStr(Ship.Fuel.BaseEFuel)                //13
      + SEP + '0'                 //wiggle room 14
      + SEP + '0'                 //wiggle room 15
end;

function TFuelFrm.RemoveCommas(Text: String): String;
//remove the commas from a number

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

function TFuelFrm.StrToFloatDef(const S: string;
  Default: Extended): Extended;
//like StrToIntDef but with real numbers

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

function TFuelFrm.HasDropTanks: Boolean;
begin
  if (StrToInt(LHydPwrPlntFuelEdit.Text) > 0)
        or (StrToInt(LHydJFuelEdit.Text) > 0)
        or (StrToFloat(RemoveCommas(LHydExtraFuelEdit.Text)) > 0) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

end.
