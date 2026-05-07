unit StartFrmPas;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Menus, ExtCtrls, Spin, Buttons, MainPas, HgsFormFrm, SquadronPas,
  ShipPas;

type

  { TStartFrm }

  TStartFrm = class(THgsForm)
    AddShipBtn: TButton;
    AllDiscountChkBox: TCheckBox;
    ApplyBtn: TButton;
    CancelBtn: TButton;
    InOrdChkBox: TCheckBox;
    CarriedCraftChkBox: TCheckBox;
    EditShipBtn: TButton;
    DeleteShipBtn: TButton;
    ExitMenuItem: TMenuItem;
    ExportMenuItem: TMenuItem;
    FileMenu: TMenuItem;
    TechLevelSpinEdit: TSpinEdit;
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
    NewShipBtn: TButton;
    OpenDialog: TOpenDialog;
    OpenMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    SaveDialog: TSaveDialog;
    SaveMenuItem: TMenuItem;
    ShipsListView: TListView;
    procedure AddShipBtnClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure NewShipBtnClick(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
  private
    { private declarations }
    procedure AssignDefaults;
  public
    { public declarations }
    procedure RefreshForm;
  end; 

var
  StartFrm: TStartFrm;

implementation

{$R *.lfm}

{ TStartFrm }

procedure TStartFrm.NewShipBtnClick(Sender: TObject);
//make a new ship
var
  MainFrm : TMainFrm;
begin
  MainFrm := TMainFrm.Create(Self);
  MainFrm.Show{Modal};
end;

procedure TStartFrm.FormCreate(Sender: TObject);
begin
  AssignDefaults;
  Squadron := TSquadron.Create;
end;

procedure TStartFrm.NewMenuItemClick(Sender: TObject);
begin
  //
end;

procedure TStartFrm.AddShipBtnClick(Sender: TObject);
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
    end;
  end;
end;

procedure TStartFrm.ExitMenuItemClick(Sender: TObject);
begin
  Close;
end;

procedure TStartFrm.OpenMenuItemClick(Sender: TObject);
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
      TechLevelSpinEdit.Text := IntToStr(Squadron.SquadronTechLevel);
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
  end;
end;

procedure TStartFrm.SaveMenuItemClick(Sender: TObject);
begin
  if (Squadron.SaveFile <> '') then
  begin
    Squadron.SquadronName := SqdNameEdit.Text;
    Squadron.DesignerName := DesignerNameEdit.Text;
    Squadron.SquadronBudget := StrToFloat(RemoveCommas(SqdBudgetEdit.Text));
    Squadron.SquadronTonnage := StrToFloat(RemoveCommas(SqdTonnageEdit.Text));
    Squadron.SquadronTechLevel := StrToInt(TechLevelSpinEdit.Text);
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
        Squadron.SquadronTechLevel := StrToInt(TechLevelSpinEdit.Text);
        Squadron.WriteToFile(FileName);
      end;
    end;
  end;
end;

procedure TStartFrm.SaveAsMenuItemClick(Sender: TObject);
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
      Squadron.SquadronTechLevel := StrToInt(TechLevelSpinEdit.Text);
      Squadron.WriteToFile(FileName);
    end;
  end;
end;

procedure TStartFrm.AssignDefaults;
begin
  SqdNameEdit.Text := 'New Squadron';
  DesignerNameEdit.Text := 'Andrew Vallance';
  SqdBudgetEdit.Text := '1,000';
  SqdTonnageEdit.Text := '1,000';
  TechLevelSpinEdit.Text := '9';
end;

procedure TStartFrm.RefreshForm;
begin
  //
end;

end.

