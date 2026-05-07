unit AboutBoxFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, HgsFormFrm;

type

  { TAboutBoxFrm }

  TAboutBoxFrm = class(THgsForm)
    OKBitBtn: TBitBtn;
    AboutMemo: TMemo;
    NameStatLbl: TLabel;
    VersionLbl: TLabel;
    StarshipsListLbl: TLabel;
    QuikLinkLbl: TLabel;
    FarFutureLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FarFutureLblClick(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure QuikLinkLblClick(Sender: TObject);
    procedure StarshipsListLblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBoxFrm: TAboutBoxFrm;

implementation

{$R *.lfm}

{ TAboutBoxFrm }

procedure TAboutBoxFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//close the form

begin
  Action := caFree;
end;

procedure TAboutBoxFrm.FormCreate(Sender: TObject);
//create the form and fill the elements

var
  VerNum : String;
begin
  VerNum := '1.3.1.4';
  VersionLbl.Caption := 'Version ' + VerNum;
  AboutMemo.Lines.Clear;
  AboutMemo.Lines.LoadFromFile('Licence.txt');
end;

procedure TAboutBoxFrm.FarFutureLblClick(Sender: TObject);
//go to far future page

begin
  ShowWebPage('http://www.farfuture.net');
end;

procedure TAboutBoxFrm.OKBitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TAboutBoxFrm.QuikLinkLblClick(Sender: TObject);
//go to QLI page

begin
  ShowWebPage('http://www.rpgrealms.com/');
end;

procedure TAboutBoxFrm.StarshipsListLblClick(Sender: TObject);
//go to CT-Starphip page

begin
  ShowWebPage('http://groups.yahoo.com/group/ct-starships/');
end;

end.

