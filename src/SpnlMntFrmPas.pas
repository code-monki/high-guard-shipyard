unit SpnlMntFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, ShipPas, DataPas, DesAssistFrmPas, HgsFormFrm;

type

  { TSpnlMntFrm }

  TSpnlMntFrm = class(THgsForm)
    RefitSpinalChkBx: TCheckBox;
    UpgradeSpaceEdit: TEdit;
    RefitSpinalEdit: TEdit;
    UpgradeSpaceLbl: TLabel;
    RefitTlLbl: TLabel;
    SpnlMntRadGrp: TRadioGroup;
    SpnlMntComboBx: TComboBox;
    OKBtn: TButton;
    CancelBtn: TButton;
    HardPointsLbl: TLabel;
    HardPointsStatLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure RefitSpinalChkBxChange(Sender: TObject);
    procedure RefitSpinalEditChange(Sender: TObject);
    procedure SpnlMntRadGrpClick(Sender: TObject);
    procedure SpnlMntComboBxChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function TrapErrors : Boolean;
    function GetSpinalValue (SpinalMount: Char) : Integer;
    function Warn(TheMessage : String) : Boolean;
    function GenerateSpinalMountDetails : String;
    function AreMesonsElsewhere: Boolean;
    function ArePaElsewhere: Boolean;
    procedure CommitChanges;
    procedure FillCombo(Tech, SpinalType: Integer);
  public
    { Public declarations }
    function CalRemHardPoints : Integer;
    procedure RefreshForm;
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  SpnlMntFrm: TSpnlMntFrm;
  Data : TData;

implementation

uses MainPas;

{$R *.lfm}

procedure TSpnlMntFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//close the form and clean up

begin
   FreeAndNil(Data);
   Action := caFree;
end;

procedure TSpnlMntFrm.FormCreate(Sender: TObject);
//create the datastore and fill the form with data

begin
  Data := TData.Create;
  Data.InitialiseData;
  if (Ship.IsRefitted) then
  begin
    case (Ship.SpinalMount.SpinalType) of
      0: SpnlMntRadGrp.Caption := ' Spinal Mount (None)';
      1: SpnlMntRadGrp.Caption := ' Spinal Mount ('
             + Data.GetSpnlMesData(1, Ship.SpinalMount.SpinalMount) + ')';
      2: SpnlMntRadGrp.Caption := ' Spinal Mount ('
             + Data.GetSpnlPaData(1, Ship.SpinalMount.SpinalMount) + ')';
    end;
  end;
  RefreshForm;
end;

procedure TSpnlMntFrm.OKBtnClick(Sender: TObject);
//close the form sending the data to the ship

begin
   HardPointsLbl.Caption := IntToStr(CalRemHardPoints);
   if (TrapErrors) then begin
      exit;
   end;
   CommitChanges;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TSpnlMntFrm.CancelBtnClick(Sender: TObject);
//close the form without sending the data to the ship

begin
   Close;
end;

procedure TSpnlMntFrm.RefitSpinalChkBxChange(Sender: TObject);
var
  iMark: Integer;
begin
  with (RefitSpinalChkBx) do
  begin
    SpnlMntComboBx.Enabled := Checked;
    SpnlMntRadGrp.Enabled := Checked;
    RefitSpinalEdit.Enabled := Checked;
    if (Checked) then
    begin
      iMark := GetSpinalValue(SpnlMntComboBx.Text[1]);
      RefitSpinalEdit.Text := IntToStr(Ship.SpinalMount.SpinalMountRefitTech);
      FillCombo(StrToInt(RefitSpinalEdit.Text), SpnlMntRadGrp.ItemIndex);
      case (SpnlMntRadGrp.ItemIndex) of
        0: SpnlMntComboBx.Text := '0 None';
        1: SpnlMntComboBx.Text := Data.GetSpnlMesData(1, iMark);
        2: SpnlMntComboBx.Text := Data.GetSpnlPaData(1, iMark);
      end;
    end
    else
    begin
      iMark := Ship.SpinalMount.SpinalMount;
      RefitSpinalEdit.Text := '0';
      FillCombo(Ship.TechLevel, Ship.SpinalMount.SpinalType);
      case (SpnlMntRadGrp.ItemIndex) of
        0: SpnlMntComboBx.Text := '0 None';
        1: SpnlMntComboBx.Text := Data.GetSpnlMesData(1, iMark);
        2: SpnlMntComboBx.Text := Data.GetSpnlPaData(1, iMark);
      end;
    end;
  end;
end;

procedure TSpnlMntFrm.RefitSpinalEditChange(Sender: TObject);
var
  iMark: Integer;
begin
  if (Ship.IsRefitted) then
  begin
    with (RefitSpinalEdit) do
    begin
      if (Text = '') then
      begin
        Abort;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then
      begin
        MessageDlg('Spinal Refit TL must be an integer', mtError, [mbOk], 0);
        Text := IntToStr(Ship.SpinalMount.SpinalMountRefitTech);
        Exit;
      end;
      iMark := GetSpinalValue(SpnlMntComboBx.Text[1]);
      FillCombo(StrToInt(Text), SpnlMntRadGrp.ItemIndex);
      case (SpnlMntRadGrp.ItemIndex) of
        0: SpnlMntComboBx.Text := '0 None';
        1: SpnlMntComboBx.Text := Data.GetSpnlMesData(1, iMark);
        2: SpnlMntComboBx.Text := Data.GetSpnlPaData(1, iMark);
      end;
    end;
  end;
end;

function TSpnlMntFrm.GetSpinalValue(SpinalMount: Char): Integer;
//change the spinal mount value into a number

begin
   Case (SpinalMount) of
   '0' : Result := 0;
   'A' : Result := 1;
   'B' : Result := 2;
   'C' : Result := 3;
   'D' : Result := 4;
   'E' : Result := 5;
   'F' : Result := 6;
   'G' : Result := 7;
   'H' : Result := 8;
   'J' : Result := 9;
   'K' : Result := 10;
   'L' : Result := 11;
   'M' : Result := 12;
   'N' : Result := 13;
   'P' : Result := 14;
   'Q' : Result := 15;
   'R' : Result := 16;
   'S' : Result := 17;
   'T' : Result := 18;
   end;
end;

procedure TSpnlMntFrm.SpnlMntRadGrpClick(Sender: TObject);
//select the type of spinal mount and fill the combo box with data

var
  mCount, pCount, iTech, iBaseSpinalType, iSpinalMount: Integer;
  MesSpinalList : TStringList;
  PASpinalList : TStringList;
begin
  //mCount := 0;
  //pCount := 0;
  if (RefitSpinalChkBx.Checked) then iTech := StrToInt(RefitSpinalEdit.Text)
      else iTech := Ship.TechLevel;
  if (Ship.SpinalMount.RefitSpinalMount) then iBaseSpinalType := Ship.SpinalMount.NewSpinalType
      else iBaseSpinalType := Ship.SpinalMount.SpinalType;
  if (Ship.SpinalMount.RefitSpinalMount) then iSpinalMount := Ship.SpinalMount.NewSpinalMount
      else iSpinalMount := Ship.SpinalMount.SpinalMount;
  FillCombo(iTech, SpnlMntRadGrp.ItemIndex);
  (*
  MesSpinalList := TStringList.Create;
  PASpinalList := TStringList.Create;
  try
    while (mCount < 19) do
    begin
      if (StrToInt(Data.GetSpnlMesData(3, mCount)) <= Ship.TechLevel) then
      begin
        MesSpinalList.Add(Data.GetSpnlMesData(1, mCount));
      end;
      inc(mCount);
    end;
    while (pCount < 19) do
    begin
      if (StrToInt(Data.GetSpnlPAData(3, pCount)) <= Ship.TechLevel) then
      begin
        PASpinalList.Add(Data.GetSpnlPAData(1, pCount));
      end;
      inc(pCount);
    end;
    SpnlMntComboBx.Clear;
    *)
    case (SpnlMntRadGrp.ItemIndex) of
      0: begin
           //SpnlMntComboBx.Items.Add('0 None');
           SpnlMntComboBx.Text := '0 None';
         end;
      1: begin
           //SpnlMntComboBx.Items.AddStrings(MesSpinalList);
           if (iBaseSpinalType = 1) then
           begin
             SpnlMntComboBx.Text := Data.GetSpnlMesData(1, iSpinalMount);
           end
           else
           begin
             SpnlMntComboBx.Text := '0 None';
           end;
         end;
      2: begin
           //SpnlMntComboBx.Items.AddStrings(PASpinalList);
           if (iBaseSpinalType = 2) then
           begin
             SpnlMntComboBx.Text := Data.GetSpnlPAData(1, iSpinalMount);
           end
           else
           begin
             SpnlMntComboBx.Text := '0 None';
           end;
         end;
    end;
    HardPointsLbl.Caption := IntToStr(CalRemHardPoints);
    (*
  finally
    FreeAndNil(MesSpinalList);
    FreeAndNil(PASpinalList);
  end;
  *)
end;

function TSpnlMntFrm.TrapErrors: Boolean;
//check the form for errors
var
  BaseSpinalSize, CurSpinalSize: Extended;
  Data: TData;
begin
  Result := False;
  Data := TData.Create;
  try
    Data.InitialiseData;
    BaseSpinalSize := Ship.SpinalMount.SpinalMountSpace(Ship.ShipRace, Data);
    case (SpnlMntRadGrp.ItemIndex) of
      0: CurSpinalSize := 0;
      1: begin
           CurSpinalSize := StrToFloat(Data.GetSpnlMesData(2, GetSpinalValue(SpnlMntComboBx.Text[1])));
           if (Ship.ShipRace = 1) then CurSpinalSize := CurSpinalSize * 2;
         end;
      2: begin
           CurSpinalSize := StrToFloat(Data.GetSpnlPaData(2, GetSpinalValue(SpnlMntComboBx.Text[1])));
           if (Ship.ShipRace = 1) then CurSpinalSize := CurSpinalSize * 2;
         end;
    end;
    if (SpnlMntComboBx.Text = '') then
    begin
      MessageDlg('No Spinal Mount Entered (This may be none)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (UpgradeSpaceEdit.Text = '') then
    begin
      MessageDlg('No Upgrade space Entered (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToFloatDef(RemoveCommas(UpgradeSpaceEdit.Text), 2) = 2)
        and (StrToFloatDef(RemoveCommas(UpgradeSpaceEdit.Text), 3) = 3) then
    begin
      MessageDlg('Upgrade space must be a floating point value (This may be zero)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToFloat(RemoveCommas(UpgradeSpaceEdit.Text)) < 0) then
    begin
      MessageDlg('Upgrade space may not be less than zero', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (RefitSpinalEdit.Text = '') then
    begin
      MessageDlg('No Refit TL Entered (This should be seven or greater)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToIntDef(RefitSpinalEdit.Text, 2) = 2) and (StrToIntDef(RefitSpinalEdit.Text, 3) = 3) then
    begin
      MessageDlg('Refit TL must be an Integer value (This should be seven or greater)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (StrToInt(RefitSpinalEdit.Text) < 0) then
    begin
      MessageDlg('Refit TL may not be less than zero (Should be seven or greater)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (SpnlMntRadGrp.ItemIndex = -1) then
    begin
      MessageDlg('Spinal Mount type not selected (May be none)', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (SpnlMntRadGrp.ItemIndex > 0) and (GetSpinalValue(SpnlMntComboBx.Text[1]) = 0) then
    begin
      MessageDlg('No Spinal Mount selected, resetting Spinal Type to none', mtError, [mbOk], 0);
      SpnlMntRadGrp.ItemIndex := 0;
      Result := True;
      //exit;
    end;
    if (CalRemHardPoints < 0) then
    begin
      if (Warn('There are not enough hardpoints for the weapons installed, '
            + 'do you wish to alter these weapons?')) then
      begin
        Result := True;
        exit;
      end;
    end;
    if (SpnlMntRadGrp.ItemIndex = 1) and (AreMesonsElsewhere) then
    begin
      if (Warn('There are already Meson Guns installed, '
            + 'do you wish to alter these weapons?')) then
      begin
        Result := True;
        exit;
      end;
    end;
    if (SpnlMntRadGrp.ItemIndex = 2) and (ArePaElsewhere) then
    begin
      if (Warn('There are already Particle Accelerators installed, '
            + 'do you wish to alter these weapons?')) then
      begin
        Result := True;
        exit;
      end;
    end;
    //refit rule enforcement
    if (Ship.IsRefitted) then
    begin
      if ((CurSpinalSize + Ship.SpinalMount.UpgradeSpace) > BaseSpinalSize) then
      begin
        MessageDlg('Refitted Spinal Mount is larger than the existing Spinal Mount', mtError, [mbOk], 0);
        Result := True;
        exit;
      end;
    end;
  finally
    Data.Free;
  end;
end;

procedure TSpnlMntFrm.RefreshForm;
var
  iTech, iSpinalType, iSpinalMount: Integer;
begin
  if (Ship.SpinalMount.RefitSpinalMount) then iTech := Ship.SpinalMount.SpinalMountRefitTech
      else iTech := Ship.TechLevel;
  if (Ship.SpinalMount.RefitSpinalMount) then iSpinalType := Ship.SpinalMount.NewSpinalType
      else iSpinalType := Ship.SpinalMount.SpinalType;
  if (Ship.SpinalMount.RefitSpinalMount) then iSpinalMount := Ship.SpinalMount.NewSpinalMount
      else iSpinalMount := Ship.SpinalMount.SpinalMount;
  RefitTlLbl.Visible := Ship.IsRefitted;
  RefitSpinalChkBx.Visible := Ship.IsRefitted;
  RefitSpinalChkBx.Enabled := Ship.IsRefitted;
  RefitSpinalEdit.Visible := Ship.IsRefitted;
  RefitSpinalEdit.Enabled := Ship.SpinalMount.RefitSpinalMount;
  UpgradeSpaceEdit.Enabled := not Ship.IsRefitted;
  if (Ship.IsRefitted) then
  begin
    SpnlMntRadGrp.Enabled := Ship.SpinalMount.RefitSpinalMount;
    SpnlMntComboBx.Enabled := Ship.SpinalMount.RefitSpinalMount;
  end
  else
  begin
    HardPointsStatLbl.Top := HardPointsStatLbl.Top - 26;
    HardPointsLbl.Top := HardPointsLbl.Top - 26;
    OkBtn.Top := OkBtn.Top - 26;
    CancelBtn.Top := CancelBtn.Top - 26;
  end;
  FillCombo(iTech, iSpinalType);
  UpgradeSpaceEdit.Text := FloatToStrF(Ship.SpinalMount.UpgradeSpace, ffNumber, 18, 3);
  SpnlMntRadGrp.ItemIndex := iSpinalType;
  case (iSpinalType) of
    0: begin
         SpnlMntComboBx.Text := '0 None';
       end;
    1: begin
         SpnlMntComboBx.Text := Data.GetSpnlMesData(1, iSpinalMount);
       end;
    2: begin
         SpnlMntComboBx.Text := Data.GetSpnlPaData(1, iSpinalMount);
       end;
  end;
  RefitSpinalEdit.Text := IntToStr(Ship.SpinalMount.SpinalMountRefitTech);
  RefitSpinalChkBx.Checked := Ship.SpinalMount.RefitSpinalMount;
  HardPointsLbl.Caption := IntToStr(CalRemHardPoints);
end;

function TSpnlMntFrm.CalRemHardPoints: Integer;
//calculate the number of hardpoints left

var
  HardPoints: Integer;
  FormHP, ShipHP: Integer;
  iTech, iSpinalType, iSpinalMount: Integer;
begin
  HardPoints := Ship.GetRemHardPoints;
  FormHP := 0;
  ShipHP := 0;
  if (Ship.SpinalMount.RefitSpinalMount) then iSpinalType := Ship.SpinalMount.NewSpinalType
      else iSpinalType := Ship.SpinalMount.SpinalType;
  //calculate the number of hardpoints required by the values in the ship
  case (Ship.SpinalMount.SpinalType) of
  0: begin
       ShipHP := 0;
     end;
  1: begin
       ShipHP := StrToInt(Data.GetSpnlMesData(2,
           Ship.SpinalMount.SpinalMount)) div 100;
     end;
  2: begin
       ShipHP := StrToInt(Data.GetSpnlPAData(2,
           Ship.SpinalMount.SpinalMount)) div 100;
     end;
  end;
  //calculate the number of hardpoints required by the values on the form
  case (SpnlMntRadGrp.ItemIndex) of
  0: begin
       FormHP := 0;
     end;
  1: begin
       FormHP := StrToInt(Data.GetSpnlMesData(2,
           GetSpinalValue(SpnlMntComboBx.Text[1]))) div 100;
     end;
  2: begin
       FormHP := StrToInt(Data.GetSpnlPAData(2,
           GetSpinalValue(SpnlMntComboBx.Text[1]))) div 100;
     end;
  end;
  Result := HardPoints + ShipHP - FormHP;
end;

procedure TSpnlMntFrm.SpnlMntComboBxChange(Sender: TObject);
//ingnore null data and refresh the hardpoints

begin
   if (SpnlMntComboBx.Text = '') then begin
      abort;
   end;
   HardPointsLbl.Caption := IntToStr(CalRemHardPoints);
end;

procedure TSpnlMntFrm.CommitChanges;
//send the form data to the ship

begin
  if (Ship.IsRefitted) then
  begin
    Ship.SpinalMount.RefitSpinalMount := RefitSpinalChkBx.Checked;
    Ship.SpinalMount.SpinalMountRefitTech := StrToInt(RefitSpinalEdit.Text);
    Ship.SpinalMount.NewSpinalMount := GetSpinalValue(SpnlMntComboBx.Text[1]);
    Ship.SpinalMount.NewSpinalType := SpnlMntRadGrp.ItemIndex;
  end
  else
  begin
    Ship.SpinalMount.SpinalMount := GetSpinalValue(SpnlMntComboBx.Text[1]);
    Ship.SpinalMount.SpinalType := SpnlMntRadGrp.ItemIndex;
    Ship.SpinalMount.UpgradeSpace := StrToFloat(RemoveCommas(UpgradeSpaceEdit.Text));
    Ship.SpinalMount.RefitSpinalMount := False;
    Ship.SpinalMount.SpinalMountRefitTech := 0;
    Ship.SpinalMount.NewSpinalMount := 0;
    Ship.SpinalMount.NewSpinalType := 0;
  end;
  Ship.DesignShip;
  RefreshForm;
end;

procedure TSpnlMntFrm.FillCombo(Tech, SpinalType: Integer);
var
  iCount: Integer;
  SpinalList: TStringList;
begin
  SpinalList := TStringList.Create;
  try
    for iCount := 0 to 18 do
    begin
      case (SpinalType) of
        0: begin
             SpinalList.Add('0 None');
             Break;
           end;
        1: begin
             if (StrToInt(Data.GetSpnlMesData(3, iCount)) <= Tech) then
             begin
               SpinalList.Add(Data.GetSpnlMesData(1, iCount));
             end;
           end;
        2: begin
             if (StrToInt(Data.GetSpnlPaData(3, iCount)) <= Tech) then
             begin
               SpinalList.Add(Data.GetSpnlPaData(1, iCount));
             end;
           end;
      end;
    end;
    SpnlMntComboBx.Clear;
    SpnlMntComboBx.Items.AddStrings(SpinalList);
  finally
    SpinalList.Free;
  end;
end;

function TSpnlMntFrm.Warn(TheMessage: String): Boolean;
//display a warning message with a yes no dialog

begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TSpnlMntFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateSpinalMountDetails);
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

function TSpnlMntFrm.GenerateSpinalMountDetails: String;
//generate spinal mount file details

begin
   Result := IntToStr(SpnlMntRadGrp.ItemIndex)
         + SEP + IntToStr(GetSpinalValue(SpnlMntComboBx.Text[1]))
         + SEP + RemoveCommas(UpgradeSpaceEdit.Text)    //2
         + SEP + BoolToStr(RefitSpinalChkBx.Checked)                   //3
         + SEP + RefitSpinalEdit.Text                //4
         + SEP + IntToStr(SpnlMntRadGrp.ItemIndex)                       //5
         + SEP + IntToStr(GetSpinalValue(SpnlMntComboBx.Text[1]))                      //6
         + SEP + '0'                                                       //7
         + SEP + '0'                                                       //8
         + SEP + '0'                                                       //9
         + SEP + '0'                                                       //10
         + SEP + '0'                                                       //11
         + SEP + '0'                                                       //12
         + SEP + '0'                                                       //13
         + SEP + '0'                                                       //14
         + SEP + '0'                                                       //15
         + SEP + '0'                                                       //16
         ;  //terminator
end;

function TSpnlMntFrm.AreMesonsElsewhere: Boolean;
begin
  Result := False;
  if (Ship.BigBays.MesonBays > 0) and (not Ship.BigBays.RefitMesonBays) then Result := True;
  if (Ship.BigBays.NewMesonBays > 0) and (Ship.BigBays.RefitMesonBays) then Result := True;
  if (Ship.LittleBays.MesonBays > 0) and (not Ship.LittleBays.RefitMesonBays) then Result := True;
  if (Ship.LittleBays.NewMesonBays > 0) and (Ship.LittleBays.RefitMesonBays) then Result := True;
end;

function TSpnlMntFrm.ArePaElsewhere: Boolean;
begin
  Result := False;
  if (Ship.BigBays.PABays > 0) and (not Ship.BigBays.RefitPaBays) then Result := True;
  if (Ship.BigBays.NewPABays > 0) and (Ship.BigBays.RefitPaBays) then Result := True;
  if (Ship.LittleBays.PABays > 0) and (not Ship.LittleBays.RefitPaBays) then Result := True;
  if (Ship.LittleBays.NewPABays > 0) and (Ship.LittleBays.RefitPaBays) then Result := True;
  if (Ship.Turrets.PATurrets > 0) and (not Ship.Turrets.RefitPaTurrets) then Result := True;
  if (Ship.Turrets.NewPATurrets > 0) and (Ship.Turrets.RefitPaTurrets) then Result := True;
end;

end.
