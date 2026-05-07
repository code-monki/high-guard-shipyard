program HGS;

{$MODE Delphi}

uses
  Forms,
  SysUtils,
  Classes,
  Controls, Interfaces,
  Registry,
  MainPas in 'MainPas.pas' {MainFrm},
  HullFrmPas in 'HullFrmPas.pas' {HullFrm},
  ShipFrmPas in 'ShipFrmPas.pas' {ShipFrm},
  AboutBoxFrmPas in 'AboutBoxFrmPas.pas' {AboutBoxFrm},
  EngFrmPas in 'EngFrmPas.pas' {EngFrm},
  FuelFrmPas in 'FuelFrmPas.pas' {FuelFrm},
  AvionicsFrmPas in 'AvionicsFrmPas.pas' {AvionicsFrm},
  SpnlMntFrmPas in 'SpnlMntFrmPas.pas' {SpnlMntFrm},
  LittleBaysFrmPas in 'LittleBaysFrmPas.pas' {LittleBaysFrm},
  BigBaysFrmPas in 'BigBaysFrmPas.pas' {BigBaysFrm},
  TurretsFrmPas in 'TurretsFrmPas.pas' {TurretsFrm},
  ScreensFrmPas in 'ScreensFrmPas.pas' {ScreensFrm},
  CraftFrmPas in 'CraftFrmPas.pas' {CraftFrm},
  AccomFrmPas in 'AccomFrmPas.pas' {AccomFrm},
  SqdFrmPas in 'SqdFrmPas.pas' {SqdFrm},
  ShipPas in 'ShipPas.pas',
  DataPas in 'DataPas.pas',
  ShipModulePas in 'ShipModulePas.pas',
  HullPas in 'HullPas.pas',
  EngPas in 'EngPas.pas',
  FuelPas in 'FuelPas.pas',
  AvionicsPas in 'AvionicsPas.pas',
  SpinalMountPas in 'SpinalMountPas.pas',
  BigBaysPas in 'BigBaysPas.pas',
  LittleBaysPas in 'LittleBaysPas.pas',
  TurretsPas in 'TurretsPas.pas',
  ScreensPas in 'ScreensPas.pas',
  CraftPas in 'CraftPas.pas',
  AccomPas in 'AccomPas.pas',
  AnalysisPas in 'AnalysisPas.pas',
  OptionsPas in 'OptionsPas.pas',
  OptionsFrmPas in 'OptionsFrmPas.pas' {OptionsFrm},
  DescExpPas in 'DescExpPas.pas',
  CommentsFrmPas in 'CommentsFrmPas.pas' {CommentsFrm},
  ErrorFrmPas in 'ErrorFrmPas.pas' {ErrorFrm},
  SplashPas in 'SplashPas.pas' {SplashFrm},
  DesAssistFrmPas in 'DesAssistFrmPas.pas' {DesAssistFrm},
  UserDefFrmPas in 'UserDefFrmPas.pas' {UserDefFrm},
  UserDefPas in 'UserDefPas.pas',
  TypeDisplayFrmPas in 'TypeDisplayFrmPas.pas' {TypeDisplayFrm},
  TypeCodeEditFrmPas in 'TypeCodeEditFrmPas.pas' {TypeCodeEditFrm},
  R20AvionicsFrmPas in 'R20AvionicsFrmPas.pas' {R20AvionicsFrm},
  CompExpPas in 'CompExpPas.pas',
  LorenSplashFrmPas in 'LorenSplashFrmPas' {LorenSplashFrm};

var
  Ship : TShip;

{$R *.res}

procedure CheckLicence;
//check the licence file exists and is current, replace if neccessary

var
  VerNum : String;
  HomeDir : String;
  ReleaseDate : TDateTime;
  LicenceList : TStringList;
  CurYear, CurMonth, CurDay : Word;
  LicenceNotCurrent : Boolean;
begin
  HomeDir := ExtractFilePath(Application.Exename);
  VerNum := '2.00';
  ReleaseDate := EncodeDate(2013, 03, 07);//'29/09/2011';
  DecodeDate(Date, CurYear, CurMonth, CurDay);
  if (FileAge(HomeDir + 'Licence.txt') { *Converted from FileAge*  } < ReleaseDate) then begin
    LicenceNotCurrent := True;
  end
  else begin
    LicenceNotCurrent := False;
  end;
  if (FileAge(HomeDir + 'Licence.txt') { *Converted from FileAge*  } < CurrentYear) then begin
    LicenceNotCurrent := True;
  end
  else begin
    LicenceNotCurrent := False;
  end;
  LicenceList := TStringList.Create;
  try
    if (LicenceNotCurrent) then begin
      LicenceList.Add('Traveller and High Guard are Registered Trademarks of '
          + 'Far Future Enterprises Copyright Far Future Enterprises 1977-'
          + IntToStr(CurYear) + '.');
      LicenceList.Add('');
      LicenceList.Add('Produced with kind permission');
      LicenceList.Add('');
      LicenceList.Add('T20 is copyright to Quiklink Interactive and is used '
          + 'with kind permission');
      LicenceList.Add('');
      LicenceList.Add('Beta Testers');
      LicenceList.Add('  Donald McKinney');
      LicenceList.Add('  Tom Rux');
      LicenceList.Add('  Idiot Savant');
      LicenceList.Add('  Ken Kazinski');
      LicenceList.Add('  Frank Pitt');
      LicenceList.Add('  Shadowcat');
      LicenceList.Add('  The Entire CT-Starships Mailing List');
      LicenceList.Add('    (http://groups.yahoo.com/group/ct-starships)');
      LicenceList.Add('');
      LicenceList.Add('High Guard Shipyard v' + VerNum);
      LicenceList.Add('© 2000-' + IntToStr(CurYear) + ' Andrea Vallance');
      LicenceList.Add('Release Date: ' + DateTimeToStr(ReleaseDate));
      LicenceList.Add('Email: andrea.inchch@gmail.com');
      LicenceList.Add('');
      LicenceList.Add('BY INSTALLING THIS SOFTWARE, YOU ARE INDICATING '
          + 'ACCEPTANCE OF THE TERMS OF THE FOLLOWING LICENSE AGREEMENT:');
      LicenceList.Add('');
      LicenceList.Add('In Simple Terms:');
      LicenceList.Add('You' + #39 + 're free to use this software, copy it and '
          + 'give it to others but you can' + #39 + 't reverse engineer it or '
          + 'distribute partial copies. If anything goes wrong, I' + #39 + 'd '
          + 'like to hear about it, but I don' + #39 + 't accept liability for '
          + 'losses of any kind. High Guard and Traveller are Copyright to and '
          + 'Trademarks of Far Future Enterprises, however they didn' + #39 + 't '
          + 'write this and aren' + #39 + 't responsible for it.');
      LicenceList.Add('');
      LicenceList.Add('');
      LicenceList.Add('In Legal Terms:');
      LicenceList.Add('This End-User License Agreement ("EULA") is a legal '
          + 'agreement between you (either an individual or a single entity) '
          + 'and the author of the software product identified above, which '
          + 'includes computer software and may include associated media, '
          + 'printed materials, and "online" or electronic documentation '
          + '("SOFTWARE PRODUCT"). By installing, copying, or otherwise using '
          + 'the SOFTWARE PRODUCT, you agree to be bound by the terms of this '
          + 'EULA. If you do not agree to the terms of this EULA, do not install '
          + 'or use the SOFTWARE PRODUCT.');
      LicenceList.Add('');
      LicenceList.Add('SOFTWARE PRODUCT LICENSE The SOFTWARE PRODUCT is '
          + 'protected by copyright laws and international copyright treaties, '
          + 'as well as other intellectual property laws and treaties. The '
          + 'SOFTWARE PRODUCT is licensed, not sold.');
      LicenceList.Add('');
      LicenceList.Add('1. GRANT OF LICENSE.');
      LicenceList.Add('');
      LicenceList.Add('This EULA grants you the following rights: '
          + 'Installation and Use. You may install and use an unlimited number '
          + 'of copies of the SOFTWARE PRODUCT.');
      LicenceList.Add('');
      LicenceList.Add('Reproduction and Distribution. You may reproduce and '
          + 'distribute an unlimited number of copies of the SOFTWARE PRODUCT; '
          + 'provided that each copy shall be a true and complete copy, '
          + 'including all copyright and trademark notices, and shall be '
          + 'accompanied by a copy of this EULA.');
      LicenceList.Add('');
      LicenceList.Add('2. DESCRIPTION OF OTHER RIGHTS AND LIMITATIONS.');
      LicenceList.Add('');
      LicenceList.Add('Limitations on Reverse Engineering, Decompilation, and '
          + 'Disassembly. You may not reverse engineer, decompile, or '
          + 'disassemble the SOFTWARE PRODUCT, except and only to the extent '
          + 'that such activity is expressly permitted by applicable law '
          + 'notwithstanding this limitation.');
      LicenceList.Add('');
      LicenceList.Add('Separation of Components. The SOFTWARE PRODUCT is '
          + 'licensed as a single product. Its component parts may not be '
          + 'separated for use on more than one computer.');
      LicenceList.Add('');
      LicenceList.Add('Software Transfer. You may permanently transfer all of '
          + 'your rights under this EULA, provided the recipient agrees to the '
          + 'terms of this EULA.');
      LicenceList.Add('');
      LicenceList.Add('Termination. Without prejudice to any other rights, '
          + 'the Author of this Software may terminate this EULA if you fail to '
          + 'comply with the terms and conditions of this EULA. In such event, '
          + 'you must destroy all copies of the SOFTWARE PRODUCT and all of its '
          + 'component parts.');
      LicenceList.Add('');
      LicenceList.Add('Distribution. The SOFTWARE PRODUCT may not be sold or '
          + 'be included in a product or package which intends to receive '
          + 'benefits through the inclusion of the SOFTWARE PRODUCT. The '
          + 'SOFTWARE PRODUCT may be included in any free or non-profit '
          + 'packages or of its component parts.');
      LicenceList.Add('');
      LicenceList.Add('3. COPYRIGHT.');
      LicenceList.Add('');
      LicenceList.Add('All title and copyrights in and to the SOFTWARE '
          + 'PRODUCT (including but not limited to any images, photographs, '
          + 'animations, video, audio, music, text, and "applets" incorporated '
          + 'into the SOFTWARE PRODUCT), the accompanying printed materials, '
          + 'and any copies of the SOFTWARE PRODUCT are owned by the Author of '
          + 'this Software or by Far Future Enterprises. The SOFTWARE PRODUCT '
          + 'is protected by copyright laws and international treaty '
          + 'provisions. Therefore, you must treat the SOFTWARE PRODUCT like '
          + 'any other copyrighted material except that you may install the '
          + 'SOFTWARE PRODUCT on a single computer provided you keep the '
          + 'original solely for backup or archival purposes.');
      LicenceList.Add('');
      LicenceList.Add('4. U.S. GOVERNMENT RESTRICTED RIGHTS.');
      LicenceList.Add('');
      LicenceList.Add('The SOFTWARE PRODUCT and documentation are provided '
          + 'with RESTRICTED RIGHTS. Use, duplication, or disclosure by the '
          + 'Government is subject to restrictions as set forth in subparagraph '
          + '(c)(1)(ii) of the Rights in Technical Data and Computer Software '
          + 'clause at DFARS 252.227-7013 or subparagraphs (c)(1) and (2) of '
          + 'the Commercial Computer Software-Restricted Rights at 48 '
          + 'CFR 52.227-19, as applicable. Manufacturer is Andrea '
          + 'Moffatt-Vallance, 12 Harrow Street, Christchurch, NEW ZEALAND.');
      LicenceList.Add('');
      LicenceList.Add('');
      LicenceList.Add('MISCELLANEOUS');
      LicenceList.Add('');
      LicenceList.Add('If you acquired this product in New Zealand, this EULA '
          + 'is governed by the laws of New Zealand.');
      LicenceList.Add('');
      LicenceList.Add('If this product was acquired outside New Zealand, then '
          + 'local law may apply.');
      LicenceList.Add('');
      LicenceList.Add('Should you have any questions concerning this EULA, or '
          + 'if you desire to contact the Author of this Software for any '
          + 'reason, please contact me via the email address mentioned at the '
          + 'top of this EULA.');
      LicenceList.Add('');
      LicenceList.Add('LIMITED WARRANTY');
      LicenceList.Add('');
      LicenceList.Add('NO WARRANTIES. The Author of this Software expressly '
          + 'disclaims any warranty for the SOFTWARE PRODUCT. The SOFTWARE '
          + 'PRODUCT and any related documentation is provided "as is" without '
          + 'warranty of any kind, either express or implied, including, '
          + 'without limitation, the implied warranties or merchantability, '
          + 'fitness for a particular purpose, or noninfringement. The entire '
          + 'risk arising out of use or performance of the SOFTWARE PRODUCT '
          + 'remains with you.');
      LicenceList.Add('');
      LicenceList.Add('NO LIABILITY FOR DAMAGES. In no event shall the author '
          + 'of this Software be liable for any damages whatsoever (including, '
          + 'without limitation, damages for loss of business profits, business '
          + 'interruption, loss of business information, or any other '
          + 'pecuniary loss) arising out of the use of or inability to use this '
          + 'product, even if the Author of this Software has been advised of '
          + 'the possibility of such damages. Because some states/jurisdictions '
          + 'do not allow the exclusion or limitation of liability for '
          + 'consequential or incidental damages, the above limitation may not '
          + 'apply to you.');
      LicenceList.Add('');
      LicenceList.Add('FAR FUTURES ENTERPRISES - EXCLUSION OF RESPONSIBILITY');
      LicenceList.Add('Traveller and High Guard are Registered Trademarks of '
          + 'Far Futures Enterprises and Copyright 1977-' + IntToStr(CurYear)
          + '. However, Far Future Enterprises assumes no resonsibility for '
          + 'the maintainance or distribution of this SOFTWARE PRODUCT in '
          + 'any form. No liability for damages arising from the use or '
          + 'inability to use this SOFTWARE PRODUCT whatsoever shall attach '
          + 'to Far Future Enterprises.');
      LicenceList.SaveToFile(HomeDir + 'Licence.txt');
    end;
  finally
    FreeAndNil(LicenceList);
  end;
end;

procedure CheckRegistry;
//check the registry keys exist

var
  HgsReg : TRegistry;
  TheKey : String;
begin
  HgsReg := TRegistry.Create;
  try
    TheKey := '\Software\Hgs';
    if not (HgsReg.KeyExists(TheKey)) then begin
      HgsReg.OpenKey(TheKey, True);
      try
        HgsReg.WriteString('HomeDir', ExtractFilePath(Application.ExeName));
        HgsReg.WriteString('FileOne', '');
        HgsReg.WriteString('FileTwo', '');
        HgsReg.WriteString('FileThree', '');
        HgsReg.WriteString('FileFour', '');
      finally
        HgsReg.CloseKey;
      end;
    end;
  finally
    FreeAndNil(HgsReg);
  end;
end;

begin
  Application.Initialize;
  Application.Title := 'High Guard Shipyard';
  Application.HelpFile := 'Hghelp.hlp';
  CheckLicence;
  //CheckRegistry;
  SplashFrm := TSplashFrm.Create(Application);
  SplashFrm.TitleLbl.Caption := 'High Guard Shipyard';
  SplashFrm.TitleLbl.Left := 64;
  SplashFrm.ShowModal;
  //LorenSplashFrm := TLorenSplashFrm.Create(Application);
  //LorenSplashFrm.ShowModal;
  Application.CreateForm(TMainFrm, MainFrm);
  //Application.CreateForm(TSqdFrm, SqdFrm);
  Application.Run;
end.
