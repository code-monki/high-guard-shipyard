unit SplashPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TSplashFrm = class(TForm)
    SplashTimer: TTimer;
    CopyrightMemo: TMemo;
    SplashImage: TImage;
    TitleLbl: TLabel;
    procedure SplashTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashFrm: TSplashFrm;

implementation

{$R *.lfm}

procedure TSplashFrm.SplashTimerTimer(Sender: TObject);
//close the form when the timer fires

begin
   SplashTimer.Enabled := False;
   Close;
end;

procedure TSplashFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close

begin
   Action := caFree;
end;

procedure TSplashFrm.FormCreate(Sender: TObject);
//display the copyright notice, create  file if neccessary

var
  CurYear, CurMonth, CurDay : Word;
  ReleaseDate : TDate;
  HomeDir : String;
begin
  HomeDir := ExtractFilePath(Application.ExeName);
  ReleaseDate := EncodeDate(2001, 11, 13);//'13/11/2001';
  DecodeDate(Date, CurYear, CurMonth, CurDay);
  CopyRightMemo.Clear;
  if (FileExists(HomeDir + 'CopyNote') { *Converted from FileExists*  } { *Converted from FileExists*  }) and
        (FileAge(HomeDir + 'CopyNote') { *Converted from FileAge*  } { *Converted from FileAge*  } < ReleaseDate) then begin
    CopyRightMemo.Lines.LoadFromFile(HomeDir + 'CopyNote');
  end
  else begin
    CopyRightMemo.Lines.Add('The Traveller game in all forms is owned by Far '
          + 'Future Enterprises. Copyright 1977-' + IntToStr(CurYear) + ' '
          + 'Far Future Enterprises. Traveller is a registered trademark of '
          + 'Far Future Enterprises. Far Future permits web sites and '
          + 'fanzines for this game, provided it contains this notice, that '
          + 'Far Future is notified, and subject to a withdrawal of '
          + 'permission on 90 days notice. This program is for personal, '
          + 'non-commercial use only. Any use of Far Future Enterprises'
          + #39 + 's copyrighted material or trademarks anywhere in this '
          + 'program and its files should not be viewed as a challenge to '
          + 'those copyrights or trademarks. In addition, this program '
          + 'cannot be republished or distributed without the consent of the '
          + 'author who contributed it.');
    CopyRightMemo.Lines.Add('');
    CopyRightMemo.Lines.Add('T20 and portions of this Program are copyright '
          + 'to Quiklink Interactive and are used with kind permission.');
    CopyRightMemo.Lines.Add('');
    CopyRightMemo.Lines.Add('By installing this program you are agreeing to '
          + 'the terms of the licence distributed with it. These terms are '
          + 'repeated in the about box.');
    CopyRightMemo.Lines.SaveToFile(HomeDir + 'CopyNote');
  end;
end;

procedure TSplashFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//toggle the timer on and off

begin
   if (Key = VK_F10) and (ssAlt in Shift) then begin
      if (SplashTimer.Enabled) then begin
         SplashTimer.Enabled := False;
      end
      else begin
         SplashTimer.Enabled := True;
      end;
   end;
end;

end.

