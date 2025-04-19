unit HullFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ShipPas, ExtCtrls, DesAssistFrmPas, HgsFormFrm;

type
  THullFrm = class(THgsForm)
    ConfigStatLbl: TLabel;
    ArmourStatLbl: TLabel;
    ConfigComboBx: TComboBox;
    ActArmLbl: TLabel;
    ActArmStatLbl: TLabel;
    OkBtn: TButton;
    CancelBtn: TButton;
    ArmourCombo: TComboBox;
    StreamLineRadGrp: TRadioGroup;
    AirFrmRadGrp: TRadioGroup;
    StructureLbl: TLabel;
    StructureEdit: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ConfigComboBxChange(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ArmourComboChange(Sender: TObject);
    procedure StreamLineRadGrpClick(Sender: TObject);
    procedure AirFrmRadGrpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StructureEditChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetActualArmour;
    procedure SetStreamLining (HullConfig : Integer);
    procedure SetAirframe (HullConfig : Integer);
    procedure SetStructure;
    function IsSemiStreamlined(HullConfig : Integer) : Boolean;
    function GenerateHullDetails : String;
    function RemoveCommas(Text : String) : String;
    function StrToFloatDef(const S: string; Default: Extended): Extended;
  public
    { Public declarations }
  end;

var
  HullFrm: THullFrm;
  NewConfig, NewArmour, NewStreamlining, NewAirframe : Integer;

implementation

uses MainPas;

{$R *.lfm}

{ THullFrm }

procedure THullFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close the form

begin
   Action := caFree;
end;

procedure THullFrm.FormCreate(Sender: TObject);
//get the current data from the ship

var
  iCount : Integer;
begin
  //if the ship uses a planetoid hull and is a small craft show a warning
  if (Ship.Tonnage < 100) and (Ship.Hull.Config > 7) then
  begin
    MessageDlg('Ship of less than 100 tons displacement may not use planetoid hulls',
        mtWarning, [mbOk], 0);
  end;
  //get the current hull configuration
  Case (Ship.Hull.Config) of
    0 : ConfigComboBx.Text := '0 None Set';
    1 : ConfigComboBx.Text := '1 Needle/Wedge';
    2 : ConfigComboBx.Text := '2 Cone';
    3 : ConfigComboBx.Text := '3 Cylinder';
    4 : ConfigComboBx.Text := '4 Close Structure';
    5 : ConfigComboBx.Text := '5 Sphere';
    6 : ConfigComboBx.Text := '6 Flattened Sphere';
    7 : ConfigComboBx.Text := '7 Dispersed Structure';
    8 : ConfigComboBx.Text := '8 Planetoid';
    9 : ConfigComboBx.Text := '9 Buffered Planetoid';
  end;
  //fill the config combo, only add planetoid configs if 100Td+
  ConfigComboBx.Items.Add('1 Needle/Wedge');
  ConfigComboBx.Items.Add('2 Cone');
  ConfigComboBx.Items.Add('3 Cylinder');
  ConfigComboBx.Items.Add('4 Close Structure');
  ConfigComboBx.Items.Add('5 Sphere');
  ConfigComboBx.Items.Add('6 Flattened Sphere');
  ConfigComboBx.Items.Add('7 Dispersed Structure');
  if not (Ship.Tonnage < 100) then
  begin
    ConfigComboBx.Items.Add('8 Planetoid');
    ConfigComboBx.Items.Add('9 Buffered Planetoid');
  end;
  //fill the armour combo
  for iCount := 0 to Ship.TechLevel do
  begin
    ArmourCombo.Items.Add(IntToStr(iCount));
  end;
  //get the current armour if not dispersed struture
  //otherwise set armour to zero and disable the armour combo
  if (Ship.Hull.Config <> 7) then
  begin
    ArmourCombo.Text := IntToStr(Ship.Hull.Armour);
    ArmourCombo.Enabled := True;
  end
  else
  begin
    ArmourCombo.Text := '0';
    ArmourCombo.Enabled := False;
  end;
  SetActualArmour;
  NewConfig := Ship.Hull.Config;
  NewArmour := Ship.Hull.Armour;
  NewStreamlining := Ship.Hull.StreamLining;
  NewAirframe := Ship.Hull.Airframe;
  SetStreamLining(Ship.Hull.Config);
  SetAirframe(Ship.Hull.Config);
  SetStructure;

  //if ship is refitted disable the entire form
  if (Ship.IsRefitted) then
  begin
    ConfigComboBx.Enabled := False;
    ArmourCombo.Enabled := False;
    StreamLineRadGrp.Enabled := False;
    AirFrmRadGrp.Enabled := False;
    StructureEdit.Enabled := False;
  end;
end;

procedure THullFrm.ConfigComboBxChange(Sender: TObject);
//ignore errors and update the form

begin
   with ConfigComboBx do begin
      if (Text = '') then begin
         abort;
      end;
      NewConfig := StrToInt(Text[1]);
      if (StrToInt(Text[1]) = 7) then begin
         ArmourCombo.Text := '0';
         ArmourCombo.Enabled := False;
      end
      else begin
         ArmourCombo.Enabled := True;
         ArmourCombo.Text := IntToStr(NewArmour);
      end;
      SetActualArmour;
      SetStreamLining(StrToInt(Text[1]));
      SetAirframe(StrToInt(Text[1]));
   end;
end;

procedure THullFrm.SetActualArmour;
//set the actual armour label to take account of planetoid hulls

begin
   if (StrToInt(ConfigComboBx.Text[1]) < 8) then begin
      ActArmLbl.Caption := ArmourCombo.Text;
   end
   else if (StrToInt(ConfigComboBx.Text[1]) = 8) then begin
      ActArmLbl.Caption := IntToStr(StrToInt(ArmourCombo.Text) + 3);
   end
   else begin
      ActArmLbl.Caption := IntToStr(StrToInt(ArmourCombo.Text) + 6);
   end;
end;

procedure THullFrm.OkBtnClick(Sender: TObject);
//Trap errors and then send the form data to the ship

begin
  if (StrToIntDef(ArmourCombo.Text, 3) = 3)
      and (StrToIntDef(ArmourCombo.Text, 2) = 2) then
  begin
    MessageDlg('Armour must be an Integer Value', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToFloatDef(RemoveCommas(StructureEdit.Text), 3) = 3)
      and (StrToFloatDef(RemoveCommas(StructureEdit.Text), 2) = 2) then
  begin
    MessageDlg('Additional Structure must be a Floating Point Value (may be zero)', mtError, [mbOk], 0);
    exit;
  end;
  if (ArmourCombo.Text = '') then
  begin
    MessageDlg('No Armour Entered (may be zero)', mtError, [mbOk], 0);
    exit;
  end;
  if (ConfigComboBx.Text = '') then
  begin
    MessageDlg('No Configeration Entered', mtError, [mbOk], 0);
    exit;
  end;
  if (StructureEdit.Text = '') then
  begin
    MessageDlg('No Additional Structure Entered (may be zero(', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToInt(ArmourCombo.Text) < 0) then
  begin
    MessageDlg('Armour may not be a Negative Number', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToInt(ConfigComboBx.Text[1]) < 0) then
  begin
    MessageDlg('Configeration may not be a Negative Number', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToInt(ConfigComboBx.Text[1]) > 9) then
  begin
    MessageDlg('Configeration may not be greater than 9', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToFloat(RemoveCommas(StructureEdit.Text)) < 0) then
  begin
    MessageDlg('Additional Structure may not be a Negative Number', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToInt(ConfigComboBx.Text[1]) > 7) and (Ship.Tonnage < 100) then
  begin
    MessageDlg('Small Craft may not use Planetoid Hulls', mtError, [mbOk], 0);
    exit;
  end;
  if (StrToInt(ArmourCombo.Text) > 0) and (StrToInt(ConfigComboBx.Text[1]) = 7) then
  begin
    MessageDlg('Armour may not be added to a Dispersed Structure Hull', mtError, [mbOk], 0);
    exit;
  end;
  Ship.Hull.Config := NewConfig;
  if (NewConfig <> 7) then
  begin
    Ship.Hull.Armour := NewArmour;
  end
  else
  begin
    Ship.Hull.Armour := 0;
  end;
  Ship.Hull.StreamLining := NewStreamlining;
  Ship.Hull.Airframe := NewAirframe;
  Ship.Hull.Structure := StrToFloat(RemoveCommas(StructureEdit.Text));
  Ship.DesignShip;
  MainFrm.RefreshForm;
  Ship.HasChanged := True;
  MainFrm.SaveMenuItem.Enabled := True;
  MainFrm.RestoreMenuItem.Enabled := True;
  Close;
end;

procedure THullFrm.CancelBtnClick(Sender: TObject);
//close the form without send the data to the ship

begin
   Close;
end;

procedure THullFrm.ArmourComboChange(Sender: TObject);
//ignore errors and update the form

begin
   with ArmourCombo do begin
      if (ArmourCombo.Text = '') then begin
         abort;
      end;
      if (StrToIntDef(ArmourCombo.Text, 2) = 2) and
            (StrToIntDef(ArmourCombo.Text, 3) = 3) then begin
         abort;
      end;
      if not (NewConfig = 7) then begin
         NewArmour := StrToInt(ArmourCombo.Text);
      end;
      if (NewArmour > Ship.TechLevel) then begin
         MessageDlg('Armour added can not exceed Tech Level. Reducing Armour to Tech Level', mtError, [mbOk], 0);
         ArmourCombo.Text := IntToStr(Ship.TechLevel);
      end;
      SetActualArmour;
   end;
end;

procedure THullFrm.SetStreamLining(HullConfig: Integer);
//T20 METHOD
//this allows semi streamlined ships to be streamlined
//set the streamlining radio group

begin
   if (Ship.DesignRules = 0) then begin
      if (HullConfig < 3) or (HullConfig > 5) then begin
         StreamLineRadGrp.ItemIndex := 1;
         StreamLineRadGrp.Enabled := False;
      end
      else begin
         StreamLineRadGrp.ItemIndex := NewStreamLining;
         StreamLineRadGrp.Enabled := True;
      end;
   end
   else begin
      StreamlineRadGrp.ItemIndex := 1;
      StreamLineRadGrp.Enabled := False;
   end;
end;

procedure THullFrm.SetAirframe(HullConfig: Integer);
//T20 METHOD
//this allows streamlined ships to have airframe hulls
//set the airframe radio group

begin
   if (Ship.DesignRules = 0) then begin
      if (HullConfig < 3) or (HullConfig = 6) then begin
         AirFrmRadGrp.ItemIndex := NewAirframe;
         AirFrmRadGrp.Enabled := True;
      end
      else if (IsSemiStreamLined(HullConfig)) and (NewStreamLining = 0) then begin
         AirFrmRadGrp.ItemIndex := NewAirframe;
         AirFrmRadGrp.Enabled := True;
      end
      else begin
         AirFrmRadGrp.ItemIndex := 1;
         AirFrmRadGrp.Enabled := False;
      end;
   end
   else begin
      AirFrmRadGrp.ItemIndex := 1;
      AirFrmRadGrp.Enabled := False;
   end;
end;

procedure THullFrm.StreamLineRadGrpClick(Sender: TObject);
//T20 METHOD
//this notes new streamlining and updates the airframe radio group

begin
   NewStreamlining := StreamLineRadGrp.ItemIndex;
   SetAirframe(NewConfig);
end;

procedure THullFrm.AirFrmRadGrpClick(Sender: TObject);
//T20 METHOD
//this notes new airframe

begin
   NewAirframe := AirFrmRadGrp.ItemIndex;
end;

function THullFrm.IsSemiStreamlined(HullConfig: Integer): Boolean;
//T20 METHOD
//this checks if the ship is semi streamlined

begin
   Result := False;
   if (HullConfig > 2) and (HullConfig < 6) then begin
      Result := True;
   end;
end;

procedure THullFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateHullDetails);
         FullShipData.Add(Ship.GenEngDetails);
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

function THullFrm.GenerateHullDetails: String;
//generate hull file details

begin
   Result := ConfigComboBx.Text[1]
         + SEP + ArmourCombo.Text
         + SEP + IntToStr(StreamLineRadGrp.ItemIndex)
         + SEP + IntToStr(AirFrmRadGrp.ItemIndex)
         + SEP + StructureEdit.Text
         + SEP + '0'      //wiggle room
         + SEP + '0';     //wiggle room
end;

procedure THullFrm.StructureEditChange(Sender: TObject);
//ignore errors

begin
  with StructureEdit do
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
end;

function THullFrm.RemoveCommas(Text: String): String;
//remove commas from floating point numbers

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

function THullFrm.StrToFloatDef(const S: string;
  Default: Extended): Extended;
//Like StrToIntDef but with real numbers

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

procedure THullFrm.SetStructure;
//T20 METHOD
//Set the additional hull structure

begin
  if (Ship.DesignRules = 0) then
  begin
    StructureLbl.Enabled := True;
    StructureEdit.Enabled := True;
    StructureEdit.Text := FloatToStrF(Ship.Hull.Structure, ffNumber, 18, 3);
  end
  else
  begin
    StructureLbl.Enabled := False;
    StructureEdit.Enabled := False;
    StructureEdit.Text := '0';
  end;
end;

end.




