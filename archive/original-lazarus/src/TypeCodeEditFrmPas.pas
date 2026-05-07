unit TypeCodeEditFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math, ShipPas;

type
  TTypeCodeEditFrm = class(TForm)
    TypeCombo: TComboBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    AddBtn: TButton;
    DeleteBtn: TButton;
    TypeStatLbl: TLabel;
    CodeStatLbl: TLabel;
    CodeEdit: TEdit;
    CodeLbl: TLabel;
    TypeEdit: TEdit;
    NewTypeStatLbl: TLabel;
    NewCodeStatLbl: TLabel;
    ConfirmBtn: TButton;
    AbortBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TypeComboChange(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure AbortBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ConfirmBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
  private
    { Private declarations }
    fTypeCodeList : TStringList;
    fCodeList : TStringList;
    function Confirm(TheMessage : String) : Boolean;
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];  //use this for the yes/no dialog box

   var
  TypeCodeEditFrm: TTypeCodeEditFrm;

implementation

{$R *.lfm}

procedure TTypeCodeEditFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//clean up after

begin
   FreeAndNil(fTypeCodeList);
   FreeAndNil(fCodeList);
   Action := caFree;
end;

procedure TTypeCodeEditFrm.FormCreate(Sender: TObject);
//create the type code list and fill it

var
   iCount : Integer;
   SubList : TStringList;
begin
   fTypeCodeList := TStringList.Create;
   fCodeList := TStringList.Create;
   SubList := TStringList.Create;
   try
      NewTypeStatLbl.Visible := False;
      NewCodeStatLbl.Visible := False;
      TypeEdit.Visible := False;
      TypeEdit.Text := '';
      CodeEdit.Visible := False;
      CodeEdit.Text := '';
      ConfirmBtn.Visible := False;
      AbortBtn.Visible := False;
      fTypeCodeList.LoadFromFile(Ship.HomeDir + 'TypeCode');
      TypeCombo.Clear;
      CodeLbl.Caption := '';
      fCodeList.Clear;
      for iCount := 0 to fTypeCodeList.Count - 1 do begin
         SubList.CommaText := fTypeCodeList[iCount];
         TypeCombo.Items.Add(SubList[0]);
         fCodeList.Add(SubList[1]);
      end;
      TypeCombo.ItemIndex := 0;
      CodeLbl.Caption := fCodeList[0];
   finally
      FreeAndNil(SubList);
   end;
end;

procedure TTypeCodeEditFrm.TypeComboChange(Sender: TObject);
begin
   CodeLbl.Caption := fCodeList[TypeCombo.ItemIndex];
end;

procedure TTypeCodeEditFrm.AddBtnClick(Sender: TObject);
//show the add new code controls and disable all others

begin
   NewTypeStatLbl.Visible := True;
   NewCodeStatLbl.Visible := True;
   TypeEdit.Visible := True;
   TypeEdit.Text := '';
   CodeEdit.Visible := True;
   CodeEdit.Text := '';
   ConfirmBtn.Visible := True;
   AbortBtn.Visible := True;
   TypeStatLbl.Enabled := False;
   TypeCombo.Enabled := False;
   CodeStatLbl.Enabled := False;
   CodeLbl.Enabled := False;
   AddBtn.Enabled := False;
   DeleteBtn.Enabled := False;
   OkBtn.Enabled := False;
   CancelBtn.Enabled := False;
end;

procedure TTypeCodeEditFrm.AbortBtnClick(Sender: TObject);
//hide the add code controls and enable all others

begin
   NewTypeStatLbl.Visible := False;
   NewCodeStatLbl.Visible := False;
   TypeEdit.Visible := False;
   TypeEdit.Text := '';
   CodeEdit.Visible := False;
   CodeEdit.Text := '';
   ConfirmBtn.Visible := False;
   AbortBtn.Visible := False;
   TypeStatLbl.Enabled := True;
   TypeCombo.Enabled := True;
   CodeStatLbl.Enabled := True;
   CodeLbl.Enabled := True;
   AddBtn.Enabled := True;
   DeleteBtn.Enabled := True;
   OkBtn.Enabled := True;
   CancelBtn.Enabled := True;
end;

procedure TTypeCodeEditFrm.OkBtnClick(Sender: TObject);
//apply any alterations and close the form

begin
   fTypeCodeList.SaveToFile(Ship.HomeDir + 'TypeCode');
   Close;
end;

procedure TTypeCodeEditFrm.CancelBtnClick(Sender: TObject);
//close the form without applying any changes

begin
   Close;
end;

procedure TTypeCodeEditFrm.ConfirmBtnClick(Sender: TObject);
//add the new code to the list, hide the add code controls and enable all others

var
   NewTypeCode : String;
begin
   //error trapping here
   if (TypeEdit.Text = '') then begin
      MessageDlg('No Type Entered', mtError, [mbOk], 0);
      Exit;
   end;
   if (CodeEdit.Text = '') then begin
      MessageDlg('No Code Entered', mtError, [mbOk], 0);
      Exit;
   end;
   NewTypeCode := '"' + TypeEdit.Text + '","' + CodeEdit.Text + '"';
   fTypeCodeList.Add(NewTypeCode);
   TypeCombo.Items.Add(TypeEdit.Text);
   fCodeList.Add(CodeEdit.Text);
   AbortBtnClick(Self);
end;

procedure TTypeCodeEditFrm.DeleteBtnClick(Sender: TObject);
//delete the current code

var
   CurrentItem : Integer;
begin
   if (Confirm('Do You Want to delete the current Code')) then begin
      CurrentItem := TypeCombo.ItemIndex;
      fCodeList.Delete(CurrentItem);
      fTypeCodeList.Delete(CurrentItem);
      TypeCombo.Items.Delete(CurrentItem);
      CurrentItem := Max(0, Min(Pred(fTypeCodeList.Count), Pred(CurrentItem)));
      TypeCombo.ItemIndex := CurrentItem;
      CodeLbl.Caption := fCodeList[CurrentItem];
   end;
end;

function TTypeCodeEditFrm.Confirm(TheMessage: String): Boolean;
//display a message and allow the user to make a yes/no choice

begin
   if (MessageDlg(TheMessage, mtConfirmation, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

end.
