unit EngFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ShipPas, Math, DesAssistFrmPas, HgsFormFrm;

type

  { TEngFrm }

  TEngFrm = class(THgsForm)
    DriveUpgradeChkBx: TCheckBox;
    SingleEngSpaceChkBx: TCheckBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    DrivesGrpBx: TGroupBox;
    MDriveStatLbl: TLabel;
    JDriveStatLbl: TLabel;
    CodeStatLbl: TLabel;
    JDriveComboBx: TComboBox;
    MDriveComboBx: TComboBox;
    PowerGrpBx: TGroupBox;
    EPGenLbl: TLabel;
    PwrPlntStatLbl: TLabel;
    PwrPlntEdit: TEdit;
    EPGenStatLbl: TLabel;
    PowerStatLbl: TLabel;
    RefitJDEdit: TEdit;
    RefitPPEdit: TEdit;
    BackupsGrpBx: TGroupBox;
    BakMDriveStatLbl: TLabel;
    BakPwrPlntStatLbl: TLabel;
    BakJDriveStatLbl: TLabel;
    NumStatLbl: TLabel;
    BakCodeStatLbl: TLabel;
    BakPwrPlntEdit: TEdit;
    NoBakMEdit: TEdit;
    NoBakPPEdit: TEdit;
    NoBakJEdit: TEdit;
    BakJDriveComboBx: TComboBox;
    BakMDriveComboBx: TComboBox;
    RefitBakMDEdit: TEdit;
    RefitBakJDEdit: TEdit;
    RefitBakPPEdit: TEdit;
    RefitBakMDChkBx: TCheckBox;
    RefitBakJDChkbx: TCheckBox;
    RefitBakPPChkBx: TCheckBox;
    RefitJDChkBx: TCheckBox;
    RefitPPChkBx: TCheckBox;
    RefitMDChkBx: TCheckBox;
    RefitMDEdit: TEdit;
    T20BakPPStatLbl: TLabel;
    T20BakPPEdit: TEdit;
    T20NoBakPPEdit: TEdit;
    T20RefitBakPPChkBx: TCheckBox;
    T20RefitBakPPEdit: TEdit;
    RefitTLStatLbl: TLabel;
    PowerRefitTLStatLbl: TLabel;
    T20PowerGrp: TGroupBox;
    PowerTonsStatLbl: TLabel;
    TonsLbl: TLabel;
    EPGenT20StatLbl: TLabel;
    EPGenT20Lbl: TLabel;
    PowerTonsEdit: TEdit;
    T20RefitPPEdit: TEdit;
    T20RefitPPChkBx: TCheckBox;
    T20PowerRefitStatLbl: TLabel;
    BakRefitTechStatLbl: TLabel;
    UpgradeSpaceEdit: TEdit;
    UpgradeSpaceStatLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RefitBakPPEditChange(Sender: TObject);
    procedure SingleEngSpaceChkBxChange(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure PwrPlntEditChange(Sender: TObject);
    procedure MDriveComboBxChange(Sender: TObject);
    procedure JDriveComboBxChange(Sender: TObject);
    procedure BakMDriveComboBxChange(Sender: TObject);
    procedure BakJDriveComboBxChange(Sender: TObject);
    procedure BakPwrPlntEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RefitBakJDChkbxChange(Sender: TObject);
    procedure RefitBakMDChkBxChange(Sender: TObject);
    procedure RefitBakPPChkBxChange(Sender: TObject);
    procedure RefitJDChkBxChange(Sender: TObject);
    procedure RefitMDChkBxChange(Sender: TObject);
    procedure RefitPPChkBxChange(Sender: TObject);
    procedure T20RefitBakPPChkBxChange(Sender: TObject);
    procedure T20RefitPPChkBxChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetMDrive(Tech: Integer);
    procedure SetPPlant(Tech: Integer);
    procedure SetJDrive(Tech: Integer);
    procedure SetRefitItems(IsRefitted: Boolean);
    procedure SendNormalData;
    procedure SendRefitData;
    function TrapErrors : boolean;
    function Confirm (TheMessage: String) : Boolean;
    function Warn (TheMessage: String) : Boolean;
    function GenerateEngDetails : String;
    function RemoveCommas(Text : String) : String;
    function StrToFloatDef(const S: string; Default: Extended): Extended;
    function MDriveSpace(HullSize: Extended; DriveNum: Integer): Extended;
    function JDriveSpace(HullSize: Extended; DriveNum: Integer): Extended;
    function PPlantSpace(HullSize: Extended; PlantNum, PlantTech: Integer): Extended;
    function InvalidRefit: Boolean;
    function InvalidMDrive: Boolean;
    function InvalidPPlant: Boolean;
    function InvalidJDrive: Boolean;
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  EngFrm: TEngFrm;

implementation

uses MainPas;

{$R *.lfm}

{ TEngFrm }

procedure TEngFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
  Action := CaFree;
end;

procedure TEngFrm.FormCreate(Sender: TObject);
//set the drives and EP caption

begin
  //enable refit items if refitted
  SetRefitItems(Ship.IsRefitted);
  UpgradeSpaceEdit.Text := FloatToStrF(Ship.Eng.UpgradeSpace, ffNumber, 19, 3);
  SingleEngSpaceChkBx.Checked := Ship.Eng.SingleEngSpace;
  DriveUpgradeChkBx.Checked := Ship.Eng.DriveUpgradesAllowed;
  if (Ship.IsRefitted) then
  begin
    SetMDrive(Ship.RefitTechLevel);
    SetPPlant(Ship.RefitTechLevel);
    SetJDrive(Ship.RefitTechLevel);
  end
  else
  begin
    DrivesGrpBx.Width := DrivesGrpBx.Width - 97;
    PowerGrpBx.Width := PowerGrpBx.Width - 97;
    T20PowerGrp.Width := T20PowerGrp.Width - 97;
    BackupsGrpBx.Width := BackupsGrpBx.Width - 83;
    BackupsGrpBx.Left := BackupsGrpBx.Left - 97;
    //UpgradeSpaceStatLbl.Left := UpgradeSpaceStatLbl.Left - 97;
    //UpgradeSpaceEdit.Left := UpgradeSpaceEdit.Left - 97;
    OkBtn.Left := OkBtn.Left - 97;
    CancelBtn.Left := CancelBtn.Left - 97;
    SetMDrive(Ship.TechLevel);
    SetPPlant(Ship.TechLevel);
    SetJDrive(Ship.TechLevel);
  end;
  EPGenLbl.Caption := FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3);
  EPGenT20Lbl.Caption := FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3);

  //reposition T20 items (needed as have left them out of position for design
  T20PowerGrp.Top := PowerGrpBx.Top;
  T20PowerGrp.Left := PowerGrpBx.Left;
  T20BakPPStatLbl.Top := BakPwrPlntStatLbl.Top;
  T20BakPPEdit.Top := BakPwrPlntEdit.Top;
  T20NoBakPPEdit.Top := NoBakPPEdit.Top;
  T20RefitBakPPChkBx.Top := RefitBakPPChkBx.Top;
  T20RefitBakPPEdit.Top := RefitBakPPEdit.Top;
  BackupsGrpBx.Height := BackupsGrpBx.Height - 21;
  OkBtn.Top := OkBtn.Top - 13;
  CancelBtn.Top := CancelBtn.Top - 13;

  //choose T20 (0) or HG (1) rules
  if (Ship.DesignRules = 0) then
  begin
    T20PowerGrp.Visible := True;
    T20BakPPStatLbl.Visible := True;
    T20BakPPEdit.Visible := True;
    T20NoBakPPEdit.Visible := True;
    T20RefitBakPPChkBx.Visible := Ship.IsRefitted;
    T20RefitBakPPEdit.Visible := Ship.IsRefitted;
    PowerGrpBx.Visible := False;
    BakPwrPlntStatLbl.Visible := False;
    BakPwrPlntEdit.Visible := False;
    NoBakPPEdit.Visible := False;
    RefitBakPPChkBx.Visible := False;
    RefitBakPPEdit.Visible := False;
  end
  else if (Ship.DesignRules = 1) then
  begin
    T20PowerGrp.Visible := False;
    T20BakPPStatLbl.Visible := False;
    T20BakPPEdit.Visible := False;
    T20NoBakPPEdit.Visible := False;
    T20RefitBakPPChkBx.Visible := False;
    T20RefitBakPPEdit.Visible := False;
    PowerGrpBx.Visible := True;
    BakPwrPlntStatLbl.Visible := True;
    BakPwrPlntEdit.Visible := True;
    NoBakPPEdit.Visible := True;
    RefitBakPPChkBx.Visible := Ship.IsRefitted;
    RefitBakPPEdit.Visible := Ship.IsRefitted;
  end;
end;

procedure TEngFrm.RefitBakPPEditChange(Sender: TObject);
begin

end;

procedure TEngFrm.SingleEngSpaceChkBxChange(Sender: TObject);
begin
  //
end;

procedure TEngFrm.SetJDrive(Tech: Integer);
//set the j drive and backup j drive

var
  jCount : integer;
begin
  JDriveComboBx.Clear;
  BakJDriveComboBx.Clear;
  JDriveComboBx.Items.Add('0');
  BakJDriveComboBx.Items.Add('0');
  if (Ship.IsRefitted) then
  begin
    JDriveStatLbl.Caption := 'J Drive (J' + IntToStr(Ship.Eng.JDrive) + ')';
    BakJDriveStatLbl.Caption := 'JD (J' + IntToStr(Ship.Eng.BakJDrive) + ' x '
        + IntToStr(Ship.Eng.BakJDNum) + ')';
    JDriveComboBx.Text := IntToStr(Ship.Eng.NewJDrive);
    RefitJDEdit.Text := IntToStr(Ship.Eng.JDriveRefitTech);
    BakJDriveComboBx.Text := IntToStr(Ship.Eng.BakNewJDrive);
    NoBakJEdit.Text := IntToStr(Ship.Eng.BakNewJDNumb);
    RefitBakJDEdit.Text := IntToStr(Ship.Eng.BakJDriveRefitTech);
    JDriveComboBx.Enabled := Ship.Eng.JDriveIsRefitted;
    RefitJDEdit.Enabled := Ship.Eng.JDriveIsRefitted;
    BakJDriveComboBx.Enabled := Ship.Eng.BakJDriveIsRefitted;
    NoBakJEdit.Enabled := Ship.Eng.BakJDriveIsRefitted;
    RefitBakJDEdit.Enabled := Ship.Eng.BakJDriveIsRefitted;
    RefitJDChkBx.Checked := Ship.Eng.JDriveIsRefitted;
    RefitBakJDChkBx.Checked := Ship.Eng.BakJDriveIsRefitted;
  end
  else
  begin
    JDriveComboBx.Text := IntToStr(Ship.Eng.JDrive);
    BakJDriveComboBx.Text := IntToStr(Ship.Eng.BakJDrive);
    NoBakJEdit.Text := IntToStr(Ship.Eng.BakJDNum);
  end;

   //fill j drive combo by TL
  case (Tech) of
    7..8 :begin
            JDriveComboBx.Text := '0';
            JDriveComboBx.Enabled := False;
            BakJDriveComboBx.Text := '0';
            BakJDriveComboBx.Enabled := False;
            NoBakJEdit.Text := '0';
            NoBakJEdit.Enabled := False;
          end;
     9..10: begin
              JDriveComboBx.Items.Add('1');
              BakJDriveComboBx.Items.Add('1');
              if (StrToInt(JDriveComboBx.Text) > 1) then
              begin
                JDriveComboBx.Text := '1';
              end;
              if (StrToInt(BakJDriveComboBx.Text) > 1) then
              begin
                BakJDriveComboBx.Text := '1';
              end;
            end;
      11..15 : begin
                 for jCount := 1 to ((Tech) - 9) do
                 begin
                   JDriveComboBx.Items.Add(IntToStr(jCount));
                   BakJDriveComboBx.Items.Add(IntToStr(jCount));
                 end;
                 if (StrToInt(JDriveComboBx.Text) > (Tech)) then
                 begin
                   JDriveComboBx.Text := IntToStr(Tech);
                 end;
                 if (StrToInt(BakJDriveComboBx.Text) > (Tech)) then
                 begin
                   BakJDriveComboBx.Text := IntToStr(Tech);
                 end;
               end;
      else
      begin
        for jCount := 1 to 6 do
        begin
          JDriveComboBx.Items.Add(IntToStr(jCount));
          BakJDriveComboBx.Items.Add(IntToStr(jCount));
        end;
      end;
  end;

   //disable jump drive for small craft
  if (Ship.Tonnage < 100) then
  begin
    JDriveComboBx.Enabled := False;
    JDriveComboBx.Text := '0';
    BakJDriveComboBx.Enabled := False;
    BakJDriveComboBx.Text := '0';
    NoBakJEdit.Enabled := False;
    NoBakJEdit.Text := '0';
  end;
end;

procedure TEngFrm.SetRefitItems(IsRefitted: Boolean);
begin
  UpgradeSpaceEdit.Enabled := not IsRefitted;
  RefitTLStatLbl.Visible := IsRefitted;
  PowerRefitTLStatLbl.Visible := IsRefitted;
  T20PowerRefitStatLbl.Visible := IsRefitted;
  BakRefitTechStatLbl.Visible := IsRefitted;
  RefitMDChkBx.Visible := IsRefitted;
  RefitMDChkBx.Enabled := IsRefitted;
  RefitMDEdit.Visible := IsRefitted;
  RefitMDEdit.Enabled := IsRefitted;
  RefitJDChkBx.Visible := IsRefitted;
  RefitJDChkBx.Enabled := IsRefitted;
  RefitJDEdit.Visible := IsRefitted;
  RefitJDEdit.Enabled := IsRefitted;
  RefitPPChkBx.Visible := IsRefitted;
  RefitPPChkBx.Enabled := IsRefitted;
  RefitPPEdit.Visible := IsRefitted;
  RefitPPEdit.Enabled := IsRefitted;
  RefitBakMDChkBx.Visible := IsRefitted;
  RefitBakMDChkBx.Enabled := IsRefitted;
  RefitBakMDEdit.Visible := IsRefitted;
  RefitBakMDEdit.Enabled := IsRefitted;
  RefitBakJDChkBx.Visible := IsRefitted;
  RefitBakJDChkBx.Enabled := IsRefitted;
  RefitBakJDEdit.Visible := IsRefitted;
  RefitBakJDEdit.Enabled := IsRefitted;
  RefitBakPPChkBx.Visible := IsRefitted;
  RefitBakPPChkBx.Enabled := IsRefitted;
  RefitBakPPEdit.Visible := IsRefitted;
  RefitBakPPEdit.Enabled := IsRefitted;
  SingleEngSpaceChkBx.Enabled := IsRefitted;
  SingleEngSpaceChkBx.Visible := IsRefitted;
  DriveUpgradeChkBx.Enabled := IsRefitted;
  DriveUpgradeChkBx.Visible := IsRefitted;
end;

procedure TEngFrm.SendNormalData;
begin
  Ship.Eng.MDrive := StrToInt(MDriveComboBx.Text);
  Ship.Eng.BakMDrive := StrToInt(BakMDriveComboBx.Text);
  Ship.Eng.BakMDNum := StrToInt(NoBakMEdit.Text);
  Ship.Eng.PPlant := StrToInt(PwrPlntEdit.Text);
  case (Ship.DesignRules) of
    0 : Ship.Eng.BakPPNum := StrToInt(T20NoBakPPEdit.Text);
    1 : Ship.Eng.BakPPlant := StrToInt(BakPwrPlntEdit.Text);
  end;
  Ship.Eng.BakPPNum := StrToInt(NoBakPPEdit.Text);
  Ship.Eng.JDrive := StrToInt(JDriveComboBx.Text);
  Ship.Eng.BakJDrive := StrToInt(BakJDriveComboBx.Text);
  Ship.Eng.BakJDnum := StrToInt(NoBakJEdit.Text);
  Ship.Eng.PowerTons := StrToFloat(RemoveCommas(PowerTonsEdit.Text));
  Ship.Eng.BakPowerTons := StrToFloat(RemoveCommas(T20BakPPEdit.Text));
  Ship.Eng.BakPowerTonsNum := StrToInt(T20NoBakPPEdit.Text);
  Ship.Eng.UpgradeSpace := StrToFloat(RemoveCommas(UpgradeSpaceEdit.Text));
  Ship.Eng.MDriveIsRefitted := False;
  Ship.Eng.NewMDrive := 0;
  Ship.Eng.MDriveRefitTech := 0;
  Ship.Eng.JDriveIsRefitted := False;
  Ship.Eng.NewJDrive := 0;
  Ship.Eng.JDriveRefitTech := 0;
  Ship.Eng.PPlantIsRefitted := False;
  Ship.Eng.NewPPlant := 0;
  Ship.Eng.PPlantRefitTech := 0;
  Ship.Eng.BakMDriveIsRefitted := False;
  Ship.Eng.BakNewMDrive := 0;
  // new bak mdrive numb
  Ship.Eng.BakMDriveRefitTech := 0;
  Ship.Eng.BakJDriveIsRefitted := False;
  Ship.Eng.BakNewJDrive := 0;
  // new bak jdrive numb
  Ship.Eng.BakJDriveRefitTech := 0;
  Ship.Eng.BakPPlantIsRefitted := False;
  Ship.Eng.BakNewPPlant := 0;
  // new bak pp numb
  Ship.Eng.BakPPlantRefitTech := 0;
  Ship.Eng.BakNewMDNumb := 0;
  Ship.Eng.BakNewJDNumb := 0;
  Ship.Eng.BakNewPPNumb := 0;
  Ship.Eng.PowerTonsIsRefitted := False;
  Ship.Eng.NewPowerTons := 0;
  Ship.Eng.PowerTonsRefitTech := 0;
  Ship.Eng.BakPowerTonsIsRefitted := False;
  Ship.Eng.BakNewPowerTons := 0;
  Ship.Eng.BakPowerTonsRefitTech := 0;
  Ship.Eng.BakNewPowerTonsNum := 0;
  Ship.Eng.SingleEngSpace := SingleEngSpaceChkBx.Checked;
  Ship.Eng.DriveUpgradesAllowed := DriveUpgradeChkBx.Checked;
end;

procedure TEngFrm.SendRefitData;
begin
  Ship.Eng.MDriveIsRefitted := RefitMDChkBx.Checked;
  Ship.Eng.NewMDrive := StrToInt(MDriveComboBx.Text);
  Ship.Eng.MDriveRefitTech := StrToInt(RefitMDEdit.Text);
  Ship.Eng.JDriveIsRefitted := RefitJDChkBx.Checked;
  Ship.Eng.NewJDrive := StrToInt(JDriveComboBx.Text);
  Ship.Eng.JDriveRefitTech := StrToInt(RefitJDEdit.Text);
  Ship.Eng.PPlantIsRefitted := RefitPPChkBx.Checked;
  Ship.Eng.NewPPlant := StrToInt(PwrPlntEdit.Text);
  Ship.Eng.PPlantRefitTech := StrToInt(RefitPPEdit.Text);
  Ship.Eng.BakMDriveIsRefitted := RefitBakMDChkBx.Checked;
  Ship.Eng.BakNewMDrive := StrToInt(BakMDriveComboBx.Text);
  // new bak mdrive numb
  Ship.Eng.BakMDriveRefitTech := StrToInt(RefitBakMDEdit.Text);
  Ship.Eng.BakJDriveIsRefitted := RefitBakJDChkBx.Checked;
  Ship.Eng.BakNewJDrive := StrToInt(BakJDriveComboBx.Text);
  // new bak jdrive numb
  Ship.Eng.BakJDriveRefitTech := StrToInt(RefitBakJDEdit.Text);
  Ship.Eng.BakPPlantIsRefitted := RefitBakPPChkBx.Checked;
  Ship.Eng.BakNewPPlant := StrToInt(BakPwrPlntEdit.Text);
  // new bak pp numb
  Ship.Eng.BakPPlantRefitTech := StrToInt(RefitBakPPEdit.Text);
  Ship.Eng.BakNewMDNumb := StrToInt(NoBakMEdit.Text);
  Ship.Eng.BakNewJDNumb := StrToInt(NoBakJEdit.Text);
  Ship.Eng.BakNewPPNumb := StrToInt(NoBakPPEdit.Text);
  Ship.Eng.PowerTonsIsRefitted := T20RefitPPChkBx.Checked;
  Ship.Eng.NewPowerTons := StrToFloat(RemoveCommas(PowerTonsEdit.Text));
  Ship.Eng.PowerTonsRefitTech := StrToInt(T20RefitPPEdit.Text);
  Ship.Eng.BakPowerTonsIsRefitted := T20RefitBakPPChkBx.Checked;
  Ship.Eng.BakNewPowerTons := StrToFloat(RemoveCommas(T20BakPPEdit.Text));
  Ship.Eng.BakPowerTonsRefitTech := StrToInt(T20RefitBakPPEdit.Text);
  Ship.Eng.BakNewPowerTonsNum := StrToInt(T20NoBakPPEdit.Text);
  Ship.Eng.SingleEngSpace := SingleEngSpaceChkBx.Checked;
  Ship.Eng.DriveUpgradesAllowed := DriveUpgradeChkBx.Checked;
end;

procedure TEngFrm.SetMDrive(Tech: Integer);
//set m drive and backup m drive

var
  mCount : integer;
begin
  MDriveComboBx.Clear;
  BakMDriveComboBx.Clear;
  MDriveComboBx.Items.Add('0');
  BakMDriveComboBx.Items.Add('0');
  if (Ship.IsRefitted) then
  begin
    MDriveStatLbl.Caption := 'M Drive (' + IntToStr(Ship.Eng.MDrive) + 'G)';
    BakMDriveStatLbl.Caption := 'MD (' + IntToStr(Ship.Eng.BakMDrive) + 'G x '
        + IntToStr(Ship.Eng.BakMDNum) + ')';
    MDriveComboBx.Text := IntToStr(Ship.Eng.NewMDrive);
    RefitMDEdit.Text := IntToStr(Ship.Eng.MDriveRefitTech);
    BakMDriveComboBx.Text := IntToStr(Ship.Eng.BakNewMDrive);
    NoBakMEdit.Text := IntToStr(Ship.Eng.BakNewMDNumb);
    RefitBakMDEdit.Text := IntToStr(Ship.Eng.BakMDriveRefitTech);
    MDriveComboBx.Enabled := Ship.Eng.MDriveIsRefitted;
    RefitMDEdit.Enabled := Ship.Eng.MDriveIsRefitted;
    BakMDriveComboBx.Enabled := Ship.Eng.BakMDriveIsRefitted;
    NoBakMEdit.Enabled := Ship.Eng.BakMDriveIsRefitted;
    RefitBakMDEdit.Enabled := Ship.Eng.BakMDriveIsRefitted;
    RefitMDChkBx.Checked := Ship.Eng.MDriveIsRefitted;
    RefitBakMDChkBx.Checked := Ship.Eng.BakMDriveIsRefitted;
  end
  else
  begin
    itest := Ship.Eng.MDrive;
    MDriveComboBx.Text := IntToStr(Ship.Eng.MDrive);
    BakMDriveComboBx.Text := IntToStr(Ship.Eng.BakMDrive);
    NoBakMEdit.Text := IntToStr(Ship.Eng.BakMDNum);
  end;

  //fill the m drive combo by TL
  case (Tech) of
    7: begin
         for mCount := 1 to 2 do
         begin
           MDriveComboBx.Items.Add(IntToStr(mCount));
           BakMDriveComboBx.Items.Add(IntToStr(mCount));
         end;
         if (StrToInt(MDriveComboBx.Text) > 2) then
         begin
           MDriveComboBx.Text := '2';
         end;
         if (StrToInt(BakMDriveComboBx.Text) > 2) then
         begin
           BakMDriveComboBx.Text := '2';
         end;
       end;
    8: begin
       for mCount := 1 to 5 do
       begin
         MDriveComboBx.Items.Add(IntToStr(mCount));
         BakMDriveComboBx.Items.Add(IntToStr(mCount));
       end;
       if (StrToInt(MDriveComboBx.Text) > 5) then
       begin
         MDriveComboBx.Text := '5';
       end;
       if (StrToInt(BakMDriveComboBx.Text) > 5) then
       begin
         BakMDriveComboBx.Text := '5';
       end;
     end;
     else
     begin
       for mCount := 1 to 6 do
       begin
         MDriveComboBx.Items.Add(IntToStr(mCount));
         BakMDriveComboBx.Items.Add(IntToStr(mCount));
       end;
     end;
  end;
end;

procedure TEngFrm.SetPPlant(Tech: Integer);
//set up pp and backup pp

begin
  if (Ship.IsRefitted) then
  begin
    if (Ship.DesignRules = 0) then
    begin
      PowerTonsStatLbl.Caption := 'PP ('+ FloatToStrF(Ship.Eng.PowerTons, ffFixed, 18, 3)
          + 'T)';
      T20BakPPStatLbl.Caption := 'PP (' + FloatToStrF(Ship.Eng.BakPowerTons, ffFixed, 18, 3)
          + 'T' + #13 + 'x ' + IntToStr(Ship.Eng.BakPowerTonsNum) + ')';
      PowerTonsEdit.Text := FloatToStrF(Ship.Eng.NewPowerTons, ffNumber, 19, 3);
      T20RefitPPEdit.Text := IntToStr(Ship.Eng.PowerTonsRefitTech);
      T20BakPPEdit.Text := FloatToStrF(Ship.Eng.BakNewPowerTonsNum, ffNumber, 19, 3);
      T20NoBakPPEdit.Text := IntToStr(Ship.Eng.BakNewPowerTonsNum);
      T20RefitBakPPEdit.Text := IntToStr(Ship.Eng.BakPowerTonsRefitTech);
      PowerTonsEdit.Enabled := Ship.Eng.PowerTonsIsRefitted;
      T20RefitPPEdit.Enabled := Ship.Eng.PowerTonsIsRefitted;
      T20BakPPEdit.Enabled := Ship.Eng.BakPowerTonsIsRefitted;
      T20NoBakPPEdit.Enabled := Ship.Eng.BakPowerTonsIsRefitted;
      T20RefitBakPPEdit.Enabled := Ship.Eng.BakPowerTonsIsRefitted;
      T20RefitPPChkBx.Checked := Ship.Eng.PowerTonsIsRefitted;
      T20RefitBakPPChkBx.Checked := Ship.Eng.BakPowerTonsIsRefitted;
    end
    else
    begin
      PwrPlntStatLbl.Caption := 'Power Plant (' + IntToStr(Ship.Eng.PPlant) + ')';
      BakPwrPlntStatLbl.Caption := 'PP (' + IntToStr(Ship.Eng.BakPPlant)
          + ' x ' + IntToStr(Ship.Eng.BakNewPPNumb) + ')';
      PwrPlntEdit.Text := IntToStr(Ship.Eng.NewPPlant);
      RefitPPEdit.Text := IntToStr(Ship.Eng.PPlantRefitTech);
      BakPwrPlntEdit.Text := IntToStr(Ship.Eng.BakNewPPlant);
      NoBakPPEdit.Text := IntToStr(Ship.Eng.BakNewPPNumb);
      RefitBakPPEdit.Text := IntToStr(Ship.Eng.BakPPlantRefitTech);
      PwrPlntEdit.Enabled := Ship.Eng.PPlantIsRefitted;
      RefitPPEdit.Enabled := Ship.Eng.PPlantIsRefitted;
      BakPwrPlntEdit.Enabled := Ship.Eng.BakPPlantIsRefitted;
      NoBakPPEdit.Enabled := Ship.Eng.BakPPlantIsRefitted;
      RefitBakPPEdit.Enabled := Ship.Eng.BakPPlantIsRefitted;
      RefitPPChkBx.Checked := Ship.Eng.PPlantIsRefitted;
      RefitBakPPChkBx.Checked := Ship.Eng.BakPPlantIsRefitted;
    end;
  end
  else
  begin
    if (Ship.DesignRules = 0) then
    begin
      PowerTonsEdit.Text := FloatToStrF(Ship.Eng.PowerTons, ffNumber, 19, 3);
      T20BakPPEdit.Text := FloatToStrF(Ship.Eng.BakPowerTons, ffNumber, 19, 3);
      T20BakPPEdit.Text := IntToStr(Ship.Eng.BakPPNum);
    end
    else
    begin
      PwrPlntEdit.Text := IntToStr(Ship.Eng.PPlant);
      BakPwrPlntEdit.Text := IntToStr(Ship.Eng.BakPPlant);
      NoBakPPEdit.Text := IntToStr(Ship.Eng.BakPPNum);
    end;
  end;
end;

function TEngFrm.TrapErrors : boolean;
//trap errors and display an appropriate error message

begin
  Result := False;
  //must be some value entered
  if (NoBakMEdit.Text = '') then
  begin
    MessageDlg('Number of Backup Maneuver Drives Not Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (NoBakMEdit.Text = '') then
  begin
    MessageDlg('Number of Backup Maneuver Drives Not Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (MDriveComboBx.Text = '') then
  begin
    MessageDlg('No Maneuver Drive Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakMDriveComboBx.Text = '') then
  begin
    MessageDlg('No Backup Maneuver Drive Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (JDriveComboBx.Text = '') then
  begin
    MessageDlg('No Jump Drive Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakJDriveComboBx.Text = '') then
  begin
    MessageDlg('No Backup Jump Drive Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (PwrPlntEdit.Text = '') then
  begin
    MessageDlg('No Power Plant Entered (This may be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BakPwrPlntEdit.Text = '') then
  begin
    MessageDlg('No Backup Power Plant Entered (This May be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (NoBakPPEdit.Text = '') then
  begin
    MessageDlg('Number of Backup Power Plants Not Entered (This May be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (NoBakJEdit.Text = '') then
  begin
    MessageDlg('Number of Backup Jump Drives Not Entered (This May be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (PowerTonsEdit.Text = '') then
  begin
    MessageDlg('No Power Plant Entered (This May be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //refit values
  if (UpgradeSpaceEdit.Text = '') then
  begin
    MessageDlg('No Upgrade Space Entered (This May be Zero)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitMDEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Manuever Drive Not Entered (This May be seven or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitJDEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Jump Drive Not Entered (This May be nine or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitPPEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Power Plant Not Entered (This May be seven or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (T20RefitPPEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Power Plant Not Entered (This May be seven or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakMDEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Backup Manuever Drive Not Entered (This May be seven or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakJDEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Backup Jump Drive Not Entered (This May be nine or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RefitBakPPEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Backup Power Plant Not Entered (This May be seven or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (T20RefitBakPPEdit.Text = '') then
  begin
    MessageDlg('Tech Level of Refitted Backup Power Plant Not Entered (This May be seven or above)', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //values must be numbers
  if (StrToIntDef(NoBakMEdit.Text, 3) = 3)
      and (StrToIntDef(NoBakMEdit.Text, 2) = 2) then
  begin
    MessageDlg('Number of Backup Maneuver Drives must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(PwrPlntEdit.Text, 3) = 3)
      and (StrToIntDef(PwrPlntEdit.Text, 2) = 2) then
  begin
    MessageDlg('Power Plant must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(BakPwrPlntEdit.Text, 3) = 3)
      and (StrToIntDef(BakPwrPlntEdit.Text, 2) = 2) then
  begin
    MessageDlg('Backup Power Plant must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(NoBakPPEdit.Text, 3) = 3)
      and (StrToIntDef(NoBakPPEdit.Text, 2) = 2) then
  begin
    MessageDlg('Number of Backup Power Plants must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToFloatDef(RemoveCommas(PowerTonsEdit.Text), 3) = 3)
      and (StrToFloatDef(RemoveCommas(PowerTonsEdit.Text), 2) = 2) then
  begin
    MessageDlg('Power Plant Tonnage must be a Floating Point Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //refit values
  if (StrToFloatDef(RemoveCommas(UpgradeSpaceEdit.Text), 3) = 3)
      and (StrToFloatDef(RemoveCommas(UpgradeSpaceEdit.Text), 2) = 2) then
  begin
    MessageDlg('Upgrade Space must be a Floating Point Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitMDEdit.Text, 3) = 3)
      and (StrToIntDef(RefitMDEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Maneuver Drive must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitJDEdit.Text, 3) = 3)
      and (StrToIntDef(RefitJDEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Jump Drive must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitPPEdit.Text, 3) = 3)
      and (StrToIntDef(RefitPPEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Power Plant must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(T20RefitPPEdit.Text, 3) = 3)
      and (StrToIntDef(T20RefitPPEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Power Plant must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakMDEdit.Text, 3) = 3)
      and (StrToIntDef(RefitBakMDEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Backup Maneuver Drive must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakJDEdit.Text, 3) = 3)
      and (StrToIntDef(RefitBakJDEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Backup Jump Drive must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(RefitBakPPEdit.Text, 3) = 3)
      and (StrToIntDef(RefitBakPPEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted Backup Power Plant must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(T20RefitBakPPEdit.Text, 3) = 3)
      and (StrToIntDef(T20RefitBakPPEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level of Refitted BackupPower Plant must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //values may not be negative
  if (StrToFloat(RemoveCommas(PowerTonsEdit.Text)) < 0) then
  begin
    MessageDlg('Power Plant Tonnage may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(MDriveComboBx.Text) < 0) then
  begin
    MessageDlg('Maneuver Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(JDriveComboBx.Text) < 0) then
  begin
    MessageDlg('Jump Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(PwrPlntEdit.Text) < 0) then
  begin
    MessageDlg('Power Plant may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(BakMDriveComboBx.Text) < 0) then
  begin
    MessageDlg('Backup Maneuver Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(BakJDriveComboBx.Text) < 0) then
  begin
    MessageDlg('Backup Jump Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(BakPwrPlntEdit.Text) < 0) then
  begin
    MessageDlg('Backup Power Plant may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(NoBakMEdit.Text) < 0) then
  begin
    MessageDlg('Number of Backup Maneuver Drives may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(NoBakJEdit.Text) < 0) then
  begin
    MessageDlg('Number of Backup Jump Drives may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(NoBakPPEdit.Text) < 0) then
  begin
    MessageDlg('Number of Backup Power Plants may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToFloat(RemoveCommas(T20BakPPEdit.Text)) < 0) then
  begin
    MessageDlg('Power Plant Tonnage may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //refit values
  if (StrToFloat(RemoveCommas(UpgradeSpaceEdit.Text)) < 0) then
  begin
    MessageDlg('Upgrade Space may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitMDEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Maneuver Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitJDEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Jump Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitPPEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Power Plant may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(T20RefitPPEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Power Plant may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakMDEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Backup Maneuver Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakJDEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Backup Jump Drive may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(RefitBakPPEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Backup Power Plant may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(T20RefitBakPPEdit.Text) < 0) then
  begin
    MessageDlg('Tech Level of Refitted Backup Power Plant may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //rule enforcement
  //PPlant
  if (InvalidPPlant) then
  begin
    Result := True;
    Exit;
  end;
  //MDrive
  if (InvalidMDrive) then
  begin
    Result := True;
    Exit;
  end;
  //Jdrive
  if (InvalidJDrive) then
  begin
    Result := True;
    Exit;
  end;
  //refit
  if (InvalidRefit) then
  begin
    Result := True;
    exit;
  end;

  //orphan tests need to be put in their proper place
  if (StrToFloatDef(RemoveCommas(T20BakPPEdit.Text), 2) = 2) and
      (StrToFloatDef(Removecommas(T20BakPPEdit.Text), 3) = 3) then
      begin
    MessageDlg('Backup Power Plant Tonnage must be a Floating Point Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToFloat(RemoveCommas(T20BakPPEdit.Text)) < 0) then
  begin
    MessageDlg('Backup Power Plant Tonnage may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToIntDef(T20NoBakPPEdit.Text, 2) = 2)
      and (StrToIntDef(T20NoBakPPEdit.Text, 3) = 3) then
      begin
    MessageDlg('Number of Backup Power Plants must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(T20NoBakPPEdit.Text) < 0) then
  begin
    MessageDlg('Number of Backup Power Plants may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
end;

procedure TEngFrm.OkBtnClick(Sender: TObject);
//check for errors and if okay send the form data to the eng module

begin
  if (TrapErrors) then begin
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    SendRefitData;
  end
  else
  begin
    SendNormalData;
  end;
  Ship.DesignShip;
  MainFrm.RefreshForm;
  Ship.HasChanged := True;
  MainFrm.SaveMenuItem.Enabled := True;
  MainFrm.RestoreMenuItem.Enabled := True;
  Close;
end;

procedure TEngFrm.CancelBtnClick(Sender: TObject);
//close the form without send the data to the module

begin
   Close;
end;

procedure TEngFrm.PwrPlntEditChange(Sender: TObject);
//check for appropriate data and then update the EP label

begin
   with PwrPlntEdit do begin
      if (Text = '') then begin
         abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('Power Plant must be an Integer Value', mtError, [mbOk], 0);
      end;
      if (StrToInt(Text) > 35) then begin
         MessageDlg('Power Plants in excess of 35 are not recommended', mtWarning, [mbOk], 0);
      end;
   end;
   EPGenLbl.Caption := FloatToStrF((Ship.Tonnage/100) * StrToFloat(PwrPlntEdit.Text), ffNumber, 18, 3);
end;

procedure TEngFrm.MDriveComboBxChange(Sender: TObject);
//check for appropriate data and if m drive > than pp increase pp

begin
   with MDriveComboBx do begin
      if (Text = '') then begin
         abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('Maneuver Drive must be an Integer Value', mtError, [mbOk], 0);
      end;
   end;
   if (StrToInt(PwrPlntEdit.Text) < StrToInt(MDriveComboBx.Text)) or
         (StrToInt(PwrPlntEdit.Text) < StrToInt(JDriveComboBx.Text)) then begin
      PwrPlntEdit.Text := IntToStr(Max(StrToInt(MDriveComboBx.Text), StrToInt(JDriveComboBx.Text)));
   end;
end;

procedure TEngFrm.JDriveComboBxChange(Sender: TObject);
//check for appropriate data and if j drive > than pp increase pp

begin
   with JDriveComboBx do begin
      if (Text = '') then begin
         abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('Jump Drive must be an Integer Value', mtError, [mbOk], 0);
      end;
   end;
   if (StrToInt(PwrPlntEdit.Text) < StrToInt(MDriveComboBx.Text)) or
         (StrToInt(PwrPlntEdit.Text) < StrToInt(JDriveComboBx.Text)) then begin
      PwrPlntEdit.Text := IntToStr(Max(StrToInt(MDriveComboBx.Text), StrToInt(JDriveComboBx.Text)));
   end;
end;

function TEngFrm.Confirm(TheMessage: String): Boolean;
//display a confirmation message and get a yes no answer

begin
   if (MessageDlg(TheMessage, mtConfirmation, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TEngFrm.Warn(TheMessage: String): Boolean;
//display a warning message and get a yes no answer

begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TEngFrm.BakMDriveComboBxChange(Sender: TObject);
//if the backup m drive is set to zero set the number of backups to zero
//if the backup m drive is set to > zero set the number of backups to 1 or the
//stored values

begin
   if (BakMDriveComboBx.Text = '') then begin
      abort;
   end;
   if (StrToint(BakMDriveComboBx.Text) > 0) then begin
      if (StrToInt(NoBakMEdit.Text) = 0) then begin
         NoBakMEdit.Text := IntToStr(Max(1, Ship.Eng.BakMDNum));
      end;
   end
   else if (StrToint(BakMDriveComboBx.Text) = 0) then begin
      NoBakMEdit.Text := '0';
   end;
end;

procedure TEngFrm.BakJDriveComboBxChange(Sender: TObject);
//if the backup j drive is set to zero set the number of backups to zero
//if the backup j drive is set to > zero set the number of backups to 1 or the
//stored values

begin
   if (BakJDriveComboBx.Text = '') then begin
      abort;
   end;
   if (StrToint(BakJDriveComboBx.Text) > 0) then begin
      if (StrToInt(NoBakJEdit.Text) = 0) then begin
         NoBakJEdit.Text := IntToStr(Max(1, Ship.Eng.BakJDNum));
      end;
   end
   else if (StrToint(BakJDriveComboBx.Text) = 0) then begin
      NoBakJEdit.Text := '0';
   end;
end;

procedure TEngFrm.BakPwrPlntEditChange(Sender: TObject);
//if the backup pp is set to zero set the number of backups to zero
//if the backup pp is set to > zero set the number of backups to 1 or the
//stored values

begin
   if (BakPwrPlntEdit.Text = '') then begin
      abort;
   end;
   if (StrToint(BakPwrPlntEdit.Text) > 0) then begin
      if (StrToInt(NoBakPPEdit.Text) = 0) then begin
         NoBakPPEdit.Text := IntToStr(Max(1, Ship.Eng.BakPPNum));
      end;
   end
   else if (StrToint(BakPwrPlntEdit.Text) = 0) then begin
      NoBakPPEdit.Text := '0';
   end;
end;

procedure TEngFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateEngDetails);
         FullShipData.Add(Ship.GenFuelDetails);
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

procedure TEngFrm.RefitBakJDChkbxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakJDChkBx do
    begin
      BakJDriveComboBx.Enabled := Checked;
      NoBakJEdit.Enabled := Checked;
      RefitBakJDEdit.Enabled := Checked;
      if (Checked) then
      begin
        BakJDriveComboBx.ItemIndex := Ship.Eng.BakNewJDrive;
        NoBakJEdit.Text := IntToStr(Ship.Eng.BakNewJDNumb);
        RefitBakJDEdit.Text := IntToStr(Ship.Eng.BakJDriveRefitTech);
      end
      else
      begin
        BakJDriveComboBx.ItemIndex := 0;
        NoBakJEdit.Text := '0';
        RefitBakJDEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.RefitBakMDChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakMDChkBx do
    begin
      BakMDriveComboBx.Enabled := Checked;
      NoBakMEdit.Enabled := Checked;
      RefitBakMDEdit.Enabled := Checked;
      if (Checked) then
      begin
        BakMDriveComboBx.ItemIndex := Ship.Eng.BakNewMDrive;
        NoBakMEdit.Text := IntToStr(Ship.Eng.BakNewMDNumb);
        RefitBakMDEdit.Text := IntToStr(Ship.Eng.BakMDriveRefitTech);
      end
      else
      begin
        BakMDriveComboBx.ItemIndex := 0;
        NoBakMEdit.Text := '0';
        RefitBakMDEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.RefitBakPPChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitBakPPChkBx do
    begin
      BakPwrPlntEdit.Enabled := Checked;
      NoBakPPEdit.Enabled := Checked;
      RefitBakPPEdit.Enabled := Checked;
      if (Checked) then
      begin
        BakPwrPlntEdit.Text := IntToStr(Ship.Eng.BakNewPPlant);
        NoBakPPEdit.Text := IntToStr(Ship.Eng.BakNewPPNumb);
        RefitPPEdit.Text := IntToStr(Ship.Eng.BakPPlantRefitTech);
      end
      else
      begin
        BakPwrPlntEdit.Text := '0';
        NoBakPPEdit.Text := '0';
        RefitPPEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.RefitJDChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitJDChkBx do
    begin
      JDriveComboBx.Enabled := Checked;
      RefitJDEdit.Enabled := Checked;
      if (Checked) then
      begin
        JDriveComboBx.ItemIndex := Ship.Eng.NewJDrive;
        RefitJDEdit.Text := IntToStr(Ship.Eng.JDriveRefitTech);
      end
      else
      begin
        JDriveComboBx.ItemIndex := 0;
        RefitJDEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.RefitMDChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitMDChkBx do
    begin
      MDriveComboBx.Enabled := Checked;
      RefitMDEdit.Enabled := Checked;
      if (Checked) then
      begin
        MDriveComboBx.ItemIndex := Ship.Eng.NewMDrive;
        RefitMDEdit.Text := IntToStr(Ship.Eng.MDriveRefitTech);
      end
      else
      begin
        MDriveComboBx.ItemIndex := 0;
        RefitMDEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.RefitPPChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with RefitPPChkBx do
    begin
      PwrPlntEdit.Enabled := Checked;
      RefitPPEdit.Enabled := Checked;
      if (Checked) then
      begin
        PwrPlntEdit.Text := IntToStr(Ship.Eng.NewPPlant);
        RefitPPEdit.Text := IntToStr(Ship.Eng.PPlantRefitTech);
      end
      else
      begin
        PwrPlntEdit.Text := '0';
        RefitPPEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.T20RefitBakPPChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with T20RefitBakPPChkBx do
    begin
      T20BakPPEdit.Enabled := Checked;
      T20NoBakPPEdit.Enabled := Checked;
      T20RefitBakPPEdit.Enabled := Checked;
      if (Checked) then
      begin
        T20BakPPEdit.Text := FloatToStrF(Ship.Eng.BakNewPowerTons, ffNumber, 18, 3);
        T20NoBakPPEdit.Text := IntToStr(Ship.Eng.BakPowerTonsNum);
        T20RefitPPEdit.Text := IntToStr(Ship.Eng.BakPowerTonsRefitTech);
      end
      else
      begin
        T20BakPPEdit.Text := '0.000';
        T20NoBakPPEdit.Text := '0';
        T20RefitPPEdit.Text := '0';
      end;
    end;
  end;
end;

procedure TEngFrm.T20RefitPPChkBxChange(Sender: TObject);
begin
  if (Ship.IsRefitted) then
  begin
    with T20RefitPPChkBx do
    begin
      PowerTonsEdit.Enabled := Checked;
      T20RefitPPEdit.Enabled := Checked;
      if (Checked) then
      begin
        PowerTonsEdit.Text := FloatToStrF(Ship.Eng.NewPowerTons, ffNumber, 18, 3);
        T20RefitPPEdit.Text := IntToStr(Ship.Eng.PowerTonsRefitTech);
      end
      else
      begin
        PowerTonsEdit.Text := '0.000';
        T20RefitPPEdit.Text := '0';
      end;
    end;
  end;
end;

function TEngFrm.GenerateEngDetails: String;
//generate engineering file details

begin
   Result := MDriveComboBx.Text
         + SEP + JDriveComboBx.Text
         + SEP + PwrPlntEdit.Text
         + SEP + BakMDriveComboBx.Text
         + SEP + BakJDriveComboBx.Text
         + SEP + BakPwrPlntEdit.Text
         + SEP + NoBakMEdit.Text
         + SEP + NoBakJEdit.Text
         + SEP + NoBakPPEdit.Text
         + SEP + RemoveCommas(PowerTonsEdit.Text) //power tons to t20
         + SEP + RemoveCommas(T20BakPPEdit.Text)
         + SEP + T20NoBakPPEdit.Text
         + SEP + BoolToStr(RefitMDChkBx.Checked)
         + SEP + MDriveComboBx.Text
         + SEP + RefitMDEdit.Text
         + SEP + BoolToStr(RefitJDChkBx.Checked)
         + SEP + JDriveComboBx.Text
         + SEP + RefitJDEdit.Text
         + SEP + BoolToStr(RefitPPChkBx.Checked)
         + SEP + PwrPlntEdit.Text
         + SEP + RefitPPEdit.Text
         + SEP + BoolToStr(RefitBakMDChkBx.Checked)
         + SEP + BakMDriveComboBx.Text
         + SEP + RefitBakMDEdit.Text
         + SEP + BoolToStr(RefitBakJDChkBx.Checked)
         + SEP + BakJDriveComboBx.Text
         + SEP + RefitBakJDEdit.Text
         + SEP + BoolToStr(RefitBakPPChkBx.Checked)
         + SEP + BakPwrPlntEdit.Text
         + SEP + RefitBakPPEdit.Text
         + SEP + NoBakMEdit.Text
         + SEP + NoBakJEdit.Text
         + SEP + NoBakPPEdit.Text
         + SEP + BoolToStr(T20RefitPPChkBx.Checked)
         + SEP + PowerTonsEdit.Text
         + SEP + T20RefitPPEdit.Text
         + SEP + BoolToStr(T20RefitBakPPChkBx.Checked)
         + SEP + T20BakPPEdit.Text
         + SEP + T20RefitBakPPEdit.Text
         + SEP + T20NoBakPpEdit.Text
         + SEP + '0.000' //upgrade space
         + SEP + '0' //SingleEngSpace
         + SEP + '0' //DriveUpgradesAllowed
         + SEP + '0' //wiggle room
         + SEP + '0' //wiggle room
         + SEP + '0' //wiggle room
         + SEP + '0' //wiggle room
         + SEP + '0' //wiggle room
         + SEP + '0' //wiggle room
         + SEP + '0'; //wiggle room
end;

function TEngFrm.RemoveCommas(Text: String): String;
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

function TEngFrm.StrToFloatDef(const S: string;
  Default: Extended): Extended;
//like StrToIntDef but with real numbers

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

function TEngFrm.MDriveSpace(HullSize: Extended; DriveNum: Integer): Extended;
begin
  Result := HullSize * (((DriveNum * 3) - 1) / 100);
end;

function TEngFrm.JDriveSpace(HullSize: Extended; DriveNum: Integer): Extended;
begin
  Result := HullSize * ((DriveNum + 1) / 100);
end;

function TEngFrm.PPlantSpace(HullSize: Extended; PlantNum, PlantTech: Integer
  ): Extended;
begin
  case (PlantTech) of
    //0..4: Result := HullSize * ((PlantNum * 10) / 100);
    //5..6: Result := HullSize * ((PlantNum * 6) / 100);
    //7..8: Result := HullSize * ((PlantNum * 4) / 100);
    0..8: Result := HullSize * ((PlantNum * 4) / 100);
    9..12: Result := HullSize * ((PlantNum * 3) / 100);
    13..14: Result := HullSize * ((PlantNum * 2) / 100);
    else Result := HullSize * ((PlantNum * 1) / 100);
  end;
end;

function TEngFrm.InvalidRefit: Boolean;
var
  BaseMDSpace, BaseJDSpace, BasePPSpace: Extended;
  BaseBakMDSpace, BaseBakJDSpace, BaseBakPPSpace: Extended;
  TotalBaseEngSpace: Extended;
  CurMDSpace, CurJDSpace, CurPPSpace: Extended;
  CurBakMDSpace, CurBakJDSpace, CurBakPPSpace: Extended;
  TotalCurEngSpace: Extended;
  HullSize, UGSpace: Extended;
begin
  Result := False;
  HullSize := Ship.Tonnage;
  UGSpace := Ship.Eng.UpgradeSpace;
  BaseMDSpace := MDriveSpace(HullSize, Ship.Eng.MDrive);
  if (RefitMDChkBx.Checked) then CurMDSpace := MDriveSpace(HullSize, StrToInt(MDriveComboBx.Text))
      else CurMDSpace := BaseMDSpace;
  BaseBakMDSpace := MDriveSpace(HullSize, Ship.Eng.BakMDrive) * Ship.Eng.BakMDNum;
  if (RefitBakMDChkBx.Checked) then CurBakMDSpace := MDriveSpace(HullSize,
      StrToInt(BakMDriveComboBx.Text)) * StrToInt(NoBakMEdit.Text)
      else CurBakMDSpace := BaseBakMDSpace;
  BaseJDSpace := JDriveSpace(HullSize, Ship.Eng.JDrive);
  if (RefitJDChkBx.Checked) then CurJDSpace := JDriveSpace(HullSize, StrToInt(JDriveComboBx.Text))
      else CurJDSpace := BaseJDSpace;
  BaseBakJDSpace := JDriveSpace(HullSize, Ship.Eng.BakJDrive) * Ship.Eng.BakJDNum;
  if (RefitBakJDChkBx.Checked) then CurBakJDSpace := JDriveSpace(HullSize,
      StrToInt(BakJDriveComboBx.Text)) * StrToInt(NoBakJEdit.Text)
      else CurBakJDSpace := BaseBakJDSpace;
  if (Ship.DesignRules = 0) then
  begin
    BasePPSpace := Ship.Eng.PowerTons;
    BaseBakPPSpace := Ship.Eng.BakPowerTons * Ship.Eng.BakPowerTonsNum;
    if (T20RefitPPChkBx.Checked) then CurPPSpace := StrToFloat(RemoveCommas(PowerTonsEdit.Text))
        else CurPPSpace := BasePPSpace;
    if (T20RefitBakPPChkBx.Checked) then CurBakPPSpace := StrToFloat(RemoveCommas(T20BakPPEdit.Text))
        * StrtoInt(T20NoBakPPEdit.Text) else CurBakPPSpace := BaseBakPPSpace;
  end
  else
  begin
    BasePPSpace := PPlantSpace(HullSize, Ship.Eng.PPlant, Ship.TechLevel);
    BaseBakPPSpace := PPlantSpace(HullSize, Ship.Eng.BakPPlant, Ship.TechLevel) * Ship.Eng.BakPPNum;
    if (RefitPPChkBx.Checked) then CurPPSpace := PPlantSpace(HullSize, StrToInt(PwrPlntEdit.Text),
        StrToInt(RefitPPEdit.Text)) else CurPPSpace := BasePPSpace;
    if (RefitBakPPChkBx.Checked) then CurBakPPSpace := PPlantSpace(HullSize,
        StrToInt(BakPwrPlntEdit.Text), StrToInt(RefitBakPPEdit.Text))
        * StrToInt(NoBakPPEdit.Text)
        else CurBakPPSpace := BaseBakPPSpace;
  end;
  TotalBaseEngSpace := BaseMDSpace + BaseBakMDSpace + BaseJDSpace + BaseBakJDSpace
      + BasePPSpace + BaseBakPPSpace + UGSpace;
  TotalCurEngSpace := CurMDSpace + CurBakMDSpace + CurJDSpace + CurBakJDSpace
      + CurPPSpace + CurBakPPSpace;
  //enforce no increases to mdrive or jdrive
  if not (DriveUpgradeChkBx.Checked) then
  begin
    if (StrToInt(MDriveComboBx.Text) > Ship.Eng.MDrive) and (RefitMDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Maneuver Drive may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (StrToInt(BakMDriveComboBx.Text) > Ship.Eng.BakMDrive) and (RefitBakMDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Backup Maneuver Drive may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (StrToInt(JDriveComboBx.Text) > Ship.Eng.JDrive) and (RefitJDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Jump Drive may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) > Ship.Eng.BakJDrive) and (RefitBakJDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Backup Jump Drive may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
  end;
  //enforce no tonnage increases
  if not (SingleEngSpaceChkBx.Checked) then
  begin
    if (CurMDSpace > (BaseMDSpace + UGSpace)) and (RefitMDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Maneuver Drive tonnage may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (CurBakMDSpace > (BaseBakMDSpace + UGSpace)) and (RefitBakMDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Backup Maneuver Drive tonnage may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (CurJDSpace > (BaseJDSpace + UGSpace)) and (RefitJDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Jump Drive tonnage may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (CurBakJDSpace > (BaseBakJDSpace + UGSpace)) and (RefitBakJDChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Backup Jump Drive tonnage may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (CurPPSpace > (BasePPSpace + UGSpace)) and (RefitPPChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Power Plant tonnage may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
    if (CurBakPPSpace > (BaseBakPPSpace + UGSpace)) and (RefitBakPPChkBx.Checked) then
    begin
      MessageDlg('Invalid Refit: Backup Power Plant tonnage may not be increased', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
  end;
  if (TotalCurEngSpace > TotalBaseEngSpace) then
  begin
    MessageDlg('Invalid Refit: Total Engineering space may not be exceeded', mtError, [mbOk], 0);
    Result := True;
    //Exit;
  end;
end;

function TEngFrm.InvalidMDrive: Boolean;
begin
  Result := False;
  if {not (Ship.Eng.MDriveIsRefitted) or} (RefitMDChkBx.Checked) then
  begin
    if (StrToInt(MDriveComboBx.Text) > 2) and (StrToInt(RefitMDEdit.Text) < 8) then
    begin
      MessageDlg('Maneuver Drives above 2 are not permitted below Tech Level 8', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(MDriveComboBx.Text) > 5) and (StrToInt(RefitMDEdit.Text) < 9) then
    begin
      MessageDlg('Maneuver Drives above 5 are not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end
  else
  begin
    if (StrToInt(MDriveComboBx.Text) > 2) and (Ship.TechLevel < 8) then
    begin
      MessageDlg('Maneuver Drives above 2 are not permitted below Tech Level 8', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(MDriveComboBx.Text) > 5) and (Ship.TechLevel < 9) then
    begin
      MessageDlg('Maneuver Drives above 5 are not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
  //only if bak Mdrive is refitted
  if {not (Ship.Eng.BakMDriveIsRefitted) or} (RefitBakMDChkBx.Checked) then
  begin
    if (StrToInt(BakMDriveComboBx.Text) > 2) and (StrToInt(RefitBakMDEdit.Text) < 8) then
    begin
      MessageDlg('Backup Maneuver Drives above 2 not permitted below Tech Level 8', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakMDriveComboBx.Text) > 5) and (StrToInt(RefitBakMDEdit.Text) < 9) then
    begin
      MessageDlg('Backup Maneuver Drives above 5 are not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end
  else
  begin
    if (StrToInt(BakMDriveComboBx.Text) > 2) and (Ship.TechLevel < 8) then
    begin
      MessageDlg('Backup Maneuver Drives above 2 not permitted below Tech Level 8', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakMDriveComboBx.Text) > 5) and (Ship.TechLevel < 9) then
    begin
      MessageDlg('Backup Maneuver Drives above 5 are not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(MDriveComboBx.Text) > 6) then
  begin
    MessageDlg('Maneuver Drives greater than 6 are not permitted', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(BakMDriveComboBx.Text) > 6) then
  begin
    MessageDlg('Backup Maneuver Drives greater than 6 are not permitted', mtError, [mbOk], 0);
    Result := True;
    //exit;
  end;
end;

function TEngFrm.InvalidPPlant: Boolean;
begin
  Result := False;
  if (StrToInt(PwrPlntEdit.Text) > 50) then
  begin
    MessageDlg('Power Plants may not exceed 50', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(PwrPlntEdit.Text) < StrToInt(MDriveComboBx.Text)) and not (Ship.DesignRules = 0) then
  begin
    MessageDlg('Power Plant Must be Equal to or Greater than Maneuver Drive', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(PwrPlntEdit.Text) < StrToInt(JDriveComboBx.Text)) and not (Ship.DesignRules = 0) then
  begin
    MessageDlg('Power Plant Must be Equal to or Greater than Jump Drive', mtError, [mbOk], 0);
    Result := True;
    //exit;
  end;
end;

function TEngFrm.InvalidJDrive: Boolean;
begin
  Result := False;
  //only if Jdrive is refitted     StrToInt(RefitJDEdit.Text)
  if {not (Ship.Eng.JDriveIsRefitted) or} (RefitJDChkBx.Checked) then
  begin
    if (StrToInt(JDriveComboBx.Text) = 1) and (StrToInt(RefitJDEdit.Text) < 9) then
    begin
      MessageDlg('Jump Drive is not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 2) and (StrToInt(RefitJDEdit.Text) < 11) then
    begin
      MessageDlg('Jump 2 is not permitted below Tech Level 11', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 3) and (StrToInt(RefitJDEdit.Text) < 12) then
    begin
      MessageDlg('Jump 3 is not permitted below Tech Level 12', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 4) and (StrToInt(RefitJDEdit.Text) < 13) then
    begin
      MessageDlg('Jump 4 is not permitted below Tech Level 13', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 5) and (StrToInt(RefitJDEdit.Text) < 14) then
    begin
      MessageDlg('Jump 5 is not permitted below Tech Level 14', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 6) and (StrToInt(RefitJDEdit.Text) < 15) then
    begin
      MessageDlg('Jump 6 is not permitted below Tech Level 15', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end
  else
  begin
    if (StrToInt(JDriveComboBx.Text) = 1) and (Ship.TechLevel < 9) then
    begin
      MessageDlg('Jump Drive is not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 2) and (Ship.TechLevel < 11) then
    begin
      MessageDlg('Jump 2 is not permitted below Tech Level 11', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 3) and (Ship.TechLevel < 12) then
    begin
      MessageDlg('Jump 3 is not permitted below Tech Level 12', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 4) and (Ship.TechLevel < 13) then
    begin
      MessageDlg('Jump 4 is not permitted below Tech Level 13', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 5) and (Ship.TechLevel < 14) then
    begin
      MessageDlg('Jump 5 is not permitted below Tech Level 14', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(JDriveComboBx.Text) = 6) and (Ship.TechLevel < 15) then
    begin
      MessageDlg('Jump 6 is not permitted below Tech Level 15', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
  //only if bak Jdrive is refitted
  if { (Ship.Eng.BakJDriveIsRefitted) or } (RefitBakJDChkBx.Checked) then
  begin
    if (StrToInt(BakJDriveComboBx.Text) = 1) and (StrToInt(RefitBakJDEdit.Text) < 9) then
    begin
      MessageDlg('Backup Jump Drive is not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 2) and (StrToInt(RefitBakJDEdit.Text) < 11) then
    begin
      MessageDlg('Backup Jump 2 is not permitted below Tech Level 11', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 3) and (StrToInt(RefitBakJDEdit.Text) < 12) then
    begin
      MessageDlg('Backup Jump 3 is not permitted below Tech Level 12', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 4) and (StrToInt(RefitBakJDEdit.Text) < 13) then
    begin
      MessageDlg('Backup Jump 4 is not permitted below Tech Level 13', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 5) and (StrToInt(RefitBakJDEdit.Text) < 14) then
    begin
      MessageDlg('Backup Jump 5 is not permitted below Tech Level 14', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 6) and (StrToInt(RefitBakJDEdit.Text) < 15) then
    begin
      MessageDlg('Backup Jump 6 is not permitted below Tech Level 15', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end
  else
  begin
    if (StrToInt(BakJDriveComboBx.Text) = 1) and (Ship.TechLevel < 9) then
    begin
      MessageDlg('Backup Jump Drive is not permitted below Tech Level 9', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 2) and (Ship.TechLevel < 11) then
    begin
      MessageDlg('Backup Jump 2 is not permitted below Tech Level 11', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 3) and (Ship.TechLevel < 12) then
    begin
      MessageDlg('Backup Jump 3 is not permitted below Tech Level 12', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 4) and (Ship.TechLevel < 13) then
    begin
      MessageDlg('Backup Jump 4 is not permitted below Tech Level 13', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 5) and (Ship.TechLevel < 14) then
    begin
      MessageDlg('Backup Jump 5 is not permitted below Tech Level 14', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(BakJDriveComboBx.Text) = 6) and (Ship.TechLevel < 15) then
    begin
      MessageDlg('Backup Jump 6 is not permitted below Tech Level 15', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) > 6) then
  begin
    MessageDlg('The Maximum Jump Drive is Jump 6', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(BakJDriveComboBx.Text) > 6) then
  begin
    MessageDlg('The Maximum Backup Jump Drive is Jump 6', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToInt(JDriveComboBx.Text) = 1) and (Ship.Avionics.MainComp < 1) then
  begin
    if (Warn('A computer is required if Jump Drive is fitted, do you wish to reduce '
        + 'the jump drive?')) then
    begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) = 2) and (Ship.Avionics.MainComp < 3) then
  begin
   if (Warn('A Model/1bis computer or better is required for Jump 2, do you wish to '
       + 'reduce the jump drive?')) then
   begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) = 3) and (Ship.Avionics.MainComp < 6) then
  begin
    if (Warn('A Model/2bis computer or better is required for Jump 3, do you wish to '
        + 'reduce the jump drive?')) then
    begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) = 4) and (Ship.Avionics.MainComp < 9) then
  begin
    if (Warn('A Model/4 computer or better is required for Jump 4, do you wish to reduce '
        + 'the jump drive?')) then
    begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) = 5) and (Ship.Avionics.MainComp < 11) then
  begin
    if (Warn('A Model/5 computer or better is required for Jump 5, do you wish to '
        + 'reduce the jump drive?')) then
    begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) = 6) and (Ship.Avionics.MainComp < 13) then
  begin
    if (Warn('A Model/6 computer or better is required for Jump 6, do you wish to reduce '
        + 'the jump drive?')) then
    begin
      Result := True;
      exit;
    end;
  end;
  if (StrToInt(JDriveComboBx.Text) > 0) and (Ship.Tonnage < 100) then
  begin
    MessageDlg('Small Craft (Vessels under 100T) may not be fitted with Jump Drives', mtError, [mbOk], 0);
    Result := True;
    //exit;
  end;
end;

end.

