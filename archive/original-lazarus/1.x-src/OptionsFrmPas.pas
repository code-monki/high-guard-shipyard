unit OptionsFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShipPas;

type

  { TOptionsFrm }

  TOptionsFrm = class(TForm)
    MilStdJumpChkBx: TCheckBox;
    OKBtn: TButton;
    CancelBtn: TButton;
    MainPnl: TPanel;
    ChargeForHPChkBx: TCheckBox;
    AutoCalcAccomChkBx: TCheckBox;
    OptPowerTonChkBox: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsFrm: TOptionsFrm;

implementation

uses MainPas;

{$R *.lfm}

procedure TOptionsFrm.FormClose(Sender: TObject; var Action: TCloseAction);
//clean up and close

begin
   Action := caFree;
end;

procedure TOptionsFrm.OKBtnClick(Sender: TObject);
//send the form data to the ship and close

begin
  //charge for hard points
  if (ChargeForHPChkBx.State = cbChecked) then
  begin
    Ship.Options.ChargeForHardPoints := 1;
  end
  else
  begin
    Ship.Options.ChargeForHardPoints := 0;
  end;
  //auto calculate accomodations
  if (AutoCalcAccomChkBx.State = cbChecked) then
  begin
    Ship.Options.AutoCalcAccom := 1;
  end
  else
  begin
    Ship.Options.AutoCalcAccom := 0;
  end;
  //use option tonnage based PP
  if (OptPowerTonChkBox.State = cbChecked) then
  begin
    Ship.Options.OptPowerTon := 1;
  end
  else
  begin
    Ship.Options.OptPowerTon := 0;
  end;
  Ship.Options.MilStdJump := MilStdJumpChkBx.Checked;
  Ship.DesignShip;
  MainFrm.RefreshForm;
  Ship.HasChanged := True;
  MainFrm.SaveMenuItem.Enabled := True;
  MainFrm.RestoreMenuItem.Enabled := True;
  Close;
end;

procedure TOptionsFrm.CancelBtnClick(Sender: TObject);
//close without sending data to the ship

begin
   Close;
end;

procedure TOptionsFrm.FormCreate(Sender: TObject);
//create the form and fill it with data from the ship

begin
  //charge for hard points
  if (Ship.Options.ChargeForHardpoints = 0) then
  begin
    ChargeForHPChkBx.State := cbUnChecked;
  end
  else
  begin
    ChargeForHPChkBx.State := cbChecked;
  end;
  //auto calculate accomodations
  if (Ship.Options.AutoCalcAccom = 0) then
  begin
    AutoCalcAccomChkBx.State := cbUnChecked;
  end
  else
  begin
    AutoCalcAccomChkBx.State := cbChecked;
  end;
  //use optional tonnage based PP
  if (Ship.Options.OptPowerTon = 0) then
  begin
    OptPowerTonChkBox.State := cbUnChecked;
  end
  else
  begin
    OptPowerTonChkBox.State := cbChecked;
  end;
  MilStdJumpChkBx.Checked := Ship.Options.MilStdJump;

  //if T20 force auto calc accom
  if (Ship.DesignRules = 0) then
  begin
    ChargeForHPChkBx.Enabled := False;
  end;
end;

end.
