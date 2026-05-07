unit DesAssistFrmPas;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ShipPas, DataPas, HgsFormFrm;

type
  TDesAssistFrm = class(THgsForm)
    CloseBtn: TButton;
    DataPanel: TPanel;
    AgilityStatLbl: TLabel;
    RemTonnageLbl: TLabel;
    RemBudgetLbl: TLabel;
    RemEPLbl: TLabel;
    AgilityLbl: TLabel;
    RemTonnageStatLbl: TLabel;
    RemBudgetStatLbl: TLabel;
    RemEPStatLbl: TLabel;
    ValidLbl: TLabel;
    CrewLbl: TLabel;
    CrewStatLbl: TLabel;
    procedure CloseBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TheShip : TShip;
    function ErrorMessage(TheError : Integer) : String;
    procedure DetailForm(var ShipData : TStringList);
  end;

var
  DesAssistFrm: TDesAssistFrm;

implementation

{$R *.lfm}

procedure TDesAssistFrm.CloseBtnClick(Sender: TObject);
//close the form

begin
   Close;
end;

procedure TDesAssistFrm.DetailForm(var ShipData: TStringList);
//create a ship and design it using the data sent from the form

begin
   TheShip.ReadFromForm(ShipData);
   RemTonnageLbl.Caption := FloatToStrF(TheShip.GetRemTonnage, ffNumber, 18, 3);
   RemBudgetLbl.Caption := FloatToStrF(TheShip.GetRemBudget, ffNumber, 18, 3);
   RemEPLbl.Caption := FloatToStrF(TheShip.GetRemPower, ffNumber, 18, 3);
   AgilityLbl.Caption := IntToStr(TheShip.Agility);
   CrewLbl.Caption := IntToStr(TheShip.GetTotalCmdCrew + TheShip.GetTotalCrew);
   if (TheShip.DesignIsValid(1000) > 0) then begin
      ValidLbl.Caption := 'INVALID DESIGN';
      ValidLbl.ShowHint := True;
      ValidLbl.Hint := ErrorMessage(TheShip.DesignIsValid(1000));
   end
   else begin
      ValidLbl.Caption := '';
      ValidLbl.ShowHint := False;
      ValidLbl.Hint := '';
   end;
end;

function TDesAssistFrm.ErrorMessage(TheError: Integer): String;
//find the first error display it as a hint

var
   Data : TData;
begin
   Data := TData.Create;
   try
      Data.InitialiseData;
      case (TheError) of
         1 : Result := 'The hull is too small.';
         2 : Result := 'You are over budget.';
         3 : Result := 'Book 2 Crew Rules are only allowed for ships under 1000 Tons.';
         4 : Result := 'This is an Empty Error.';
         5 : Result := 'There are not enough Energy Points (EP).';
         6 : Result := 'Small Craft may not use Planetoid Hulls.';
         7 : Result := 'Armour Added to the hull may not exceed Tech Level.';
         8 : Result := 'Small Craft (Vessels smaller than 100T) may not be fitted with Jump Drive.';
         9 : Result := 'Ships at Tech Level 7 are restricted to Maneuver Drive 2.';
         10 : Result := 'Ships at Tech Level 8 are restricted to Maneuver Drive 5.';
         11 : Result := 'Ships at Tech Level 7 are Restricted to Backup Maneuver Drive 2.';
         12 : Result := 'Ships at Tech Level 8 are Restricted to Backup Maneuver Drive 5.';
         13 : Result := 'Ships Below Tech Level 9 May Not Have Jump Drive.';
         14 : Result := 'Ships Below Tech Level 11 are Restricted to Jump 1.';
         15 : Result := 'Ships Below Tech Level 12 are Restricted to Jump 2.';
         16 : Result := 'Ships Below Tech Level 13 are Restricted to Jump 3.';
         17 : Result := 'Ships Below Tech Level 14 are Restricted to Jump 4.';
         18 : Result := 'Ships Below Tech Level 15 are Restricted to Jump 5.';
         19 : Result := 'Ships Below Tech Level 9 May Not Have Backup Jump Drive.';
         20 : Result := 'Ships Below Tech Level 11 are Restricted to Backup Jump 1.';
         21 : Result := 'Ships Below Tech Level 12 are Restricted to Backup Jump 2.';
         22 : Result := 'Ships Below Tech Level 13 are Restricted to Backup Jump 3.';
         23 : Result := 'Ships Below Tech Level 14 are Restricted to Backup Jump 4.';
         24 : Result := 'Ships Below Tech Level 15 are Restricted to Backup Jump 5.';
         25 : Result := 'Your Power Plant is Smaller than Your Maneuver Drive.';
         26 : Result := 'Your Power Plant is Smaller than Your Jump Drive.';
         27 : Result := 'Unstreamlined Ships may not be Fitted with Fuel Scoops.';
         28 : Result := 'Fuel Purification requires a minimum Tech Level of 8.';
         29 : Result := 'Under Standard Rules, ships require at least 28 days Power Plant Fuel.';
         30 : Result := 'Under Standard Rules, Power Plant Fuel must be in multiples of 28 days.';
         31 : Result := 'Under Standard Rules, ships require at least 28 days Lhyd Power Plant Fuel if it is included.';
         32 : Result := 'Under Standard Rules, Power Plant Fuel must be in multiples of 28 days if it is included.';
         33 : Result := 'Ships with Jump Drive require a Computer.';
         34 : Result := 'A Model/1bis computer or better is required for Jump 2.';
         35 : Result := 'A Model/2bis computer or better is required for Jump 3.';
         36 : Result := 'A Model/4 computer or better is required for Jump 4.';
         37 : Result := 'A Model/5 computer or better is required for Jump 5.';
         38 : Result := 'A Model/6 computer or better is required for Jump 6.';
         39 : Result := 'Small Craft (Vessels under 100T) must be fitted with either a Bridge or a Computer.';
         40 : Result := 'Ships of 100T and over must be fitted with a Bridge.';
         41 : Result := 'Ships of 100T and over must be fitted with a Computer.';
         42 : Result := 'Ships of 600T and over must be fitted with a Model/1 Computer or better.';
         43 : Result := 'Ships of 1000T and over must be fitted with a Model/2 Computer or better.';
         44 : Result := 'Ships of 4000T and over must be fitted with a Model/3 Computer or better.';
         45 : Result := 'Ships of 10,000T and over must be fitted with a Model/4 Computer or better.';
         46 : Result := 'Ships of 50,000T and over must be fitted with a Model/5 Computer or better.';
         47 : Result := 'Ships of 100,000T and over must be fitted with a Model/6 Computer or better.';
         48 : Result := 'Ships of 1,000,000T and over must be fitted with a Model/7 Computer or better.';
         49 : Result := Copy(Data.GetComputerData(7, Ship.Avionics.MainComp), 3, Length(Data.GetComputerData(7, Ship.Avionics.MainComp))) + ' Main Computers require a minimum Tech Level of ' + Data.GetComputerData(5, Ship.Avionics.MainComp) + '.';
         50 : Result := Copy(Data.GetComputerData(7, Ship.Avionics.BakComp), 3, Length(Data.GetComputerData(7, Ship.Avionics.BakComp))) + ' Main Computers require a minimum Tech Level of ' + Data.GetComputerData(5, Ship.Avionics.BakComp) + '.';
         51 : Result := 'There are not enough hardpoints available for the weapons fitted.';
         52 : Result := 'Spinal Meson Guns require a minimum Tech Level of 11.';
         53 : Result := 'Spinal Particle Accelerators require a minimum Tech Level of 8.';
         54 : Result := Data.GetSpnlMesData(1, Ship.SpinalMount.SpinalMount) + ' Gun Spinal Mounts require a minimum Tech Level of ' + Data.GetSpnlMesData(3, Ship.SpinalMount.SpinalMount) + '.';
         55 : Result := Data.GetSpnlPAData(1, Ship.SpinalMount.SpinalMount)[1] + ' Particle Accelerator Spinal Mounts require a minimum Tech Level of ' + Data.GetSpnlPAData(3, Ship.SpinalMount.SpinalMount) + '.';
         56 : Result := '100T Bays require a minimum hull size of 1000T.';
         57 : Result := '100T Meson Gun Bays require a minimum Tech Level of 13.';
         58 : Result := '100T Particle Accelorator Bays require a minimum Tech Level of 8.';
         59 : Result := '100T Repulsor Bays require a minimum Tech Level of 10.';
         60 : Result := '50T Bays require a minimum hull size of 1000T.';
         61 : Result := '50T Bays require a minimum Tech Level of 10.';
         62 : Result := '50T Meson Gun Bays require a minimum Tech Level of 15.';
         63 : Result := '50T Particle Accelorator Bays require a minimum Tech Level of 10.';
         64 : Result := '50T Repulsor Bays require a minimum Tech Level of 14.';
         65 : Result := '50T Missile Bays require a minimum Tech Level of 10.';
         66 : Result := '50T Plasma Gun Bays require a minimum Tech Level of 10.';
         67 : Result := '50T Fusion Gun Bays require a minimum Tech Level of 12.';
//         68 : Result := 'Beam Laser Turrets require a minimum Tech Level of 9.';
         69 : Result := 'Plasma Gun Turrets require a minimum Tech Level of 10.';
         70 : Result := 'Fusion Gun Turrets require a minimum Tech Level of 12.';
         71 : Result := 'Particle Accelerator Barbettes require a minimum Tech Level of 14.';
         72 : Result := 'Beam Laser Turrets require a minimum Tech Level of 9.';
         73 : Result := 'Mixed Turrets are not permitted for ships in excess of 1000 Tons.';
         74 : Result := 'Spinal Meson Guns and 100T Meson Bays may not be included.';
         75 : Result := 'Spinal Meson Guns and 50T Meson Bays may not be included.';
         76 : Result := 'Spinal Particle Accelerators and 100T Particle Accelerator Bays may not be included.';
         77 : Result := 'Spinal Particle Accelerators and 50T Particle Accelerator Bays may not be included.';
         78 : Result := 'Spinal Particle Accelerators and Particle Accelerator Turrets may not be included.';
         79 : Result := '100T and 50T Meson Bays may not be mixed.';
         80 : Result := '100T and 50T Particle Accelerator Bays may not be mixed.';
         81 : Result := '100T and 50T Repulsor Bays may not be mixed.';
         82 : Result := '100T and 50T Missile Bays may not be mixed.';
         83 : Result := '100T Particle Accelerator Bays and Particle Accelerator Turrets may not be mixed.';
         84 : Result := '100T Missile Bays and Missile Turrets may not be mixed.';
         85 : Result := '100T Missile Bays and Missile Turrets may not be mixed.';
         86 : Result := '50T Particle Accelerator Bays and Particle Accelerator Turrets may not be mixed.';
         87 : Result := '50T Missile Bays and Missile Turrets may not be mixed.';
         88 : Result := '50T Missile Bays and Missile Turrets may not be mixed.';
         89 : Result := '50T Energy Bays and Energy Turrets may not be mixed.';
         90 : Result := 'Factor ' + Data.GetNucDampData(1, Ship.Screens.NucDamp) + ' Nuclear Dampers require a minimum Tech Level of ' + Data.GetNucDampData(2, Ship.Screens.NucDamp) + '.';
         91 : Result := 'Factor ' + Data.GetMesScrnData(1, Ship.Screens.MesScrn) + ' Meson Screens require a minimum Tech Level of ' + Data.GetMesScrnData(2, Ship.Screens.MesScrn) + '.';
         92 : Result := 'Factor ' + Data.GetBlkGlbData(1, Ship.Screens.BlkGlb) + ' Black Globes require a minimum Tech Level of ' + Data.GetBlkGlbData(2, Ship.Screens.BlkGlb) + '.';
         93 : Result := 'Factor ' + Data.GetNucDampData(1, Ship.Screens.BakNucDamp) + ' Backup Nuclear Dampers require a minimum Tech Level of ' + Data.GetNucDampData(2, Ship.Screens.BakNucDamp) + '.';
         94 : Result := 'Factor ' + Data.GetMesScrnData(1, Ship.Screens.BakMesScrn) + ' BackUp Meson Screens require a minimum Tech Level of ' + Data.GetMesScrnData(2, Ship.Screens.BakMesScrn) + '.';
         95 : Result := 'Factor ' + Data.GetBlkGlbData(1, Ship.Screens.BakBlkGlb) + ' Backup Black Globes require a minimum Tech Level of ' + Data.GetBlkGlbData(2, Ship.Screens.BakBlkGlb) + '.';
         96 : Result := 'Low Berths require a minimum Tech Level of 9.';
         97 : Result := 'Emergancy Low Berths require a minimum Tech Level of 9.';
         98 : Result := 'Drop Capsules require a minimum Tech Level of 10.';
         99 : Result := 'Insufficent Staterooms.';
         100 : Result := 'Insufficent Couches.';
         101 : Result := 'Insufficent Low Berths.';
         102 : Result := 'Ready Drop Capsules are fitted with no Drop Casules Launchers.';
         103 : Result := 'Stored Drop Capsules are fitted with no Drop Casules Launchers.';
         104 : Result := 'Small Craft Staterooms are not permitted on Non-Small Craft (Vessels under 100T).';
         105 : Result := 'Small Craft Couches are not permitted on Non-Small Craft (Vessels under 100T).';
         106 : Result := 'Staterooms are not permitted on Small Craft (Vessels under 100T).';
         else Result := '';
      end;
   finally
      FreeAndNil(Data);
   end;
end;

procedure TDesAssistFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//clean up and close

begin
   FreeAndNil(TheShip);
   Action := caFree;
end;

procedure TDesAssistFrm.FormCreate(Sender: TObject);
//create a virtual ship to use

begin
   TheShip := TShip.Create;
end;

end.
