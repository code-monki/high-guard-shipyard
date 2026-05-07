unit ShipModulePas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, Dialogs;

type

   { TShipModule }

   TShipModule = class
   private
      fSpace : Extended;
      fCost : Extended;
      fRefitted : Boolean;
      fRefitCost : Extended;
   protected
      function FloatToIntDown(TheFloat: Extended): Integer;
      function FloatToIntUp(TheFloat: Extended): Integer;
   public
      procedure AssignDefaults(ShipData : String); virtual; abstract;
   published
      property Space : Extended read fSpace write fSpace;
      property Cost : Extended read fCost write fCost;
      property Refitted : Boolean read fRefitted write fRefitted;
      property RefitCost : Extended read fRefitCost write fRefitCost;
   end;

const
   mbYesNo = [mbYes, mbNo];  //use this for the yes/no dialog box
   SEP = Char(',');
   TEXTMARK = Char('"');
var
  //test variables
  iTest: Integer;
  eTest: Extended;
  sTest: String;
  bTest: Boolean;

type
   TExtShipModule = class(TShipModule)
   private
      fPower : Extended;
      fCmdCrew : Integer;
      fCrew : Integer;
   public

   published
      property Power : Extended read fPower write fPower;
      property CmdCrew : Integer read fCmdCrew write fCmdCrew;
      property Crew : Integer read fCrew write fCrew;
   end;

type
   TWpnShipModule = class(TExtShipModule)
   private
      fHardPoints : Integer;
   public

   published
      property HardPoints : Integer read fHardPoints write fHardPoints;
   end;

type

   { TShipExporter }

   TShipExporter = class(TShipModule)
   private

   protected
     function MakePlural(TheString: String): String;
   public

   published

   end;
implementation

{ TShipExporter }

function TShipExporter.MakePlural(TheString: String): String;
begin
  //if the last character is a H, S or X use es otherwise use s
   if (UpperCase(TheString[Length(TheString)]) = 'H')
       or (UpperCase(TheString[Length(TheString)]) = 'S')
       or (UpperCase(TheString[Length(TheString)]) = 'X') then
   begin
     Result := TheString + 'es';
   end
   else
   begin
     Result := TheString + 's';
   end;
end;

{ TShipModule }

function TShipModule.FloatToIntDown(TheFloat: Extended): Integer;
begin
   Result := StrToInt(FloatToStr(Int(TheFloat)));
end;

function TShipModule.FloatToIntUp(TheFloat: Extended): Integer;
begin
   if ((TheFloat - Int(TheFloat)) <> 0) then begin
      Result := FloatToIntDown(TheFloat) + 1;
   end
   else begin
      Result := FloatToIntDown(TheFloat);
   end;
end;

end.
