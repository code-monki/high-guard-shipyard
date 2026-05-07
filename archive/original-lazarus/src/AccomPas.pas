unit AccomPas;

{$MODE Delphi}

interface

uses
   Classes, SysUtils, Math, ShipModulePas;

type

   { TAccom }

   TAccom = class(TExtShipModule)
   private
     fBk2Captain: Boolean;
      fDblOccMark : Integer;
      fShpTrpMark : Integer;
      fHighPass : Integer;
      fMidPass : Integer;
      fLowPass : Integer;
      fStRoom : Extended;
      fSmStRoom : Extended;
      fCouches : Integer;
      fLowBerth : Integer;
      fEmLowBerth : Integer;
      fCargo : Extended;
      fAutoCargoMark : Integer;
      fShipsTroops : Integer;
      fMarines : Integer;
      fMedicalCrew : Integer;
      fOtherCrew : Integer;
      fDropCaps : Integer;
      fReadyDropCaps : Integer;
      fStoredDropCaps : Integer;
      fFrozWatch : Integer;
      fEngShop : Integer;
      fVehicleShop : Integer;
      fLabs : Integer;
      fSickBay : Integer;
      fAutoDoc : Integer;
      fAirlock : Integer;
      fFresher : Integer;
      fMissileMag : Extended;
   public
      function StRoomCost(Race, Rules : Integer) : Extended;
      function StRoomSpace(Race : Integer) : Extended;
      function SmStRoomCost(Race, Rules : Integer) : Extended;
      function SmStRoomSpace(Race : Integer) : Extended;
      function CouchesCost : Extended;
      function CouchesSpace(Race : Integer) : Extended;
      function LowBerthCost(Race : Integer) : Extended;
      function LowBerthSpace(Race : Integer) : Extended;
      function EmLowBerthCost(Race : Integer) : Extended;
      function EmLowBerthSpace(Race : Integer) : Extended;
      function DropCapsCost : Extended;
      function DropCapsSpace : Extended;
      function ReadyDropCapsCost : Extended;
      function ReadyDropCapsSpace : Extended;
      function StoredDropCapsCost : Extended;
      function StoredDropCapsSpace : Extended;
      function OtherCost : Extended;
      function OtherSpace : Extended;
      //
      function EngShopCost : Extended;
      function EngShopSpace : Extended;
      function VehicleShopCost : Extended;
      function VehicleShopSpace : Extended;
      function LabsCost : Extended;
      function LabsSpace : Extended;
      function SickBayCost : Extended;
      function SickBaySpace : Extended;
      function AutoDocCost : Extended;
      function AutoDocSpace : Extended;
      function AirlockCost : Extended;
      function AirlockSpace : Extended;
      function FresherCost : Extended;
      function FresherSpace : Extended;
      function MissileMagCost : Extended;
      function MissileMagSpace : Extended;
      //
      procedure CalcCrew(Rules, JDrive: Integer; Size: Extended);
      property DblOccMark : Integer read fDblOccMark write fDblOccMark;
      property ShpTrpMark : Integer read fShpTrpMark write fShpTrpMark;
      property HighPass : Integer read fHighPass write fHighPass;
      property MidPass : Integer read fMidPass write fMidPass;
      property LowPass : Integer read fLowPass write fLowPass;
      property StRoom : Extended read fStRoom write fStRoom;
      property SmStRoom : Extended read fSmStRoom write fSmStRoom;
      property Couches : Integer read fCouches write fCouches;
      property LowBerth : Integer read fLowBerth write fLowBerth;
      property EmLowBerth : Integer read fEmLowBerth write fEmLowBerth;
      property Cargo : Extended read fCargo write fCargo;
      property AutoCargoMark : Integer read fAutoCargoMark write fAutoCargoMark;
      property ShipsTroops : Integer read fShipsTroops write fShipsTroops;
      property Marines : Integer read fMarines write fMarines;
      property MedicalCrew : Integer read fMedicalCrew write fMedicalCrew;
      property OtherCrew : Integer read fOtherCrew write fOtherCrew;
      property DropCaps : Integer read fDropCaps write fDropCaps;
      property ReadyDropCaps : Integer read fReadyDropCaps write fReadyDropCaps;
      property StoredDropCaps : Integer read fStoredDropCaps write fStoredDropCaps;
      property FrozWatch : Integer read fFrozWatch write fFrozWatch;
      property EngShop : Integer read fEngShop write fEngShop;
      property VehicleShop : Integer read fVehicleShop write fVehicleShop;
      property Labs : Integer read fLabs write fLabs;
      property SickBay : Integer read fSickBay write fSickBay;
      property AutoDoc : Integer read fAutoDoc write fAutoDoc;
      property Airlock : Integer read fAirlock write fAirlock;
      property Fresher : Integer read fFresher write fFresher;
      property MissileMag : Extended read fMissileMag write fMissileMag;
      property Bk2Captain : Boolean read fBk2Captain write fBk2Captain;
      procedure AssignDefaults(ShipData : String); virtual;
      procedure DesignAccom(ShipData : String);
   end;

implementation

{ TAccom }

procedure TAccom.AssignDefaults(ShipData: String);
//assign the default values on creation

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
      DblOccMark := StrToInt(Props[0]);
      ShpTrpMark := StrToInt(Props[1]);
      HighPass := StrToInt(Props[2]);
      MidPass := StrToInt(Props[3]);
      LowPass := StrToInt(Props[4]);
      StRoom := StrToFloat(Props[5]);
      SmStRoom := StrToFloat(Props[6]);
      Couches := StrToInt(Props[7]);
      LowBerth := StrToInt(Props[8]);
      EmLowBerth := StrToInt(Props[9]);
      Cargo := StrToFloat(Props[10]);
      AutoCargoMark := StrToInt(Props[11]);
      ShipsTroops := 0;
      Marines := StrToInt(Props[12]);
      OtherCrew := StrToInt(Props[13]);
      DropCaps := StrToInt(Props[14]);
      ReadyDropCaps := StrToInt(Props[15]);
      StoredDropCaps := StrToInt(Props[16]);
      FrozWatch := StrToInt(Props[17]);
      EngShop := StrToInt(Props[18]);
      VehicleShop := StrToInt(Props[19]);
      Labs := StrToInt(Props[20]);
      SickBay := StrToInt(Props[21]);
      AutoDoc := StrToInt(Props[22]);
      Airlock := StrToInt(Props[23]);
      Fresher := StrToInt(Props[24]);
      MissileMag := StrToFloat(Props[25]);
      Bk2Captain := StrToBool(Props[26]);
   finally
      FreeAndNil(Props);
   end;
end;

procedure TAccom.CalcCrew(Rules, JDrive: Integer; Size: Extended);
//calculate the crew required by this module

var
   TotPass : Integer;
begin
   TotPass := HighPass + MidPass + LowPass;
   CmdCrew := 0;
   Crew := 0;
   ShipsTroops := 0;

   //work out for book 2 (just stewards and medics)
   if (Rules = 0) then
   begin
     //Captain
     if (Bk2Captain) then
     begin
       CmdCrew := 1;
     end
     else
     begin
       CmdCrew := 0;
     end;
     //stewards (1 per 8 high passengers)
     if (HighPass > 0) then begin
       Crew := Crew + (HighPass div 8);
       if (HighPass mod 8 <> 0) then begin
         Crew := Crew + 1;
       end;
     end;
     //medics (1 per 120 passengers)
     //at least 1 medic if 200T+
     if ((TotPass > 0) or (Size >= 200)) and (JDrive <> 0) then begin
       Crew := Crew + Max(1, TotPass div 120);
       if (TotPass > 0) and (Size >= 200) then begin
         if (TotPass mod 120 <> 0) and (TotPass > 120) then begin
           Crew := Crew + 1;
         end;
       end;
     end;
   end

   //calculate book 5 crew (2 per 1000T, + 1 ships troop per 1000T if any)
   else
   if (Rules = 1) then begin
     CmdCrew := 1;
     Crew := Crew + Round(Size / 500) - 1;
     if (ShpTrpMark = 0) then begin
       ShipsTroops := Round(Size / 1000);
     end;
     //medical crew 1 per 240 crew
     //MedicalCrew := Ship.Crew div 240;
   end;
end;

function TAccom.CouchesCost: Extended;
//couches at Cr25,000 per

begin
   Result := Couches * 0.025;
end;

function TAccom.CouchesSpace(Race: Integer): Extended;
//couches at 0.5T per (x6 for K'kree)

begin
   if (Race = 1) then begin
      Result := Couches * 6;
   end
   else begin
      Result := Couches * 0.5;
   end;
end;

procedure TAccom.DesignAccom(ShipData: String);
//design the module

var
   ShipDetails : TStringList;
   Tonnage : Extended;
   ShipRace, CrewRules, JDrive : Integer;
begin
   ShipDetails := TStringList.Create;
   try
      ShipDetails.CommaText := ShipData;
      Tonnage := StrToFloat(ShipDetails[1]);
      ShipRace := StrToInt(ShipDetails[2]);
      CrewRules := StrToInt(ShipDetails[3]);
      JDrive := StrToInt(ShipDetails[12]);
      Cost := StRoomCost(ShipRace, CrewRules)
            + SmStRoomCost(ShipRace, CrewRules)
            + CouchesCost + LowBerthCost(ShipRace)
            + EmLowBerthCost(ShipRace)
            + DropCapsCost + ReadyDropCapsCost + StoredDropCapsCost
            //+ OtherCost;
            + EngShopCost + VehicleShopCost + LabsCost + SickBayCost
            + AutoDocCost + AirlockCost + FresherCost + MissileMagCost;
      Space := StRoomSpace(ShipRace)
            + SmStRoomSpace(ShipRace)
            + CouchesSpace(ShipRace)
            + LowBerthSpace(ShipRace)
            + EmLowBerthSpace(ShipRace)
            + DropCapsSpace + ReadyDropCapsSpace + StoredDropCapsSpace + Cargo
            //+ OtherSpace;
            + EngShopSpace + VehicleShopSpace + LabsSpace + SickBaySpace
            + AutoDocSpace + AirlockSpace + FresherSpace + MissileMagSpace;
      CalcCrew(CrewRules, JDrive, Tonnage);
   finally
      FreeAndNil(ShipDetails);
   end;
end;

function TAccom.DropCapsCost: Extended;
//work out the cost of drop caps

begin
   Result := DropCaps * 0.01;
end;

function TAccom.DropCapsSpace: Extended;
//space of drop caps

begin
   Result := DropCaps * 1;
end;

function TAccom.EmLowBerthCost(Race: Integer): Extended;
//emergancy low berth cost

begin
   case (Race) of
      0: Result := EmLowBerth * 0.1;
      1: Result := EmLowBerth * 0.2;
      2: Result := EmLowBerth * 1;
      3: Result := EmLowBerth * 0.1;
      4: Result := EmLowBerth * 1;
   end;
end;

function TAccom.EmLowBerthSpace(Race: Integer): Extended;
//emergancy low berth space

begin
   if (Race = 1) then begin
      Result := EmLowBerth * 2;
   end
   else begin
      Result := EmLowBerth * 1;
   end;
end;

function TAccom.LowBerthCost(Race: Integer): Extended;
//low berth cost

begin
   case (Race) of
      0: Result := LowBerth * 0.05;
      1: Result := LowBerth * 0.1;
      2: Result := LowBerth * 0.5;
      3: Result := LowBerth * 0.05;
      4: Result := LowBerth * 0.5;
   end;
end;

function TAccom.LowBerthSpace(Race: Integer): Extended;
//low berth space

begin
   if (Race = 1) then begin
      Result := LowBerth * 1;
   end
   else begin
      Result := LowBerth * 0.5;
   end;
end;

function TAccom.OtherCost: Extended;
//other components cost

begin
   Result := (EngShop * 1) + (VehicleShop * 2) + (Labs * 5) + (SickBay * 5)
         + (AutoDoc * 10) + (Airlock * 0.005) + (Fresher * 0.002)
         + (MissileMag * 0.1);
end;

function TAccom.OtherSpace: Extended;
//other components space

begin
   Result := (EngShop * 6) + (VehicleShop * 10) + (Labs * 8) + (SickBay * 8)
         + (AutoDoc * 2) + (Airlock * 3) + (Fresher * 0.5) + (MissileMag * 1);
end;

function TAccom.EngShopCost: Extended;
begin
  Result := EngShop * 1;
end;

function TAccom.EngShopSpace: Extended;
begin
  Result := EngShop * 6;
end;

function TAccom.VehicleShopCost: Extended;
begin
  Result := VehicleShop * 2;
end;

function TAccom.VehicleShopSpace: Extended;
begin
  Result := VehicleShop * 10;
end;

function TAccom.LabsCost: Extended;
begin
  Result := Labs * 5;
end;

function TAccom.LabsSpace: Extended;
begin
  Result := Labs * 8;
end;

function TAccom.SickBayCost: Extended;
begin
  Result := SickBay * 5;
end;

function TAccom.SickBaySpace: Extended;
begin
  Result := SickBay * 8;
end;

function TAccom.AutoDocCost: Extended;
begin
  Result := AutoDoc * 10;
end;

function TAccom.AutoDocSpace: Extended;
begin
  Result := AutoDoc * 2;
end;

function TAccom.AirlockCost: Extended;
begin
  Result := Airlock * 0.005;
end;

function TAccom.AirlockSpace: Extended;
begin
  Result := Airlock * 3;
end;

function TAccom.FresherCost: Extended;
begin
  Result := Fresher * 0.002;
end;

function TAccom.FresherSpace: Extended;
begin
  Result := Fresher * 0.5;
end;

function TAccom.MissileMagCost: Extended;
begin
  Result := MissileMag * 0.1;
end;

function TAccom.MissileMagSpace: Extended;
begin
  Result := MissileMag * 1;
end;

function TAccom.ReadyDropCapsCost: Extended;
//ready drop caps cost

begin
   Result := ReadyDropCaps * 0.001;
end;

function TAccom.ReadyDropCapsSpace: Extended;
//ready drop caps space

begin
   Result := ReadyDropCaps * 0.5;
end;

function TAccom.SmStRoomCost(Race, Rules: Integer): Extended;
//small craft staterooms cost

begin
   case (Race) of
      0: Result := SmStRoom * 0.05;
      1: begin
            if (Rules = 0) then begin
               Result := SmStRoom * 0.1;
            end
            else begin
               Result := SmStRoom * 0.05;
            end;
         end;
      2: Result := SmStRoom * 0.05;
      3: Result := SmStRoom * 0.025;
      4: Result := SmStRoom * 0.05;
   end;
end;

function TAccom.SmStRoomSpace(Race: Integer): Extended;
//small craft staterooms space

begin
   case (Race) of
      0: Result := SmStRoom * 2;
      1: Result := SmStRoom * 24;
      2: Result := SmStRoom * 2;
      3: Result := SmStRoom * 1;
      4: Result := SmStRoom * 2;
   end;
end;

function TAccom.StoredDropCapsCost: Extended;
//stored drop caps cost

begin
   Result := StoredDropCaps * 0;
end;

function TAccom.StoredDropCapsSpace: Extended;
//stored drop caps space

begin
   Result := StoredDropCaps * 0.5;
end;

function TAccom.StRoomCost(Race, Rules: Integer): Extended;
//standard stateroom cost

begin
   case (Race) of
      0: Result := StRoom * 0.5;
      1: begin
            if (Rules = 0) then begin
               Result := StRoom * 1;
            end
            else begin
               Result := StRoom * 0.5;
            end;
         end;
      2: Result := StRoom * 0.5;
      3: Result := StRoom * 0.25;
      4: Result := StRoom * 0.5;
   end;
end;

function TAccom.StRoomSpace(Race: Integer): Extended;
//standard staterooms space

begin
   case (Race) of
      0: Result := StRoom * 4;
      1: Result := StRoom * 48;
      2: Result := StRoom * 4;
      3: Result := StRoom * 2;
      4: Result := StRoom * 4;
   end;
end;

end.
