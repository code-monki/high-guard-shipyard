unit MainPas;

{$MODE Delphi}

interface
                                               
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  StdCtrls, Menus, StdActns, ActnList, ImgList, HgsFormFrm,
  HullFrmPas, ShipFrmPas, AboutBoxFrmPas, EngFrmPas, FuelFrmPas, DataPas,
  AvionicsFrmPas, SpnlMntFrmPas, ScreensFrmPas, CraftFrmPas, ExtCtrls,
  AccomFrmPas, ComCtrls, ShipModulePas, ShipPas, BigBaysFrmPas, LittleBaysFrmPas,
  TurretsFrmPas, OptionsFrmPas, AnalysisPas, Buttons, CommentsFrmPas,
  ErrorFrmPas, DesAssistFrmPas, UserDefFrmPas, TypeDisplayFrmPas,
  TypeCodeEditFrmPas, R20AvionicsFrmPas, SqdFrmPas;

type

  { TMainFrm }

  TMainFrm = class(THgsForm)
    AltCrewRulesRadGrp: TRadioGroup;
    FlagChkBx: TCheckBox;
    TestChkBox: TCheckBox;
    TestRadGrp: TRadioGroup;
    TestBtn: TButton;
    SqdBtn: TButton;
    ClassEdit: TEdit;
    ClassStatLbl: TLabel;
    HullSpdBtn: TSpeedButton;
    EngSpdBtn: TSpeedButton;
    FuelSpdBtn: TSpeedButton;
    AviSpdBtn: TSpeedButton;
    BigBaySpdBtn: TSpeedButton;
    LittleBaySpdBtn: TSpeedButton;
    ScreensSpdBtn: TSpeedButton;
    CraftSpdBtn: TSpeedButton;
    AccomSpdBtn: TSpeedButton;
    UserDefSpdBtn: TSpeedButton;
    OptionsSpdBt: TSpeedButton;
    TurretSpdBtn: TSpeedButton;
    SpinalSpdBtn: TSpeedButton;
    TypeStatLbl: TLabel;
    TypeEdit: TEdit;
    TechStatLbl: TLabel;
    TechLevelEdit: TEdit;
    CodeStatLbl: TLabel;
    CodeEdit: TEdit;
    ArchStatLbl: TLabel;
    ArchEdit: TEdit;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    ExitMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    NewMenuItem: TMenuItem;
    EditMenu: TMenuItem;
    PasteMenuItem: TMenuItem;
    CopyMenuItem: TMenuItem;
    CutMenuItem: TMenuItem;
    UndoMenuItem: TMenuItem;
    HelpMenu: TMenuItem;
    AboutMenuItem: TMenuItem;
    ImageList: TImageList;
    ActionList: TActionList;
    EditCopy: TEditCopy;
    EditCut: TEditCut;
    EditPaste: TEditPaste;
    EditUndo: TEditUndo;
    ShipFrmBtn: TButton;
    TonnageStatLbl: TLabel;
    BudgetStatLbl: TLabel;
    TonnageEdit: TEdit;
    BudgetEdit: TEdit;
    TonsRemLbl: TLabel;
    BudRemLbl: TLabel;
    EPLbl: TLabel;
    EPRemLbl: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    RaceRadGrp: TRadioGroup;
    CommitBtn: TButton;
    ResetBtn: TButton;
    ShipNameStatLbl: TLabel;
    ShipNameEdit: TEdit;
    CrewTypeRadGrp: TRadioGroup;
    RestoreMenuItem: TMenuItem;
    ExportUSPMenuItem: TMenuItem;
    N2: TMenuItem;
    DefaultsMenuItem: TMenuItem;
    ExportDialog: TSaveDialog;
    CheckDesignMenuItem: TMenuItem;
    DesignMenu: TMenuItem;
    HullMenuItem: TMenuItem;
    EngMenuItem: TMenuItem;
    FuelMenuItem: TMenuItem;
    AvionicsMenuItem: TMenuItem;
    WeaponsMenuitem: TMenuItem;
    ScreensMenuItem: TMenuItem;
    CraftMenuItem: TMenuItem;
    AccomMenuItem: TMenuItem;
    SpinalMountSubMenuItem: TMenuItem;
    BigBaysSubMenuItem: TMenuItem;
    LittleBaysSubMenuItem: TMenuItem;
    TurretsSubMenuItem: TMenuItem;
    N3: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    HelpMenuItem: TMenuItem;
    AgilityLbl: TLabel;
    ValidLbl: TLabel;
    TestLbl: TLabel;
    OptionsMenuItem: TMenuItem;
    OptionalLbl: TLabel;
    DescExpDialog: TSaveDialog;
    N1: TMenuItem;
    TxtExpMenuItem: TMenuItem;
    CommentsBtn: TButton;
    DesRulesRadGrp: TRadioGroup;
    UserMenuItem: TMenuItem;
    N4: TMenuItem;
    ClearAllMenuItem: TMenuItem;
    EPStatLbl: TLabel;
    EPRemStatLbl: TLabel;
    TonsRemStatLbl: TLabel;
    BudRemStatLbl: TLabel;
    AgilityStatLbl: TLabel;
    RefitTechEdit: TEdit;
    RefitTechLbl: TLabel;
    RefitMenuItem: TMenuItem;
    RefitBudgetEdit: TEdit;
    RefitBudgetLbl: TLabel;
    RefRemStatLbl: TLabel;
    RefRemLbl: TLabel;
    CmpExpMenuItem: TMenuItem;
    CompExpDialog: TSaveDialog;
    procedure AltCrewRulesRadGrpClick(Sender: TObject);
    procedure FlagChkBxChange(Sender: TObject);
    procedure ShipFrmBtnClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResetBtnClick(Sender: TObject);
    procedure CommitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CrewTypeRadGrpClick(Sender: TObject);
    procedure SqdBtnClick(Sender: TObject);
    procedure TestBtnClick(Sender: TObject);
    procedure TonnageEditChange(Sender: TObject);
    procedure RestoreMenuItemClick(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure DefaultsMenuItemClick(Sender: TObject);
    procedure ExportUSPMenuItemClick(Sender: TObject);
    procedure ShipNameEditChange(Sender: TObject);
    procedure BudgetEditChange(Sender: TObject);
    procedure TechLevelEditChange(Sender: TObject);
    procedure CheckDesignMenuItemClick(Sender: TObject);
    procedure HullMenuItemClick(Sender: TObject);
    procedure EngMenuItemClick(Sender: TObject);
    procedure FuelMenuItemClick(Sender: TObject);
    procedure AvionicsMenuItemClick(Sender: TObject);
    procedure SpinalMountSubMenuItemClick(Sender: TObject);
    procedure BigBaysSubMenuItemClick(Sender: TObject);
    procedure LittleBaysSubMenuItemClick(Sender: TObject);
    procedure TurretsSubMenuItemClick(Sender: TObject);
    procedure ScreensMenuItemClick(Sender: TObject);
    procedure CraftMenuItemClick(Sender: TObject);
    procedure AccomMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure HelpMenuItemClick(Sender: TObject);
    procedure OptionsMenuItemClick(Sender: TObject);
    procedure TxtExpMenuItemClick(Sender: TObject);
    procedure CommentsBtnClick(Sender: TObject);
    procedure DesRulesRadGrpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UserMenuItemClick(Sender: TObject);
    procedure TonnageEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BudgetEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TechLevelEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CodeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClassEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TypeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClearAllMenuItemClick(Sender: TObject);
    procedure RefitTechEditChange(Sender: TObject);
    procedure RefitMenuItemClick(Sender: TObject);
    procedure RefitTechEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RefitBudgetEditChange(Sender: TObject);
    procedure RefitBudgetEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmpExpMenuItemClick(Sender: TObject);
  private
    FTargetFile: String;
    FTestingBuild: Boolean;
    procedure SetTargetFile(const AValue: String);
    procedure SetTestingBuild(const AValue: Boolean);
    function OptionalRulesUsed: Boolean;
  public
    { Public declarations }
    property TargetFile: String read FTargetFile write SetTargetFile;
    property TestingBuild: Boolean read FTestingBuild write SetTestingBuild;
    procedure RefreshForm;
    procedure LoadThisShip(TheFile: String);
    function TrapErrors : Boolean;
    function ErrorMessage(TheError : Integer) : String;
  private
    { Private declarations }
    ClearShip : Boolean;
    function InvalidDesign : TStringList;
    function Confirm(TheMessage: String): Boolean;
    function GenerateShipDetails : String;
    procedure CommitChanges;
    procedure UncheckedCommit;
    procedure Test;
    procedure CreateTypeCodeFile;
    procedure SyncCode;
    procedure SyncType;
    procedure BlankShip;
end;

const
   mbYesNo = [mbYes, mbNo];  //use this for the yes/no dialog box
   SEP = Char(',');
   TEXTMARK = Char('"');
var
  MainFrm: TMainFrm;

implementation

{$R *.lfm}

procedure TMainFrm.ShipFrmBtnClick(Sender: TObject);
//check to see if there are any unapplied changes then show the ship data form

var
  ShipFrm : TShipFrm;
begin
  if (CommitBtn.Enabled) or (ResetBtn.Enabled) then
  begin
    if (Confirm('Your Changes have not been applied.' +
        ' Do you wish to Apply them now?')) then
    begin
      CommitChanges;
      ShipFrm := TShipFrm.Create(self);
      ShipFrm.ShowModal;
    end;
  end
  else
  begin
    ShipFrm := TShipFrm.Create(self);
    ShipFrm.ShowModal;
  end;
end;

procedure TMainFrm.AltCrewRulesRadGrpClick(Sender: TObject);
begin
   CommitBtn.Enabled := True;
   ResetBtn.Enabled := True;
   DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.FlagChkBxChange(Sender: TObject);
begin
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.ExitMenuItemClick(Sender: TObject);
//Check to see if the design is valid and has been saved then quit

begin
   if (Ship.DesignIsValid(1000) > 0) then begin
      if (Confirm('Invalid Design. ' + ErrorMessage(Ship.DesignIsValid(1000)) + ' Do you wish to Quit')) then begin
         Close;
      end
      else begin
         exit;
      end;
   end
   else begin
      if (Confirm('Do you wish to Quit')) then begin
         Close;
      end
   end;
end;

procedure TMainFrm.AboutMenuItemClick(Sender: TObject);
//display the about box

Var
   AboutBox: TAboutBoxFrm;
begin
   AboutBox := TAboutBoxFrm.Create(self);
   AboutBox.ShowModal;
end;

procedure TMainFrm.OpenMenuItemClick(Sender: TObject);
//Open a new ship file

begin
   if (Ship.HasChanged) then begin
      if (Confirm('Changes have not been saved, do you wish to save now?')) then begin
         SaveMenuItemClick(Self);
      end;
   end;
   OpenDialog.Options := [ofCreatePrompt];
   if (OpenDialog.Execute) then begin
      TargetFile := OpenDialog.FileName;
      if (Ship.ValidFile(TargetFile)) then begin
         Ship.ResetAllCrew;
         Ship.ReadFromFile(TargetFile);
         RefreshForm;
         SaveMenuItem.Enabled := False;
         RestoreMenuItem.Enabled := False;
      end
      else begin
         MessageDlg('Invalid File', mtError, [mbOk], 0);
      end;
   end;
   RefitMenuItem.Enabled := not Ship.IsRefitted;
end;

procedure TMainFrm.SaveMenuItemClick(Sender: TObject);
//check to see if a save file has been set and save the ship

begin
   if (TargetFile = '') then begin
      SaveAsMenuItemClick(Self);
   end
   else begin
      Ship.WriteToFile(TargetFile);
      Ship.HasChanged := False;
      SaveMenuItem.Enabled := False;
      RestoreMenuItem.Enabled := False;
   end;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
//clear the target file, set the crew radbox disable save and restore

var
  iTech : Integer;
begin
  TestingBuild := False;
  TestBtn.Visible := TestingBuild;
  TestLbl.Visible := TestingBuild;
  TestRadGrp.Visible := TestingBuild;
  TestChkBox.Visible := TestingBuild;
  DesRulesRadGrp.Items.Clear;
  DesRulesRadGrp.Items.Add('T20');
  DesRulesRadGrp.Items.Add('High Guard');
  Ship := TShip.Create;
  ClearShip := False;
  //if the program is sent a file name open it
  if (UpperCase(ParamStr(1)) = 'T20') then
  begin
    DesRulesRadGrp.Enabled := True;
    TargetFile := '';
  end
  else if (ParamStr(1) <> '') then
  begin
    //DesRulesRadGrp.Enabled := False;
    DesRulesRadGrp.Enabled := True;
    TargetFile := ParamStr(1);
    if (Ship.ValidFile(TargetFile)) then
    begin
      Ship.ResetAllCrew;
      Ship.ReadFromFile(TargetFile);
      RefreshForm;
      SaveMenuItem.Enabled := False;
      RestoreMenuItem.Enabled := False;
    end
    else
    begin
      MessageDlg('Invalid File', mtError, [mbOk], 0);
      TargetFile := '';
    end;
  end
  else
  begin
    //DesRulesRadGrp.Enabled := False;
    DesRulesRadGrp.Enabled := True;
    TargetFile := '';
  end;
  RefreshForm;
  if (Ship.Tonnage > 1000) then
  begin
    CrewTypeRadGrp.ItemIndex := 1;
    CrewTypeRadGrp.Enabled := False;
  end;
  SaveMenuItem.Enabled := False;
  RestoreMenuItem.Enabled := False;
  //if the ship is not refitted then disable and hide the RefitTechEdit box
  if not (Ship.IsRefitted) then
  begin
    RefitTechEdit.Enabled := False;
    RefitTechEdit.Visible := False;
    RefitTechLbl.Visible := False;
    RefitBudgetEdit.Enabled := False;
    RefitBudgetEdit.Visible := False;
    RefitBudgetLbl.Visible := False;
    RefRemStatLbl.Visible := False;
    RefRemLbl.Visible := False;
  end;
end;

procedure TMainFrm.RefreshForm;
//refresh all the display elements, check if the ship is valid (hint first error)
//and display if optional rules are being used

begin
  //get the details from the ship
  ShipNameEdit.Text := Ship.ShipName;
  ArchEdit.Text := Ship.Architect;
  ClassEdit.Text := Ship.ShipClass;
  TypeEdit.Text := Ship.ShipType;
  TonnageEdit.Text := FloatToStrF(Ship.Tonnage, ffNumber, 18, 3);//here
  BudgetEdit.Text := FloatToStrF(Ship.Budget, ffNumber, 18, 3);//Here
  EPLbl.Caption := FloatToStrF(Ship.Eng.Power, ffNumber, 18, 3);
  CodeEdit.Text := Ship.ShipCode;
  TechLevelEdit.Text := IntToStr(Ship.TechLevel);
  TonsRemLbl.Caption := FloatToStrF(Ship.GetRemTonnage, ffNumber, 18, 3);
  BudRemLbl.Caption := FloatToStrF(Ship.GetRemBudget, ffNumber, 18, 3);
  EPRemLbl.Caption := FloatToStrF(Ship.GetRemPower, ffNumber, 18, 3);
  RaceRadGrp.ItemIndex := Ship.ShipRace;
  CrewTypeRadGrp.ItemIndex := Ship.CrewRules;
  FlagChkBx.Checked := Ship.Flagship;
  //temp value
  AltCrewRulesRadGrp.ItemIndex := Ship.AlternateCrewRules;

  //if the ship is refitted show the RefitTechEdit, disable tonnage, tech level
  //and design rules
  if (Ship.IsRefitted) then
  begin
    RefitTechEdit.Text := IntToStr(Ship.RefitTechLevel);
    RefitTechEdit.Enabled := True;
    RefitTechEdit.Visible := True;
    RefitTechEdit.Left := TechLevelEdit.Left;
    RefitTechEdit.Top := TechLevelEdit.Top + 24;
    RefitTechLbl.Visible := True;
    RefitTechLbl.Left := TechStatLbl.Left;
    RefitTechLbl.Top := TechStatLbl.Top + 24;
    RefitBudgetEdit.Text := FloatToStrF(Ship.RefitBudget, ffNumber, 18, 3);
    RefitBudgetEdit.Enabled := True;
    RefitBudgetEdit.Visible := True;
    RefitBudgetEdit.Left := BudgetEdit.Left;
    RefitBudgetEdit.Top := BudgetEdit.Top + 24;
    RefitBudgetLbl.Visible := True;
    RefitBudgetLbl.Left := BudgetStatLbl.Left;
    RefitBudgetLbl.Top := BudgetStatLbl.Top + 24;
    RefRemStatLbl.Visible := True;
    RefRemStatLbl.Left := BudRemStatLbl.Left;
    RefRemStatLbl.Top := BudRemStatLbl.Top + 24;   RefRemLbl.Visible := True;
    RefRemLbl.Visible := True;
    RefRemLbl.Left := BudRemLbl.Left;
    RefRemLbl.Top := BudRemLbl.Top + 24;   RefRemLbl.Visible := True;
    RefRemLbl.Caption := FloatToStrF(Ship.GetRemRefitBudget, ffNumber, 18, 3);
    TonnageEdit.Enabled := False;
    TechLevelEdit.Enabled := False;
    BudgetEdit.Enabled := False;
    DesRulesRadGrp.Enabled := False;
  end
  else
  begin
    RefitTechEdit.Text := IntToStr(Ship.RefitTechLevel);
    RefitTechEdit.Enabled := False;
    RefitTechEdit.Visible := False;
    RefitTechLbl.Visible := False;
    RefitBudgetEdit.Text := FloatToStrF(Ship.RefitBudget, ffNumber, 18, 3);
    RefitBudgetEdit.Enabled := False;
    RefitBudgetEdit.Visible := False;
    RefitBudgetLbl.Visible := False;
    RefRemStatLbl.Visible := False;
    RefRemLbl.Visible := False;
    TonnageEdit.Enabled := True;
    TechLevelEdit.Enabled := True;
    BudgetEdit.Enabled := True;
    DesRulesRadGrp.Enabled := True;
  end;
  //if clearing all values set remainder and agility labels to zero
  if (ClearShip) then
  begin
    TonsRemLbl.Caption := '0';
    BudRemLbl.Caption := '0';
    AgilityLbl.Caption := '0';
  end
  else
  begin
    AgilityLbl.Caption := IntToStr(Ship.Agility);
  end;
  DesRulesRadGrp.ItemIndex := Ship.DesignRules;

  //disable the commit and reset buttons. Enable the set as default option
  CommitBtn.Enabled := False;
  ResetBtn.Enabled := False;
  DefaultsMenuItem.Enabled := True;

  //check for validity and optional rules
  if (Ship.DesignIsValid(1000) > 0) then
  begin
    ValidLbl.Caption := 'INVALID DESIGN';
    ValidLbl.ShowHint := True;
    ValidLbl.Hint := ErrorMessage(Ship.DesignIsValid(1000));
  end
  else
  begin
    ValidLbl.Caption := '';
    ValidLbl.ShowHint := False;
    ValidLbl.Hint := '';
  end;
  if (OptionalRulesUsed) then
  begin
    OptionalLbl.Caption := 'OPTIONAL RULES USED';
    OptionalLbl.ShowHint := True;
  end
  else
  begin
    OptionalLbl.Caption := '';
  end;
//   Test;  //use this for running a test routine
end;

procedure TMainFrm.LoadThisShip(TheFile: String);
begin
  Ship.ReadFromFile(TheFile);
  RefreshForm;
end;

procedure TMainFrm.CommitChanges;
//store the existing values in temp vars, send the new values to the ship.
//check if changes are valid. If not restore old values. Capture design has
//changed

var
   TmpShipName, TmpArch, TmpClass, TmpType, TmpCode : String;
   TmpTonnage, TmpBudget, TmpRefitBudget : Extended;
   TmpTechLevel, TmpRace, TmpCrewType, TmpRefitTech : integer;
begin
   //store the present values
   TmpShipName := Ship.ShipName;
   TmpArch := Ship.Architect;
   TmpClass := Ship.ShipClass;
   TmpType := Ship.ShipType;
   TmpTonnage := Ship.Tonnage;
   TmpBudget := Ship.Budget;
   TmpCode := Ship.ShipCode;
   TmpTechLevel := Ship.TechLevel;
   TmpRace := Ship.ShipRace;
   TmpCrewType := Ship.CrewRules;
   TmpRefitTech := Ship.RefitTechLevel;
   TmpRefitBudget := Ship.RefitBudget;

   //send the current values to ship
   Ship.ShipName := ShipNameEdit.Text;
   Ship.Architect := ArchEdit.Text;
   Ship.ShipClass := ClassEdit.Text;
   Ship.ShipType := TypeEdit.Text;
   Ship.Tonnage := StrToFloat(RemoveCommas(TonnageEdit.Text));
   Ship.Budget := StrToFloat(RemoveCommas(BudgetEdit.Text));
   Ship.ShipCode := CodeEdit.Text;
   Ship.TechLevel := StrToInt(TechLevelEdit.Text);
   Ship.ShipRace := RaceRadGrp.ItemIndex;
   Ship.CrewRules := CrewTypeRadGrp.ItemIndex;
   Ship.RefitTechLevel := StrToInt(RefitTechEdit.Text);
   Ship.RefitBudget := StrToFloat(RemoveCommas(RefitBudgetEdit.Text));
   Ship.DesignShip;

   //if the new values result in an invalid design ask if the user wished to
   //revert to the previous values
   if (Ship.DesignIsValid(1000) > 0) then begin
      if (Confirm('This is an invalid design. Do you wish to revert to the previously stored version?')) then begin
         Ship.ShipName := TmpShipName;
         Ship.Architect := TmpArch;
         Ship.ShipClass := TmpClass;
         Ship.ShipType := TmpType;
         Ship.Tonnage := TmpTonnage;
         Ship.Budget := TmpBudget;
         Ship.ShipCode := TmpCode;
         Ship.TechLevel := TmpTechLevel;
         Ship.ShipRace := TmpRace;
         Ship.CrewRules := TmpCrewType;
         Ship.RefitTechLevel := TmpRefitTech;
         Ship.RefitBudget := TmpRefitBudget;
         Ship.DesignShip;
         RefreshForm;
         Exit;
      end;
   end;

   //refresh the form and note that the ship has changed
   //Enable save and restore
   RefreshForm;
   Ship.HasChanged := True;
   SaveMenuItem.Enabled := True;
   RestoreMenuItem.Enabled := True;
end;

procedure TMainFrm.ResetBtnClick(Sender: TObject);
//restore values from ship

begin
  RefreshForm;
end;

procedure TMainFrm.CommitBtnClick(Sender: TObject);
//send the new values to the ship

begin
  if (TrapErrors) then begin
    exit;
  end;
//   CommitChanges;
  UncheckedCommit;
  RefreshForm;
end;

function TMainFrm.TrapErrors: Boolean;
//find errors in the data on the form

begin
  Result := False;

  //do all fields have data
  if (ShipNameEdit.Text = '') then
  begin
    MessageDlg('No Ship Name Entered', mtWarning, [mbOk], 0);
  end;
  if (ClassEdit.Text = '') then
  begin
    MessageDlg('No Class Name Entered', mtWarning, [mbOk], 0);
  end;
  if (TypeEdit.Text = '') then
  begin
    MessageDlg('No Ship Type Entered', mtWarning, [mbOk], 0);
  end;
  if (ArchEdit.Text = '') then
  begin
    MessageDlg('No Architect Entered', mtWarning, [mbOk], 0);
  end;
  if (CodeEdit.Text = '') then
  begin
    MessageDlg('No Ship Code Entered', mtWarning, [mbOk], 0);
  end;
  if (TechLevelEdit.Text = '') then
  begin
    MessageDlg('No Tech Level Entered', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (TonnageEdit.Text = '') then
  begin
    MessageDlg('No Tonnage Entered', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (BudgetEdit.Text = '') then
  begin
    MessageDlg('No Budget Entered', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (RaceRadGrp.ItemIndex = -1) then
  begin
    MessageDlg('No Race Selected', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (CrewTypeRadGrp.ItemIndex = -1) then
  begin
    MessageDlg('Crew Type Not Selected', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //only check the RefitTechEdit box if the ship has been refitted
  if (Ship.IsRefitted) then
  begin
    if (RefitTechEdit.Text = '') then
    begin
      MessageDlg('No Refit Tech Level Entered', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
    if (RefitBudgetEdit.Text = '') then
    begin
      MessageDlg('No Refit Budget Entered', mtError, [mbOk], 0);
      Result := True;
      Exit;
    end;
  end;

  //is the tech level sufficent to build a ship (7)
  if (StrToInt(TechLevelEdit.Text) < 7) then
  begin
    MessageDlg('Ships may not be constructed below Tech Level 7', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;

  //are there real numbers where there should be real numbers
  //remember to remove the commas
  if (StrToFloatDef(RemoveCommas(TonnageEdit.Text), 2) = 2)
      and (StrToFloatDef(RemoveCommas(TonnageEdit.Text), 3) = 3) then
  begin
    MessageDlg('Tonnage must be a Floating Point Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToFloatDef(RemoveCommas(BudgetEdit.Text), 2) = 2)
      and (StrToFloatDef(RemoveCommas(BudgetEdit.Text), 3) = 3) then
  begin
    MessageDlg('Budget must be a Floating Point Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    if (StrToFloatDef(RemoveCommas(RefitBudgetEdit.Text), 2) = 2)
        and (StrToFloatDef(RemoveCommas(RefitBudgetEdit.Text), 3) = 3) then
    begin
      MessageDlg('Refit Budget must be a Floating Point Value', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
  if (StrToFloat(RemoveCommas(TonnageEdit.Text)) < 0) then
  begin
    MessageDlg('Tonnage may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (StrToFloat(RemoveCommas(BudgetEdit.Text)) < 0) then
  begin
    MessageDlg('Budget may not be a Negative Number', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  if (Ship.IsRefitted) then
  begin
    if (StrToFloat(RemoveCommas(RefitBudgetEdit.Text)) < 0) then
    begin
      MessageDlg('Refit Budget may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;

  //are there integers where there should be integers
  if (StrToIntDef(TechLevelEdit.Text, 3) = 3)
      and (StrToIntDef(TechLevelEdit.Text, 2) = 2) then
  begin
    MessageDlg('Tech Level must be an Integer Value', mtError, [mbOk], 0);
    Result := True;
    exit;
  end;
  //only check the RefitTechEdit box if ship has been refitted
  if (Ship.IsRefitted) then
  begin
    if (StrToIntDef(RefitTechEdit.Text, 3) = 3)
        and (StrToIntDef(RefitTechEdit.Text, 2) = 2) then
    begin
      MessageDlg('The Refit Tech Level must be an Integer Value', mtError, [mbOk], 0);
      Result := True;
      exit;
    end;
  end;
end;

function TMainFrm.Confirm(TheMessage: String): Boolean;
//display a message and allow the user to make a yes/no choice

begin
   if (MessageDlg(TheMessage, mtConfirmation, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//check to see if the design is valid, if not tell the user and ask if they
//want to save. If valid and unsaved ask if they want to save. Finally quit

begin
   if (Ship.DesignIsValid(1000) > 0) then begin
      if (Ship.HasChanged) then begin
         if (Confirm('Invalid Design. ' + ErrorMessage(Ship.DesignIsValid(1000)) + ' Do you wish to Save your Changes')) then begin
            SaveMenuItemClick(Self);
         end;
      end
      else begin
         MessageDlg('Invalid Design. ' + ErrorMessage(Ship.DesignIsValid(1000)), mtInformation, [mbOk], 0);
      end;
   end
   else if (Ship.HasChanged) then begin
      if (Confirm('Do you wish to Save your Changes')) then begin
         SaveMenuItemClick(Self);
      end;
   end;
   FreeAndNil(Ship);
end;

function TMainFrm.InvalidDesign: TStringList;
//construct a list of all design errors

var
   Data : TData;
   ErrorList : TStringList;
   CurrentError : Integer;
begin
//   MessageDlg('This menu item is undergoing revision', mtInformation, [mbOk], 0);

   Data := TData.Create;
   ErrorList := TStringList.Create;
   try
      Data.InitialiseData;
      CurrentError := 106;
      While (CurrentError < 109) do begin  //108 errors so stop loop before 109
         if (Ship.DesignIsValid(CurrentError + 1) > 0) then begin
            CurrentError := Ship.DesignIsValid(CurrentError + 1);
            ErrorList.Add(ErrorMessage(CurrentError));
         end;
      end;
      Result := ErrorList;
   finally
      FreeAndNil(Data);
      FreeAndNil(ErrorList);
   end;
end;

procedure TMainFrm.CrewTypeRadGrpClick(Sender: TObject);
//check to see the bk2 rules can be used. If not reset to bk5 and disable the
//button

begin
  if (StrToFloat(RemoveCommas(TonnageEdit.Text)) > 1000)
      and (CrewTypeRadGrp.ItemIndex = 0) then
  begin
    if (Confirm('Book 2 Crew Rules should not be used for ships over 1000 Tons'
         + #13 + 'Do you wish to alter this?')) then
    begin
       CrewTypeRadGrp.ItemIndex := 1;
     end;
  end;
  if (StrToFloat(RemoveCommas(TonnageEdit.Text)) < 100)
      and (CrewTypeRadGrp.ItemIndex = 0) then
  begin
    if (Confirm('Book 5 Crew Rules are recommended for Small Craft'
        + #13 + 'Do you wish to alter this?')) then
    begin
      CrewTypeRadGrp.ItemIndex := 0;
    end;
  end;
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.SqdBtnClick(Sender: TObject);
begin
  if (CommitBtn.Enabled) or (ResetBtn.Enabled) then
  begin
    if (Confirm('Your Changes have not been applied.' +
        ' Do you wish to Apply them now?')) then
    begin
      CommitChanges;
      SqdFrm := TSqdFrm.Create(self);
      SqdFrm.Show;
    end;
  end
  else
  begin
    SqdFrm := TSqdFrm.Create(self);
    SqdFrm.Show;
  end;
end;

procedure TMainFrm.TestBtnClick(Sender: TObject);
begin
//this button is for testing make sure its invisible in releaases

end;

procedure TMainFrm.Test;
//use this to test things

begin
   //
end;

procedure TMainFrm.TonnageEditChange(Sender: TObject);
//capture errors and set the crew rules radio box to match the tonnage

begin
  if (TonnageEdit.Text = '') then
  begin
    abort;
  end;
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
  if (StrToFloat(RemoveCommas(TonnageEdit.Text)) > 5000) then
  begin
    CrewTypeRadGrp.ItemIndex := 1;
    CrewTypeRadGrp.Enabled := False;
  end
  else if (StrToFloat(RemoveCommas(TonnageEdit.Text)) > 1000) then
  begin
    CrewTypeRadGrp.ItemIndex := 1;
    CrewTypeRadGrp.Enabled := True;
  end
  else if (StrToFloat(RemoveCommas(TonnageEdit.Text)) <= 1000)
      and (StrToFloat(RemoveCommas(TonnageEdit.Text)) >= 100) then
  begin
    CrewTypeRadGrp.ItemIndex := 0;
    CrewTypeRadGrp.Enabled := False
  end
  //removed 29/11/2001    readded in altered form 2/11/2011
  else if (StrToFloat(RemoveCommas(TonnageEdit.Text)) < 100) then
  begin
    CrewTypeRadGrp.ItemIndex := 1;
    CrewTypeRadGrp.Enabled := True;
  end
  else
  begin
    CrewTypeRadGrp.ItemIndex := Ship.CrewRules;
    CrewTypeRadGrp.Enabled := True;
  end;
end;

procedure TMainFrm.RestoreMenuItemClick(Sender: TObject);
//restore the ship from the last saved version. NOTE if no save file set,
//take the data from the default file

begin
   //read from the default ship or backup if corrupt
   if (TargetFile = '') then begin
      if (Ship.ValidFile(Ship.HomeDir + 'Hg')) then begin
         Ship.ReadFromFile(Ship.HomeDir + 'Hg');
         RefreshForm;
         Ship.HasChanged := False;
         SaveMenuItem.Enabled := False;
         RestoreMenuItem.Enabled := False;
      end
      else if (Ship.ValidFile(Ship.HomeDir + 'Hg.bak')) then begin
         Ship.ReadFromFile(Ship.HomeDir + 'Hg.bak');
         RefreshForm;
         Ship.HasChanged := False;
         SaveMenuItem.Enabled := False;
         RestoreMenuItem.Enabled := False;
      end
      else begin
         MessageDlg('The defaults file and backup are corrupt,' +
               ' unable to complete request', mtError, [mbOk], 0);
      end;
   end
   else begin
      if (Ship.ValidFile(TargetFile)) then begin
         Ship.ReadFromFile(TargetFile);
         RefreshForm;
         Ship.HasChanged := False;
         SaveMenuItem.Enabled := False;
         RestoreMenuItem.Enabled := False;
      end
      else begin
         MessageDlg('The file you last saved is corrupt,' +
               ' unable to complete request', mtError, [mbOk], 0);
      end;
   end;
end;

procedure TMainFrm.NewMenuItemClick(Sender: TObject);
//save the ship if unsaved then reset the ship from the defaults file

begin
   if (Ship.HasChanged) then begin
      if (Confirm('Changes have not been saved, do you wish to save now?')) then begin
         SaveMenuItemClick(Self);
      end;
   end;
   Ship.ResetAllCrew;
   Ship.ReadFromFile(Ship.HomeDir + 'Hg');
   TargetFile := '';
   RefreshForm;
   SaveMenuItem.Enabled := False;
   RestoreMenuItem.Enabled := False;
   RefitMenuItem.Enabled := not Ship.IsRefitted;
end;

procedure TMainFrm.DefaultsMenuItemClick(Sender: TObject);
//set the current ship as default

begin
   if (Confirm('This will make the current design the default.' +
         ' Do you wish to do this?')) then begin
      Ship.WriteToFile(Ship.HomeDir + 'Hg');
   end;
end;

procedure TMainFrm.ExportUSPMenuItemClick(Sender: TObject);
//export the ship USP as flat text

begin
   ExportDialog.Options := [ofOverwritePrompt, ofNoReadOnlyReturn];
   ExportDialog.FileName := Ship.ShipClass;
   if (ExportDialog.Execute) then begin
      Ship.GenerateUSP;
      Ship.USP.SaveToFile(ExportDialog.FileName);
//      Ship.ExportUsp(ExportDialog.FileName);
   end;
end;

procedure TMainFrm.ShipNameEditChange(Sender: TObject);
//No errors to trap. Enable commit and reset. Disable make default

begin
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.BudgetEditChange(Sender: TObject);
//diasable trap errors. Enable commit and reset. Disable make default

begin
  if (BudgetEdit.Text = '') then begin
    abort;
  end;
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.TechLevelEditChange(Sender: TObject);
//diasable trap errors. Enable commit and reset. Disable make default
{ TODO : Fix invalid integer error }

begin
  with TechLevelEdit do
  begin
    if (Text = '') then
    begin
      abort;
    end;
  end;
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.CheckDesignMenuItemClick(Sender: TObject);
//check to see if the design is valid
//1.1 revision. Change this to display a list of all errors

var
   ErrorFrm : TErrorFrm;
begin
   if (Ship.DesignIsValid(1000) < 1) then begin //invalid design will display the message
      MessageDlg('Design is Valid', mtInformation, [mbOk], 0);
   end
   else begin
      ErrorFrm := TErrorFrm.Create(self);
      ErrorFrm.ShowModal;
   end;
end;

procedure TMainFrm.UncheckedCommit;
//commit the changes withour checking for a valid design

begin
   Ship.ShipName := ShipNameEdit.Text;
   Ship.Architect := ArchEdit.Text;
   Ship.ShipClass := ClassEdit.Text;
   Ship.ShipType := TypeEdit.Text;
   Ship.Tonnage := StrToFloat(RemoveCommas(TonnageEdit.Text));
   Ship.Budget := StrToFloat(RemoveCommas(BudgetEdit.Text));
   Ship.ShipCode := CodeEdit.Text;
   Ship.TechLevel := StrToInt(TechLevelEdit.Text);
   Ship.ShipRace := RaceRadGrp.ItemIndex;
   Ship.CrewRules := CrewTypeRadGrp.ItemIndex;
   Ship.DesignRules := DesRulesRadGrp.ItemIndex;
   Ship.RefitTechLevel := StrToInt(RefitTechEdit.Text);
   Ship.SetEngRefitTech(Ship.RefitTechLevel);
   Ship.RefitBudget := StrToFloat(RemoveCommas(RefitBudgetEdit.Text));
   Ship.AlternateCrewRules := AltCrewRulesRadGrp.ItemIndex;
   Ship.Flagship := FlagChkBx.Checked;
   if not (Ship.Flagship) and (Ship.Avionics.FlagBridge) then
   begin
     Ship.Avionics.FlagBridge := False;
   end;
   if (Ship.IsRefitted) then
   begin
     if not (Ship.Flagship) and (Ship.Avionics.NewFlagComp <> 0) then
     begin
       Ship.Avionics.NewFlagComp := 0;
     end;
   end
   else
   begin
     if not (Ship.Flagship) and (Ship.Avionics.FlagComp <> 0) then
     begin
       Ship.Avionics.FlagComp := 0;
     end;
   end;
   Ship.DesignShip;
   RefreshForm;
   Ship.HasChanged := True;
   SaveMenuItem.Enabled := True;
   RestoreMenuItem.Enabled := True;
end;

procedure TMainFrm.HullMenuItemClick(Sender: TObject);
//go to the hull form

var
   HullFrm : THullFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         //UncheckedCommit;
         CommitChanges;
         HullFrm := THullFrm.Create(self);
         HullFrm.ShowModal;
      end;
   end
   else begin
      HullFrm := THullFrm.Create(self);
      HullFrm.ShowModal;
   end;
end;

procedure TMainFrm.EngMenuItemClick(Sender: TObject);
//go to the engineering form

var
   EngFrm : TEngFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         EngFrm := TEngFrm.Create(self);
         EngFrm.ShowModal;
      end;
   end
   else begin
      EngFrm := TEngFrm.Create(self);
      EngFrm.ShowModal;
   end;
end;

procedure TMainFrm.FuelMenuItemClick(Sender: TObject);
//go to the fuel form

var
   FuelFrm : TFuelFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         FuelFrm := TFuelFrm.Create(self);
         FuelFrm.ShowModal;
      end;
   end
   else begin
      FuelFrm := TFuelFrm.Create(self);
      FuelFrm.ShowModal;
   end;
end;

procedure TMainFrm.AvionicsMenuItemClick(Sender: TObject);
//go to the avionics form

var
   AvionicsFrm : TAvionicsFrm;
   R20AvionicsFrm : TR20AvionicsFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         if (Ship.DesignRules = 0) then begin
            R20AvionicsFrm := TR20AvionicsFrm.Create(self);
            R20AvionicsFrm.ShowModal;
         end
         else begin
            AvionicsFrm := TAvionicsFrm.Create(self);
            AvionicsFrm.ShowModal;
         end;
      end;
   end
   else begin
      if (Ship.DesignRules = 0) then begin
         R20AvionicsFrm := TR20AvionicsFrm.Create(self);
         R20AvionicsFrm.ShowModal;
      end
      else begin
         AvionicsFrm := TAvionicsFrm.Create(self);
         AvionicsFrm.ShowModal;
      end;
   end;
end;

procedure TMainFrm.SpinalMountSubMenuItemClick(Sender: TObject);
//go to the spinal mount form

var
   SpnlMntFrm : TSpnlMntFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         SpnlMntFrm := TSpnlMntFrm.Create(self);
         SpnlMntFrm.ShowModal;
      end;
   end
   else begin
      SpnlMntFrm := TSpnlMntFrm.Create(self);
      SpnlMntFrm.ShowModal;
   end;
end;

procedure TMainFrm.BigBaysSubMenuItemClick(Sender: TObject);
//go to the 100t bays form

var
   BigBaysFrm : TBigBaysFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         BigBaysFrm := TBigBaysFrm.Create(self);
         BigBaysFrm.ShowModal;
      end;
   end
   else begin
      BigBaysFrm := TBigBaysFrm.Create(self);
      BigBaysFrm.ShowModal;
   end;
end;

procedure TMainFrm.LittleBaysSubMenuItemClick(Sender: TObject);
//go to the 50t bays form

var
   LittleBaysFrm : TLittleBaysFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         LittleBaysFrm := TLittleBaysFrm.Create(self);
         LittleBaysFrm.ShowModal;
      end;
   end
   else begin
      LittleBaysFrm := TLittleBaysFrm.Create(self);
      LittleBaysFrm.ShowModal;
   end;
end;

procedure TMainFrm.TurretsSubMenuItemClick(Sender: TObject);
//go to the turrets form

var
   TurretsFrm : TTurretsFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         TurretsFrm := TTurretsFrm.Create(self);
         TurretsFrm.ShowModal;
      end;
   end
   else begin
      TurretsFrm := TTurretsFrm.Create(self);
      TurretsFrm.ShowModal;
   end;
end;

procedure TMainFrm.ScreensMenuItemClick(Sender: TObject);
//go to the screens form

var
   ScreensFrm : TScreensFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         ScreensFrm := TScreensFrm.Create(self);
         ScreensFrm.ShowModal;
      end;
   end
   else begin
      ScreensFrm := TScreensFrm.Create(self);
      ScreensFrm.ShowModal;
   end;
end;

procedure TMainFrm.CraftMenuItemClick(Sender: TObject);
//go to the craft form

var
  CraftFrm : TCraftFrm;
begin
  if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
    if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
      UncheckedCommit;
      //CommitChanges;
      CraftFrm := TCraftFrm.Create(self);
      CraftFrm.ShowModal;
    end;
  end
  else begin
    CraftFrm := TCraftFrm.Create(self);
    CraftFrm.ShowModal;
  end;
end;

procedure TMainFrm.AccomMenuItemClick(Sender: TObject);
//go to the accomodations form

var
   AccomFrm : TAccomFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         AccomFrm := TAccomFrm.Create(self);
         AccomFrm.ShowModal;
      end;
   end
   else begin
      AccomFrm := TAccomFrm.Create(self);
      AccomFrm.ShowModal;
   end;
end;

procedure TMainFrm.SaveAsMenuItemClick(Sender: TObject);
//save the current form. Ask for file name

begin
//   ShowMessage('This Function is currently disabled');
  SaveDialog.Options := [ofOverwritePrompt, ofNoReadOnlyReturn];
  SaveDialog.FileName := Ship.ShipClass;
  if (SaveDialog.Execute) then
  begin
    TargetFile := SaveDialog.FileName;
    Ship.WriteToFile(TargetFile);
    Ship.HasChanged := False;
    SaveMenuItem.Enabled := False;
    RestoreMenuItem.Enabled := False;
  end;
end;


procedure TMainFrm.HelpMenuItemClick(Sender: TObject);
//get the help file

begin
  Application.HelpFile := 'HGHELP.HLP';
  Application.HelpCommand(HELP_FINDER, 0);
end;

function TMainFrm.ErrorMessage(TheError: Integer): String;
//find the first error display it as a hint

var
   Data : TData;
begin
   Data := TData.Create;
   try
      Data.InitialiseData;
      case (TheError) of
         1 : Result := 'The hull is too small.';
         2 : Result := 'You are over budget.';
         3 : Result := 'Book 2 Crew Rules are only allowed for ships under 1000 Tons.';
         4 : Result := 'This is an Empty Error.';
         5 : Result := 'There are not enough Energy Points (EP).';
         6 : Result := 'Small Craft may not use Planetoid Hulls.';
         7 : Result := 'Armour Added to the hull may not exceed Tech Level.';
         8 : Result := 'Small Craft (Vessels smaller than 100T) may not be fitted with Jump Drive.';
         9 : Result := 'Ships at Tech Level 7 are restricted to Maneuver Drive 2.';
         10 : Result := 'Ships at Tech Level 8 are restricted to Maneuver Drive 5.';
         11 : Result := 'Ships at Tech Level 7 are Restricted to Backup Maneuver Drive 2.';
         12 : Result := 'Ships at Tech Level 8 are Restricted to Backup Maneuver Drive 5.';
         13 : Result := 'Ships Below Tech Level 9 May Not Have Jump Drive.';
         14 : Result := 'Ships Below Tech Level 11 are Restricted to Jump 1.';
         15 : Result := 'Ships Below Tech Level 12 are Restricted to Jump 2.';
         16 : Result := 'Ships Below Tech Level 13 are Restricted to Jump 3.';
         17 : Result := 'Ships Below Tech Level 14 are Restricted to Jump 4.';
         18 : Result := 'Ships Below Tech Level 15 are Restricted to Jump 5.';
         19 : Result := 'Ships Below Tech Level 9 May Not Have Backup Jump Drive.';
         20 : Result := 'Ships Below Tech Level 11 are Restricted to Backup Jump 1.';
         21 : Result := 'Ships Below Tech Level 12 are Restricted to Backup Jump 2.';
         22 : Result := 'Ships Below Tech Level 13 are Restricted to Backup Jump 3.';
         23 : Result := 'Ships Below Tech Level 14 are Restricted to Backup Jump 4.';
         24 : Result := 'Ships Below Tech Level 15 are Restricted to Backup Jump 5.';
         25 : Result := 'Your Power Plant is Smaller than Your Maneuver Drive.';
         26 : Result := 'Your Power Plant is Smaller than Your Jump Drive.';
         27 : Result := 'Unstreamlined Ships may not be Fitted with Fuel Scoops.';
         28 : Result := 'Fuel Purification requires a minimum Tech Level of 8.';
         29 : Result := 'Under Standard Rules, ships require at least 28 days Power Plant Fuel.';
         30 : Result := 'Under Standard Rules, Power Plant Fuel must be in multiples of 28 days.';
         31 : Result := 'Under Standard Rules, ships require at least 28 days Lhyd Power Plant Fuel if it is included.';
         32 : Result := 'Under Standard Rules, Power Plant Fuel must be in multiples of 28 days if it is included.';
         33 : Result := 'Ships with Jump Drive require a Computer.';
         34 : Result := 'A Model/1bis computer or better is required for Jump 2.';
         35 : Result := 'A Model/2bis computer or better is required for Jump 3.';
         36 : Result := 'A Model/4 computer or better is required for Jump 4.';
         37 : Result := 'A Model/5 computer or better is required for Jump 5.';
         38 : Result := 'A Model/6 computer or better is required for Jump 6.';
         39 : Result := 'Small Craft (Vessels under 100T) must be fitted with either a Bridge or a Computer.';
         40 : Result := 'Ships of 100T and over must be fitted with a Bridge.';
         41 : Result := 'Ships of 100T and over must be fitted with a Computer.';
         42 : Result := 'Ships of 600T and over must be fitted with a Model/1 Computer or better.';
         43 : Result := 'Ships of 1000T and over must be fitted with a Model/2 Computer or better.';
         44 : Result := 'Ships of 4000T and over must be fitted with a Model/3 Computer or better.';
         45 : Result := 'Ships of 10,000T and over must be fitted with a Model/4 Computer or better.';
         46 : Result := 'Ships of 50,000T and over must be fitted with a Model/5 Computer or better.';
         47 : Result := 'Ships of 100,000T and over must be fitted with a Model/6 Computer or better.';
         48 : Result := 'Ships of 1,000,000T and over must be fitted with a Model/7 Computer or better.';
         49 : Result := Copy(Data.GetComputerData(7, Ship.Avionics.MainComp), 3, Length(Data.GetComputerData(7, Ship.Avionics.MainComp))) + ' Main Computers require a minimum Tech Level of ' + Data.GetComputerData(5, Ship.Avionics.MainComp) + '.';
         50 : Result := Copy(Data.GetComputerData(7, Ship.Avionics.BakComp), 3, Length(Data.GetComputerData(7, Ship.Avionics.BakComp))) + ' Main Computers require a minimum Tech Level of ' + Data.GetComputerData(5, Ship.Avionics.BakComp) + '.';
         51 : Result := 'There are not enough hardpoints available for the weapons fitted.';
         52 : Result := 'Spinal Meson Guns require a minimum Tech Level of 11.';
         53 : Result := 'Spinal Particle Accelerators require a minimum Tech Level of 8.';
         54 : Result := Data.GetSpnlMesData(1, Ship.SpinalMount.SpinalMount) + ' Gun Spinal Mounts require a minimum Tech Level of ' + Data.GetSpnlMesData(3, Ship.SpinalMount.SpinalMount) + '.';
         55 : Result := Data.GetSpnlPAData(1, Ship.SpinalMount.SpinalMount)[1] + ' Particle Accelerator Spinal Mounts require a minimum Tech Level of ' + Data.GetSpnlPAData(3, Ship.SpinalMount.SpinalMount) + '.';
         56 : Result := '100T Bays require a minimum hull size of 1000T.';
         57 : Result := '100T Meson Gun Bays require a minimum Tech Level of 13.';
         58 : Result := '100T Particle Accelorator Bays require a minimum Tech Level of 8.';
         59 : Result := '100T Repulsor Bays require a minimum Tech Level of 10.';
         60 : Result := '50T Bays require a minimum hull size of 1000T.';
         61 : Result := '50T Bays require a minimum Tech Level of 10.';
         62 : Result := '50T Meson Gun Bays require a minimum Tech Level of 15.';
         63 : Result := '50T Particle Accelorator Bays require a minimum Tech Level of 10.';
         64 : Result := '50T Repulsor Bays require a minimum Tech Level of 14.';
         65 : Result := '50T Missile Bays require a minimum Tech Level of 10.';
         66 : Result := '50T Plasma Gun Bays require a minimum Tech Level of 10.';
         67 : Result := '50T Fusion Gun Bays require a minimum Tech Level of 12.';
//         68 : Result := 'Beam Laser Turrets require a minimum Tech Level of 9.';
         69 : Result := 'Plasma Gun Turrets require a minimum Tech Level of 10.';
         70 : Result := 'Fusion Gun Turrets require a minimum Tech Level of 12.';
         71 : Result := 'Particle Accelerator Barbettes require a minimum Tech Level of 14.';
         72 : Result := 'Beam Laser Turrets require a minimum Tech Level of 9.';
         73 : Result := 'Mixed Turrets are not permitted for ships in excess of 1000 Tons.';
         74 : Result := 'Spinal Meson Guns and 100T Meson Bays may not be included.';
         75 : Result := 'Spinal Meson Guns and 50T Meson Bays may not be included.';
         76 : Result := 'Spinal Particle Accelerators and 100T Particle Accelerator Bays may not be included.';
         77 : Result := 'Spinal Particle Accelerators and 50T Particle Accelerator Bays may not be included.';
         78 : Result := 'Spinal Particle Accelerators and Particle Accelerator Turrets may not be included.';
         79 : Result := '100T and 50T Meson Bays may not be mixed.';
         80 : Result := '100T and 50T Particle Accelerator Bays may not be mixed.';
         81 : Result := '100T and 50T Repulsor Bays may not be mixed.';
         82 : Result := '100T and 50T Missile Bays may not be mixed.';
         83 : Result := '100T Particle Accelerator Bays and Particle Accelerator Turrets may not be mixed.';
         84 : Result := '100T Missile Bays and Missile Turrets may not be mixed.';
         85 : Result := '100T Missile Bays and Missile Turrets may not be mixed.';
         86 : Result := '50T Particle Accelerator Bays and Particle Accelerator Turrets may not be mixed.';
         87 : Result := '50T Missile Bays and Missile Turrets may not be mixed.';
         88 : Result := '50T Missile Bays and Missile Turrets may not be mixed.';
         89 : Result := '50T Energy Bays and Energy Turrets may not be mixed.';
         90 : Result := 'Factor ' + Data.GetNucDampData(1, Ship.Screens.NucDamp) + ' Nuclear Dampers require a minimum Tech Level of ' + Data.GetNucDampData(2, Ship.Screens.NucDamp) + '.';
         91 : Result := 'Factor ' + Data.GetMesScrnData(1, Ship.Screens.MesScrn) + ' Meson Screens require a minimum Tech Level of ' + Data.GetMesScrnData(2, Ship.Screens.MesScrn) + '.';
         92 : Result := 'Factor ' + Data.GetBlkGlbData(1, Ship.Screens.BlkGlb) + ' Black Globes require a minimum Tech Level of ' + Data.GetBlkGlbData(2, Ship.Screens.BlkGlb) + '.';
         93 : Result := 'Factor ' + Data.GetNucDampData(1, Ship.Screens.BakNucDamp) + ' Backup Nuclear Dampers require a minimum Tech Level of ' + Data.GetNucDampData(2, Ship.Screens.BakNucDamp) + '.';
         94 : Result := 'Factor ' + Data.GetMesScrnData(1, Ship.Screens.BakMesScrn) + ' BackUp Meson Screens require a minimum Tech Level of ' + Data.GetMesScrnData(2, Ship.Screens.BakMesScrn) + '.';
         95 : Result := 'Factor ' + Data.GetBlkGlbData(1, Ship.Screens.BakBlkGlb) + ' Backup Black Globes require a minimum Tech Level of ' + Data.GetBlkGlbData(2, Ship.Screens.BakBlkGlb) + '.';
         96 : Result := 'Low Berths require a minimum Tech Level of 9.';
         97 : Result := 'Emergancy Low Berths require a minimum Tech Level of 9.';
         98 : Result := 'Drop Capsules require a minimum Tech Level of 10.';
         99 : Result := 'Insufficent Staterooms.';
         100 : Result := 'Insufficent Couches.';
         101 : Result := 'Insufficent Low Berths.';
         102 : Result := 'Ready Drop Capsules are fitted with no Drop Casules Launchers.';
         103 : Result := 'Stored Drop Capsules are fitted with no Drop Casules Launchers.';
         104 : Result := 'Small Craft Staterooms are not permitted on Non-Small Craft (Vessels under 100T).';
         105 : Result := 'Small Craft Couches are not permitted on Non-Small Craft (Vessels under 100T).';
         106 : Result := 'Staterooms are not permitted on Small Craft (Vessels under 100T).';
         107 : Result := 'Small Craft may not be fitted with Fib or Bis Computers.';
         108 : Result := 'Small Craft may not be fitted with Fib or Bis Backup Computers..';
         else Result := '';
      end;
   finally
      FreeAndNil(Data);
   end;
end;

procedure TMainFrm.OptionsMenuItemClick(Sender: TObject);
//go to the options form

var
   OptionsFrm : TOptionsFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         OptionsFrm := TOptionsFrm.Create(self);
         OptionsFrm.ShowModal;
      end;
   end
   else begin
      OptionsFrm := TOptionsFrm.Create(self);
      OptionsFrm.ShowModal;
   end;
end;

//revision 1.1
procedure TMainFrm.TxtExpMenuItemClick(Sender: TObject);
//export the ship in descriptive text format

begin
   DescExpDialog.Options := [ofOverwritePrompt, ofNoReadOnlyReturn];
   DescExpDialog.FileName := Ship.ShipClass;
   if (DescExpDialog.Execute) then begin
//      Ship.ExportUsp(DescExpDialog.FileName);
      Ship.TextExport(DescExpDialog.FileName);
   end;
end;

procedure TMainFrm.CommentsBtnClick(Sender: TObject);
//go to the comments form

var
   CommentsFrm : TCommentsFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied.' +
            ' Do you wish to Apply them now?')) then begin
         CommitChanges;
         CommentsFrm := TCommentsFrm.Create(self);
         CommentsFrm.ShowModal;
      end;
   end
   else begin
      CommentsFrm := TCommentsFrm.Create(self);
      CommentsFrm.ShowModal;
   end;
end;

procedure TMainFrm.DesRulesRadGrpClick(Sender: TObject);
//No errors to trap. Enable commit and reset. Disable make default

begin
   CommitBtn.Enabled := True;
   ResetBtn.Enabled := True;
   DefaultsMenuItem.Enabled := False;
   if ((Ship.DesignRules = 0) or (DesRulesRadGrp.ItemIndex = 0))
      and (Ship.Options.ChargeForHardpoints <> 1) then
   begin
      Ship.Options.ChargeForHardpoints := 1;
   end;
end;

procedure TMainFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateShipDetails);
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
   end
   else
   if (KEY = VK_F12) then
   begin
      Ship.TestDesign := True;
   end;
end;

function TMainFrm.GenerateShipDetails: String;
begin
   Result := TEXTMARK + ShipNameEdit.Text + TEXTMARK
         + SEP + TEXTMARK + ClassEdit.Text + TEXTMARK
         + SEP + TEXTMARK + TypeEdit.Text + TEXTMARK
         + SEP + TEXTMARK + ArchEdit.Text + TEXTMARK
         + SEP + TEXTMARK + CodeEdit.Text + TEXTMARK
         + SEP + TechLevelEdit.Text
         + SEP + RemoveCommas(TonnageEdit.Text)
         + SEP + RemoveCommas(BudgetEdit.Text)
         + SEP + IntToStr(RaceRadGrp.ItemIndex)
         + SEP + IntToStr(CrewTypeRadGrp.ItemIndex)
         + SEP + IntToStr(DesRulesRadGrp.ItemIndex)
         + SEP + BoolToStr(Ship.IsRefitted)
         + SEP + RefitTechEdit.Text
         + SEP + RemoveCommas(RefitBudgetEdit.Text)
         + SEP + '0';
end;

procedure TMainFrm.UserMenuItemClick(Sender: TObject);
//go to the user components form

var
   UserDefFrm : TUserDefFrm;
begin
   if (CommitBtn.Enabled) or (ResetBtn.Enabled) then begin
      if (Confirm('Your Changes have not been applied. Do you wish to Apply them now?')) then begin
         UncheckedCommit;
         //CommitChanges;
         UserDefFrm := TUserDefFrm.Create(self);
         UserDefFrm.ShowModal;
      end;
   end
   else begin
      UserDefFrm := TUserDefFrm.Create(self);
      UserDefFrm.ShowModal;
   end;
end;

procedure TMainFrm.TonnageEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//up = increase by 10, up + shift = increase by 100
//up + ctrl = increase by 1000, up + alt = increase by 1000
//down = decrease by 10, down + shift = decrease by 100
//down + ctrl = decrease by 1000, down + alt = decrease by 1000

var
  Tonnage : Extended;
begin
  with TonnageEdit do
  begin
    if (StrToFloatDef(RemoveCommas(Text), 3) = 3) and
        (StrToFloatDef(RemoveCommas(Text), 2) = 2) then
    begin
      abort;
    end;
  end;
  Tonnage := StrToFloat(RemoveCommas(TonnageEdit.Text));
  if (Key = VK_UP) and (ssAlt in Shift) then
  begin
    Tonnage := Tonnage + 10000;
    TonnageEdit.Text := FloatToStrF(Tonnage, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    Tonnage := Tonnage + 1000;
    TonnageEdit.Text := FloatToStrF(Tonnage, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) and (ssShift in Shift) then
  begin
    Tonnage := Tonnage + 100;
    TonnageEdit.Text := FloatToStrF(Tonnage, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) then begin
    Tonnage := Tonnage + 10;
    TonnageEdit.Text := FloatToStrF(Tonnage, ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssAlt in Shift) then
  begin
    Tonnage := Tonnage - 10000;
    TonnageEdit.Text := FloatToStrF(Max(Tonnage, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    Tonnage := Tonnage - 1000;
    TonnageEdit.Text := FloatToStrF(Max(Tonnage, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssShift in Shift) then
  begin
    Tonnage := Tonnage - 100;
    TonnageEdit.Text := FloatToStrF(Max(Tonnage, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) then
  begin
    Tonnage := Tonnage - 10;
    TonnageEdit.Text := FloatToStrF(Max(Tonnage, 0), ffNumber, 18, 3);
  end;
end;

procedure TMainFrm.BudgetEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//up = increase by 10, up + shift = increase by 100
//up + ctrl = increase by 1000, up + alt = increase by 1000
//down = decrease by 10, down + shift = decrease by 100
//down + ctrl = decrease by 1000, down + alt = decrease by 1000

var
  Budget : Extended;
begin
  with BudgetEdit do
  begin
    if (StrToFloatDef(RemoveCommas(Text), 3) = 3) and
        (StrToFloatDef(RemoveCommas(Text), 2) = 2) then
    begin
      abort;
    end;
  end;
  Budget := StrToFloat(RemoveCommas(BudgetEdit.Text));
  if (Key = VK_UP) and (ssAlt in Shift) then
  begin
    Budget := Budget + 10000;
    BudgetEdit.Text := FloatToStrF(Budget, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    Budget := Budget + 1000;
    BudgetEdit.Text := FloatToStrF(Budget, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) and (ssShift in Shift) then
  begin
    Budget := Budget + 100;
    BudgetEdit.Text := FloatToStrF(Budget, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) then
  begin
    Budget := Budget + 10;
    BudgetEdit.Text := FloatToStrF(Budget, ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssAlt in Shift) then
  begin
    Budget := Budget - 10000;
    BudgetEdit.Text := FloatToStrF(Max(Budget, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    Budget := Budget - 1000;
    BudgetEdit.Text := FloatToStrF(Max(Budget, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssShift in Shift) then
  begin
    Budget := Budget - 100;
    BudgetEdit.Text := FloatToStrF(Max(Budget, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) then
  begin
    Budget := Budget - 10;
    BudgetEdit.Text := FloatToStrF(Max(Budget, 0), ffNumber, 18, 3);
  end;
end;

procedure TMainFrm.TechLevelEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//up = increase by 1
//down = decrease by 1

var
  Tech : Integer;
begin
  with TechLevelEdit do
  begin
    if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then
    begin
      abort;
    end;
  end;
  Tech := StrToInt(TechLevelEdit.Text);
  if (Key = VK_UP) then
  begin
    Tech := Tech + 1;
    TechLevelEdit.Text := IntToStr(Tech);
  end
  else if (Key = VK_DOWN) then
  begin
    Tech := Tech - 1;
    TechLevelEdit.Text := IntToStr(Max(Tech, 7));
  end;
end;

procedure TMainFrm.CodeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//launch type display and type edit forms, Syncronise the type code

var
   TypeDisplayFrm : TTypeDisplayFrm;
   TypeCodeEditFrm : TTypeCodeEditFrm;
begin
   if (Key = VK_F5) and (ssAlt in Shift) then begin
      TypeDisplayFrm := TTypeDisplayFrm.Create(Self);
      TypeDisplayFrm.ShowModal;
   end
   else if (Key = VK_F5) and (ssCtrl in Shift) then begin
      if not (FileExists(Ship.HomeDir + 'TypeCode') { *Converted from FileExists*  }) then begin
         CreateTypeCodeFile;
      end;
      TypeCodeEditFrm := TTypeCodeEditFrm.Create(Self);
      TypeCodeEditFrm.ShowModal;
   end
   else if (Key = VK_F5) then begin
      if not (FileExists(Ship.HomeDir + 'TypeCode') { *Converted from FileExists*  }) then begin
         CreateTypeCodeFile;
      end;
      SyncCode;
   end;
end;

procedure TMainFrm.CreateTypeCodeFile;
//create the type code file

var
   TypeCodeList : TStringList;
begin
   TypeCodeList := TStringList.Create;
   try
      TypeCodeList.Add('"Battleship","BB"');
      TypeCodeList.Add('"Battle Ship","BB"');
      TypeCodeList.Add('"Monitor","BM"');
      TypeCodeList.Add('"Battlerider","BR"');
      TypeCodeList.Add('"Battle Rider","BR"');
      TypeCodeList.Add('"Battlecruiser","CC"');
      TypeCodeList.Add('"Battle Cruiser","CC"');
      TypeCodeList.Add('"Armoured Cruiser","CA"');
      TypeCodeList.Add('"Heavy Cruiser","CA"');
      TypeCodeList.Add('"Light Cruiser","CL"');
      TypeCodeList.Add('"Strike Cruiser","CS"');
      TypeCodeList.Add('"Patrol Cruiser","CP"');
      TypeCodeList.Add('"Scout Cruiser","CS"');
      TypeCodeList.Add('"Missile Cruiser","CM"');
      TypeCodeList.Add('"Raider","CR"');
      TypeCodeList.Add('"Carrier","CV"');
      TypeCodeList.Add('"Destroyer","DD"');
      TypeCodeList.Add('"Destroyer Leader","DL"');
      TypeCodeList.Add('"Missile Destroyer","DM"');
      TypeCodeList.Add('"Destroyer Escort","DE"');
      TypeCodeList.Add('"Escort Destroyer","DE"');
      TypeCodeList.Add('"Frigate","FF"');
      TypeCodeList.Add('"Missile Frigate","FM"');
      TypeCodeList.Add('"Corvette","LL"');
      TypeCodeList.Add('"Missile Corvette","LM"');
      TypeCodeList.Add('"Close Escort","EC"');
      TypeCodeList.Add('"Missileboat","MB"');
      TypeCodeList.Add('"Missile Boat","MB"');
      TypeCodeList.Add('"Merchant","AM"');
      TypeCodeList.Add('"Tanker","AO"');
      TypeCodeList.Add('"Transport","AT"');
      TypeCodeList.Add('"Liner","RR"');
      TypeCodeList.Add('"XBoat","XB"');
      TypeCodeList.Add('"X-Boat","XB"');
      TypeCodeList.Add('"X Boat","XB"');
      TypeCodeList.Add('"XBoat Tender","XT"');
      TypeCodeList.Add('"X-Boat Tender","XT"');
      TypeCodeList.Add('"X Boat Tender","XT"');
      TypeCodeList.Add('"Explorer","EX"');
      TypeCodeList.Add('"Scout","SS"');
      TypeCodeList.Add('"Courier","SS"');
      TypeCodeList.SaveToFile(Ship.HomeDir + 'TypeCode');
   finally
      FreeAndNil(TypeCodeList);
   end;
end;

procedure TMainFrm.SyncCode;
//syncronise the ship code with the ship type if the type is in the list

var
   TypeCodes, CurrentType : TStringList;
   iCount : Integer;
   TheType, TheCode : String;
   CodeNotFound : Boolean;
begin
   TypeCodes := TStringList.Create;
   CurrentType := TStringList.Create;
   try
      CodeNotFound := True;
      TypeCodes.LoadFromFile(Ship.HomeDir + 'TypeCode');
      for iCount := 0 to Pred(TypeCodes.Count) do begin
         CurrentType.Clear;
         CurrentType.CommaText := TypeCodes[iCount];
         TheType := CurrentType[0];
         TheCode := CurrentType[1];
         if (UpperCase(TypeEdit.Text) = UpperCase(TheType)) then begin
            CodeEdit.Text := TheCode;
            CodeNotFound := False;
            Break;
         end;
      end;
      if (CodeNotFound) then begin
         MessageDlg('No matching code found', mtInformation, [mbOk], 0);
      end;
   finally
      FreeAndNil(TypeCodes);
      FreeAndNil(CurrentType);
   end;
end;

procedure TMainFrm.ClassEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//syncronise the class name with the ship name

begin
   if (Key = VK_F4) then begin
      ClassEdit.Text := ShipNameEdit.Text;
   end;
end;

procedure TMainFrm.SyncType;
//syncronise the ship type with the ship code if the code is in the list

var
   TypeCodes, CurrentType : TStringList;
   iCount : Integer;
   TheType, TheCode : String;
   CodeNotFound : Boolean;
begin
   TypeCodes := TStringList.Create;
   CurrentType := TStringList.Create;
   try
      CodeNotFound := True;
      TypeCodes.LoadFromFile(Ship.HomeDir + 'TypeCode');
      for iCount := 0 to Pred(TypeCodes.Count) do begin
         CurrentType.Clear;
         CurrentType.CommaText := TypeCodes[iCount];
         TheType := CurrentType[0];
         TheCode := CurrentType[1];
         if (UpperCase(CodeEdit.Text) = UpperCase(TheCode)) then begin
            TypeEdit.Text := TheType;
            CodeNotFound := False;
            Break;
         end;
      end;
      if (CodeNotFound) then begin
         MessageDlg('No matching type found', mtInformation, [mbOk], 0);
      end;
   finally
      FreeAndNil(TypeCodes);
      FreeAndNil(CurrentType);
   end;
end;

procedure TMainFrm.TypeEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//launch type display and type edit forms, Syncronise the type code

var
   TypeDisplayFrm : TTypeDisplayFrm;
   TypeCodeEditFrm : TTypeCodeEditFrm;
begin
   if (Key = VK_F5) and (ssAlt in Shift) then begin
      TypeDisplayFrm := TTypeDisplayFrm.Create(Self);
      TypeDisplayFrm.ShowModal;
   end
   else if (Key = VK_F5) and (ssCtrl in Shift) then begin
      if not (FileExists(Ship.HomeDir + 'TypeCode') { *Converted from FileExists*  }) then begin
         CreateTypeCodeFile;
      end;
      TypeCodeEditFrm := TTypeCodeEditFrm.Create(Self);
      TypeCodeEditFrm.ShowModal;
   end
   else if (Key = VK_F5) then begin
      if not (FileExists(Ship.HomeDir + 'TypeCode') { *Converted from FileExists*  }) then begin
         CreateTypeCodeFile;
      end;
      SyncType;
   end;
end;

procedure TMainFrm.ClearAllMenuItemClick(Sender: TObject);
//clear all fields from the ship

begin
  if (Confirm('This will clear all fields for the ship, '
      + 'do you wish to do this?')) then
  begin
    if (Ship.HasChanged) then
    begin
      if (Confirm('Changes have not been saved, '
          + 'do you wish to save now?')) then
      begin
        SaveMenuItemClick(Self);
      end;
    end;
    if (FileExists(Ship.HomeDir + 'Blank.shp') { *Converted from FileExists*  }) then
    begin
      Ship.ReadFromFile(Ship.HomeDir + 'Blank.shp');
    end
    else
    begin
      BlankShip;
    end;
    TargetFile := '';
    ClearShip := True;
    RefreshForm;
    ClearShip := False;
    SaveMenuItem.Enabled := False;
    RestoreMenuItem.Enabled := False;
  end;
end;

procedure TMainFrm.BlankShip;
//create a blank ship file

var
  BlankShipList : TStringList;
begin
  BlankShipList := TStringList.Create;
  try
    BlankShipList.Add(Ship.GetCurver);
    BlankShipList.Add('"","","","","",0,0,0,-1,-1,-1,0,0,0,0');
    BlankShipList.Add('0,0,0,0,0,-1,-1');
    BlankShipList.Add('0,0,0,0,0,0,0,0,0');
    BlankShipList.Add('0,0,-1,-1,0,0,0,0,0,0');
    BlankShipList.Add('0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1');
    BlankShipList.Add('0,0');
    BlankShipList.Add('0,0,0,0,0');
    BlankShipList.Add('0,0,0,0,0,0,0');
    BlankShipList.Add('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0');
    BlankShipList.Add('0,0,0,0,0,0,0,0,0,0');
    BlankShipList.Add('0,0,"",0,0,0,0,0,"",0,0,0,0,0,"",0,0,0,0,0,"",0,0,0,0,0,"",0,0,0,0,0,"",0,0,0,0,0,"",0,0,0,0,0,"",0,0,0,0,0,0,0,0');
    BlankShipList.Add('-1,-1,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0');
    BlankShipList.Add('0,0,"",0,0,0,0,0,0,0,0,0,"",0,0,0,0,0,0,0,0,0,"",0,0,0,0,0,0,0,0,0,"",0,0,0,0,0,0,0,' +'0,0,"",0,0,0,0,0,0,0,0,0,"",0,0,0,0,0,0,0,0,0,"",0,0,0,0,0,0,0,0,0,"",0,0,0,0,0,0,0');
    BlankShipList.Add('0,0,0');
    BlankShipList.Add('Reserved for future expansion');
    BlankShipList.Add('Reserved for future expansion');
    BlankShipList.Add('Reserved for future expansion');
    BlankShipList.SaveToFile(Ship.HomeDir + 'Blank.shp');
    Ship.ReadFromFile(Ship.HomeDir + 'Blank.shp');
  finally
    FreeAndNil(BlankShipList);
  end;
end;

procedure TMainFrm.RefitTechEditChange(Sender: TObject);
//diasable trap errors. Enable commit and reset. Disable make default
{ TODO : Fix invalid integer error }

begin
  with RefitTechEdit do
  begin
    if (Text = '') then
    begin
      abort;
    end;
  end;
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.RefitMenuItemClick(Sender: TObject);
//start a new design and file based on the current ship
//and set the refit flag to true

begin
  //if uncommitted changes, commit and save
  if (Ship.HasChanged) then
  begin
    if (Confirm('Changes have not been saved, '
        + 'do you wish to save now?')) then
    begin
      SaveMenuItemClick(Self);
    end;
  end;
  
  //if there's no target file then set it to class name
  ClassEdit.Text := ClassEdit.Text + '_Refit';
  if (TargetFile = '') then
  begin
    TargetFile := ClassEdit.Text;
  end;
  { TODO : Fix so file ext is dropped if it exists }
  //reset the target file to TargetFile + '_Refit'
  //TargetFile := ExtractFileDir(TargetFile) + ExtractFileName(TargetFile) + '_Refit.hgs';
  //save the design to the new file

  //set the IsRefitted flag to true
  Ship.IsRefitted := True;
  //set the initial refit tech level to ship tech level + 1
  Ship.RefitTechLevel := Ship.TechLevel + 1;
  Ship.Fuel.BasePFuel := Ship.Fuel.PFuel;
  Ship.Fuel.BaseJFuel := Ship.Fuel.JFuel;
  Ship.Fuel.BaseEFuel := Ship.Fuel.ExtraFuel;
  Ship.SetEngRefitTech(Ship.RefitTechLevel);
  Ship.SetFuelRefitTech(Ship.RefitTechLevel);
  Ship.SetAvionicsRefitTech(Ship.RefitTechLevel);
  Ship.SetSpinalRefitTech(Ship.RefitTechLevel);
  Ship.SetBigBaysRefitTech(Ship.RefitTechLevel);
  Ship.SetLittleBaysRefitTech(Ship.RefitTechLevel);
  //show the refit tech level in the RefitTechEdit
  RefitTechEdit.Text := IntToStr(Ship.RefitTechLevel);
  RefitMenuItem.Enabled := False;
  CommitChanges;
end;

procedure TMainFrm.RefitTechEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//up = increase by 1
//down = decrease by 1

var
  RefitTech : Integer;
begin
  with RefitTechEdit do
  begin
    if (StrToIntDef(Text, 3) = 3) and (StrToIntDef(Text, 2) = 2) then
    begin
      abort;
    end;
  end;
  RefitTech := StrToInt(RefitTechEdit.Text);
  if (Key = VK_UP) then
  begin
    RefitTech := RefitTech + 1;
    RefitTechEdit.Text := IntToStr(RefitTech);
  end
  else if (Key = VK_DOWN) then
  begin
    RefitTech := RefitTech - 1;
    RefitTechEdit.Text := IntToStr(Max(RefitTech, 7));
  end;
end;

procedure TMainFrm.RefitBudgetEditChange(Sender: TObject);
//diasable trap errors. Enable commit and reset. Disable make default

begin
  if (RefitBudgetEdit.Text = '') then begin
    abort;
  end;
  CommitBtn.Enabled := True;
  ResetBtn.Enabled := True;
  DefaultsMenuItem.Enabled := False;
end;

procedure TMainFrm.RefitBudgetEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//up = increase by 10, up + shift = increase by 100
//up + ctrl = increase by 1000, up + alt = increase by 1000
//down = decrease by 10, down + shift = decrease by 100
//down + ctrl = decrease by 1000, down + alt = decrease by 1000

var
  RefitBudget : Extended;
begin
  with RefitBudgetEdit do
  begin
    if (StrToFloatDef(RemoveCommas(Text), 3) = 3) and
        (StrToFloatDef(RemoveCommas(Text), 2) = 2) then
    begin
      abort;
    end;
  end;
  RefitBudget := StrToFloat(RemoveCommas(RefitBudgetEdit.Text));
  if (Key = VK_UP) and (ssAlt in Shift) then
  begin
    RefitBudget := RefitBudget + 10000;
    RefitBudgetEdit.Text := FloatToStrF(RefitBudget, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) and (ssCtrl in Shift) then
  begin
    RefitBudget := RefitBudget + 1000;
    RefitBudgetEdit.Text := FloatToStrF(RefitBudget, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) and (ssShift in Shift) then
  begin
    RefitBudget := RefitBudget + 100;
    RefitBudgetEdit.Text := FloatToStrF(RefitBudget, ffNumber, 18, 3);
  end
  else if (Key = VK_UP) then
  begin
    RefitBudget := RefitBudget + 10;
    RefitBudgetEdit.Text := FloatToStrF(RefitBudget, ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssAlt in Shift) then
  begin
    RefitBudget := RefitBudget - 10000;
    RefitBudgetEdit.Text := FloatToStrF(Max(RefitBudget, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssCtrl in Shift) then
  begin
    RefitBudget := RefitBudget - 1000;
    RefitBudgetEdit.Text := FloatToStrF(Max(RefitBudget, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) and (ssShift in Shift) then
  begin
    RefitBudget := RefitBudget - 100;
    RefitBudgetEdit.Text := FloatToStrF(Max(RefitBudget, 0), ffNumber, 18, 3);
  end
  else if (Key = VK_DOWN) then
  begin
    RefitBudget := RefitBudget - 10;
    RefitBudgetEdit.Text := FloatToStrF(Max(RefitBudget, 0), ffNumber, 18, 3);
  end;
end;

procedure TMainFrm.CmpExpMenuItemClick(Sender: TObject);
begin
  //Ship.ComponentExport;
  with (CompExpDialog) do
  begin
    Options := [ofOverwritePrompt, ofNoReadOnlyReturn];
    FileName := Ship.ShipClass;
    if (Execute) then
    begin
      Ship.ComponentExport(FileName, True);
    end;
  end;
end;

procedure TMainFrm.SetTargetFile(const AValue: String);
begin
  if FTargetFile=AValue then exit;
  FTargetFile:=AValue;
end;

procedure TMainFrm.SetTestingBuild(const AValue: Boolean);
begin
  if FTestingBuild=AValue then exit;
  FTestingBuild:=AValue;
end;

function TMainFrm.OptionalRulesUsed: Boolean;
begin
  if ((Ship.Options.ChargeForHardpoints = 1)
        and ((Ship.DesignRules <> 0) or (DesRulesRadGrp.ItemIndex <> 0)))
      or (Ship.Options.MilStdJump) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

end.
