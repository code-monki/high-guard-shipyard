unit UserDefFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  ShipPas, DesAssistFrmPas;

type
  TUserDefFrm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Item1StatLbl: TLabel;
    Item2StatLbl: TLabel;
    Item3StatLbl: TLabel;
    Item4StatLbl: TLabel;
    Item5StatLbl: TLabel;
    Item6StatLbl: TLabel;
    Item7StatLbl: TLabel;
    Item8StatLbl: TLabel;
    NumStatLbl: TLabel;
    SizeStatLbl: TLabel;
    DescStatLbl: TLabel;
    CrewStatLbl: TLabel;
    EpStatLbl: TLabel;
    CostStatLbl: TLabel;
    HpStatLbl: TLabel;
    RemHpStatLbl: TLabel;
    RemHpLbl: TLabel;
    Item1NumEdit: TEdit;
    Item1SizeEdit: TEdit;
    Item1DescEdit: TEdit;
    Item1CrewEdit: TEdit;
    Item1EpEdit: TEdit;
    Item1CostEdit: TEdit;
    Item1HpEdit: TEdit;
    Item2NumEdit: TEdit;
    Item2SizeEdit: TEdit;
    Item2DescEdit: TEdit;
    Item2CrewEdit: TEdit;
    Item2EpEdit: TEdit;
    Item2CostEdit: TEdit;
    Item2HpEdit: TEdit;
    Item3NumEdit: TEdit;
    Item3SizeEdit: TEdit;
    Item3DescEdit: TEdit;
    Item3CrewEdit: TEdit;
    Item3EpEdit: TEdit;
    Item3CostEdit: TEdit;
    Item3HpEdit: TEdit;
    Item4NumEdit: TEdit;
    Item4SizeEdit: TEdit;
    Item4DescEdit: TEdit;
    Item4CrewEdit: TEdit;
    Item4EpEdit: TEdit;
    Item4CostEdit: TEdit;
    Item4HpEdit: TEdit;
    Item5NumEdit: TEdit;
    Item5SizeEdit: TEdit;
    Item5DescEdit: TEdit;
    Item5CrewEdit: TEdit;
    Item5EpEdit: TEdit;
    Item5CostEdit: TEdit;
    Item5HpEdit: TEdit;
    Item6NumEdit: TEdit;
    Item6SizeEdit: TEdit;
    Item6DescEdit: TEdit;
    Item6CrewEdit: TEdit;
    Item6EpEdit: TEdit;
    Item6CostEdit: TEdit;
    Item6HpEdit: TEdit;
    Item7NumEdit: TEdit;
    Item7SizeEdit: TEdit;
    Item7DescEdit: TEdit;
    Item7CrewEdit: TEdit;
    Item7EpEdit: TEdit;
    Item7CostEdit: TEdit;
    Item7HpEdit: TEdit;
    Item8NumEdit: TEdit;
    Item8SizeEdit: TEdit;
    Item8DescEdit: TEdit;
    Item8CrewEdit: TEdit;
    Item8EpEdit: TEdit;
    Item8CostEdit: TEdit;
    Item8HpEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure Item1HpEditChange(Sender: TObject);
    procedure Item2HpEditChange(Sender: TObject);
    procedure Item3HpEditChange(Sender: TObject);
    procedure Item4HpEditChange(Sender: TObject);
    procedure Item5HpEditChange(Sender: TObject);
    procedure Item6HpEditChange(Sender: TObject);
    procedure Item7HpEditChange(Sender: TObject);
    procedure Item8HpEditChange(Sender: TObject);
  private
    { Private declarations }
    function StrToFloatDef(const S: string; Default: Extended): Extended;
    function TrapErrors : Boolean;
    function RemoveCommas(Text : String) : String;
    function GenerateUserDefDetails : String;
    procedure RefreshForm;
  public
    { Public declarations }
  end;

var
  UserDefFrm: TUserDefFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TUserDefFrm.FormCreate(Sender: TObject);
//fill the form

begin
   //Item 1
   Item1NumEdit.Text := IntToStr(Ship.UserDef.Item1Num);
   Item1SizeEdit.Text := FloatToStrF(Ship.UserDef.Item1Size, ffNumber, 18, 3);
   Item1DescEdit.Text := Ship.UserDef.Item1Desc;
   Item1CrewEdit.Text := IntToStr(Ship.UserDef.Item1Crew);
   Item1EpEdit.Text := FloatToStrF(Ship.UserDef.Item1Ep, ffNumber, 18, 3);
   Item1CostEdit.Text := FloatToStrF(Ship.UserDef.Item1Cost, ffNumber, 18, 3);
   Item1HpEdit.Text := IntToStr(Ship.UserDef.Item1Hp);
   //Item 2
   Item2NumEdit.Text := IntToStr(Ship.UserDef.Item2Num);
   Item2SizeEdit.Text := FloatToStrF(Ship.UserDef.Item2Size, ffNumber, 18, 3);
   Item2DescEdit.Text := Ship.UserDef.Item2Desc;
   Item2CrewEdit.Text := IntToStr(Ship.UserDef.Item2Crew);
   Item2EpEdit.Text := FloatToStrF(Ship.UserDef.Item2Ep, ffNumber, 18, 3);
   Item2CostEdit.Text := FloatToStrF(Ship.UserDef.Item2Cost, ffNumber, 18, 3);
   Item2HpEdit.Text := IntToStr(Ship.UserDef.Item2Hp);
   //Item 3
   Item3NumEdit.Text := IntToStr(Ship.UserDef.Item3Num);
   Item3SizeEdit.Text := FloatToStrF(Ship.UserDef.Item3Size, ffNumber, 18, 3);
   Item3DescEdit.Text := Ship.UserDef.Item3Desc;
   Item3CrewEdit.Text := IntToStr(Ship.UserDef.Item3Crew);
   Item3EpEdit.Text := FloatToStrF(Ship.UserDef.Item3Ep, ffNumber, 18, 3);
   Item3CostEdit.Text := FloatToStrF(Ship.UserDef.Item3Cost, ffNumber, 18, 3);
   Item3HpEdit.Text := IntToStr(Ship.UserDef.Item3Hp);
   //Item 4
   Item4NumEdit.Text := IntToStr(Ship.UserDef.Item4Num);
   Item4SizeEdit.Text := FloatToStrF(Ship.UserDef.Item4Size, ffNumber, 18, 3);
   Item4DescEdit.Text := Ship.UserDef.Item4Desc;
   Item4CrewEdit.Text := IntToStr(Ship.UserDef.Item4Crew);
   Item4EpEdit.Text := FloatToStrF(Ship.UserDef.Item4Ep, ffNumber, 18, 3);
   Item4CostEdit.Text := FloatToStrF(Ship.UserDef.Item4Cost, ffNumber, 18, 3);
   Item4HpEdit.Text := IntToStr(Ship.UserDef.Item4Hp);
   //Item 5
   Item5NumEdit.Text := IntToStr(Ship.UserDef.Item5Num);
   Item5SizeEdit.Text := FloatToStrF(Ship.UserDef.Item5Size, ffNumber, 18, 3);
   Item5DescEdit.Text := Ship.UserDef.Item5Desc;
   Item5CrewEdit.Text := IntToStr(Ship.UserDef.Item5Crew);
   Item5EpEdit.Text := FloatToStrF(Ship.UserDef.Item5Ep, ffNumber, 18, 3);
   Item5CostEdit.Text := FloatToStrF(Ship.UserDef.Item5Cost, ffNumber, 18, 3);
   Item5HpEdit.Text := IntToStr(Ship.UserDef.Item5Hp);
   //Item 6
   Item6NumEdit.Text := IntToStr(Ship.UserDef.Item6Num);
   Item6SizeEdit.Text := FloatToStrF(Ship.UserDef.Item6Size, ffNumber, 18, 3);
   Item6DescEdit.Text := Ship.UserDef.Item6Desc;
   Item6CrewEdit.Text := IntToStr(Ship.UserDef.Item6Crew);
   Item6EpEdit.Text := FloatToStrF(Ship.UserDef.Item6Ep, ffNumber, 18, 3);
   Item6CostEdit.Text := FloatToStrF(Ship.UserDef.Item6Cost, ffNumber, 18, 3);
   Item6HpEdit.Text := IntToStr(Ship.UserDef.Item6Hp);
   //Item 7
   Item7NumEdit.Text := IntToStr(Ship.UserDef.Item7Num);
   Item7SizeEdit.Text := FloatToStrF(Ship.UserDef.Item7Size, ffNumber, 18, 3);
   Item7DescEdit.Text := Ship.UserDef.Item7Desc;
   Item7CrewEdit.Text := IntToStr(Ship.UserDef.Item7Crew);
   Item7EpEdit.Text := FloatToStrF(Ship.UserDef.Item7Ep, ffNumber, 18, 3);
   Item7CostEdit.Text := FloatToStrF(Ship.UserDef.Item7Cost, ffNumber, 18, 3);
   Item7HpEdit.Text := IntToStr(Ship.UserDef.Item7Hp);
   //Item 8
   Item8NumEdit.Text := IntToStr(Ship.UserDef.Item8Num);
   Item8SizeEdit.Text := FloatToStrF(Ship.UserDef.Item8Size, ffNumber, 18, 3);
   Item8DescEdit.Text := Ship.UserDef.Item8Desc;
   Item8CrewEdit.Text := IntToStr(Ship.UserDef.Item8Crew);
   Item8EpEdit.Text := FloatToStrF(Ship.UserDef.Item8Ep, ffNumber, 18, 3);
   Item8CostEdit.Text := FloatToStrF(Ship.UserDef.Item8Cost, ffNumber, 18, 3);
   Item8HpEdit.Text := IntToStr(Ship.UserDef.Item8Hp);
   RefreshForm;
end;

procedure TUserDefFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up the form

begin
   Action := caFree;
end;

procedure TUserDefFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(Ship.GenScreenDetails);
         FullShipData.Add(Ship.GenCraftDetails);
         FullShipData.Add(Ship.GenAccomDetails);
         FullShipData.Add(GenerateUserDefDetails);
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

procedure TUserDefFrm.OKBtnClick(Sender: TObject);
//apply changes and close the form

begin
   if (TrapErrors) then begin
      Exit;
   end;
   //item 1
   Ship.UserDef.Item1Num := StrToInt(Item1NumEdit.Text);
   Ship.UserDef.Item1Size := StrToFloat(RemoveCommas(Item1SizeEdit.Text));
   Ship.UserDef.Item1Desc := Item1DescEdit.Text;
   Ship.UserDef.Item1Crew := StrToInt(Item1CrewEdit.Text);
   Ship.UserDef.Item1Ep := StrToFloat(RemoveCommas(Item1EpEdit.Text));
   Ship.UserDef.Item1Cost := StrToFloat(RemoveCommas(Item1CostEdit.Text));
   Ship.UserDef.Item1Hp := StrToInt(Item1HpEdit.Text);
   //item 2
   Ship.UserDef.Item2Num := StrToInt(Item2NumEdit.Text);
   Ship.UserDef.Item2Size := StrToFloat(RemoveCommas(Item2SizeEdit.Text));
   Ship.UserDef.Item2Desc := Item2DescEdit.Text;
   Ship.UserDef.Item2Crew := StrToInt(Item2CrewEdit.Text);
   Ship.UserDef.Item2Ep := StrToFloat(RemoveCommas(Item2EpEdit.Text));
   Ship.UserDef.Item2Cost := StrToFloat(RemoveCommas(Item2CostEdit.Text));
   Ship.UserDef.Item2Hp := StrToInt(Item2HpEdit.Text);
   //item 3
   Ship.UserDef.Item3Num := StrToInt(Item3NumEdit.Text);
   Ship.UserDef.Item3Size := StrToFloat(RemoveCommas(Item3SizeEdit.Text));
   Ship.UserDef.Item3Desc := Item3DescEdit.Text;
   Ship.UserDef.Item3Crew := StrToInt(Item3CrewEdit.Text);
   Ship.UserDef.Item3Ep := StrToFloat(RemoveCommas(Item3EpEdit.Text));
   Ship.UserDef.Item3Cost := StrToFloat(RemoveCommas(Item3CostEdit.Text));
   Ship.UserDef.Item3Hp := StrToInt(Item3HpEdit.Text);
   //item 4
   Ship.UserDef.Item4Num := StrToInt(Item4NumEdit.Text);
   Ship.UserDef.Item4Size := StrToFloat(RemoveCommas(Item4SizeEdit.Text));
   Ship.UserDef.Item4Desc := Item4DescEdit.Text;
   Ship.UserDef.Item4Crew := StrToInt(Item4CrewEdit.Text);
   Ship.UserDef.Item4Ep := StrToFloat(RemoveCommas(Item4EpEdit.Text));
   Ship.UserDef.Item4Cost := StrToFloat(RemoveCommas(Item4CostEdit.Text));
   Ship.UserDef.Item4Hp := StrToInt(Item4HpEdit.Text);
   //item 5
   Ship.UserDef.Item5Num := StrToInt(Item5NumEdit.Text);
   Ship.UserDef.Item5Size := StrToFloat(RemoveCommas(Item5SizeEdit.Text));
   Ship.UserDef.Item5Desc := Item5DescEdit.Text;
   Ship.UserDef.Item5Crew := StrToInt(Item5CrewEdit.Text);
   Ship.UserDef.Item5Ep := StrToFloat(RemoveCommas(Item5EpEdit.Text));
   Ship.UserDef.Item5Cost := StrToFloat(RemoveCommas(Item5CostEdit.Text));
   Ship.UserDef.Item5Hp := StrToInt(Item5HpEdit.Text);
   //item 6
   Ship.UserDef.Item6Num := StrToInt(Item6NumEdit.Text);
   Ship.UserDef.Item6Size := StrToFloat(RemoveCommas(Item6SizeEdit.Text));
   Ship.UserDef.Item6Desc := Item6DescEdit.Text;
   Ship.UserDef.Item6Crew := StrToInt(Item6CrewEdit.Text);
   Ship.UserDef.Item6Ep := StrToFloat(RemoveCommas(Item6EpEdit.Text));
   Ship.UserDef.Item6Cost := StrToFloat(RemoveCommas(Item6CostEdit.Text));
   Ship.UserDef.Item6Hp := StrToInt(Item6HpEdit.Text);
   //item 7
   Ship.UserDef.Item7Num := StrToInt(Item7NumEdit.Text);
   Ship.UserDef.Item7Size := StrToFloat(RemoveCommas(Item7SizeEdit.Text));
   Ship.UserDef.Item7Desc := Item7DescEdit.Text;
   Ship.UserDef.Item7Crew := StrToInt(Item7CrewEdit.Text);
   Ship.UserDef.Item7Ep := StrToFloat(RemoveCommas(Item7EpEdit.Text));
   Ship.UserDef.Item7Cost := StrToFloat(RemoveCommas(Item7CostEdit.Text));
   Ship.UserDef.Item7Hp := StrToInt(Item7HpEdit.Text);
   //item 8
   Ship.UserDef.Item8Num := StrToInt(Item8NumEdit.Text);
   Ship.UserDef.Item8Size := StrToFloat(RemoveCommas(Item8SizeEdit.Text));
   Ship.UserDef.Item8Desc := Item8DescEdit.Text;
   Ship.UserDef.Item8Crew := StrToInt(Item8CrewEdit.Text);
   Ship.UserDef.Item8Ep := StrToFloat(RemoveCommas(Item8EpEdit.Text));
   Ship.UserDef.Item8Cost := StrToFloat(RemoveCommas(Item8CostEdit.Text));
   Ship.UserDef.Item8Hp := StrToInt(Item8HpEdit.Text);

   Ship.DesignShip;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TUserDefFrm.CancelBtnClick(Sender: TObject);
//close the form without applying the changes

begin
   Close;
end;

function TUserDefFrm.StrToFloatDef(const S: string;
  Default: Extended): Extended;
//like StrToIntDef but with real numbers

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

function TUserDefFrm.TrapErrors: Boolean;
//trap and report errors

begin
   Result := False;
   //item 1
   with Item1NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 1 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 1 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 1 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item1SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 1 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 1 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 1 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item1CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 1 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 1 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 1 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item1EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 1 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 1 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 1 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item1CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 1 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 1 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 1 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item1HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 1 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 1 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 1 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 2
   with Item2NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 2 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 2 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 2 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item2SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 2 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 2 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 2 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item2CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 2 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 2 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 2 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item2EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 2 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 2 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 2 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item2CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 2 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 2 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 2 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item2HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 2 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 2 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 2 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 3
   with Item3NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 3 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 3 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 3 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item3SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 3 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 3 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 3 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item3CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 3 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 3 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 3 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item3EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 3 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 3 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 3 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item3CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 3 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 3 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 3 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item3HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 3 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 3 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 3 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 4
   with Item4NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 4 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 4 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 4 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item4SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 4 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 4 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 4 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item4CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 4 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 4 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 4 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item4EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 4 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 4 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 4 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item4CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 4 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 4 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 4 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item4HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 4 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 4 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 4 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 5
   with Item5NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 5 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 5 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 5 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item5SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 5 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 5 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 5 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item5CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 5 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 5 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 5 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item5EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 5 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 5 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 5 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item5CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 5 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 5 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 5 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item5HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 5 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 5 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 5 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 6
   with Item6NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 6 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 6 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 6 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item6SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 6 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 6 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 6 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item6CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 6 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 6 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 6 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item6EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 6 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 6 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 6 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item6CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 6 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 6 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 6 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item6HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 6 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 6 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 6 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 7
   with Item7NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 7 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 7 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 7 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item7SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 7 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 7 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 7 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item7CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 7 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 7 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 7 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item7EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 7 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 7 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 7 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item7CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 7 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 7 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 7 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item7HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 7 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 7 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 7 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   //item 8
   with Item8NumEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 8 Quantity (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Quantity for Item 8 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Quantity for Item 8 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item8SizeEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 8 Tonnage (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Tonnage for Item 8 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Tonnage for Item 8 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item8CrewEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 8 Crew (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Crew for Item 8 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Crew for Item 8 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item8EpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 8 Energy Points (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Energy Points for Item 8 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Energy Points for Item 8 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item8CostEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 8 Cost (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloatDef(RemoveCommas(Text), 2) = 2) and (StrToFloatDef(RemoveCommas(Text), 3) = 3) then begin
         MessageDlg('The Cost for Item 8 must be a floating point (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToFloat(RemoveCommas(Text)) < 0) then begin
         MessageDlg('The Cost for Item 8 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
   with Item8HpEdit do begin
      if (Text = '') then begin
         MessageDlg('No value entered for Item 8 Hardpoints (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 8 must be an integer (this may be zero)', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
      if (StrToInt(Text) < 0) then begin
         MessageDlg('The Hardpoints for Item 8 may not be a negative number', mtError, [mbOk], 0);
         Result := True;
         Exit;
      end;
   end;
end;

function TUserDefFrm.RemoveCommas(Text: String): String;
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

procedure TUserDefFrm.RefreshForm;
//display the number of remaining hardpoints based on current values on form

var
   ShipHardPoints, FormHardPoints : Integer;
begin
   ShipHardPoints := Ship.GetRemHardPoints + Ship.UserDef.HardPoints;
   FormHardPoints := StrToInt(Item1HpEdit.Text)
         + StrToInt(Item2HpEdit.Text)
         + StrToInt(Item3HpEdit.Text)
         + StrToInt(Item4HpEdit.Text)
         + StrToInt(Item5HpEdit.Text)
         + StrToInt(Item6HpEdit.Text)
         + StrToInt(Item7HpEdit.Text)
         + StrToInt(Item8HpEdit.Text);
   RemHpLbl.Caption := IntToStr(ShipHardPoints - FormHardPoints);
end;

procedure TUserDefFrm.Item1HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item1HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 1 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item2HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item2HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 2 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item3HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item3HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 3 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item4HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item4HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 4 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item5HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item5HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 5 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item6HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item6HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 6 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item7HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item7HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 7 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

procedure TUserDefFrm.Item8HpEditChange(Sender: TObject);
//trap errors, ignore no value and if an integer value refresh the form

begin
   With Item8HpEdit do begin
      if (Text = '') then begin
         Abort;
      end
      else if (StrToIntDef(Text, 2) = 2) and (StrToIntDef(Text, 3) = 3) then begin
         MessageDlg('The Hardpoints for Item 8 must be an integer (this may be zero)', mtError, [mbOk], 0);
      end
      else begin
         RefreshForm;
      end;
   end;
end;

function TUserDefFrm.GenerateUserDefDetails: String;
//generate user defaults file details

begin
   Result := Item1NumEdit.Text
            + SEP + RemoveCommas(Item1SizeEdit.Text)
            + SEP + TEXTMARK + Item1DescEdit.Text + TEXTMARK
            + SEP + Item1CrewEdit.Text
            + SEP + RemoveCommas(Item1EpEdit.Text)
            + SEP + RemoveCommas(Item1CostEdit.Text)
            + SEP + Item1HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item2NumEdit.Text
            + SEP + RemoveCommas(Item2SizeEdit.Text)
            + SEP + TEXTMARK + Item2DescEdit.Text + TEXTMARK
            + SEP + Item2CrewEdit.Text
            + SEP + RemoveCommas(Item2EpEdit.Text)
            + SEP + RemoveCommas(Item2CostEdit.Text)
            + SEP + Item2HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item3NumEdit.Text
            + SEP + RemoveCommas(Item3SizeEdit.Text)
            + SEP + TEXTMARK + Item3DescEdit.Text + TEXTMARK
            + SEP + Item3CrewEdit.Text
            + SEP + RemoveCommas(Item3EpEdit.Text)
            + SEP + RemoveCommas(Item3CostEdit.Text)
            + SEP + Item3HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item4NumEdit.Text
            + SEP + RemoveCommas(Item4SizeEdit.Text)
            + SEP + TEXTMARK + Item4DescEdit.Text + TEXTMARK
            + SEP + Item4CrewEdit.Text
            + SEP + RemoveCommas(Item4EpEdit.Text)
            + SEP + RemoveCommas(Item4CostEdit.Text)
            + SEP + Item4HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item5NumEdit.Text
            + SEP + RemoveCommas(Item5SizeEdit.Text)
            + SEP + TEXTMARK + Item5DescEdit.Text + TEXTMARK
            + SEP + Item5CrewEdit.Text
            + SEP + RemoveCommas(Item5EpEdit.Text)
            + SEP + RemoveCommas(Item5CostEdit.Text)
            + SEP + Item5HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item6NumEdit.Text
            + SEP + RemoveCommas(Item6SizeEdit.Text)
            + SEP + TEXTMARK + Item6DescEdit.Text + TEXTMARK
            + SEP + Item6CrewEdit.Text
            + SEP + RemoveCommas(Item6EpEdit.Text)
            + SEP + RemoveCommas(Item6CostEdit.Text)
            + SEP + Item6HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item7NumEdit.Text
            + SEP + RemoveCommas(Item7SizeEdit.Text)
            + SEP + TEXTMARK + Item7DescEdit.Text + TEXTMARK
            + SEP + Item7CrewEdit.Text
            + SEP + RemoveCommas(Item7EpEdit.Text)
            + SEP + RemoveCommas(Item7CostEdit.Text)
            + SEP + Item7HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + Item8NumEdit.Text
            + SEP + RemoveCommas(Item8SizeEdit.Text)
            + SEP + TEXTMARK + Item8DescEdit.Text + TEXTMARK
            + SEP + Item8CrewEdit.Text
            + SEP + RemoveCommas(Item8EpEdit.Text)
            + SEP + RemoveCommas(Item8CostEdit.Text)
            + SEP + Item8HpEdit.Text
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
            + SEP + '0'     //Wiggle room
         + SEP + '0'        //general wiggle room
         + SEP + '0'        //general wiggle room
         + SEP + '0';       //general wiggle room
end;

end.
