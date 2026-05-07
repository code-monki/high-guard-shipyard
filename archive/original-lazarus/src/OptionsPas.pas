unit OptionsPas;

{$MODE Delphi}

interface

uses
   SysUtils, Classes;

type

   { TOptions }

   TOptions = class
   private
      fChargeForHardpoints : Integer;
      fAutoCalcAccom : Integer;
      FMilStdMod: Extended;
      fOptPowerTon : Integer;
      FMilStdJump: Boolean;
      procedure SetMilStdJump(const AValue: Boolean);
      procedure SetMilStdMod(const AValue: Extended);
   public
      constructor Create;
   published
      property ChargeForHardpoints : Integer read fChargeForHardpoints write fChargeForHardpoints;
      property AutoCalcAccom : Integer read fAutoCalcAccom write fAutoCalcAccom;
      property OptPowerTon : Integer read fOptPowerTon write fOptPowerTon;
      property MilStdJump: Boolean read FMilStdJump write SetMilStdJump;
      property MilStdMod: Extended read FMilStdMod write SetMilStdMod;
   end;

implementation

{ TOptions }

procedure TOptions.SetMilStdJump(const AValue: Boolean);
begin
  if FMilStdJump=AValue then exit;
  FMilStdJump:=AValue;
end;

procedure TOptions.SetMilStdMod(const AValue: Extended);
begin
  if FMilStdMod=AValue then exit;
  FMilStdMod:=AValue;
end;

constructor TOptions.Create;
//create the form and set the defaults

begin
   ChargeForHardPoints := 0;
   AutoCalcAccom := 0;
   OptPowerTon := 0;
   MilStdJump := False;
   MilStdMod := 0;
end;

end.
