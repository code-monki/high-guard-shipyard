unit CommentsFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, HgsFormFrm;

type
  TCommentsFrm = class(THgsForm)
    OkBtn: TButton;
    CancelBtn: TButton;
    CommentMemo: TMemo;
    ClearBtn: TButton;
    RestoreBtn: TButton;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure RestoreBtnClick(Sender: TObject);
  private
    { Private declarations }
    BakComments : TStringList;
    function Warn (TheMessage: String) : Boolean;
  public
    { Public declarations }
  end;

const
   mbYesNo = [mbYes, mbNo];
var
  CommentsFrm: TCommentsFrm;

implementation

uses ShipPas, MainPas;

{$R *.lfm}

procedure TCommentsFrm.CancelBtnClick(Sender: TObject);
//close the form without applying the changes

begin
   Close;
end;

procedure TCommentsFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//clean up and close the form

begin
   FreeAndNil(BakComments);
   Action := caFree;
end;

procedure TCommentsFrm.OkBtnClick(Sender: TObject);
//send the comments to the ship

begin
   Ship.ShipComments.Clear;
   Ship.ShipComments.AddStrings(CommentMemo.Lines);
   Ship.HasChanged := True;
   MainFrm.SaveMenuItem.Enabled := True;
   MainFrm.RestoreMenuItem.Enabled := True;
   Close;
end;

procedure TCommentsFrm.FormCreate(Sender: TObject);
//get the current ship comments

begin
   BakComments := TStringList.Create;
   CommentMemo.Lines.Clear;
   CommentMemo.Lines.AddStrings(Ship.ShipComments);
end;

procedure TCommentsFrm.ClearBtnClick(Sender: TObject);
//clear the comments

begin
   if (Warn('Do you want to clear the comments?')) then begin
      BakComments.Clear;
      BakComments.AddStrings(CommentMemo.Lines);
      CommentMemo.Lines.Clear;
      RestoreBtn.Enabled := True;
      RestoreBtn.Visible := True;
   end;
end;

function TCommentsFrm.Warn(TheMessage: String): Boolean;
//display a warning message and get a yes no answer

begin
   if (MessageDlg(TheMessage, mtWarning, mbYesNo, 0) = mrYes) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TCommentsFrm.RestoreBtnClick(Sender: TObject);
//restore the ship comments from the backup

begin
   if (Warn('Do you wish to restore the previous comments?')) then begin
      CommentMemo.Lines.Clear;
      CommentMemo.Lines.AddStrings(BakComments);
      RestoreBtn.Enabled := False;
      RestoreBtn.Visible := False;
   end;
end;

end.
