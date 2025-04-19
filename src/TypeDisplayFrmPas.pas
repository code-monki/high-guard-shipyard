unit TypeDisplayFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TTypeDisplayFrm = class(TForm)
    OkBitBtn: TBitBtn;
    PrimaryMemo: TMemo;
    SecondaryMemo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TypeDisplayFrm: TTypeDisplayFrm;

implementation

{$R *.lfm}

procedure TTypeDisplayFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//clean up after

begin
   Action := caFree;
end;

procedure TTypeDisplayFrm.OkBitBtnClick(Sender: TObject);
//close the form

begin
   Close;
end;

procedure TTypeDisplayFrm.FormCreate(Sender: TObject);
//fill the memos

begin
   PrimaryMemo.Lines.Clear;
   PrimaryMemo.Lines.Add('Primary');
   PrimaryMemo.Lines.Add('');
   PrimaryMemo.Lines.Add('A Merchant');
   PrimaryMemo.Lines.Add('B Battle');
   PrimaryMemo.Lines.Add('C Cruiser; Carrier');
   PrimaryMemo.Lines.Add('D Destroyer');
   PrimaryMemo.Lines.Add('E Escort');
   PrimaryMemo.Lines.Add('F Frigate; Fighter');
   PrimaryMemo.Lines.Add('G Gig; Refinery');
   PrimaryMemo.Lines.Add('H');
   PrimaryMemo.Lines.Add('J Intruder');
   PrimaryMemo.Lines.Add('K Pinnace');
   PrimaryMemo.Lines.Add('L Corvette; Lab');
   PrimaryMemo.Lines.Add('M Merchant');
   PrimaryMemo.Lines.Add('N');
   PrimaryMemo.Lines.Add('P Planetoid');
   PrimaryMemo.Lines.Add('Q Auxiliary');
   PrimaryMemo.Lines.Add('R Liner; Carrier');
   PrimaryMemo.Lines.Add('S Scout; Station');
   PrimaryMemo.Lines.Add('T Tanker; Tender');
   PrimaryMemo.Lines.Add('U');
   PrimaryMemo.Lines.Add('V');
   PrimaryMemo.Lines.Add('W Barge');
   PrimaryMemo.Lines.Add('X Express');
   PrimaryMemo.Lines.Add('Y Yacht');
   PrimaryMemo.Lines.Add('Z');
   SecondaryMemo.Lines.Clear;
   SecondaryMemo.Lines.Add('Qualifier');
   SecondaryMemo.Lines.Add('');
   SecondaryMemo.Lines.Add('A Armoured');
   SecondaryMemo.Lines.Add('B Battle; Boat');
   SecondaryMemo.Lines.Add('C Cruiser; Close');
   SecondaryMemo.Lines.Add('D Destroyer');
   SecondaryMemo.Lines.Add('E Escort');
   SecondaryMemo.Lines.Add('F Fast; Fleet');
   SecondaryMemo.Lines.Add('G Gunned');
   SecondaryMemo.Lines.Add('H Heavy');
   SecondaryMemo.Lines.Add('J');
   SecondaryMemo.Lines.Add('K');
   SecondaryMemo.Lines.Add('L Leader; Light');
   SecondaryMemo.Lines.Add('M Missile');
   SecondaryMemo.Lines.Add('N Non-standard');
   SecondaryMemo.Lines.Add('P Provincial');
   SecondaryMemo.Lines.Add('Q Decoy');
   SecondaryMemo.Lines.Add('R Raider; Carried');
   SecondaryMemo.Lines.Add('S Strike');
   SecondaryMemo.Lines.Add('T Troop; Transport');
   SecondaryMemo.Lines.Add('U Unpowered');
   SecondaryMemo.Lines.Add('V Vehicle');
   SecondaryMemo.Lines.Add('W');
   SecondaryMemo.Lines.Add('X');
   SecondaryMemo.Lines.Add('Y Shuttle; Cutter');
   SecondaryMemo.Lines.Add('Z Experimental');
end;

end.
