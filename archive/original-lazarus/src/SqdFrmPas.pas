unit SqdFrmPas;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Menus, ExtCtrls, Spin, Buttons, {MainPas,} HgsFormFrm, SquadronPas,
  ShipPas;

type

  { TSqdFrm }

  TSqdFrm = class(THgsForm)
    AddShipBtn: TButton;
    AllDiscountChkBox: TCheckBox;
    TechLevelEdit: TEdit;
    LowTechLbl: TLabel;
    NewBtn: TButton;
    CloseBtn: TButton;
    CostLbl: TLabel;
    ShipsBoatLbl: TLabel;
    MaintLbl: TLabel;
    ShipsBoatStatTxt: TStaticText;
    LowTechStatTxt: TStaticText;
    TonnageLbl: TLabel;
    CrewLbl: TLabel;
    PilotsLbl: TLabel;
    FuelLbl: TLabel;
    GasGiantLbl: TLabel;
    OceanLbl: TLabel;
    OpenBtn: TButton;
    SaveBtn: TButton;
    InOrdChkBox: TCheckBox;
    CarriedCraftChkBox: TCheckBox;
    EditShipBtn: TButton;
    DeleteShipBtn: TButton;
    ExitMenuItem: TMenuItem;
    ExportMenuItem: TMenuItem;
    FileMenu: TMenuItem;
    CostStatTxt: TStaticText;
    MaintStatTxt: TStaticText;
    TonnageStatTxt: TStaticText;
    CrewStatTxt: TStaticText;
    PilotStatTxt: TStaticText;
    FuelStatTxt: TStaticText;
    GasGiantStatTxt: TStaticText;
    OceanStaTxt: TStaticText;
    NumStatTxt1: TStaticText;
    SqdNameEdit: TLabeledEdit;
    DesignerNameEdit: TLabeledEdit;
    SqdBudgetEdit: TLabeledEdit;
    SqdTonnageEdit: TLabeledEdit;
    MainMenu: TMainMenu;
    NumSpinEdit: TSpinEdit;
    NumStatTxt: TStaticText;
    UspMemo: TMemo;
    N1: TMenuItem;
    NewMenuItem: TMenuItem;
    RefreshBtn: TButton;
    OpenDialog: TOpenDialog;
    OpenMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    SaveDialog: TSaveDialog;
    SaveMenuItem: TMenuItem;
    ShipsListView: TListView;
    procedure AddShipBtnClick(Sender: TObject);
    procedure AllDiscountChkBoxClick(Sender: TObject);
    procedure CarriedCraftChkBoxChange(Sender: TObject);
    procedure ExportMenuItemClick(Sender: TObject);
    procedure InOrdChkBoxChange(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure DeleteShipBtnClick(Sender: TObject);
    procedure EditShipBtnClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure NumSpinEditChange(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure ShipsListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TechLevelEditChange(Sender: TObject);
  private
    { private declarations }
    procedure AssignDefaults;
    procedure RefreshLabels;
    procedure RefreshNum(TheShip: TShip);
    procedure RefreshUsp(TheShip: TShip);
    procedure RefreshShipsList;
    procedure LoadAFile;
  public
    { public declarations }
  end;

var
  SqdFrm: TSqdFrm;

implementation

uses
  MainPas;

{$R *.lfm}

{ TSqdFrm }

procedure TSqdFrm.RefreshBtnClick(Sender: TObject);
//refresh form
var
  iCount: Integer;
begin
  //save the sqd to a temp file
  Squadron.WriteToFile(ParamStr(0) + 'tempsqdsav.tcs');
  //clear out the sqd
  Squadron.Clear;
  //reload from the temp file
  Squadron.ReadFromFile(ParamStr(0) + 'tempsqdsav.tcs');
  RefreshShipsList;
  RefreshLabels;
end;

procedure TSqdFrm.FormCreate(Sender: TObject);
begin
  AssignDefaults;
  Squadron := TSquadron.Create;
end;

procedure TSqdFrm.NewMenuItemClick(Sender: TObject);
begin
  //
end;

procedure TSqdFrm.NumSpinEditChange(Sender: TObject);
var
  TheShip: TShip;
begin
  with (NumSpinEdit) do
  begin
    if (Text = '') then
    begin
      abort;
    end;
    if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then
    begin
      abort;
    end;
  end;
  if (ShipsListView.Selected <> Nil) then
  begin
    TheShip := Squadron.ShipList[ShipsListView.Selected.Index];
    TheShip.Num := StrToInt(NumSpinEdit.Text);
    RefreshNum(TheShip);
    RefreshLabels;
  end
  else
  begin
    MessageDlg('No Ship Selected', mtInformation, [mbOk], 0);
  end;
end;

procedure TSqdFrm.OpenBtnClick(Sender: TObject);
begin

end;

procedure TSqdFrm.AddShipBtnClick(Sender: TObject);
var
  TheShip: TShip;
  TheItem: TListItem;
  iCount: Integer;
begin
  With (OpenDialog) do
  begin
    //set the open dialogs properties
    DefaultExt := '*.hgs';
    Filter := 'Hgs Files (*.hgs)|*.hgs|All Files (*.*)|*.*';
    Options := [ofFileMustExist, ofCreatePrompt, ofAllowMultiSelect, ofEnableSizing];
    if (Execute) then
    begin
      //loop through all selected files
      for iCount := 0 to Files.Count - 1 do
      begin
        //if a file is invalid abort
        if (Squadron.AddAShip(Files[iCount], 1, False, False, False) = False) then
        begin
          MessageDlg(ExtractFileName(Files[iCount]) + ' is not a valid file',
                     mtError, [mbOk], 0);
          Exit;
        end;
        //display the ship in the list view
        TheShip := Squadron.ShipList[Squadron.ShipList.Count - 1];
        with ShipsListView do
        begin
          TheItem := Items.Add;
          TheItem.Caption := TheShip.ShipClass;
          TheItem.SubItems.Add(IntToStr(TheShip.Num));
          TheItem.SubItems.Add(TheShip.ShipFile);
          TheItem.SubItems.Add(IntToStr(TheShip.TechLevel));
          Selected := TheItem;
          ItemFocused := TheItem;
        end;
      end;
      RefreshLabels;
    end;
  end;
end;

procedure TSqdFrm.AllDiscountChkBoxClick(Sender: TObject);
var
  TheShip: TShip;
begin
  if (ShipsListView.Selected <> Nil) then
  begin
    TheShip := Squadron.ShipList[ShipsListView.Selected.Index];
    TheShip.DiscountAll := AllDiscountChkBox.Checked;
    RefreshLabels;
  end
  else
  begin
    MessageDlg('No Ship Selected', mtInformation, [mbOk], 0);
  end;
end;

procedure TSqdFrm.CarriedCraftChkBoxChange(Sender: TObject);
var
  TheShip: TShip;
begin
  if (ShipsListView.Selected <> Nil) then
  begin
    TheShip := Squadron.ShipList[ShipsListView.Selected.Index];
    TheShip.CarriedCraft := CarriedCraftChkBox.Checked;
    RefreshLabels;
  end
  else
  begin
    MessageDlg('No Ship Selected', mtInformation, [mbOk], 0);
  end;
end;

procedure TSqdFrm.ExportMenuItemClick(Sender: TObject);
begin
  with SaveDialog do
  begin
    DefaultExt := '.txt';
    FileName := Squadron.SquadronName;
    Filter := 'Txt File (*.txt)|*.txt|All Files (*.*)|*.*';
    options := [ofEnableSizing, ofViewDetail, ofOverwritePrompt];
    if (Execute) then
    begin
      Squadron.ExportSquadron(FileName);
    end;
  end;
end;

procedure TSqdFrm.InOrdChkBoxChange(Sender: TObject);
var
  TheShip: TShip;
begin
  if (ShipsListView.Selected <> Nil) then
  begin
    TheShip := Squadron.ShipList[ShipsListView.Selected.Index];
    TheShip.InOrdinary := InOrdChkBox.Checked;
    RefreshLabels;
  end
  else
  begin
    MessageDlg('No Ship Selected', mtInformation, [mbOk], 0);
  end;
end;

procedure TSqdFrm.NewBtnClick(Sender: TObject);
begin
  if (MessageDlg('Do you want to start a new squadron, any unsaved changes will be lost',
      mtConfirmation, mbYesNo, 0) = mrYes) then
  begin
    Squadron.Clear;
    UspMemo.Clear;
    RefreshShipsList;
    RefreshLabels;
  end;
end;

procedure TSqdFrm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSqdFrm.DeleteShipBtnClick(Sender: TObject);
begin
  if (ShipsListView.Selected <> Nil) then
  begin
    Squadron.DeleteAShip(ShipsListView.Selected.Index);
    RefreshShipsList;
    RefreshLabels;
  end
  else
  begin
    MessageDlg('No Ship Selected', mtInformation, [mbOk], 0);
  end;
end;

procedure TSqdFrm.EditShipBtnClick(Sender: TObject);
begin
  if (ShipsListView.Selected <> Nil) then
  begin
    if (MessageDlg('Do you want to load this ship into HGS. Any unsaved changes'
        + ' to the existing design will be lost', mtConfirmation, mbYesNo, 0) = mrYes) then
    begin
      //MainFrm.LoadThisShip('kwin.hgs');
      MainFrm.LoadThisShip(ShipsListView.Selected.SubItems.Strings[1]);
      MainFrm.TargetFile := ShipsListView.Selected.SubItems.Strings[1];
    end;
  end
  else
  begin
    MessageDlg('No Ship Selected', mtInformation, [mbOk], 0);
  end;
end;

procedure TSqdFrm.ExitMenuItemClick(Sender: TObject);
begin
  Close;
end;

procedure TSqdFrm.OpenMenuItemClick(Sender: TObject);
var
  sTest: String;
begin
  sTest:= Squadron.SaveFile;

  if (Squadron.SaveFile <> '') then
  begin
    if (MessageDlg('Do you want to load a new squadron, any unsaved changes will be lost',
        mtConfirmation, mbYesNo, 0) = mrYes) then
    begin
      LoadAFile;
    end;
  end
  else
  begin
    LoadAFile;
  end;
end;

procedure TSqdFrm.SaveMenuItemClick(Sender: TObject);
begin
  if (Squadron.SaveFile <> '') then
  begin
    Squadron.SquadronName := SqdNameEdit.Text;
    Squadron.DesignerName := DesignerNameEdit.Text;
    Squadron.SquadronBudget := StrToFloat(RemoveCommas(SqdBudgetEdit.Text));
    Squadron.SquadronTonnage := StrToFloat(RemoveCommas(SqdTonnageEdit.Text));
    Squadron.SquadronTechLevel := StrToInt(TechLevelEdit.Text);
    Squadron.WriteToFile(Squadron.SaveFile);
  end
  else
  begin
    with SaveDialog do
    begin
      DefaultExt := '.tcs';
      FileName := SqdNameEdit.Text;
      Filter := 'Tcs Files (*.tcs)|*.tcs|All Files (*.*)|*.*';
      options := [ofEnableSizing, ofViewDetail, ofOverwritePrompt];
      if (Execute) then
      begin
        Squadron.SquadronName := SqdNameEdit.Text;
        Squadron.DesignerName := DesignerNameEdit.Text;
        Squadron.SquadronBudget := StrToFloat(RemoveCommas(SqdBudgetEdit.Text));
        Squadron.SquadronTonnage := StrToFloat(RemoveCommas(SqdTonnageEdit.Text));
        Squadron.SquadronTechLevel := StrToInt(TechLevelEdit.Text);
        Squadron.WriteToFile(FileName);
      end;
    end;
  end;
end;

procedure TSqdFrm.ShipsListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  TheShip: TShip;
begin
  TheShip := Squadron.ShipList[Item.Index];
  NumSpinEdit.Text := IntToStr(TheShip.Num);
  RefreshUsp(TheShip);
end;

procedure TSqdFrm.TechLevelEditChange(Sender: TObject);
begin
  with (TechLevelEdit) do
  begin
    if (Text = '') then
    begin
      abort;
    end;
    if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then
    begin
      abort;
    end;
  end;
  if (StrToInt(TechLevelEdit.Text) <> Squadron.SquadronTechLevel) then
  begin
    Squadron.SquadronTechLevel := StrToInt(TechLevelEdit.Text);
    RefreshLabels;
  end;
end;

procedure TSqdFrm.SaveAsMenuItemClick(Sender: TObject);
begin
  with SaveDialog do
  begin
    DefaultExt := '.tcs';
    FileName := SqdNameEdit.Text;
    Filter := 'Tcs Files (*.tcs)|*.tcs|All Files (*.*)|*.*';
    options := [ofEnableSizing, ofViewDetail, ofOverwritePrompt];
    if (Execute) then
    begin
      Squadron.SquadronName := SqdNameEdit.Text;
      Squadron.DesignerName := DesignerNameEdit.Text;
      Squadron.SquadronBudget := StrToFloat(RemoveCommas(SqdBudgetEdit.Text));
      Squadron.SquadronTonnage := StrToFloat(RemoveCommas(SqdTonnageEdit.Text));
      Squadron.SquadronTechLevel := StrToInt(TechLevelEdit.Text);
      Squadron.WriteToFile(FileName);
    end;
  end;
end;

procedure TSqdFrm.AssignDefaults;
begin
  SqdNameEdit.Text := 'New Squadron';
  DesignerNameEdit.Text := 'Andrea Vallance';
  SqdBudgetEdit.Text := '1,000';
  SqdTonnageEdit.Text := '1,000';
  TechLevelEdit.Text := '9';
  CostLbl.Caption := 'MCr 0.000';
  MaintLbl.Caption := 'MCr 0.000';
  TonnageLbl.Caption := '0.000 Td';
  CrewLbl.Caption := '0';
  PilotsLbl.Caption := '0';
  ShipsBoatLbl.Caption := '0';
  FuelLbl.Caption := '0.000 Td';
  GasGiantLbl.Caption := '0.000%';
  OceanLbl.Caption := '0.000%';
end;

procedure TSqdFrm.RefreshLabels;
begin
  CostLbl.Caption := 'MCr ' + FloatToStrF(Squadron.GetSqdCost, ffNumber, 18, 3);
  MaintLbl.Caption := 'MCr ' + FloatToStrF(Squadron.GetSqdMaint, ffNumber, 18, 3);
  TonnageLbl.Caption := FloatToStrF(Squadron.GetSqdTonnage, ffNumber, 18, 3) + ' Td';
  CrewLbl.Caption := FloatToStrF(Squadron.GetSqdCrew, ffNumber, 18, 0);
  PilotsLbl.Caption := FloatToStrF(Squadron.GetSqdPilots, ffNumber, 18, 0);
  ShipsBoatLbl.Caption := FloatToStrF(Squadron.GetSqdShipsBoat, ffNumber, 18, 0);
  FuelLbl.Caption := FloatToStrF(Squadron.GetSqdFuel, ffNumber, 18, 3) + ' Td';
  GasGiantLbl.Caption := FloatToStrF(Squadron.GetGasGiantRefueling, ffNumber, 18, 3) + '%';
  OceanLbl.Caption := FloatToStrF(Squadron.GetOceanRefueling, ffNumber, 18, 3) + '%';
  LowTechLbl.Caption := FloatToStrF(Squadron.GetLowerTech, ffNumber, 18, 3) + '%';
end;

procedure TSqdFrm.RefreshNum(TheShip: TShip);
begin
  ShipsListView.Selected.SubItems.Delete(0);
  ShipsListView.Selected.SubItems.Insert(0, IntToStr(TheShip.Num));
end;

procedure TSqdFrm.RefreshUsp(TheShip: TShip);
begin
  UspMemo.Lines.Clear;
  UspMemo.Lines.AddStrings(TheShip.USP);
  AllDiscountChkBox.Checked := TheShip.DiscountAll;
  InOrdChkBox.Checked := TheShip.InOrdinary;
  CarriedCraftChkBox.Checked := TheShip.CarriedCraft;
end;

procedure TSqdFrm.RefreshShipsList;
var
  iCount: Integer;
  TheShip: TShip;
  TheItem: TListItem;
begin
  ShipsListView.Clear;
  for iCount := 0  to Squadron.ShipList.Count - 1 do
  begin
    TheShip := Squadron.ShipList[iCount];
    with ShipsListView do
    begin
      TheItem := Items.Add;
      TheItem.Caption := TheShip.ShipClass;
      TheItem.SubItems.Add(IntToStr(TheShip.Num));
      TheItem.SubItems.Add(TheShip.ShipFile);
      TheItem.SubItems.Add(IntToStr(TheShip.TechLevel));
      Selected := TheItem;
      ItemFocused := TheItem;
    end;
  end;
end;

procedure TSqdFrm.LoadAFile;
var
  iCount: Integer;
  TheShip: TShip;
  TheItem: TListItem;
begin
  with OpenDialog do
  begin
    DefaultExt := '.tcs';
    FileName := '';
    Filter := 'Tcs Files (*.tcs)|*.tcs|All Files (*.*)|*.*';
    options := [ofEnableSizing,ofViewDetail, ofOverwritePrompt];
    if (Execute) then
    begin
      Squadron.ReadFromFile(FileName);
      SqdNameEdit.Text := Squadron.SquadronName;
      DesignerNameEdit.Text := Squadron.DesignerName;
      SqdBudgetEdit.Text := FloatToStrF(Squadron.SquadronBudget, ffNumber, 18, 3);
      SqdTonnageEdit.Text := FloatToStrF(Squadron.SquadronTonnage, ffNumber, 18, 3);
      TechLevelEdit.Text := IntToStr(Squadron.SquadronTechLevel);
      ShipsListView.Clear;
      for iCount := 0  to Squadron.ShipList.Count - 1 do
      begin
        TheShip := Squadron.ShipList[iCount];
        with ShipsListView do
        begin
          TheItem := Items.Add;
          TheItem.Caption := TheShip.ShipClass;
          TheItem.SubItems.Add(IntToStr(TheShip.Num));
          TheItem.SubItems.Add(TheShip.ShipFile);
          TheItem.SubItems.Add(IntToStr(TheShip.TechLevel));
          Selected := TheItem;
          ItemFocused := TheItem;
        end;
      end;
      RefreshLabels;
    end;
  end;
end;

end.

