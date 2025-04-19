unit CraftFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ShipPas, DesAssistFrmPas, HgsFormFrm;

type
  TCraftFrm = class(THgsForm)
    NumberStatLbl: TLabel;
    SizeStatLbl: TLabel;
    DescrStatLbl: TLabel;
    Craft1StatLbl: TLabel;
    Craft2StatLbl: TLabel;
    Craft3StatLbl: TLabel;
    Craft4StatLbl: TLabel;
    Craft5StatLbl: TLabel;
    Craft6StatLbl: TLabel;
    Craft1NumEdit: TEdit;
    Craft1SizeEdit: TEdit;
    Craft1DescEdit: TEdit;
    Craft2SizeEdit: TEdit;
    Craft2DescEdit: TEdit;
    Craft3NumEdit: TEdit;
    Craft3SizeEdit: TEdit;
    Craft3DescEdit: TEdit;
    Craft4NumEdit: TEdit;
    Craft4SizeEdit: TEdit;
    Craft4DescEdit: TEdit;
    Craft5NumEdit: TEdit;
    Craft5SizeEdit: TEdit;
    Craft5DescEdit: TEdit;
    Craft6NumEdit: TEdit;
    Craft6SizeEdit: TEdit;
    Craft6DescEdit: TEdit;
    LaunchFac1StatLbl: TLabel;
    LFNumStatLbl: TLabel;
    LFSizeStatLbl: TLabel;
    LF1NumEdit: TEdit;
    LF1SizeEdit: TEdit;
    LF2NumEdit: TEdit;
    LF2SizeEdit: TEdit;
    Craft2NumEdit: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Craft1CrewEdit: TEdit;
    Craft2CrewEdit: TEdit;
    Craft3CrewEdit: TEdit;
    Craft4CrewEdit: TEdit;
    Craft5CrewEdit: TEdit;
    Craft6CrewEdit: TEdit;
    CrewStatLbl: TLabel;
    Craft1ChkBx: TCheckBox;
    Craft2ChkBx: TCheckBox;
    Craft3ChkBx: TCheckBox;
    Craft4ChkBx: TCheckBox;
    Craft5ChkBx: TCheckBox;
    Craft6ChkBx: TCheckBox;
    FtrSqd1StatLbl: TLabel;
    FtrSqdEdit: TEdit;
    LaunchFac2StatLbl: TLabel;
    FtrSqd2StatLbl: TLabel;
    Craft7StatLbl: TLabel;
    Craft8StatLbl: TLabel;
    Craft7NumEdit: TEdit;
    Craft7SizeEdit: TEdit;
    Craft7DescEdit: TEdit;
    Craft8NumEdit: TEdit;
    Craft8SizeEdit: TEdit;
    Craft8DescEdit: TEdit;
    Craft7CrewEdit: TEdit;
    Craft8CrewEdit: TEdit;
    Craft7ChkBx: TCheckBox;
    Craft8ChkBx: TCheckBox;
    Craft1CostEdit: TEdit;
    CostStatLbl: TLabel;
    Craft2CostEdit: TEdit;
    Craft3CostEdit: TEdit;
    Craft4CostEdit: TEdit;
    Craft5CostEdit: TEdit;
    Craft6CostEdit: TEdit;
    Craft7CostEdit: TEdit;
    Craft8CostEdit: TEdit;
    function TrapErrors : Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function GenerateCraftDetails : String;
    function IsVehicle(var VehicleChkBx : TCheckBox) : String;
  public
    { Public declarations }
  end;

var
  CraftFrm: TCraftFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TCraftFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close

begin
   Action := caFree;
end;

procedure TCraftFrm.OKBtnClick(Sender: TObject);
//check for errors and if okay send the data to the ship

begin
   if (TrapErrors) then begin
      Exit;
   end;

   //craft 1
   Ship.Craft.Cr1Num := StrToInt(Craft1NumEdit.Text);
   Ship.Craft.Cr1Tonnage := StrToFloat(RemoveCommas(Craft1SizeEdit.Text));
   Ship.Craft.Cr1Desc := Craft1DescEdit.Text;
   Ship.Craft.Cr1Crew := StrToInt(Craft1CrewEdit.Text);
   if (Craft1ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr1Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr1Vehicle := 0;
   end;
   Ship.Craft.Cr1Price := StrToFloat(RemoveCommas(Craft1CostEdit.Text));

   //craft 2
   Ship.Craft.Cr2Num := StrToInt(Craft2NumEdit.Text);
   Ship.Craft.Cr2Tonnage := StrToFloat(RemoveCommas(Craft2SizeEdit.Text));
   Ship.Craft.Cr2Desc := Craft2DescEdit.Text;
   Ship.Craft.Cr2Crew := StrToInt(Craft2CrewEdit.Text);
   if (Craft2ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr2Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr2Vehicle := 0;
   end;
   Ship.Craft.Cr2Price := StrToFloat(RemoveCommas(Craft2CostEdit.Text));

   //craft 3
   Ship.Craft.Cr3Num := StrToInt(Craft3NumEdit.Text);
   Ship.Craft.Cr3Tonnage := StrToFloat(RemoveCommas(Craft3SizeEdit.Text));
   Ship.Craft.Cr3Desc := Craft3DescEdit.Text;
   Ship.Craft.Cr3Crew := StrToInt(Craft3CrewEdit.Text);
   if (Craft3ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr3Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr3Vehicle := 0;
   end;
   Ship.Craft.Cr3Price := StrToFloat(RemoveCommas(Craft3CostEdit.Text));

   //craft 4
   Ship.Craft.Cr4Num := StrToInt(Craft4NumEdit.Text);
   Ship.Craft.Cr4Tonnage := StrToFloat(RemoveCommas(Craft4SizeEdit.Text));
   Ship.Craft.Cr4Desc := Craft4DescEdit.Text;
   Ship.Craft.Cr4Crew := StrToInt(Craft4CrewEdit.Text);
   if (Craft4ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr4Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr4Vehicle := 0;
   end;
   Ship.Craft.Cr4Price := StrToFloat(RemoveCommas(Craft4CostEdit.Text));

   //craft 5
   Ship.Craft.Cr5Num := StrToInt(Craft5NumEdit.Text);
   Ship.Craft.Cr5Tonnage := StrToFloat(RemoveCommas(Craft5SizeEdit.Text));
   Ship.Craft.Cr5Desc := Craft5DescEdit.Text;
   Ship.Craft.Cr5Crew := StrToInt(Craft5CrewEdit.Text);
   if (Craft5ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr5Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr5Vehicle := 0;
   end;
   Ship.Craft.Cr5Price := StrToFloat(RemoveCommas(Craft5CostEdit.Text));

   //craft 6
   Ship.Craft.Cr6Num := StrToInt(Craft6NumEdit.Text);
   Ship.Craft.Cr6Tonnage := StrToFloat(RemoveCommas(Craft6SizeEdit.Text));
   Ship.Craft.Cr6Desc := Craft6DescEdit.Text;
   Ship.Craft.Cr6Crew := StrToInt(Craft6CrewEdit.Text);
   if (Craft6ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr6Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr6Vehicle := 0;
   end;
   Ship.Craft.Cr6Price := StrToFloat(RemoveCommas(Craft6CostEdit.Text));

   //craft 7
   Ship.Craft.Cr7Num := StrToInt(Craft7NumEdit.Text);
   Ship.Craft.Cr7Tonnage := StrToFloat(RemoveCommas(Craft7SizeEdit.Text));
   Ship.Craft.Cr7Desc := Craft7DescEdit.Text;
   Ship.Craft.Cr7Crew := StrToInt(Craft7CrewEdit.Text);
   if (Craft7ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr7Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr7Vehicle := 0;
   end;
   Ship.Craft.Cr7Price := StrToFloat(RemoveCommas(Craft7CostEdit.Text));

   //craft 8
   Ship.Craft.Cr8Num := StrToInt(Craft8NumEdit.Text);
   Ship.Craft.Cr8Tonnage := StrToFloat(RemoveCommas(Craft8SizeEdit.Text));
   Ship.Craft.Cr8Desc := Craft8DescEdit.Text;
   Ship.Craft.Cr8Crew := StrToInt(Craft8CrewEdit.Text);
   if (Craft8ChkBx.State = cbChecked) then begin
      Ship.Craft.Cr8Vehicle := 1;
   end
   else begin
      Ship.Craft.Cr8Vehicle := 0;
   end;
   Ship.Craft.Cr8Price := StrToFloat(RemoveCommas(Craft8CostEdit.Text));

   //fighter squadrons and launch facilities
   Ship.Craft.FtrSqd := StrToInt(FtrSqdEdit.Text);
   Ship.Craft.LF1Num := StrToInt(LF1NumEdit.Text);
   Ship.Craft.LF1Size := StrToFloat(RemoveCommas(LF1SizeEdit.Text));
   Ship.Craft.LF2Num := StrToInt(LF2NumEdit.Text);
   Ship.Craft.LF2Size := StrToFloat(RemoveCommas(LF2SizeEdit.Text));
   Ship.DesignShip;
   MainFrm.RefreshForm;
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TCraftFrm.CancelBtnClick(Sender: TObject);
//close the form without applying the changes

begin
   Close;
end;

procedure TCraftFrm.FormCreate(Sender: TObject);
//create the form and fill with data from the ship

begin
   //craft 1
   Craft1NumEdit.Text := IntToStr(Ship.Craft.Cr1Num);
   Craft1SizeEdit.Text := FloatToStrF(Ship.Craft.Cr1Tonnage, ffNumber, 18, 3);
   Craft1DescEdit.Text := Ship.Craft.Cr1Desc;
   Craft1CrewEdit.Text := IntToStr(Ship.Craft.Cr1Crew);
   if (Ship.Craft.Cr1Vehicle = 1) then begin
      Craft1ChkBx.State := cbChecked;
   end
   else begin
      Craft1ChkBx.State := cbUnchecked;
   end;
   Craft1CostEdit.Text := FloatToStrF(Ship.Craft.Cr1Price, ffNumber, 18, 3);

   //craft 2
   Craft2NumEdit.Text := IntToStr(Ship.Craft.Cr2Num);
   Craft2SizeEdit.Text := FloatToStrF(Ship.Craft.Cr2Tonnage, ffNumber, 18, 3);
   Craft2DescEdit.Text := Ship.Craft.Cr2Desc;
   Craft2CrewEdit.Text := IntToStr(Ship.Craft.Cr2Crew);
   if (Ship.Craft.Cr2Vehicle = 1) then begin
      Craft2ChkBx.State := cbChecked;
   end
   else begin
      Craft2ChkBx.State := cbUnchecked;
   end;
   Craft2CostEdit.Text := FloatToStrF(Ship.Craft.Cr2Price, ffNumber, 18, 3);

   //craft 3
   Craft3NumEdit.Text := IntToStr(Ship.Craft.Cr3Num);
   Craft3SizeEdit.Text := FloatToStrF(Ship.Craft.Cr3Tonnage, ffNumber, 18, 3);
   Craft3DescEdit.Text := Ship.Craft.Cr3Desc;
   Craft3CrewEdit.Text := IntToStr(Ship.Craft.Cr3Crew);
   if (Ship.Craft.Cr3Vehicle = 1) then begin
      Craft3ChkBx.State := cbChecked;
   end
   else begin
      Craft3ChkBx.State := cbUnchecked;
   end;
   Craft3CostEdit.Text := FloatToStrF(Ship.Craft.Cr3Price, ffNumber, 18, 3);

   //craft 4
   Craft4NumEdit.Text := IntToStr(Ship.Craft.Cr4Num);
   Craft4SizeEdit.Text := FloatToStrF(Ship.Craft.Cr4Tonnage, ffNumber, 18, 3);
   Craft4DescEdit.Text := Ship.Craft.Cr4Desc;
   Craft4CrewEdit.Text := IntToStr(Ship.Craft.Cr4Crew);
   if (Ship.Craft.Cr4Vehicle = 1) then begin
      Craft4ChkBx.State := cbChecked;
   end
   else begin
      Craft4ChkBx.State := cbUnchecked;
   end;
   Craft4CostEdit.Text := FloatToStrF(Ship.Craft.Cr4Price, ffNumber, 18, 3);

   //craft 5
   Craft5NumEdit.Text := IntToStr(Ship.Craft.Cr5Num);
   Craft5SizeEdit.Text := FloatToStrF(Ship.Craft.Cr5Tonnage, ffNumber, 18, 3);
   Craft5DescEdit.Text := Ship.Craft.Cr5Desc;
   Craft5CrewEdit.Text := IntToStr(Ship.Craft.Cr5Crew);
   if (Ship.Craft.Cr5Vehicle = 1) then begin
      Craft5ChkBx.State := cbChecked;
   end
   else begin
      Craft5ChkBx.State := cbUnchecked;
   end;
   Craft5CostEdit.Text := FloatToStrF(Ship.Craft.Cr5Price, ffNumber, 18, 3);

   //craft 6
   Craft6NumEdit.Text := IntToStr(Ship.Craft.Cr6Num);
   Craft6SizeEdit.Text := FloatToStrF(Ship.Craft.Cr6Tonnage, ffNumber, 18, 3);
   Craft6DescEdit.Text := Ship.Craft.Cr6Desc;
   Craft6CrewEdit.Text := IntToStr(Ship.Craft.Cr6Crew);
   if (Ship.Craft.Cr6Vehicle = 1) then begin
      Craft6ChkBx.State := cbChecked;
   end
   else begin
      Craft6ChkBx.State := cbUnchecked;
   end;
   Craft6CostEdit.Text := FloatToStrF(Ship.Craft.Cr6Price, ffNumber, 18, 3);

   //craft 7
   Craft7NumEdit.Text := IntToStr(Ship.Craft.Cr7Num);
   Craft7SizeEdit.Text := FloatToStrF(Ship.Craft.Cr7Tonnage, ffNumber, 18, 3);
   Craft7DescEdit.Text := Ship.Craft.Cr7Desc;
   Craft7CrewEdit.Text := IntToStr(Ship.Craft.Cr7Crew);
   if (Ship.Craft.Cr7Vehicle = 1) then begin
      Craft7ChkBx.State := cbChecked;
   end
   else begin
      Craft7ChkBx.State := cbUnchecked;
   end;
   Craft7CostEdit.Text := FloatToStrF(Ship.Craft.Cr7Price, ffNumber, 18, 3);

   //craft 8
   Craft8NumEdit.Text := IntToStr(Ship.Craft.Cr8Num);
   Craft8SizeEdit.Text := FloatToStrF(Ship.Craft.Cr8Tonnage, ffNumber, 18, 3);
   Craft8DescEdit.Text := Ship.Craft.Cr8Desc;
   Craft8CrewEdit.Text := IntToStr(Ship.Craft.Cr8Crew);
   if (Ship.Craft.Cr8Vehicle = 1) then begin
      Craft8ChkBx.State := cbChecked;
   end
   else begin
      Craft8ChkBx.State := cbUnchecked;
   end;
   Craft8CostEdit.Text := FloatToStrF(Ship.Craft.Cr8Price, ffNumber, 18, 3);

   //fighter squadrons and launch facilities
   FtrSqdEdit.Text := IntToStr(Ship.Craft.FtrSqd);
   LF1NumEdit.Text := IntToStr(Ship.Craft.LF1Num);
   LF1SizeEdit.Text := FloatToStrF(Ship.Craft.LF1Size, ffNumber, 18, 3);
   LF2NumEdit.Text := IntToStr(Ship.Craft.LF2Num);
   LF2SizeEdit.Text := FloatToStrF(Ship.Craft.LF2Size, ffNumber, 18, 3);
end;

function TCraftFrm.TrapErrors: Boolean;
//check for errors and display an appropriate message

begin
   Result := False;
   if (Craft1NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 1 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft1SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 1 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft1DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 1 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft1CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 1 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft1CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 1 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft2NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 2 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft2SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 2 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft2DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 2 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft2CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 2 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft2CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 2 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft3NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 3 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft3SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 3 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft3DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 3 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft3CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 3 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft3CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 3 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft4NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 4 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft4SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 4 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft4DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 4 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft4CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 4 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft4CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 4 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft5NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 5 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft5SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 5 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft5DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 5 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft5CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 5 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft5CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 5 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft6NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 6 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft6SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 6 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft6DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 6 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft6CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 6 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft6CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 6 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft7NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 7 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft7SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 7 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft7DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 7 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft7CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 7 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft7CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 7 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft8NumEdit.Text = '') then begin
      MessageDlg('No number entered for Craft 8 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft8SizeEdit.Text = '') then begin
      MessageDlg('Tonnage not entered for Craft 8 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft8DescEdit.Text = '') then begin
      MessageDlg('No Description entered for Craft 8 (this may be "None")', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft8CrewEdit.Text = '') then begin
      MessageDlg('No Crew entered for Craft 8 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (Craft8CostEdit.Text = '') then begin
      MessageDlg('No Cost entered for Craft 8 (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (FtrSqdEdit.Text = '') then begin
      MessageDlg('Number of Fighter Squadrons not entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LF1NumEdit.Text = '') then begin
      MessageDlg('Number of Launch Tubes not entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LF1SizeEdit.Text = '') then begin
      MessageDlg('Maximum Size of Launch Tubes not entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LF2NumEdit.Text = '') then begin
      MessageDlg('Number of Launch Tubes not entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (LF2SizeEdit.Text = '') then begin
      MessageDlg('Maximum Size of Launch Tubes not entered (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft1NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft1NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 1 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft1SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft1SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 1 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft1CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft1CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 1 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft1CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft1CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 1 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft2NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft2NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 2 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft2SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft2SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 2 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft2CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft2CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 2 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft2CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft2CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 2 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft3NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft3NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 3 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft3SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft3SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 3 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft3CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft3CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 3 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft3CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft3CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 3 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft4NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft4NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 4 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft4SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft4SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 4 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft4CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft4CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 4 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft4CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft4CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 4 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft5NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft5NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 5 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft5SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft5SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 5 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft5CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft5CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 5 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft5CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft5CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 5 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft6NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft6NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 6 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft6SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft6SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 6 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft6CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft6CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 6 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft6CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft6CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 6 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft7NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft7NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 7 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft7SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft7SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 7 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft7CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft7CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 7 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft7CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft7CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 7 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft8NumEdit.Text, 3) = 3) and
         (StrToIntDef(Craft8NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Craft 8 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft8SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft8SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Tonnage of Craft 8 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(Craft8CrewEdit.Text, 3) = 3) and
         (StrToIntDef(Craft8CrewEdit.Text, 2) = 2) then begin
      MessageDlg('Crew of Craft 8 must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(Craft8CostEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(Craft8CostEdit.Text), 2) = 2) then begin
      MessageDlg('Cost of Craft 8 must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(FtrSqdEdit.Text, 3) = 3) and
         (StrToIntDef(FtrSqdEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Fighter Squadrons must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(LF1NumEdit.Text, 3) = 3) and
         (StrToIntDef(LF1NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Launch Tubes must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(LF1SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(LF1SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Maximum Size of Launch Tubes must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToIntDef(LF2NumEdit.Text, 3) = 3) and
         (StrToIntDef(LF2NumEdit.Text, 2) = 2) then begin
      MessageDlg('Number of Launch Tubes must be an Integer (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloatDef(RemoveCommas(LF2SizeEdit.Text), 3) = 3) and
         (StrToFloatDef(RemoveCommas(LF2SizeEdit.Text), 2) = 2) then begin
      MessageDlg('Maximum Size of Launch Tubes must be a Floating Point Value (this may be zero)', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft1NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 1 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft1SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 1 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft1CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 1 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft1CostEdit.Text) < 0) then begin
      MessageDlg('Craft 1 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft2NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 2 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft2SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 2 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft2CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 2 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft2CostEdit.Text) < 0) then begin
      MessageDlg('Craft 2 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft3NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 3 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft3SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 3 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft3CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 3 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft3CostEdit.Text) < 0) then begin
      MessageDlg('Craft 3 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft4NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 4 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft4SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 4 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft4CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 4 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft4CostEdit.Text) < 0) then begin
      MessageDlg('Craft 4 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft5NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 5 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft5SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 5 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft5CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 5 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft5CostEdit.Text) < 0) then begin
      MessageDlg('Craft 5 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft6NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 6 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft6SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 6 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft6CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 6 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft6CostEdit.Text) < 0) then begin
      MessageDlg('Craft 6 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft7NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 7 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft7SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 7 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft7CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 7 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft7CostEdit.Text) < 0) then begin
      MessageDlg('Craft 7 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft8NumEdit.Text) < 0) then begin
      MessageDlg('Number of Craft 8 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(Craft8SizeEdit.Text)) < 0) then begin
      MessageDlg('Tonnage of Craft 8 may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(Craft8CrewEdit.Text) < 0) then begin
      MessageDlg('Craft 8 Crew may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(Craft8CostEdit.Text) < 0) then begin
      MessageDlg('Craft 8 Cost may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(FtrSqdEdit.Text) < 0) then begin
      MessageDlg('Number of Fighter Squadrons may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(LF1NumEdit.Text) < 0) then begin
      MessageDlg('Number of Launch Tubes may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(LF1SizeEdit.Text)) < 0) then begin
      MessageDlg('Maximum Size of Launch Tubes may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToInt(LF2NumEdit.Text) < 0) then begin
      MessageDlg('Number of Launch Tubes may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
   if (StrToFloat(RemoveCommas(LF2SizeEdit.Text)) < 0) then begin
      MessageDlg('Maximum Size of Launch Tubes may not be a Negative Number', mtError, [mbOk], 0);
      Result := True;
      Exit;
   end;
end;

procedure TCraftFrm.FormKeyDown(Sender: TObject; var Key: Word;
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
         FullShipData.Add(GenerateCraftDetails);
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

function TCraftFrm.GenerateCraftDetails: String;
//generate craft file details

begin
   Result := Craft1NumEdit.Text
            + SEP + RemoveCommas(Craft1SizeEdit.Text)
            + SEP + TEXTMARK + Craft1DescEdit.Text + TEXTMARK
            + SEP + Craft1CrewEdit.Text
            + SEP + IsVehicle(Craft1ChkBx)
            + SEP + RemoveCommas(Craft1CostEdit.Text)
         + SEP + Craft2NumEdit.Text
            + SEP + RemoveCommas(Craft2SizeEdit.Text)
            + SEP + TEXTMARK + Craft2DescEdit.Text + TEXTMARK
            + SEP + Craft2CrewEdit.Text
            + SEP + IsVehicle(Craft2ChkBx)
            + SEP + RemoveCommas(Craft2CostEdit.Text)
         + SEP + Craft3NumEdit.Text
            + SEP + RemoveCommas(Craft3SizeEdit.Text)
            + SEP + TEXTMARK + Craft3DescEdit.Text + TEXTMARK
            + SEP + Craft3CrewEdit.Text
            + SEP + IsVehicle(Craft3ChkBx)
            + SEP + RemoveCommas(Craft3CostEdit.Text)
         + SEP + Craft4NumEdit.Text
            + SEP + RemoveCommas(Craft4SizeEdit.Text)
            + SEP + TEXTMARK + Craft4DescEdit.Text + TEXTMARK
            + SEP + Craft4CrewEdit.Text
            + SEP + IsVehicle(Craft4ChkBx)
            + SEP + RemoveCommas(Craft4CostEdit.Text)
         + SEP + Craft5NumEdit.Text
            + SEP + RemoveCommas(Craft5SizeEdit.Text)
            + SEP + TEXTMARK + Craft5DescEdit.Text + TEXTMARK
            + SEP + Craft5CrewEdit.Text
            + SEP + IsVehicle(Craft5ChkBx)
            + SEP + RemoveCommas(Craft5CostEdit.Text)
         + SEP + Craft6NumEdit.Text
            + SEP + RemoveCommas(Craft6SizeEdit.Text)
            + SEP + TEXTMARK + Craft6DescEdit.Text + TEXTMARK
            + SEP + Craft6CrewEdit.Text
            + SEP + IsVehicle(Craft6ChkBx)
            + SEP + RemoveCommas(Craft6CostEdit.Text)
         + SEP + Craft7NumEdit.Text
            + SEP + RemoveCommas(Craft7SizeEdit.Text)
            + SEP + TEXTMARK + Craft7DescEdit.Text + TEXTMARK
            + SEP + Craft7CrewEdit.Text
            + SEP + IsVehicle(Craft7ChkBx)
            + SEP + RemoveCommas(Craft7CostEdit.Text)
         + SEP + Craft8NumEdit.Text
            + SEP + RemoveCommas(Craft8SizeEdit.Text)
            + SEP + TEXTMARK + Craft8DescEdit.Text + TEXTMARK
            + SEP + Craft8CrewEdit.Text
            + SEP + IsVehicle(Craft8ChkBx)
            + SEP + RemoveCommas(Craft8CostEdit.Text)

         //fighter squadrons and launch facilities info
         + SEP + FtrSqdEdit.Text
         + SEP + LF1NumEdit.Text
            + SEP + RemoveCommas(LF1SizeEdit.Text)
         + SEP + LF2NumEdit.Text
            + SEP + RemoveCommas(LF2SizeEdit.Text)
         + SEP + '0'     //wiggle room
         + SEP + '0'     //wiggle room
         + SEP + '0';    //wiggle room
end;

function TCraftFrm.IsVehicle(var VehicleChkBx: TCheckBox): String;
//check to see if craft is vehicle

begin
   Result := '0';
   if (VehicleChkBx.Checked) then begin
      Result := '1';
   end;
end;

end.
