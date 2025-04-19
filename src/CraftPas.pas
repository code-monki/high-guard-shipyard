unit CraftPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, ShipModulePas;

type
   TCraft = class(TExtShipModule)
   private
      fCr1Num : Integer;
      fCr1Tonnage : Extended;
      fCr1Desc : String;
      fCr1Crew : Integer;
      fCr1Vehicle : Integer;
      fCr1Price : Extended;
      fCr2Num : Integer;
      fCr2Tonnage : Extended;
      fCr2Desc : String;
      fCr2Crew : Integer;
      fCr2Vehicle : Integer;
      fCr2Price : Extended;
      fCr3Num : Integer;
      fCr3Tonnage : Extended;
      fCr3Desc : String;
      fCr3Crew : Integer;
      fCr3Vehicle : Integer;
      fCr3Price : Extended;
      fCr4Num : Integer;
      fCr4Tonnage : Extended;
      fCr4Desc : String;
      fCr4Crew : Integer;
      fCr4Vehicle : Integer;
      fCr4Price : Extended;
      fCr5Num : Integer;
      fCr5Tonnage : Extended;
      fCr5Desc : String;
      fCr5Crew : Integer;
      fCr5Vehicle : Integer;
      fCr5Price : Extended;
      fCr6Num : Integer;
      fCr6Tonnage : Extended;
      fCr6Desc : String;
      fCr6Crew : Integer;
      fCr6Vehicle : Integer;
      fCr6Price : Extended;
      fCr7Num : Integer;
      fCr7Tonnage : Extended;
      fCr7Desc : String;
      fCr7Crew : Integer;
      fCr7Vehicle : Integer;
      fCr7Price : Extended;
      fCr8Num : Integer;
      fCr8Tonnage : Extended;
      fCr8Desc : String;
      fCr8Crew : Integer;
      fCr8Vehicle : Integer;
      fCr8Price : Extended;
      fFtrSqd : Integer;
      fLF1Num : Integer;
      fLF1Size : Extended;
      fLF2Num : Integer;
      fLF2Size : Extended;
      function IsVehicle(Test : Integer) : Boolean;
   public
      function CraftCost(Num, Config : Integer; Size, ShipSize : Extended; Vehicle : Boolean) : Extended;
      function CraftSpace(Num, Config : Integer; Size, ShipSize : Extended; Vehicle : Boolean) : Extended;
      function LauncherCost(Num : Integer; Size : Extended) : Extended;
      function LauncherSpace(Num : Integer; Size : Extended) : Extended;
      procedure CalcCrew(Size: Extended; Rules: Integer);
      property Cr1Num : Integer read fCr1Num write fCr1Num;
      property Cr1Tonnage : Extended read fCr1Tonnage write fCr1Tonnage;
      property Cr1Desc : String read fCr1Desc write fCr1Desc;
      property Cr1Crew : Integer read fCr1Crew write fCr1Crew;
      property Cr1Vehicle : Integer read fCr1Vehicle write fCr1Vehicle;
      property Cr1Price : Extended read fCr1Price write fCr1Price;
      property Cr2Num : Integer read fCr2Num write fCr2Num;
      property Cr2Tonnage : Extended read fCr2Tonnage write fCr2Tonnage;
      property Cr2Desc : String read fCr2Desc write fCr2Desc;
      property Cr2Crew : Integer read fCr2Crew write fCr2Crew;
      property Cr2Vehicle : Integer read fCr2Vehicle write fCr2Vehicle;
      property Cr2Price : Extended read fCr2Price write fCr2Price;
      property Cr3Num : Integer read fCr3Num write fCr3Num;
      property Cr3Tonnage : Extended read fCr3Tonnage write fCr3Tonnage;
      property Cr3Desc : String read fCr3Desc write fCr3Desc;
      property Cr3Crew : Integer read fCr3Crew write fCr3Crew;
      property Cr3Vehicle : Integer read fCr3Vehicle write fCr3Vehicle;
      property Cr3Price : Extended read fCr3Price write fCr3Price;
      property Cr4Num : Integer read fCr4Num write fCr4Num;
      property Cr4Tonnage : Extended read fCr4Tonnage write fCr4Tonnage;
      property Cr4Desc : String read fCr4Desc write fCr4Desc;
      property Cr4Crew : Integer read fCr4Crew write fCr4Crew;
      property Cr4Vehicle : Integer read fCr4Vehicle write fCr4Vehicle;
      property Cr4Price : Extended read fCr4Price write fCr4Price;
      property Cr5Num : Integer read fCr5Num write fCr5Num;
      property Cr5Tonnage : Extended read fCr5Tonnage write fCr5Tonnage;
      property Cr5Desc : String read fCr5Desc write fCr5Desc;
      property Cr5Crew : Integer read fCr5Crew write fCr5Crew;
      property Cr5Vehicle : Integer read fCr5Vehicle write fCr5Vehicle;
      property Cr5Price : Extended read fCr5Price write fCr5Price;
      property Cr6Num : Integer read fCr6Num write fCr6Num;
      property Cr6Tonnage : Extended read fCr6Tonnage write fCr6Tonnage;
      property Cr6Desc : String read fCr6Desc write fCr6Desc;
      property Cr6Crew : Integer read fCr6Crew write fCr6Crew;
      property Cr6Vehicle : Integer read fCr6Vehicle write fCr6Vehicle;
      property Cr6Price : Extended read fCr6Price write fCr6Price;
      property Cr7Num : Integer read fCr7Num write fCr7Num;
      property Cr7Tonnage : Extended read fCr7Tonnage write fCr7Tonnage;
      property Cr7Desc : String read fCr7Desc write fCr7Desc;
      property Cr7Crew : Integer read fCr7Crew write fCr7Crew;
      property Cr7Vehicle : Integer read fCr7Vehicle write fCr7Vehicle;
      property Cr7Price : Extended read fCr7Price write fCr7Price;
      property Cr8Num : Integer read fCr8Num write fCr8Num;
      property Cr8Tonnage : Extended read fCr8Tonnage write fCr8Tonnage;
      property Cr8Desc : String read fCr8Desc write fCr8Desc;
      property Cr8Crew : Integer read fCr8Crew write fCr8Crew;
      property Cr8Vehicle : Integer read fCr8Vehicle write fCr8Vehicle;
      property Cr8Price : Extended read fCr8Price write fCr8Price;
      property FtrSqd : Integer read fFtrSqd write fFtrSqd;
      property LF1Num : Integer read fLF1Num write fLF1Num;
      property LF1Size : Extended read fLF1Size write fLF1Size;
      property LF2Num : Integer read fLF2Num write fLF2Num;
      property LF2Size : Extended read fLF2Size write fLF2Size;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignCraft(ShipData : String);
   end;

var
   Craft : TCraft;

implementation

{ TCraft }

procedure TCraft.AssignDefaults(ShipData: String);
//assign the defaults from the ship

var
   Props : TStringList;
begin
   Props := TStringList.Create;
   try
      Props.CommaText := ShipData;
      Space := 0;
      Cost := 0;
      CmdCrew := 0;
      Crew := 0;
      Power := 0;

      //craft 1
      Cr1Num := StrToInt(Props[0]);
      Cr1Tonnage := StrToFloat(Props[1]);
      Cr1Desc := Props[2];
      Cr1Crew := StrToInt(Props[3]);
      Cr1Vehicle := StrToInt(Props[4]);
      Cr1Price := StrToFloat(Props[5]);

      //craft 2
      Cr2Num := StrToInt(Props[6]);
      Cr2Tonnage := StrToFloat(Props[7]);
      Cr2Desc := Props[8];
      Cr2Crew := StrToInt(Props[9]);
      Cr2Vehicle := StrToInt(Props[10]);
      Cr2Price := StrToFloat(Props[11]);

      //craft 3
      Cr3Num := StrToInt(Props[12]);
      Cr3Tonnage := StrToFloat(Props[13]);
      Cr3Desc := Props[14];
      Cr3Crew := StrToInt(Props[15]);
      Cr3Vehicle := StrToInt(Props[16]);
      Cr3Price := StrToFloat(Props[17]);

      //craft 4
      Cr4Num := StrToInt(Props[18]);
      Cr4Tonnage := StrToFloat(Props[19]);
      Cr4Desc := Props[20];
      Cr4Crew := StrToInt(Props[21]);
      Cr4Vehicle := StrToInt(Props[22]);
      Cr4Price := StrToFloat(Props[23]);

      //craft 5
      Cr5Num := StrToInt(Props[24]);
      Cr5Tonnage := StrToFloat(Props[25]);
      Cr5Desc := Props[26];
      Cr5Crew := StrToInt(Props[27]);
      Cr5Vehicle := StrToInt(Props[28]);
      Cr5Price := StrToFloat(Props[29]);

      //craft 6
      Cr6Num := StrToInt(Props[30]);
      Cr6Tonnage := StrToFloat(Props[31]);
      Cr6Desc := Props[32];
      Cr6Crew := StrToInt(Props[33]);
      Cr6Vehicle := StrToInt(Props[34]);
      Cr6Price := StrToFloat(Props[35]);

      //craft 7
      Cr7Num := StrToInt(Props[36]);
      Cr7Tonnage := StrToFloat(Props[37]);
      Cr7Desc := Props[38];
      Cr7Crew := StrToInt(Props[39]);
      Cr7Vehicle := StrToInt(Props[40]);
      Cr7Price := StrToFloat(Props[41]);

      //craft 8
      Cr8Num := StrToInt(Props[42]);
      Cr8Tonnage := StrToFloat(Props[43]);
      Cr8Desc := Props[44];
      Cr8Crew := StrToInt(Props[45]);
      Cr8Vehicle := StrToInt(Props[46]);
      Cr8Price := StrToFloat(Props[47]);

      //fighter squadrons and launch facilities
      FtrSqd := StrToInt(Props[48]);
      LF1Num := StrToInt(Props[49]);
      LF1Size := StrToFloat(Props[50]);
      LF2Num := StrToInt(Props[51]);
      LF2Size := StrToFloat(Props[52]);
   finally
      FreeAndNil(Props);
   end;
end;

procedure TCraft.CalcCrew(Size: Extended; Rules: Integer);
//calculate the crew

var
   NumVehicles, NumCraft : Integer;
begin
   CmdCrew := 0;
   Crew := 0;
   NumVehicles := 0;
   NumCraft := 0;

   //calculate the number of vehicles
   if (IsVehicle(Cr1Vehicle)) then Inc(NumVehicles, Cr1Num);
   if (IsVehicle(Cr2Vehicle)) then Inc(NumVehicles, Cr2Num);
   if (IsVehicle(Cr3Vehicle)) then Inc(NumVehicles, Cr3Num);
   if (IsVehicle(Cr4Vehicle)) then Inc(NumVehicles, Cr4Num);
   if (IsVehicle(Cr5Vehicle)) then Inc(NumVehicles, Cr5Num);
   if (IsVehicle(Cr6Vehicle)) then Inc(NumVehicles, Cr6Num);
   if (IsVehicle(Cr7Vehicle)) then Inc(NumVehicles, Cr7Num);
   if (IsVehicle(Cr8Vehicle)) then Inc(NumVehicles, Cr8Num);

   //calculate the number of non-vehicles
   if not (IsVehicle(Cr1Vehicle)) then Inc(NumCraft, Cr1Num);
   if not (IsVehicle(Cr2Vehicle)) then Inc(NumCraft, Cr2Num);
   if not (IsVehicle(Cr3Vehicle)) then Inc(NumCraft, Cr3Num);
   if not (IsVehicle(Cr4Vehicle)) then Inc(NumCraft, Cr4Num);
   if not (IsVehicle(Cr5Vehicle)) then Inc(NumCraft, Cr5Num);
   if not (IsVehicle(Cr6Vehicle)) then Inc(NumCraft, Cr6Num);
   if not (IsVehicle(Cr7Vehicle)) then Inc(NumCraft, Cr7Num);
   if not (IsVehicle(Cr8Vehicle)) then Inc(NumCraft, Cr8Num);

   //book 2 crew
   if (Rules = 0) or (Size < 100) then begin
      Crew := Crew + (Cr1Num * Cr1Crew);
      Crew := Crew + (Cr2Num * Cr2Crew);
      Crew := Crew + (Cr3Num * Cr3Crew);
      Crew := Crew + (Cr4Num * Cr4Crew);
      Crew := Crew + (Cr5Num * Cr5Crew);
      Crew := Crew + (Cr6Num * Cr6Crew);
      Crew := Crew + (Cr7Num * Cr7Crew);
      Crew := Crew + (Cr8Num * Cr8Crew);
      Crew := Crew + ((LF1Num + LF2Num) * 10);
   end

   //book 5 crew
   else begin
      if (NumCraft > 0) or (NumVehicles > 0) then begin
         CmdCrew := 1;
      end
      else begin
         CmdCrew := 0;
      end;
      if not (IsVehicle(Cr1Vehicle)) then Crew := Crew + Cr1Num;
      if not (IsVehicle(Cr2Vehicle)) then Crew := Crew + Cr2Num;
      if not (IsVehicle(Cr3Vehicle)) then Crew := Crew + Cr3Num;
      if not (IsVehicle(Cr4Vehicle)) then Crew := Crew + Cr4Num;
      if not (IsVehicle(Cr5Vehicle)) then Crew := Crew + Cr5Num;
      if not (IsVehicle(Cr6Vehicle)) then Crew := Crew + Cr6Num;
      if not (IsVehicle(Cr7Vehicle)) then Crew := Crew + Cr7Num;
      if not (IsVehicle(Cr8Vehicle)) then Crew := Crew + Cr8Num;
      Crew := Crew + (Cr1Num * Cr1Crew);
      Crew := Crew + (Cr2Num * Cr2Crew);
      Crew := Crew + (Cr3Num * Cr3Crew);
      Crew := Crew + (Cr4Num * Cr4Crew);
      Crew := Crew + (Cr5Num * Cr5Crew);
      Crew := Crew + (Cr6Num * Cr6Crew);
      Crew := Crew + (Cr7Num * Cr7Crew);
      Crew := Crew + (Cr8Num * Cr8Crew);
      Crew := Crew + ((LF1Num + LF2Num) * 10);
      if (NumVehicles > 2) then begin
         Crew := Crew + (NumVehicles div 3);
         if ((NumVehicles mod 3) <> 0) then Crew := Crew + 1;
      end;
   end;
end;

function TCraft.CraftCost(Num, Config: Integer; Size, ShipSize: Extended;
  Vehicle: Boolean): Extended;
//calculate the cost of the craft facilities (not the craft themselves)

begin
   if (Vehicle) then begin
      Result := 0;
   end
   else begin
      Result := CraftSpace(Num, Config, Size, ShipSize, Vehicle) * 0.002;
   end;
end;

function TCraft.CraftSpace(Num, Config: Integer; Size, ShipSize: Extended;
  Vehicle: Boolean): Extended;
//calculate the space required to carry the craft

begin
  //if ship not > 1000t, config 7 or craft = vehicle, craft require their own space
  if (ShipSize <= 1000) or (Config = 7) or (Vehicle) then
  begin
    Result := Num * Size;
  end
  else begin
    if (Size < 100) then
    begin
      Result := (Num * Size) * 1.3;
    end
    else
    begin
      Result := (Num * Size) * 1.1;
    end;
  end;
end;

procedure TCraft.DesignCraft(ShipData: String);
//design the module

var
   ShipDetails : TStringList;
   Tonnage : Extended;
   Techlevel, CrewRules, Config : Integer;
begin
   ShipDetails := TStringList.Create;
   try
      ShipDetails.CommaText := ShipData;
      TechLevel := StrToInt(ShipDetails[0]);
      Tonnage := StrToFloat(ShipDetails[1]);
      CrewRules := StrToInt(ShipDetails[3]);
      Config := StrToInt(ShipDetails[5]);
      Cost := CraftCost(Cr1Num, Config, Cr1Tonnage, Tonnage, IsVehicle(Cr1Vehicle))
            + CraftCost(Cr2Num, Config, Cr2Tonnage, Tonnage, IsVehicle(Cr2Vehicle))
            + CraftCost(Cr3Num, Config, Cr3Tonnage, Tonnage, IsVehicle(Cr3Vehicle))
            + CraftCost(Cr4Num, Config, Cr4Tonnage, Tonnage, IsVehicle(Cr4Vehicle))
            + CraftCost(Cr5Num, Config, Cr5Tonnage, Tonnage, IsVehicle(Cr5Vehicle))
            + CraftCost(Cr6Num, Config, Cr6Tonnage, Tonnage, IsVehicle(Cr6Vehicle))
            + CraftCost(Cr7Num, Config, Cr7Tonnage, Tonnage, IsVehicle(Cr7Vehicle))
            + CraftCost(Cr8Num, Config, Cr8Tonnage, Tonnage, IsVehicle(Cr8Vehicle))
            + LauncherCost(LF1Num, LF1Size) + LauncherCost(LF2Num, LF2Size);
      Space := CraftSpace(Cr1Num, Config, Cr1Tonnage, Tonnage, IsVehicle(Cr1Vehicle))
            + CraftSpace(Cr2Num, Config, Cr2Tonnage, Tonnage, IsVehicle(Cr2Vehicle))
            + CraftSpace(Cr3Num, Config, Cr3Tonnage, Tonnage, IsVehicle(Cr3Vehicle))
            + CraftSpace(Cr4Num, Config, Cr4Tonnage, Tonnage, IsVehicle(Cr4Vehicle))
            + CraftSpace(Cr5Num, Config, Cr5Tonnage, Tonnage, IsVehicle(Cr5Vehicle))
            + CraftSpace(Cr6Num, Config, Cr6Tonnage, Tonnage, IsVehicle(Cr6Vehicle))
            + CraftSpace(Cr7Num, Config, Cr7Tonnage, Tonnage, IsVehicle(Cr7Vehicle))
            + CraftSpace(Cr8Num, Config, Cr8Tonnage, Tonnage, IsVehicle(Cr8Vehicle))
            + LauncherSpace(LF1Num, LF1Size) + LauncherSpace(LF2Num, LF2Size);
      CalcCrew(Tonnage, CrewRules);
   finally
      FreeAndNil(ShipDetails);
   end;
end;

function TCraft.IsVehicle(Test: Integer): Boolean;
//see if the craft is a vehicle

begin
   Result := False;
   if (Test = 1) then begin
      Result := True;
   end;
end;

function TCraft.LauncherCost(Num: Integer; Size: Extended): Extended;
//calculate the cost of a launch facility

begin
   Result := LauncherSpace(Num, Size) * 0.002;
end;

function TCraft.LauncherSpace(Num: Integer; Size: Extended): Extended;
//calculate the space of a launch facility
begin
   Result := Num * (Size * 25);
end;

end.
