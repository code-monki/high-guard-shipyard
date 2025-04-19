unit AccomFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShipPas, Math, DesAssistFrmPas, HgsFormFrm;

type

  { TAccomFrm }

  TAccomFrm = class(THgsForm)
    CaptainChkBox: TCheckBox;
    FlagshipLbl: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    DblOccRadGrp: TRadioGroup;
    ShpTrpRadGrp: TRadioGroup;
    CargoEdit: TEdit;
    CargoChkBx: TCheckBox;
    PassGrpBx: TGroupBox;
    HighEdit: TEdit;
    MidEdit: TEdit;
    LowPEdit: TEdit;
    AccomGrpBx: TGroupBox;
    SRLbl: TLabel;
    SmSRLbl: TLabel;
    CouchesLbl: TLabel;
    LowBLbl: TLabel;
    EmLowLbl: TLabel;
    SREdit: TEdit;
    SmSREdit: TEdit;
    CouchesEdit: TEdit;
    LowBEdit: TEdit;
    EmLowEdit: TEdit;
    DropCapGrpBx: TGroupBox;
    LaunchersEdit: TEdit;
    ReadyEdit: TEdit;
    StoredEdit: TEdit;
    Book5GrpBx: TGroupBox;
    Bk5TotLbl: TLabel;
    Bk5MarineEdit: TEdit;
    Bk5OtherEdit: TEdit;
    CmdLbl: TLabel;
    EngLbl: TLabel;
    GunLbl: TLabel;
    FltLbl: TLabel;
    SvcLbl: TLabel;
    SecLbl: TLabel;
    Book2GrpBx: TGroupBox;
    Book2Memo: TMemo;
    Bk2OtherEdit: TEdit;
    Bk2TotLbl: TLabel;
    Bk2MarineEdit: TEdit;
    OtherGrpBox: TGroupBox;
    EngShopEdit: TEdit;
    VehicleShopEdit: TEdit;
    LabEdit: TEdit;
    SickEdit: TEdit;
    AutoDocEdit: TEdit;
    AirlockEdit: TEdit;
    FresherEdit: TEdit;
    FrozWatchEdit: TEdit;
    AddLbl: TLabel;
    MissileMagEdit: TEdit;
    Bk5TotStatLbl: TLabel;
    CmdStatLbl: TLabel;
    EngStatLbl: TLabel;
    GunStatLbl: TLabel;
    FltStatLbl: TLabel;
    SvcStatLbl: TLabel;
    SecStatLbl: TLabel;
    AddStatLbl: TLabel;
    Bk5MarineStatLbl: TLabel;
    Bk5OtherStatLbl: TLabel;
    HighStatLbl: TLabel;
    MidStatLbl: TLabel;
    LowPStatLbl: TLabel;
    Bk2MarineStatLbl: TLabel;
    Bk2OtherStatLbl: TLabel;
    Bk2TotStatLbl: TLabel;
    CargoStatLbl: TLabel;
    FrozenStatLbl: TLabel;
    WatchStatLbl: TLabel;
    EngShopStatLbl: TLabel;
    VehicleShopStatLbl: TLabel;
    LabStatLbl: TLabel;
    SickStatLbl: TLabel;
    AutoDocStatLbl: TLabel;
    AirlockStatLbl: TLabel;
    FresherStatLbl: TLabel;
    MissileMagStatLbl: TLabel;
    SRStatLbl: TLabel;
    SmSRStatLbl: TLabel;
    CouchesStatLbl: TLabel;
    LowBStatLbl: TLabel;
    EmLowStatLbl: TLabel;
    MinStatLbl: TLabel;
    ActStatLbl: TLabel;
    LaunchersStatLbl: TLabel;
    ReadyStatLbl: TLabel;
    StoredStatLbl: TLabel;
    MedStatLbl: TLabel;
    MedLbl: TLabel;
    procedure CaptainChkBoxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HighEditChange(Sender: TObject);
    procedure MidEditChange(Sender: TObject);
    procedure LowPEditChange(Sender: TObject);
    procedure SREditChange(Sender: TObject);
    procedure SmSREditChange(Sender: TObject);
    procedure CouchesEditChange(Sender: TObject);
    procedure LowBEditChange(Sender: TObject);
    procedure EmLowEditChange(Sender: TObject);
    procedure CargoEditChange(Sender: TObject);
    procedure Bk5MarineEditChange(Sender: TObject);
    procedure Bk5OtherEditChange(Sender: TObject);
    procedure Bk2OtherEditChange(Sender: TObject);
    procedure LaunchersEditChange(Sender: TObject);
    procedure ReadyEditChange(Sender: TObject);
    procedure StoredEditChange(Sender: TObject);
    procedure CargoChkBxClick(Sender: TObject);
    procedure DblOccRadGrpClick(Sender: TObject);
    procedure ShpTrpRadGrpClick(Sender: TObject);
    procedure Bk2MarineEditChange(Sender: TObject);
    procedure FrozWatchEditChange(Sender: TObject);
    procedure EngShopEditChange(Sender: TObject);
    procedure VehicleShopEditChange(Sender: TObject);
    procedure LabEditChange(Sender: TObject);
    procedure SickEditChange(Sender: TObject);
    procedure AutoDocEditChange(Sender: TObject);
    procedure AirlockEditChange(Sender: TObject);
    procedure FresherEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MissileMagEditChange(Sender: TObject);
  private
    { Private declarations }
    function TrapErrors : Boolean;
    function ExistingCmdCrew : Integer;
    function ExistingCrew : Integer;
    function FormCmdCrew : Integer;
    function FormCrew : Integer;
    function ExistingSpace : Extended;
    function FormSpace : Extended;
    function RequiredSR : Extended;
    function RequiredCouches : Integer;
    function RequiredLowBerths : Integer;
    function StRoomSpace(SR : Extended) : Extended;
    function SmStRoomSpace(SmSR : Extended) : Extended;
    function CouchesSpace(Couches : Integer) : Extended;
    function LowBerthSpace(LowBerth : Integer) : Extended;
    function EmLowBerthSpace(EmLowBerth : Integer) : Extended;
    function FloatToIntDown(TheFloat: Extended): Integer;
    function FloatToIntUp(TheFloat: Extended): Integer;
    function Warn (TheMessage: String) : Boolean;
    function GenerateAccomDetails : String;
    function IsChecked(var ChkBx : TCheckBox) : String;
    function GetMarines : String;
    function GetOther : String;
    function GetCargo : String;
    procedure RefreshForm;
    procedure Book2Crew;
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  AccomFrm: TAccomFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TAccomFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
   Action := caFree;
end;

procedure TAccomFrm.CaptainChkBoxChange(Sender: TObject);
begin
  RefreshForm;
end;

procedure TAccomFrm.OKBtnClick(Sender: TObject);
//Trap errors and then send the form data to the ship

begin
   if (TrapErrors) then begin
      Exit;
   end;
   Ship.Accom.DblOccMark := DblOccRadGrp.ItemIndex;
   Ship.Accom.ShpTrpMark := ShpTrpRadGrp.ItemIndex;
   Ship.Accom.HighPass := StrToInt(HighEdit.Text);
   Ship.Accom.MidPass := StrToInt(MidEdit.Text);
   Ship.Accom.LowPass := StrToInt(LowPEdit.Text);
   Ship.Accom.StRoom := StrToFloat(RemoveCommas(SREdit.Text));
   Ship.Accom.SmStRoom := StrToFloat(RemoveCommas(SmSREdit.Text));
   Ship.Accom.Couches := StrToInt(CouchesEdit.Text);
   Ship.Accom.LowBerth := StrToInt(LowBEdit.Text);
   Ship.Accom.EmLowBerth := StrToInt(EmLowEdit.Text);
   Ship.Accom.Cargo := StrToFloat(RemoveCommas(CargoEdit.Text));
   if (CargoChkBx.Checked) then begin
      Ship.Accom.AutoCargoMark := 1;
      Ship.Accom.Cargo := 0;
   end
   else begin
      Ship.Accom.AutoCargoMark := 0;
      Ship.Accom.Cargo := StrToFloat(RemoveCommas(CargoEdit.Text));
   end;
   if (Ship.CrewRules = 0) then begin
      Ship.Accom.Marines := StrToInt(Bk2MarineEdit.Text);
   end
   else begin
      Ship.Accom.Marines := StrToInt(Bk5MarineEdit.Text);
   end;
   if (Ship.CrewRules = 0) then begin
      Ship.Accom.OtherCrew := StrToInt(Bk2OtherEdit.Text);
   end
   else begin
      Ship.Accom.OtherCrew := StrToInt(Bk5OtherEdit.Text);
   end;
   Ship.Accom.DropCaps := StrToInt(LaunchersEdit.Text);
   Ship.Accom.ReadyDropCaps := StrToInt(ReadyEdit.Text);
   Ship.Accom.StoredDropCaps := StrToInt(StoredEdit.Text);
   Ship.Accom.FrozWatch := StrToInt(FrozWatchEdit.Text);
   Ship.Accom.EngShop := StrToInt(EngShopEdit.Text);
   Ship.Accom.VehicleShop := StrToInt(VehicleShopEdit.Text);
   Ship.Accom.Labs := StrToInt(LabEdit.Text);
   Ship.Accom.SickBay := StrToInt(SickEdit.Text);
   Ship.Accom.AutoDoc := StrToInt(AutoDocEdit.Text);
   Ship.Accom.Airlock := StrToInt(AirlockEdit.Text);
   Ship.Accom.Fresher := StrToInt(FresherEdit.Text);
   Ship.Accom.MissileMag := StrToFloat(RemoveCommas(MissileMagEdit.Text));
   Ship.Accom.Bk2Captain := CaptainChkBox.Checked;
   Ship.DesignShip;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TAccomFrm.CancelBtnClick(Sender: TObject);
//close the form without sending the data to the ship

begin
   Close;
end;

procedure TAccomFrm.FormCreate(Sender: TObject);
//get the current data from the ship

begin
   if (Ship.Flagship) then FlagshipLbl.Visible := True else FlagshipLbl.Visible := False;

   //set the rew list according to crew rules in use
   if (Ship.CrewRules = 0) {or (Ship.Tonnage < 100)} then begin
      Book2GrpBx.Visible := True;
      Book2GrpBx.Enabled := True;
      Book5GrpBx.Visible := False;
      Book5GrpBx.Enabled := False;
      Book2GrpBx.Left := Book5GrpBx.Left;
      Book2GrpBx.Top := Book5GrpBx.Top;
   end
   else begin
      Book2GrpBx.Visible := False;
      Book2GrpBx.Enabled := False;
      Book5GrpBx.Visible := True;
      Book5GrpBx.Enabled := True;
      Book2GrpBx.Left := Book5GrpBx.Left;
      Book2GrpBx.Top := Book5GrpBx.Top;
   end;

   //passengers
   HighEdit.Text := IntToStr(Ship.Accom.HighPass);
   MidEdit.Text := IntToStr(Ship.Accom.MidPass);
   LowPEdit.Text := IntToStr(Ship.Accom.LowPass);

   //accomodations
   SREdit.Text := FloatToStr(Ship.Accom.StRoom);
   SmSREdit.Text := FloatToStr(Ship.Accom.SmStRoom);
   CouchesEdit.Text := IntToStr(Ship.Accom.Couches);
   LowBEdit.Text := IntToStr(Ship.Accom.LowBerth);
   EmLowEdit.Text := IntToStr(Ship.Accom.EmLowBerth);

   //cargo
   CargoEdit.Text := FloatToStrF(Ship.Accom.Cargo, ffNumber, 18, 3);

   //book 5 crew list
   Cmdlbl.Caption := IntToStr(Ship.Avionics.CmdCrew + Ship.Avionics.Crew);
   EngLbl.Caption := IntToStr(Ship.Eng.CmdCrew + Ship.Eng.Crew);
   GunLbl.Caption := IntToStr(Min(1, Ship.SpinalMount.CmdCrew + Ship.BigBays.CmdCrew + Ship.LittleBays.CmdCrew + Ship.Turrets.CmdCrew + Ship.Screens.CmdCrew) + Ship.SpinalMount.Crew + Ship.BigBays.Crew + Ship.LittleBays.Crew + Ship.Turrets.Crew + Ship.Screens.Crew);
   FltLbl.Caption := IntToStr(Ship.Craft.CmdCrew + Ship.Craft.Crew);
   SvcLbl.Caption := IntToStr(Ship.Accom.CmdCrew + Ship.Accom.Crew);
   SecLbl.Caption := IntToStr(Ship.Accom.ShipsTroops);
   iTest := Ship.MedicalCmdCrew;
   iTest := Ship.MedicalCrew;
   MedLbl.Caption := IntToStr(Ship.MedicalCmdCrew + Ship.MedicalCrew); 
   AddLbl.Caption := IntToStr(Ship.UserDef.CmdCrew + Ship.UserDef.Crew);
   Bk5MarineEdit.Text := IntToStr(Ship.Accom.Marines);
   Bk5OtherEdit.Text := IntToStr(Ship.Accom.OtherCrew);

   Bk2MarineEdit.Text := IntToStr(Ship.Accom.Marines);
   Bk2OtherEdit.Text := IntToStr(Ship.Accom.OtherCrew);

   //drop capsules
   LaunchersEdit.Text := IntToStr(Ship.Accom.DropCaps);
   ReadyEdit.Text := IntToStr(Ship.Accom.ReadyDropCaps);
   StoredEdit.Text := IntToStr(Ship.Accom.StoredDropCaps);

   //other section
   FrozWatchEdit.Text := IntToStr(Ship.Accom.FrozWatch);
   if (Ship.DesignRules = 1) then begin
      EngShopEdit.Enabled := False;
      EngShopStatLbl.Enabled := False;
      VehicleShopEdit.Enabled := False;
      VehicleShopStatLbl.Enabled := False;
      LabEdit.Enabled := False;
      LabStatLbl.Enabled := False;
      SickEdit.Enabled := False;
      SickStatLbl.Enabled := False;
      AutoDocEdit.Enabled := False;
      AutoDocStatLbl.Enabled := False;
      AirlockEdit.Enabled := False;
      AirlockStatLbl.Enabled := False;
      FresherEdit.Enabled := False;
      FresherStatLbl.Enabled := False;
      MissileMagEdit.Enabled := False;
      MissileMagStatLbl.Enabled := False;
   end
   else begin
      EngShopEdit.Text := IntToStr(Ship.Accom.EngShop);
      VehicleShopEdit.Text := IntToStr(Ship.Accom.VehicleShop);
      LabEdit.Text := IntToStr(Ship.Accom.Labs);
      SickEdit.Text := IntToStr(Ship.Accom.SickBay);
      AutoDocEdit.Text := IntToStr(Ship.Accom.AutoDoc);
      AirlockEdit.Text := IntToStr(Ship.Accom.Airlock);
      if (Ship.Tonnage >= 100) then begin
         FresherEdit.Enabled := False;
         FresherEdit.Text := '0';
      end
      else begin
         FresherEdit.Enabled := True;
         FresherEdit.Text := IntToStr(Ship.Accom.Fresher);
      end;
      MissileMagEdit.Text := FloatToStrF(Ship.Accom.MissileMag, ffNumber, 18, 2);
   end;
   //form options
   DblOccRadGrp.ItemIndex := Ship.Accom.DblOccMark;
   ShpTrpRadGrp.ItemIndex := Ship.Accom.ShpTrpMark;
   if (Ship.Accom.AutoCargoMark = 1) then begin
      CargoChkBx.State := cbChecked;
   end
   else begin
      CargoChkBx.State := cbUnchecked;
   end;

   (* Redundant Section
   //disable accomodations according to ship size
   if (Ship.Tonnage < 100) then begin
      SREdit.Text := '0';
      SREdit.Enabled := False;
   end
   else begin
      SmSREdit.Text := '0';
      SmSREdit.Enabled := False ;
      CouchesEdit.Text := '0';
      CouchesEdit.Enabled := False;
   end;
   *)
   CaptainChkBox.Checked := Ship.Accom.Bk2Captain;

   RefreshForm;
end;

function TAccomFrm.TrapErrors: Boolean;
//trap any errors

begin
   Result := False;

   //check for empty fields
   if (HighEdit.Text = '') then begin
      MessageDlg('No value entered for High Passengers (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (MidEdit.Text = '') then begin
      MessageDlg('No value entered for Middle Passengers (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LowPEdit.Text = '') then begin
      MessageDlg('No value entered for Low Passengers (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (SREdit.Text = '') then begin
      MessageDlg('No value entered for Staterooms (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (SmSREdit.Text = '') then begin
      MessageDlg('No value entered for Small Craft Staterooms (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (CouchesEdit.Text = '') then begin
      MessageDlg('No value entered for Small Craft Couches (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LowBEdit.Text = '') then begin
      MessageDlg('No value entered for Low Berths (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (EmLowEdit.Text = '') then begin
      MessageDlg('No value entered for Emergancy Low Berths (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (CargoEdit.Text = '') then begin
      MessageDlg('No value entered for Cargo (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Bk2MarineEdit.Text = '') then begin
      MessageDlg('No value entered for Marines (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Bk5MarineEdit.Text = '') then begin
      MessageDlg('No value entered for Marines (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Bk5OtherEdit.Text = '') then begin
      MessageDlg('No value entered for Other Crew (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Bk2OtherEdit.Text = '') then begin
      MessageDlg('No value entered for Other Crew (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LaunchersEdit.Text = '') then begin
      MessageDlg('No value entered for Drop Capsule Launchers (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (ReadyEdit.Text = '') then begin
      MessageDlg('No value entered for Ready Drop Capsules (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StoredEdit.Text = '') then begin
      MessageDlg('No value entered for Stored Drop Capsules (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (FrozWatchEdit.Text = '') then begin
      MessageDlg('No value entered for Frozen Watches (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (EngShopEdit.Text = '') then begin
      MessageDlg('No value entered for Engineering Shops (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (VehicleShopEdit.Text = '') then begin
      MessageDlg('No value entered for Vehicle Shops (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LabEdit.Text = '') then begin
      MessageDlg('No value entered for Laboratories (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (SickEdit.Text = '') then begin
      MessageDlg('No value entered for Sickbays (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (AutoDocEdit.Text = '') then begin
      MessageDlg('No value entered for Autodocs (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (AirlockEdit.Text = '') then begin
      MessageDlg('No value entered for Airlocks (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (FresherEdit.Text = '') then begin
      MessageDlg('No value entered for Freshers (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (MissileMagEdit.Text = '') then begin
      MessageDlg('No value entered for Missile Magzines (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;

   //check the integers are integers
   if (StrToIntDef(HighEdit.Text, 3) = 3) and
         (StrToIntDef(HighEdit.Text, 2) = 2) then begin
      MessageDlg('High Passengers must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(MidEdit.Text, 3) = 3) and
         (StrToIntDef(MidEdit.Text, 2) = 2) then begin
      MessageDlg('Middle Passengers must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(LowPEdit.Text, 3) = 3) and
         (StrToIntDef(LowPEdit.Text, 2) = 2) then begin
      MessageDlg('Low Passengers must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(CouchesEdit.Text, 3) = 3) and
         (StrToIntDef(CouchesEdit.Text, 2) = 2) then begin
      MessageDlg('Small Craft Couches must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(LowBEdit.Text, 3) = 3) and
         (StrToIntDef(LowBEdit.Text, 2) = 2) then begin
      MessageDlg('Low Berths must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(EmLowEdit.Text, 3) = 3) and
         (StrToIntDef(EmLowEdit.Text, 2) = 2) then begin
      MessageDlg('Emergancy Low Berths must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Bk2MarineEdit.Text, 3) = 3) and
         (StrToIntDef(Bk2MarineEdit.Text, 2) = 2) then begin
      MessageDlg('Marines must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Bk5MarineEdit.Text, 3) = 3) and
         (StrToIntDef(Bk5MarineEdit.Text, 2) = 2) then begin
      MessageDlg('Marines must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Bk5OtherEdit.Text, 3) = 3) and
         (StrToIntDef(Bk5OtherEdit.Text, 2) = 2) then begin
      MessageDlg('Other Crew must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Bk2OtherEdit.Text, 3) = 3) and
         (StrToIntDef(Bk2OtherEdit.Text, 2) = 2) then begin
      MessageDlg('Other Crew must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(LaunchersEdit.Text, 3) = 3) and
         (StrToIntDef(LaunchersEdit.Text, 2) = 2) then begin
      MessageDlg('Drop Capsule Launchers must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(ReadyEdit.Text, 3) = 3) and
         (StrToIntDef(ReadyEdit.Text, 2) = 2) then begin
      MessageDlg('Ready Drop Capsules must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(StoredEdit.Text, 3) = 3) and
         (StrToIntDef(StoredEdit.Text, 2) = 2) then begin
      MessageDlg('Stored Drop Capsules must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(FrozWatchEdit.Text, 3) = 3) and
         (StrToIntDef(FrozWatchEdit.Text, 2) = 2) then begin
      MessageDlg('Frozen Watches must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(EngShopEdit.Text, 3) = 3) and
         (StrToIntDef(EngShopEdit.Text, 2) = 2) then begin
      MessageDlg('Engineering Shops must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(VehicleShopEdit.Text, 3) = 3) and
         (StrToIntDef(VehicleShopEdit.Text, 2) = 2) then begin
      MessageDlg('Vehicle Shops must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(LabEdit.Text, 3) = 3) and
         (StrToIntDef(LabEdit.Text, 2) = 2) then begin
      MessageDlg('Laboratories must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(SickEdit.Text, 3) = 3) and
         (StrToIntDef(SickEdit.Text, 2) = 2) then begin
      MessageDlg('Sickbays must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(AutoDocEdit.Text, 3) = 3) and
         (StrToIntDef(AutoDocEdit.Text, 2) = 2) then begin
      MessageDlg('Autodocs must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(AirlockEdit.Text, 3) = 3) and
         (StrToIntDef(AirlockEdit.Text, 2) = 2) then begin
      MessageDlg('Airlocks must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(FresherEdit.Text, 3) = 3) and
         (StrToIntDef(FresherEdit.Text, 2) = 2) then begin
      MessageDlg('Freshers must be an Integer Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;

   //check reals are real
   if (StrToFloatDef(RemoveCommas(SREdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(SREdit.Text), 2) = 2) then begin
      MessageDlg('Staterooms must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(SmSREdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(SmSREdit.Text), 2) = 2) then begin
      MessageDlg('Small Craft Staterooms must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(CargoEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(CargoEdit.Text), 2) = 2) then begin
      MessageDlg('Cargo must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(MissileMagEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(MissileMagEdit.Text), 2) = 2) then begin
      MessageDlg('Missile Magzines must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;

   //check for negatives
   if (StrToInt(HighEdit.Text) < 0) then begin
      MessageDlg('High Passengers may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(MidEdit.Text) < 0) then begin
      MessageDlg('Middle Passengers may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(LowPEdit.Text) < 0) then begin
      MessageDlg('Low Passengers may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(SREdit.Text)) < 0) then begin
      MessageDlg('Staterooms may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(SmSREdit.Text)) < 0) then begin
      MessageDlg('Small Craft Staterooms may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(CouchesEdit.Text) < 0) then begin
      MessageDlg('Small Craft Couches may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(LowBEdit.Text) < 0) then begin
      MessageDlg('Low Berths may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(EmLowEdit.Text) < 0) then begin
      MessageDlg('Emergancy Low Berths may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Bk5MarineEdit.Text) < 0) then begin
      MessageDlg('Marines may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Bk2MarineEdit.Text) < 0) then begin
      MessageDlg('Marines may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Bk5OtherEdit.Text) < 0) then begin
      MessageDlg('Other Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Bk2OtherEdit.Text) < 0) then begin
      MessageDlg('Other Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(LaunchersEdit.Text) < 0) then begin
      MessageDlg('Drop Capsule Launchers may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(ReadyEdit.Text) < 0) then begin
      MessageDlg('Ready Drop Capsules may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(StoredEdit.Text) < 0) then begin
      MessageDlg('Stored Drop Capsules may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(FrozWatchEdit.Text) < 0) then begin
      MessageDlg('Frozen Watches may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(EngShopEdit.Text) < 0) then begin
      MessageDlg('Engineering Shops may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(VehicleShopEdit.Text) < 0) then begin
      MessageDlg('Vehicle Shops may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(LabEdit.Text) < 0) then begin
      MessageDlg('Laboratories may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(SickEdit.Text) < 0) then begin
      MessageDlg('Sickbays may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(AutoDocEdit.Text) < 0) then begin
      MessageDlg('Autodocs may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(AirlockEdit.Text) < 0) then begin
      MessageDlg('Airlocks may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(FresherEdit.Text) < 0) then begin
      MessageDlg('Freshers may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(MissileMagEdit.Text)) < 0) then begin
      MessageDlg('Missile Magazines may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;

   //Check for insufficent accomodations
   (*Redundant Section
   if (StrToFloat(RemoveCommas(CargoEdit.Text)) < 0) then begin
      MessageDlg('Cargo may not be a negative number', mtError, [mbOk], 0)
      Result := True;
      Exit;
   end;
   if (Ship.Tonnage >= 100) and (StrToFloat(SREdit.Text) < RequiredSR) then begin
      MessageDlg('Insufficent Staterooms', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   *)
   //Begin Changed Section
   if (StrToFloat(RemoveCommas(CargoEdit.Text)) < 0) then begin
      if (Warn('Cargo may not be a Negative Number.'
            + ' Do you wish to correct this now?')) then begin
         Result := True;
         Exit;
      end;
   end;
   if (Ship.Tonnage >= 100) and (StrToFloat(RemoveCommas(SREdit.Text)) < RequiredSR) then begin
      if (Warn('Insufficent Staterooms, do you wish to correct this now?')) then begin
         Result := True;
         Exit;
      end;
   end;
   if (Ship.Tonnage < 100) and (StrToInt(CouchesEdit.Text) < RequiredCouches) then begin
      if (Warn('Insufficent Small Craft Couches, do you wish to correct this now?')) then begin
         Result := True;
         Exit;
      end;
   end;
   if (StrToInt(LowBEdit.Text) < RequiredLowBerths) then begin
      if (Warn('Insufficent LowBerths, do you wish to correct this now?')) then begin
         Result := True;
         Exit;
      end;
   end;
   //End Changed Section

   //check for tech level requirements
   if ((StrToInt(LowBEdit.Text) + StrToInt(EmLowEdit.Text)) > 0) and (Ship.TechLevel < 9) then begin
      MessageDlg('Low Berths require a minimum Tech Level of 9', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if ((StrToInt(LaunchersEdit.Text) + StrToInt(ReadyEdit.Text) + StrToInt(StoredEdit.Text)) > 0) and (Ship.TechLevel < 10) then begin
      MessageDlg('Drop Capsules require a minimum Tech Level of 10', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
end;

procedure TAccomFrm.HighEditChange(Sender: TObject);
//ignore errors

begin
   with HighEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.MidEditChange(Sender: TObject);
//ignore errors

begin
   with MidEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.LowPEditChange(Sender: TObject);
//ignore errors

begin
   with LowPEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.SREditChange(Sender: TObject);
//ignore errors

begin
  with SREdit do
  begin
    if (Text = '') then
    begin
      Abort;
    end;
    if (StrToFloatDef(RemoveCommas(Text), 3) = 3)
        and (StrToFloatDef(RemoveCommas(Text), 2) = 2) then
    begin
      Abort;
    end;
  end;
  RefreshForm;
end;

procedure TAccomFrm.SmSREditChange(Sender: TObject);
//ignore errors

begin
   with SmSREdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 3) = 3)
            and (StrToFloatDef(RemoveCommas(Text), 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.CouchesEditChange(Sender: TObject);
//ignore errors

begin
   with CouchesEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.LowBEditChange(Sender: TObject);
//ignore errors

begin
   with LowBEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.EmLowEditChange(Sender: TObject);
//ignore errors

begin
   with EmLowEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.CargoEditChange(Sender: TObject);
//ignore errors

begin
   with CargoEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 3) = 3)
            and (StrToFloatDef(RemoveCommas(Text), 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.Bk5MarineEditChange(Sender: TObject);
//ignore errors

begin
   with Bk5MarineEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.Bk5OtherEditChange(Sender: TObject);
//ignore errors

begin
   with Bk5OtherEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.Bk2OtherEditChange(Sender: TObject);
//ignore errors

begin
   with Bk2OtherEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.LaunchersEditChange(Sender: TObject);
//ignore errors

begin
   with LaunchersEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.ReadyEditChange(Sender: TObject);
//ignore errors

begin
   with ReadyEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.StoredEditChange(Sender: TObject);
//ignore errors

begin
   with StoredEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

function TAccomFrm.ExistingCmdCrew: Integer;
//get the total command crew from the ship excluding crew that can be
//set on form

//need to add medical crew

begin
   Result := Ship.Eng.CmdCrew + Ship.Avionics.CmdCrew
         + Min(1, Ship.SpinalMount.CmdCrew + Ship.BigBays.CmdCrew
         + Ship.LittleBays.CmdCrew + Ship.Turrets.CmdCrew + Ship.Screens.CmdCrew)
         + Ship.Craft.CmdCrew + {Ship.Accom.CmdCrew +} Ship.UserDef.CmdCrew;
end;

function TAccomFrm.ExistingCrew: Integer;
//get the total non-command crew from the ship excluding crew that can be
//set on form

begin
   Result := Ship.Eng.Crew + Ship.Avionics.Crew + Ship.SpinalMount.Crew
         + Ship.BigBays.Crew + Ship.LittleBays.Crew + Ship.Turrets.Crew
         + Ship.Screens.Crew + Ship.Craft.Crew {+ Ship.Accom.Crew}
         + Ship.UserDef.Crew;
end;

function TAccomFrm.FormCmdCrew: Integer;
//calculate the command crew that can be set on the form

begin
  if (Ship.CrewRules = 0) or (Ship.Tonnage < 100) then
  begin
    if (CaptainChkBox.Checked) then
    begin
      Result := 1;
    end
    else
    begin
      Result := 0;
    end;
  end
  else
  begin
    if (StrToInt(Bk5MarineEdit.Text) > 0) then begin
      Result := 2;   //marine commander plus medical commander
    end
    else
    begin
      Result := 1;    //medical commander
    end;
  end;
end;

function TAccomFrm.FormCrew: Integer;
//calculate the non-command crew that can be set on the form
//

var
   Passengers : Integer;
   ShipPass: Integer;
   MedicCrew : Integer;
   iCrew: Integer;
begin
   //how many passengers on form and in ship
   Passengers := StrToInt(HighEdit.Text) + StrToInt(MidEdit.Text)
         + StrToInt(LowPEdit.Text);
   ShipPass := Ship.Accom.HighPass + Ship.Accom.MidPass + Ship.Accom.LowPass;
   Result := 0;

   //book 2 calculataions
   if (Ship.CrewRules = 0) {or (Ship.Tonnage < 100)} then begin
      //if there are marines count them
      if (StrToInt(Bk2MarineEdit.Text) > 0) then begin
         Result := Result + StrToInt(Bk2MarineEdit.Text);
      end;

      //if there are other crew count them
      if (StrToInt(Bk2OtherEdit.Text) > 0) then begin
         Result := Result + StrToInt(Bk2OtherEdit.Text);
      end;

      //if there are no passengers in ship but some on form, calculate the
      //stewards required
      if (Ship.Accom.HighPass = 0) and (StrToInt(HighEdit.Text) > 0) then begin
         Result := Result + (StrToInt(HighEdit.Text) div 8);
         if ((StrToInt(HighEdit.Text) mod 8) <> 0) then begin
            Result := Result + 1;
         end;
      end;

      //calculate the medics required
      //if no passengers in ship and some on form and ship is less than 200T
      if (ShipPass = 0) and (Passengers > 0) and (Ship.Tonnage < 200) then begin
         Result := Result + (Passengers div 120);
         if ((Passengers mod 120) <> 0) then begin
            Result := Result + 1;
         end;
      end;
      //if no passengers in ship and some on form and ship is 200T or over
      if (ShipPass = 0) and (Passengers > 120) and (Ship.Tonnage >= 200) then begin
         Result := Result + ((Passengers div 120) - 1);
         if ((Passengers mod 120) <> 0) then begin
            Result := Result + 1;
         end;
      end;
   end

   //book 5 calculations
   else begin
      //if there are marines count them
      if (StrToInt(Bk5MarineEdit.Text) > 0) then begin
         Result := Result + StrToInt(Bk5MarineEdit.Text) - 1;
      end;

      //if there are ships troops count them
      if (ShpTrpRadGrp.ItemIndex = 0) then begin
         Result := Result + Round(Ship.Tonnage / 1000);
      end;
      
      //if there are other crew count them
      if (StrToInt(Bk5OtherEdit.Text) > 0) then begin
         Result := Result + StrToInt(Bk5OtherEdit.Text);
      end;

      //calculate medical crew
      //this still needs work
      iCrew := Result + ExistingCrew + StrToInt(HighEdit.Text) + StrToInt(MidEdit.Text)
                    + StrToInt(LowBEdit.Text);
      MedicCrew := iCrew div 240;
      repeat
        if (((iCrew + MedicCrew) div 240) > MedicCrew) then
        begin
          MedicCrew := (iCrew + MedicCrew) div 240
        end;
      until (((iCrew + MedicCrew) div 240) = MedicCrew);
      //if (Ship.Tonnage >= 100) then Inc(MedicCrew, 1);
      MedLbl.Caption := IntToStr(MedicCrew);
      Result := Result + MedicCrew;
   end;
end;

procedure TAccomFrm.RefreshForm;
//fill the form with data

begin
   //put minimum accomodation facilities
   if (Ship.Tonnage >= 100) then begin
      SRLbl.Caption := FloatToStr(RequiredSR);
      CouchesLbl.Caption := '0';
   end
   else begin
      SRLbl.Caption := '0';
      CouchesLbl.Caption := IntToStr(RequiredCouches);
   end;
   SmSRLbl.Caption := '0';
   LowBLbl.Caption := IntToStr(RequiredLowBerths);
   EmLowLbl.Caption := '0';

   //put how much cargo, if auto calculating cargo, disable the cargo edit
   //remember to add in engineering upgrade space
   if (CargoChkBx.Checked) then begin
      CargoEdit.Enabled := False;
      CargoEdit.Text := FloatToStrF(Ship.GetRemTonnage
            + ExistingSpace - FormSpace + Ship.Eng.UpgradeSpaceAvailable, ffNumber, 18, 3);
   end
   else begin
      CargoEdit.Enabled := True;
   end;

   //if book 2 crew set ships troops to zero and disable
   //chose which marine and other bo to use
   if (Ship.CrewRules = 0) then begin
      ShpTrpRadGrp.ItemIndex := 1;
      ShpTrpRadGrp.Enabled := False;
      Bk5MarineEdit.Text := Bk2MarineEdit.Text;
   end
   else if (StrToInt(Bk5MarineEdit.Text) = 0) then begin
      ShpTrpRadGrp.ItemIndex := 0;
      ShpTrpRadGrp.Enabled := False;
      Bk2MarineEdit.Text := Bk5MarineEdit.Text;
   end
   else begin
      ShpTrpRadGrp.Enabled := True;
      Bk2MarineEdit.Text := Bk5MarineEdit.Text;
   end;

   //if book 2 crew display the crew list
   if (Ship.CrewRules = 0) {or (Ship.Tonnage < 100)} then begin
      Book2Crew;
   end;

   //disable accomodations by tech level
   if (Ship.TechLevel < 9) then begin
      LowPEdit.Text := '0';
      LowPEdit.Enabled := False;
      LowBLbl.Caption := '0';
      LowBEdit.Text := '0';
      LowBEdit.Enabled := False;
      EmLowEdit.Text := '0';
      EmLowEdit.Enabled := False;
   end;
   if (Ship.TechLevel < 10) then begin
      LaunchersEdit.Text := '0';
      LaunchersEdit.Enabled := False;
      ReadyEdit.Text := '0';
      ReadyEdit.Enabled := False;
      StoredEdit.Text := '0';
      StoredEdit.Enabled := False;
   end;

   //if there are no ships troops, show that
   if (ShpTrpRadGrp.ItemIndex = 1) then begin
      SecLbl.Caption := '0';
   end
   else begin
      SecLbl.Caption := IntToStr(Round(Ship.Tonnage / 1000));
   end;

   //display total crew
   Bk5TotLbl.Caption := IntToStr(ExistingCmdCrew + ExistingCrew + FormCmdCrew + FormCrew);
   Bk2TotLbl.Caption := IntToStr(ExistingCmdCrew + ExistingCrew + FormCmdCrew + FormCrew);
end;

procedure TAccomFrm.CargoChkBxClick(Sender: TObject);
//refresh the form

begin
   RefreshForm;
end;

function TAccomFrm.ExistingSpace: Extended;
//work out how much space the stored ships accomodation elements require

begin
   Result := StRoomSpace(Ship.Accom.StRoom) + SmStRoomSpace(Ship.Accom.SmStRoom)
         + CouchesSpace(Ship.Accom.Couches) + LowBerthSpace(Ship.Accom.LowBerth)
         + EmLowBerthSpace(Ship.Accom.EmLowBerth) + (Ship.Accom.Cargo)
         + (Ship.Accom.DropCaps * 1) + (Ship.Accom.ReadyDropCaps * 0.5)
         + (Ship.Accom.StoredDropCaps * 0.5) + (Ship.Accom.EngShop * 6)
         + (Ship.Accom.VehicleShop * 10) + (Ship.Accom.Labs * 8)
         + (Ship.Accom.SickBay * 8) + (Ship.Accom.AutoDoc * 2)
         + (Ship.Accom.Airlock * 2) + (Ship.Accom.Fresher * 0.5)
         + (Ship.Accom.MissileMag * 1);
end;

function TAccomFrm.FormSpace: Extended;
//work out how much space the items on the form take up

begin
   Result := StRoomSpace(StrToFloat(SREdit.Text))
         + SmStRoomSpace(StrToFloat(SmSREdit.Text))
         + CouchesSpace(StrToInt(CouchesEdit.Text))
         + LowBerthSpace(StrToInt(LowBEdit.Text))
         + EmLowBerthSpace(StrToInt(EmLowEdit.Text))
         + (StrToInt(LaunchersEdit.Text) * 1)
         + (StrToInt(ReadyEdit.Text) * 0.5)
         + (StrToInt(StoredEdit.Text) * 0.5)
         + (StrToInt(EngShopEdit.Text) * 6)
         + (StrToInt(VehicleShopEdit.Text) * 10)
         + (StrToInt(LabEdit.Text) * 8)
         + (StrToInt(SickEdit.Text) * 8)
         + (StrToInt(AutoDocEdit.Text) * 2)
         + (StrToInt(AirlockEdit.Text) * 3)
         + (StrToInt(FresherEdit.Text) * 0.5)
         + (StrToFloat(MissileMagEdit.Text) * 1);
end;

procedure TAccomFrm.DblOccRadGrpClick(Sender: TObject);
//refresh the form

begin
   RefreshForm;
end;

procedure TAccomFrm.ShpTrpRadGrpClick(Sender: TObject);
//refresh the form

begin
   RefreshForm;
end;

procedure TAccomFrm.Book2Crew;
//calcualate and display a book 2 crew list

//1.1 revision. this is too large, break up

var
   CrewString : TStringList;
   EngString, StewardString, MedicString, GunnerString, FlightString, MarineString, OtherString : String;
   Stewards, Medics, Passengers : Integer;
begin
   CrewString := TStringList.Create;
   try
      //initialise variables
      Stewards := 0;
      Medics := 0;

      //calculate the number of passengers based on form data
      Passengers := StrToInt(HighEdit.Text) + StrToInt(MidEdit.Text)
            + StrToInt(LowPEdit.Text);

      //if there's a captain add them
      if (CaptainChkBox.Checked) then CrewString.Add('Captain');

      //add a pilot
      CrewString.Add('Pilot');

      //add navigator if required
      if (Ship.Tonnage > 200) and (Ship.Eng.JDrive <> 0) then begin
         CrewString.Add('Navigator');
      end;

      //calculate and add the number of engineers (1 per 35T of drive)
      if not (Ship.Tonnage < 200) then begin
         EngString := IntToStr(Ship.Eng.Crew) + ' Engineer';
         if (Ship.Eng.Crew > 1) then begin
            EngString := EngString + 's';
         end;
         CrewString.Add(EngString);
      end;

      //calculate and add the number of stewards (1 per 8 high passengers)
      if (StrToInt(HighEdit.Text) > 0) then begin
         Stewards := StrToInt(HighEdit.Text) div 8;
         if ((StrToInt(HighEdit.Text) mod 8) <> 0) then begin
            Stewards := Stewards + 1;
         end;
         StewardString := IntToStr(Stewards) + ' Steward';
         if (Stewards > 1) then begin
            StewardString := StewardString + 's';
         end;
         CrewString.Add(StewardString);
      end;

      //calculate and add the number of medics (1 per 120 passengers)
      //must have a medic if 200T+
      if ((Ship.Tonnage >= 200) or (Passengers > 0)) and (Ship.Eng.JDrive <> 0)  then begin
         Medics := Max(1, Passengers div 120);
         if (Passengers > 120) and ((Passengers mod 120) <> 0) then begin
            Medics := Medics + 1;
         end;
         MedicString := IntToStr(Medics) + ' Medic';
         if (Medics > 1) then begin
            MedicString := MedicString + 's';
         end;
         CrewString.Add(MedicString);
      end;

      //calculate and add the number of gunners (2 per bay, plus 1 per turret
      //battery, plus screens)
      if (Ship.BigBays.Crew > 0)
            or (Ship.LittleBays.Crew > 0)
            or (Ship.Turrets.Crew > 0)
            or (Ship.Screens.Crew > 0) then begin
         GunnerString := IntToStr(Ship.BigBays.Crew
               + Ship.LittleBays.Crew + Ship.Turrets.Crew + Ship.Screens.Crew) + ' Gunner';
         if (Ship.BigBays.Crew > 1)
               or (Ship.LittleBays.Crew > 1)
               or (Ship.Turrets.Crew > 1)
               or (Ship.Screens.Crew > 1) then begin
            GunnerString := GunnerString + 's';
         end;
         CrewString.Add(GunnerString);
      end;

      //calculate and add the flight crew
      if (Ship.Craft.Crew > 0) then begin
         FlightString := IntToStr(Ship.Craft.Crew) + ' Flight Crew';
         CrewString.Add(FlightString);
      end;

      //add the marines
      if (StrToInt(Bk2MarineEdit.Text) > 0) then begin
         MarineString := Bk2MarineEdit.Text + ' Marine';
         if (StrToInt(Bk2MarineEdit.Text) > 1) then begin
            MarineString := MarineString + 's';
         end;
         CrewString.Add(MarineString);
      end;

      //add any other crew
      if (StrToInt(Bk2OtherEdit.Text) > 0) then begin
         OtherString := Bk2OtherEdit.Text + ' Other';
         if (StrToInt(Bk2OtherEdit.Text) > 1) then begin
            OtherString := OtherString + 's';
         end;
         CrewString.Add(OtherString);
      end;

      //add crew for user defined components
      if (Ship.UserDef.Crew > 0) or (Ship.UserDef.CmdCrew > 0) then begin
         CrewString.Add(IntToStr(Ship.UserDef.CmdCrew + Ship.UserDef.Crew)
               + ' Additional Crew');
      end;

      //display the list
      Book2Memo.Lines := CrewString;
   finally
      FreeAndNil(CrewString);
   end;
end;

function TAccomFrm.RequiredCouches: Integer;
//if under 100T, calculate the number of couches required

begin
   if (Ship.Avionics.Bridge = 0) then begin
      Result := Max(0, (ExistingCmdCrew + FormCmdCrew + ExistingCrew + FormCrew
            + StrToInt(HighEdit.Text) + StrToInt(MidEdit.Text) - 2));
   end
   else begin
      Result := ExistingCmdCrew + FormCmdCrew + ExistingCrew + FormCrew
            + StrToInt(HighEdit.Text) + StrToInt(MidEdit.Text);
   end;
end;

function TAccomFrm.RequiredSR: Extended;
//if 100T+ calculate the number of staterooms required
//passengers always get one stateroom

begin
   if (DblOccRadGrp.ItemIndex = 0) then begin
      Result := ExistingCmdCrew + FormCmdCrew + ((ExistingCrew + FormCrew) / 2)
            + StrToFloat(HighEdit.Text) + StrToFloat(MidEdit.Text);
   end
   else begin
      Result := ExistingCmdCrew + FormCmdCrew + ExistingCrew + FormCrew
            + StrToInt(HighEdit.Text) + StrToInt(MidEdit.Text);
   end;
   //add staterooms for the admiral and staff
   if (Ship.Flagship) then
   begin
     if (DblOccRadGrp.ItemIndex = 0) then
     begin
        Result := Result + 6;
     end
     else
     begin
        Result := Result + 11;
     end;
   end;
end;

function TAccomFrm.RequiredLowBerths: Integer;
//calculate the number of low berths required

var
  TotCrew, FrozWatch : Integer;
begin
  TotCrew := Ship.GetTotalCmdCrew + Ship.GetTotalCrew;
  FrozWatch := StrToInt(FrozWatchEdit.Text);
  if (Ship.AlternateCrewRules > 1) then
  begin
    Result := StrToInt(LowPEdit.Text)
        + FloatToIntUp((TotCrew * FrozWatch) / 2);
  end
  else
  begin
    Result := StrToInt(LowPEdit.Text) + (Ship.CalcSizeCrewSections * FrozWatch);
  end;
end;

function TAccomFrm.CouchesSpace(Couches: Integer): Extended;
//couches take up 0.5T per (modified by race)

begin
   if (Ship.ShipRace = 1) then begin
      Result := Couches * 6;
   end
   else begin
      Result := Couches * 0.5;
   end;
end;

function TAccomFrm.EmLowBerthSpace(EmLowBerth: Integer): Extended;
//emergancy low berths take up 1T per (modified by race)

begin
   if (Ship.ShipRace = 1) then begin
      Result := EmLowBerth * 2;
   end
   else begin
      Result := EmLowBerth * 1;
   end;
end;

function TAccomFrm.LowBerthSpace(LowBerth: Integer): Extended;
//low berths take up 0.5T per (modified by race)

begin
   if (Ship.ShipRace = 1) then begin
      Result := LowBerth * 1;
   end
   else begin
      Result := LowBerth * 0.5;
   end;
end;

function TAccomFrm.SmStRoomSpace(SmSR: Extended): Extended;
//small craft staterooms take up 2T per (modified by race)

begin
   case (Ship.ShipRace) of
      0: Result := SmSR * 2;
      1: Result := SmSR * 24;
      2: Result := SmSR * 2;
      3: Result := SmSR * 1;
      4: Result := SmSR * 2;
   end;
end;

function TAccomFrm.StRoomSpace(SR: Extended): Extended;
//staterooms take up 4T per (modified by race)

begin
   case (Ship.ShipRace) of
      0: Result := SR * 4;
      1: Result := SR * 48;
      2: Result := SR * 4;
      3: Result := SR * 2;
      4: Result := SR * 4;
   end;
end;

procedure TAccomFrm.Bk2MarineEditChange(Sender: TObject);
//if the marine edit changes, skip the errors and refresh the form

begin
   with Bk2MarineEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

function TAccomFrm.Warn(TheMessage: String): Boolean;
//display a warning with a yes/no

begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TAccomFrm.FrozWatchEditChange(Sender: TObject);
//if the frozen watch edit changes, skip the errors and refresh the form

begin
   with FrozWatchEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.EngShopEditChange(Sender: TObject);
//T20 METHOD
//if the engineering shop edit changes, skip the errors and refresh the form

begin
   with EngShopEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.VehicleShopEditChange(Sender: TObject);
//T20 METHOD
//if the vehicle shop edit changes, skip the errors and refresh the form

begin
   with VehicleShopEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.LabEditChange(Sender: TObject);
//T20 METHOD
//if the labs edit changes, skip the errors and refresh the form

begin
   with LabEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.SickEditChange(Sender: TObject);
//T20 METHOD
//if the sickbay edit changes, skip the errors and refresh the form

begin
   with SickEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.AutoDocEditChange(Sender: TObject);
//T20 METHOD
//if the autodoc edit changes, skip the errors and refresh the form

begin
   with AutoDocEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.AirlockEditChange(Sender: TObject);
//T20 METHOD
//if the airlock edit changes, skip the errors and refresh the form

begin
   with AirlockEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

procedure TAccomFrm.FresherEditChange(Sender: TObject);
//T20 METHOD
//if the fresher edit changes, skip the errors and refresh the form

begin
   with FresherEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

function TAccomFrm.FloatToIntDown(TheFloat: Extended): Integer;
//change a float to an int rounding down

begin
   Result := StrToInt(FloatToStr(Int(TheFloat)));
end;

function TAccomFrm.FloatToIntUp(TheFloat: Extended): Integer;
//change a float to an int rounding up

begin
   if ((TheFloat - Int(TheFloat)) <> 0) then begin
      Result := FloatToIntDown(TheFloat) + 1;
   end
   else begin
      Result := FloatToIntDown(TheFloat);
   end;
end;

procedure TAccomFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//go to the design assistant

var
   DesAssist : TDesAssistFrm;
   FullShipData : TStringList;
begin
//   if (Key = VK_F1) and (ssCtrl in Shift) then begin
  if (Key = VK_F3) then begin
    DesAssist := TDesAssistFrm.Create(Self);
    try
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
        FullShipData.Add(Ship.GenScreenDetails);
        FullShipData.Add(Ship.GenCraftDetails);
        FullShipData.Add(GenerateAccomDetails);
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
    finally
      DesAssist.Release;
    end;
  end;
end;

function TAccomFrm.GenerateAccomDetails: String;
//generate accommodation and misc file details

begin
   Result := IntToStr(DblOccRadGrp.ItemIndex)
         + SEP + IntToStr(ShpTrpRadGrp.ItemIndex)
         + SEP + HighEdit.Text
         + SEP + MidEdit.Text
         + SEP + LowPEdit.Text
         + SEP + RemoveCommas(SREdit.Text)
         + SEP + RemoveCommas(SmSREdit.Text)
         + SEP + CouchesEdit.Text
         + SEP + LowBEdit.Text
         + SEP + EmLowEdit.Text
         + SEP + GetCargo
         + SEP + IsChecked(CargoChkBx)
         + SEP + GetMarines
         + SEP + GetOther
         + SEP + LaunchersEdit.Text
         + SEP + ReadyEdit.Text
         + SEP + StoredEdit.Text
         + SEP + FrozWatchEdit.Text
         + SEP + EngShopEdit.Text
         + SEP + VehicleShopEdit.Text
         + SEP + LabEdit.Text
         + SEP + SickEdit.Text
         + SEP + AutoDocEdit.Text
         + SEP + AirlockEdit.Text
         + SEP + FresherEdit.Text
         + SEP + RemoveCommas(MissileMagEdit.Text)
         + SEP + BoolToStr(CaptainChkBox.Checked)
         + SEP + '0';     //wiggle room
end;

function TAccomFrm.IsChecked(var ChkBx: TCheckBox): String;
//check to see if craft is vehicle

begin
   Result := '0';
   if (ChkBx.Checked) then begin
      Result := '1';
   end;
end;

function TAccomFrm.GetMarines: String;
//get the number of marines

begin
   if (Ship.CrewRules = 0) then begin
      Result := Bk2MarineEdit.Text;
   end
   else begin
      Result := Bk5MarineEdit.Text;
   end;
end;

function TAccomFrm.GetOther: String;
//get the number of other crew

begin
   if (Ship.CrewRules = 0) then begin
      Result := Bk2OtherEdit.Text;
   end
   else begin
      Result := Bk5OtherEdit.Text;
   end;
end;

function TAccomFrm.GetCargo: String;
//if autocalc cargo return zero otherwise return cargo in box

var
   CargoSize : Extended;
begin
   Result := '0.0000';
   if not (CargoChkBx.Checked) then begin
      Result := CargoEdit.Text;
   end;
end;

procedure TAccomFrm.MissileMagEditChange(Sender: TObject);
//T20 METHOD
//if the missile magazine edit changes, skip the errors and refresh the form

begin
   with MissileMagEdit do begin
      if (Text = '') then begin
         Abort;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 3) = 3)
            and (StrToFloatDef(RemoveCommas(Text), 2) = 2) then begin
         Abort;
      end;
   end;
   RefreshForm;
end;

end.



