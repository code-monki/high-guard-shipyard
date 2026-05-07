unit HgsFormFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellApi;

type

  { THgsForm }

  THgsForm = class(TForm)
  private
    FTestBoolean: Boolean;
    FTestExtended: Extended;
    FTestInteger: Integer;
    FTestString: String;
    procedure SetTestBoolean(const AValue: Boolean);
    procedure SetTestExtended(const AValue: Extended);
    procedure SetTestInteger(const AValue: Integer);
    procedure SetTestString(const AValue: String);
    { Private declarations }
  public
    { Public declarations }
    property TestString: String read FTestString write SetTestString;
    property TestInteger: Integer read FTestInteger write SetTestInteger;
    property TestExtended: Extended read FTestExtended write SetTestExtended;
    property TestBoolean: Boolean read FTestBoolean write SetTestBoolean;
  published
    { Published declarations }
  protected
    { Protected declarations }
    function RemoveCommas(Text : String) : String;
    function StrToFloatDef(const S: string; Default: Extended): Extended;
    procedure ShowWebPage(TheUrl : String);
  end;

var
  HgsForm: THgsForm;
  iTest: Integer;
  eTest: Extended;
  sTest: String;
  bTest: Boolean;

implementation

{$R *.DFM}

{ TForm1 }

procedure THgsForm.SetTestString(const AValue: String);
begin
  if FTestString=AValue then exit;
  FTestString:=AValue;
end;

procedure THgsForm.SetTestInteger(const AValue: Integer);
begin
  if FTestInteger=AValue then exit;
  FTestInteger:=AValue;
end;

procedure THgsForm.SetTestExtended(const AValue: Extended);
begin
  if FTestExtended=AValue then exit;
  FTestExtended:=AValue;
end;

procedure THgsForm.SetTestBoolean(const AValue: Boolean);
begin
  if FTestBoolean=AValue then exit;
  FTestBoolean:=AValue;
end;

function THgsForm.RemoveCommas(Text: String): String;
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

procedure THgsForm.ShowWebPage(TheUrl: String);
//open a web page

begin
	ShellExecute(0,'open',pchar(TheUrl),nil,nil,SW_MAXIMIZE);
end;

function THgsForm.StrToFloatDef(const S: string;
  Default: Extended): Extended;
//like StrToIntDef but with real numbers

begin
  if not TextToFloat(PChar(S), Result, fvExtended) then
    Result := Default;
end;

end.
