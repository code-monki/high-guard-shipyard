unit LorenSplashFrmPas;

{$mode delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, HgsFormFrm;

type

  { TLorenSplashFrm }

  TLorenSplashFrm = class(THgsForm)
    DontShowChkBox: TCheckBox;
    DonateBtn: TButton;
    CloseBtn: TButton;
    LorenMemo: TMemo;
    procedure CloseBtnClick(Sender: TObject);
    procedure DonateBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  LorenSplashFrm: TLorenSplashFrm;

implementation

{$R *.lfm}

{ TLorenSplashFrm }

procedure TLorenSplashFrm.FormCreate(Sender: TObject);
begin
  //
end;

procedure TLorenSplashFrm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TLorenSplashFrm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TLorenSplashFrm.DonateBtnClick(Sender: TObject);
begin
  ShowWebPage('http://www.paypal.com');
  Close;
end;

end.

